From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 3 May 2013 11:49:50 +0800
Subject: [PATCH 0/5] Add initial i.MX6 SoloLite support
Message-ID: <1367552995-31777-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX6 SoloLite (imx6sl) is another member of Freescale i.MX6 family
besides i.MX6 Quad/Dual (imx6q) and i.MX6 DualLite/Solo (imx6dl).
Unlike that there are much similarity and compatibility between imx6q
and imx6dl, imx6sl has significant differences on the integrated
multimedia IP blocks.  That's why we choose to add imx6dl support on top
of imx6q code base, but imx6sl support is added as a new SoC here.

Shawn Guo (5):
  ARM: imx: add clock support for imx6sl
  ARM: imx: enable low-level debug support for imx6sl
  ARM: imx: add initial support for imx6sl
  ARM: dts: add device tree source for imx6sl SoC
  ARM: dts: imx6sl: add initial imx6sl-evk support

 .../devicetree/bindings/clock/imx6sl-clock.txt     |   10 +
 arch/arm/Kconfig.debug                             |   13 +-
 arch/arm/boot/dts/Makefile                         |    3 +-
 arch/arm/boot/dts/imx6sl-evk.dts                   |   74 ++
 arch/arm/boot/dts/imx6sl.dtsi                      |  777 ++++++++++++++++++++
 arch/arm/include/debug/imx-uart.h                  |   10 +
 arch/arm/mach-imx/Kconfig                          |   19 +
 arch/arm/mach-imx/Makefile                         |    1 +
 arch/arm/mach-imx/clk-imx6sl.c                     |  270 +++++++
 arch/arm/mach-imx/common.h                         |    1 +
 arch/arm/mach-imx/mach-imx6sl.c                    |   48 ++
 include/dt-bindings/clock/imx6sl-clock.h           |  148 ++++
 12 files changed, 1371 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx6sl-clock.txt
 create mode 100644 arch/arm/boot/dts/imx6sl-evk.dts
 create mode 100644 arch/arm/boot/dts/imx6sl.dtsi
 create mode 100644 arch/arm/mach-imx/clk-imx6sl.c
 create mode 100644 arch/arm/mach-imx/mach-imx6sl.c
 create mode 100644 include/dt-bindings/clock/imx6sl-clock.h

-- 
1.7.9.5
