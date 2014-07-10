From: ulrich.hecht@gmail.com (Ulrich Hecht)
Date: Thu, 10 Jul 2014 09:53:58 +0200
Subject: [PATCH v2 0/2] ARM: shmobile: lager: USBHS callback elimination
Message-ID: <1404978840-31917-1-git-send-email-ulrich.hecht+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v2:
- move phy handle to struct usbhs_priv
- add new default pipe type to driver
- remove pipe type from Lager board code

Ulrich Hecht (2):
  usb: renesas_usbhs: add R-Car Gen. 2 init and power control
  ARM: shmobile: lager: remove USBHS callbacks

 arch/arm/mach-shmobile/board-lager.c | 126 ++++-------------------------------
 drivers/usb/renesas_usbhs/Makefile   |   2 +-
 drivers/usb/renesas_usbhs/common.c   |  66 ++++++++++++++++--
 drivers/usb/renesas_usbhs/common.h   |   2 +
 drivers/usb/renesas_usbhs/rcar2.c    |  76 +++++++++++++++++++++
 drivers/usb/renesas_usbhs/rcar2.h    |   4 ++
 include/linux/usb/renesas_usbhs.h    |   6 ++
 7 files changed, 163 insertions(+), 119 deletions(-)
 create mode 100644 drivers/usb/renesas_usbhs/rcar2.c
 create mode 100644 drivers/usb/renesas_usbhs/rcar2.h

-- 
1.8.4.5
