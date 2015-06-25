From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 25 Jun 2015 21:28:48 +0530
Subject: [GIT PULL] Mailbox changes for v4.2
Message-ID: <CABb+yY2N+thoJEBfNdpsyEpDjpvnJ4-GbhTEJM-e7earmZpDAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 030bbdbf4c833bc69f502eae58498bc5572db736:

  Linux 4.1-rc3 (2015-05-10 15:12:29 -0700)

are available in the git repository at:

  http://git.linaro.org/landing-teams/working/fujitsu/integration.git
mailbox-for-next

for you to fetch changes up to 7d641938aa2ae433a97cc65ec622547cfe08f2ed:

  mailbox/bcm2835: Fix mailbox full detection. (2015-06-13 16:20:39 +0530)

----------------------------------------------------------------
Andrew Bresticker (1):
      mailbox: Make mbox_chan_ops const

Benson Leung (1):
      mailbox: Fix up error handling in mbox_request_channel()

Eric Anholt (1):
      mailbox/bcm2835: Fix mailbox full detection.

Lee Jones (2):
      mailbox: Add ability for clients to request channels by name
      dt: mailbox: Remove 'mbox-names property is discouraged' message
from binding

Lubomir Rintel (2):
      dt/bindings: Add binding for the BCM2835 mailbox driver
      mailbox: Enable BCM2835 mailbox support

Richard Weinberger (1):
      mailbox: altera: Add dependency on HAS_IOMEM

 .../bindings/mailbox/brcm,bcm2835-mbox.txt         |  26 +++
 .../devicetree/bindings/mailbox/mailbox.txt        |  10 +-
 drivers/mailbox/Kconfig                            |  10 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/arm_mhu.c                          |   2 +-
 drivers/mailbox/bcm2835-mailbox.c                  | 217 +++++++++++++++++++++
 drivers/mailbox/mailbox-altera.c                   |   2 +-
 drivers/mailbox/mailbox.c                          |  40 +++-
 drivers/mailbox/omap-mailbox.c                     |   8 +-
 drivers/mailbox/pcc.c                              |   2 +-
 include/linux/mailbox_client.h                     |   2 +
 include/linux/mailbox_controller.h                 |   2 +-
 12 files changed, 304 insertions(+), 19 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt
 create mode 100644 drivers/mailbox/bcm2835-mailbox.c
