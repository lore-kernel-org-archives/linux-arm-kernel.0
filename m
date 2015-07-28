From: haibo.chen@freescale.com (Haibo Chen)
Date: Tue, 28 Jul 2015 17:58:36 +0800
Subject: [PATCH v2 0/5] Add imx6ul touch screen controller support
Message-ID: <1438077521-12857-1-git-send-email-haibo.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6UL contains a touch screen controller. This patch set add imx6ul
touch screen controller driver support.

Changes for v2:
-Add property in devicetree Documentation.
-Add tsc disable code in tsc_remove function.
-Remove some redundant code.


Haibo Chen (5):
  input: touchscreen: add imx6ul_tsc driver support
  Documentation: Detail permitted DT properties for the imx6ul_tsc
  ARM: imx_v6_v7_defconfig: enable imx6ul_tsc
  ARM: dts: imx6ul.dtsi: add TSC support
  ARM: dts: imx6ul-14x14-evk.dts: add tsc support

 .../bindings/input/touchscreen/imx6ul_tsc.txt      |  36 ++
 arch/arm/boot/dts/imx6ul-14x14-evk.dts             |  18 +
 arch/arm/boot/dts/imx6ul.dtsi                      |  11 +
 arch/arm/configs/imx_v6_v7_defconfig               |   1 +
 drivers/input/touchscreen/Kconfig                  |  12 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/imx6ul_tsc.c             | 504 +++++++++++++++++++++
 7 files changed, 583 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
 create mode 100644 drivers/input/touchscreen/imx6ul_tsc.c

-- 
1.9.1
