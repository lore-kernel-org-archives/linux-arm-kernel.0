From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Sat, 21 May 2016 13:41:08 +0530
Subject: [GIT PULL] Mailbox changes for v4.7
Message-ID: <CABb+yY00f9NU-kmqVSe2h9XDuG-QvVf=wegYFetrF+CGEa+HbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit c3b46c73264b03000d1e18b22f5caf63332547c9:

  Linux 4.6-rc4 (2016-04-17 19:13:32 -0700)

are available in the git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
mailbox-for-next

for you to fetch changes up to c430cf376fee0b03d9c9293615f9737649de1b12:

  mailbox: Fix devm_ioremap_resource error detection code (2016-05-08
22:44:46 +0530)

----------------------------------------------------------------
- OMAP
       Remove non-DT support from mailbox driver
       Move PM from client calls to native driver suspend/resume
       Trivial cleanups to make checkpatch happy
- STI
        Check return from devm_ioremap_resource as ERR_PTR, not NULL

----------------------------------------------------------------
Amitoj Kaur Chawla (1):
      mailbox: Fix devm_ioremap_resource error detection code

Suman Anna (8):
      mailbox/omap: drop legacy platform device support
      mailbox/omap: use variable name for sizeof() operator
      mailbox/omap: remove FSF mailing address paragraph
      mailbox/omap: add blank lines after declarations
      mailbox/omap: store mailbox interrupt type in omap_mbox_device
      mailbox/omap: add support for suspend/resume
      mailbox/omap: check for any unread messages during suspend
      mailbox/omap: kill omap_mbox_{save/restore}_ctx() functions

 drivers/mailbox/mailbox-sti.c              |   4 +-
 drivers/mailbox/omap-mailbox.c             | 220 +++++++++++++----------------
 include/linux/omap-mailbox.h               |   2 -
 include/linux/platform_data/mailbox-omap.h |  58 --------
 4 files changed, 104 insertions(+), 180 deletions(-)
 delete mode 100644 include/linux/platform_data/mailbox-omap.h
