From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Sat, 27 Dec 2014 19:52:52 +0200
Subject: [PATCH 0/7] Menelaus cleanup for DT, phase 1
Message-ID: <1419702779-16001-1-git-send-email-aaro.koskinen@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These patches start removal of board-specific callbacks from Menelaus:
delete platform data and a callback from the driver to the board files.

Tested on top of 3.19-rc1 on N800/N810 which are the only in-tree users
for the driver.

Aaro Koskinen (7):
  mfd: menelaus: delete omap_has_menelaus
  mfd: menelaus: drop support for SW controller VCORE
  mfd: menelaus: add initial DT support
  ARM: OMAP: N8x0: configure menelaus using DT
  mfd: menelaus: delete platform data support
  mfd: menelaus: make vcore and regulator controls internal
  mfd: menelaus: use macro for magic number

 Documentation/devicetree/bindings/mfd/menelaus.txt | 30 ++++++++
 arch/arm/boot/dts/omap2420-n8x0-common.dtsi        |  3 +
 arch/arm/mach-omap2/board-n8x0.c                   | 57 --------------
 arch/arm/mach-omap2/common-board-devices.h         |  2 -
 arch/arm/mach-omap2/pdata-quirks.c                 |  1 -
 drivers/mfd/menelaus.c                             | 86 ++++++++++++++--------
 include/linux/mfd/menelaus.h                       | 25 -------
 7 files changed, 87 insertions(+), 117 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/menelaus.txt

-- 
2.2.0
