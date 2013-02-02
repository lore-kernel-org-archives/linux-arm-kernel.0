From: andrew@lunn.ch (Andrew Lunn)
Date: Sat,  2 Feb 2013 15:35:45 +0100
Subject: [PATCH v3 0/4] Kirkwood and Dove Thermal drivers
Message-ID: <1359815749-27705-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds thermal support for Kirkwood and Dove SoCs.

Changes since v2
* More marvel -> marvell
* Dove driver. Debugged by Sebastian Hesselbarth

Changes since v1
* Temperature Reading in milligrad
* marvel -> marvell
* generalized to Orion
* Compatibility string marvell,kirkwood-thermal
* Arithmetic using unsigned long

Andrew Lunn (2):
  Thermal: Dove: Add Themal sensor support for Dove.
  Dove: Thermal: Add DT node and enable in defconfig

Nobuhiro Iwamatsu (2):
  thermal: Add support for the thermal sensor on Kirkwood SoCs
  ARM: Kirkwood: Add support thermal sensor for 88F6282 and 88F6283

 .../devicetree/bindings/thermal/dove-thermal.txt   |   18 ++
 .../bindings/thermal/kirkwood-thermal.txt          |   15 ++
 arch/arm/boot/dts/dove.dtsi                        |    5 +
 arch/arm/boot/dts/kirkwood-6282.dtsi               |    6 +
 arch/arm/configs/dove_defconfig                    |    2 +
 arch/arm/configs/kirkwood_defconfig                |    2 +
 drivers/thermal/Kconfig                            |   14 ++
 drivers/thermal/Makefile                           |    2 +
 drivers/thermal/dove_thermal.c                     |  211 ++++++++++++++++++++
 drivers/thermal/kirkwood_thermal.c                 |  136 +++++++++++++
 10 files changed, 411 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/dove-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/kirkwood-thermal.txt
 create mode 100644 drivers/thermal/dove_thermal.c
 create mode 100644 drivers/thermal/kirkwood_thermal.c

-- 
1.7.10.4
