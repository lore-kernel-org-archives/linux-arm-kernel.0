From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 6 Nov 2015 22:19:21 +0530
Subject: [GIT PULL] Mailbox changes for v4.4
Message-ID: <CABb+yY1t9CCMmCn25KGBPOSVvOJA5Kht9UNekoTQN6udXZEg3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 049e6dde7e57f0054fdc49102e7ef4830c698b46:

  Linux 4.3-rc4 (2015-10-04 16:57:17 +0100)

are available in the git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
mailbox-for-next

for you to fetch changes up to cb1ca0b3bb6681310e7fe9d29d6d4c76dd71801d:

  mailbox: mailbox-test: avoid reading iomem twice (2015-11-04 14:03:04 +0530)

----------------------------------------------------------------

A TI specific quirk to get CPU control working via remote master.
A new mailbox driver for an ST platform.
A generic test driver to aid new driver development. And a couple
     of fixes to make that really clean.

----------------------------------------------------------------
Dan Carpenter (1):
      mailbox: Off by one in mbox_test_message_read()

Dave Gerlach (1):
      mailbox/omap: Add ti,mbox-send-noirq quirk to fix AM33xx CPU Idle

Jassi Brar (1):
      mailbox: mailbox-test: avoid reading iomem twice

Lee Jones (5):
      mailbox: dt: Supply bindings for ST's Mailbox IP
      mailbox: Add support for ST's Mailbox IP
      mailbox: Add generic mechanism for testing Mailbox Controllers
      mailbox: Fix a couple of trivial static checker issues
      mailbox: mailbox-test: Correctly repair Sparse warnings

Sudip Mukherjee (1):
      PCC: fix dereference of ERR_PTR

 .../devicetree/bindings/mailbox/omap-mailbox.txt   |   8 +
 .../devicetree/bindings/mailbox/sti-mailbox.txt    |  51 ++
 drivers/mailbox/Kconfig                            |  14 +
 drivers/mailbox/Makefile                           |   4 +
 drivers/mailbox/mailbox-sti.c                      | 513 +++++++++++++++++++++
 drivers/mailbox/mailbox-test.c                     | 361 +++++++++++++++
 drivers/mailbox/omap-mailbox.c                     |  49 +-
 drivers/mailbox/pcc.c                              |   2 +-
 8 files changed, 997 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/sti-mailbox.txt
 create mode 100644 drivers/mailbox/mailbox-sti.c
 create mode 100644 drivers/mailbox/mailbox-test.c
