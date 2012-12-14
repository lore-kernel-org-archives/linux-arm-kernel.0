From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 14 Dec 2012 12:03:04 +0100
Subject: [PATCH 0/2] Thermal sensor for Orion/Kirkwood
Message-ID: <1355482986-885-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds thermal support for Orion Kirkwood devices, based
on code from Nobuhiro Iwamatsu. This provides a framework to later add
support for the thermal sensor on Dove.

The comments raised when the code was first posted have now been
addressed:

* Temperature Reading in milligrad
* marvel -> marvell
* generalized to Orion
* Compatibility string marvell,kirkwood-thermal
* Arithmetic using unsigned long

Nobuhiro Iwamatsu (2):
  thermal: Add support for thermal sensor for Orion SoC
  ARM: Kirkwood: Add support thermal sensor for 88F6282 and 88F6283

 .../devicetree/bindings/thermal/orion-thermal.txt  |   16 +++
 arch/arm/boot/dts/kirkwood-6282.dtsi               |    7 ++
 arch/arm/configs/kirkwood_defconfig                |    2 +
 drivers/thermal/Kconfig                            |    7 ++
 drivers/thermal/Makefile                           |    1 +
 drivers/thermal/orion_thermal.c                    |  133 ++++++++++++++++++++
 6 files changed, 166 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/orion-thermal.txt
 create mode 100644 drivers/thermal/orion_thermal.c

-- 
1.7.10.4
