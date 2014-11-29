From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sun, 30 Nov 2014 01:02:02 +0300
Subject: [PATCH v2 0/3] ARM/usb: add PHY for Lubbock platform
Message-ID: <1417298525-5587-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the second iteration of a compile-tested-only PHY for the Lubbock
platform. Could you please take a look and test.

Changes since V1:
- Switched to using threaded IRQs in a phy
- This allowed me to drop workqueue scheduling
- Dropped mach/lubbock.h from pxa25x_udc.h header.

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git.infradead.org:public_git/zaurus.git lubbock

for you to fetch changes up to 3ef110afa33e9e5c2ab77a4ababd279f8bd4e95c:

  usb: gadget: drop lubbock-specific code from pxa25x_udc (2014-11-30 00:51:31 +0300)

----------------------------------------------------------------
Dmitry Eremin-Solenikov (3):
      ARM: pxa: lubbock: add declaration of vbus tranceiver
      usb: phy: add lubbock phy driver
      usb: gadget: drop lubbock-specific code from pxa25x_udc

 arch/arm/mach-pxa/lubbock.c         |   6 +
 drivers/usb/gadget/udc/pxa25x_udc.c |  61 ----------
 drivers/usb/gadget/udc/pxa25x_udc.h |   5 -
 drivers/usb/phy/Kconfig             |  10 ++
 drivers/usb/phy/Makefile            |   1 +
 drivers/usb/phy/phy-lubbock.c       | 220 ++++++++++++++++++++++++++++++++++++
 6 files changed, 237 insertions(+), 66 deletions(-)
 create mode 100644 drivers/usb/phy/phy-lubbock.c
