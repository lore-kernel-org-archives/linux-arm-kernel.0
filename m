From: woogyom.kim@gmail.com (Milo Kim)
Date: Wed,  4 Jan 2017 13:55:50 +0900
Subject: [PATCH v4 0/3] ARM: dts: imx6: Support Poslab Savageboard dual & quad
Message-ID: <20170104045553.26576-1-woogyom.kim@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Poslab Savageboard is the i.MX6 SoC base, but BSP code from the vendor is 
not mainline u-boot and kernel. Personal reason of using this board is 
testing etnaviv user-space driver, so I re-write device tree files based on
mainline kernel for the first step.

This patchset includes common DT file, dual and quad board files.

Supported components are
  - Display: HDMI and LVDS panel
  - eMMC and SD card
  - Ethernet
  - Pinmux configuration
  - SATA: only for Savageboard quad
  - UART1 for debug console
  - USB host

Missing features are
  - Audio (WM8903)
  - USB OTG
  - PMIC WM8326: default settings are used so no issue to bring-up the system
  - MIPI DSI and CSI

Patches are tested on the Savageboard quad but the dual version should work 
because the only difference between dual and quad is SATA support.

More information in http://www.savageboard.org

v4:
  Fix the license text and add the vendor prefix.
  Use generic node name for the backlight panel.
  Sort alphabetically for the pinctrl nodes.
  Remove unnecessary pinmux of HDMI CEC.

v3:
  Specify the dtbs for i.MX6 build.

v2:
  Fix DT node for regulator, phy-reset-gpios and iomuxc node.

Milo Kim (3):
  ARM: dts: imx6: Add Savageboard common file
  ARM: dts: imx6: Support Savageboard dual
  ARM: dts: imx6: Support Savageboard quad

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/imx6dl-savageboard.dts           |  51 +++++
 arch/arm/boot/dts/imx6q-savageboard.dts            |  55 +++++
 arch/arm/boot/dts/imx6qdl-savageboard.dtsi         | 255 +++++++++++++++++++++
 5 files changed, 364 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-savageboard.dts
 create mode 100644 arch/arm/boot/dts/imx6q-savageboard.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-savageboard.dtsi

-- 
2.11.0
