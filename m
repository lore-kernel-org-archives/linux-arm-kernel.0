From: sourav.poddar@ti.com (Sourav Poddar)
Date: Fri, 16 Mar 2012 19:09:17 +0530
Subject: [PATCH 0/2] Omap keypad cleanup and omap5 support
Message-ID: <1331905159-11255-1-git-send-email-sourav.poddar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series consists of two patches.
Patch1 of the series makes omap4 keypad independent of the
architecture by moving platform_data to <linux/platform_data>

Patch2 add support for omap5 onchip keypad.

Tested on omap4430sdp using 3.3-rc6.
Tested on omap5 board using 3.1 custom kernel. 

Felipe Balbi (1):
  input: keypad: move platform_data to <linux/platform_data>

G, Manjunath Kondaiah (1):
  Input: omap-keypad: dynamically handle register offsets

 arch/arm/mach-omap2/board-4430sdp.c            |    1 +
 arch/arm/mach-omap2/devices.c                  |    1 +
 arch/arm/plat-omap/include/plat/omap4-keypad.h |    9 --
 drivers/input/keyboard/Kconfig                 |    7 +-
 drivers/input/keyboard/omap4-keypad.c          |  124 +++++++++++++++++++-----
 include/linux/platform_data/omap4-keypad.h     |   13 +++
 6 files changed, 118 insertions(+), 37 deletions(-)
 create mode 100644 include/linux/platform_data/omap4-keypad.h
