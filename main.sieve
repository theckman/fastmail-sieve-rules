require ["envelope", "imapflags", "fileinto", "reject", "notify", "vacation", "regex", "relational", "comparator-i;ascii-numeric", "body", "copy"];

# default fastmail.fm configuration
if not header :contains ["X-Spam-known-sender"] "yes" {
  if allof(
    header :contains ["X-Backscatter"] "yes",
    not header :matches ["X-LinkName"] "*"
  ) {
    fileinto "INBOX.Junk Mail";
    stop;
  }
  if  header :value "ge" :comparator "i;ascii-numeric" ["X-Spam-score"] ["5"]  {
    fileinto "INBOX.Junk Mail";
    stop;
  }
}

# start personal config
if header :contains ["from"] "notifications@travis-ci.org" {
  fileinto "INBOX.TravisCI";
  stop;
}

# end of config
