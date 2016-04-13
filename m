From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 13 Apr 2016 13:20:57 +0530
Subject: [GIT PULL] Mailbox fixes for v4.6-rc
Message-ID: <CABb+yY3Avcx9BzwYLi1vH8kmmfMBQ=jiqS0WOQSEGo=gNyvfjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 3c9688876ace9ca4cd8630e5fbba8bb28235990a:

  Revert "ib_srpt: Convert to percpu_ida tag allocation" (2016-04-07
18:16:20 -0700)

are available in the git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
mailbox-devel

for you to fetch changes up to 0c44d7896cbf9156b8bb10da4f665005622235ae:

  mailbox: Stop using ENOSYS for anything other than unimplemented
syscalls (2016-04-12 13:28:32 +0530)

----------------------------------------------------------------
 * Misc fixes
    mailbox-test driver : prevent memory leak and another cosmetic change
    mailbox : change the returned error code
    Xgene driver : return -ENOMEM instead of PTR_ERR for failed devm_kzalloc

----------------------------------------------------------------
Axel Lin (1):
      mailbox: xgene-slimpro: Fix wrong test for devm_kzalloc

Lee Jones (3):
      mailbox: mailbox-test: Use more consistent format for calling
copy_from_user()
      mailbox: mailbox-test: Prevent memory leak
      mailbox: Stop using ENOSYS for anything other than unimplemented syscalls

 drivers/mailbox/mailbox-test.c          | 16 +++++++++-------
 drivers/mailbox/mailbox-xgene-slimpro.c |  4 ++--
 drivers/mailbox/mailbox.c               |  4 ++--
 3 files changed, 13 insertions(+), 11 deletions(-)
