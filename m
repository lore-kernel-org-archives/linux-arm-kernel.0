From: yixun.lan@amlogic.com (Yixun Lan)
Date: Wed, 8 Nov 2017 14:46:25 +0800
Subject: [PATCH 0/4] add pinctrl driver for Meson-AXG SoC
Message-ID: <20171108064625.30517-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

patch [1/4]:
	Document the new pinctrl compatible string for Meson-AXG

patch [2/4]:
	Introduce a new pinctrl pinmux ops for Meson-AXG SoC.
The pinctrl IP has been changed, and now it use 4-bit continuous bit
to decribe the pin.
	    
patch [3/4]:
	Add pinctrl driver for Meson-AXG SoC.

patch [4/4]:
	Add the DT info for the pinctrl driver found in Meson-AXG SoC.

Xingyu Chen (4):
  documentation: Add compatibles for Amlogic Meson AXG pin controllers
  pinctrl: meson-axg: Introduce a pinctrl pinmux ops for Meson-AXG SoC
  pinctrl: meson-axg: Add new pinctrl driver for Meson AXG  SoC
  ARM64: dts: meson-axg: add pinctrl DT info for Meson-AXG SoC

 .../devicetree/bindings/pinctrl/meson,pinctrl.txt  |   2 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi         |  43 +
 drivers/pinctrl/meson/Kconfig                      |   9 +
 drivers/pinctrl/meson/Makefile                     |   2 +
 drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c      | 118 +++
 drivers/pinctrl/meson/pinctrl-meson-axg-pmx.h      |  62 ++
 drivers/pinctrl/meson/pinctrl-meson-axg.c          | 976 +++++++++++++++++++++
 drivers/pinctrl/meson/pinctrl-meson.h              |   1 +
 include/dt-bindings/gpio/meson-axg-gpio.h          | 116 +++
 9 files changed, 1329 insertions(+)
 create mode 100644 drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
 create mode 100644 drivers/pinctrl/meson/pinctrl-meson-axg-pmx.h
 create mode 100644 drivers/pinctrl/meson/pinctrl-meson-axg.c
 create mode 100644 include/dt-bindings/gpio/meson-axg-gpio.h

-- 
2.14.1
