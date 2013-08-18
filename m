From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 18 Aug 2013 21:48:06 +0800
Subject: [GIT PULL 3/5] ARM: imx: device tree changes for 3.12
In-Reply-To: <1376833688-24542-1-git-send-email-shawn.guo@linaro.org>
References: <1376833688-24542-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1376833688-24542-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof, Kevin,

The pull request depends on the previous one imx-soc-3.12.  Please take
care of it.  Thanks.

Shawn

The following changes since commit 130ef23a4b3bf9e564a6d000c096e9cb50f2e5c5:

  Merge tag 'imx-soc-3.12' into imx/dt (2013-08-18 16:30:14 +0800)

are available in the git repository at:


  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-dt-3.12

for you to fetch changes up to 63f4b28640da45ecae5bfacfe0d2a12c71a25c56:

  ARM: dts: vf610-twr: enable i2c0 device (2013-08-18 16:33:05 +0800)

----------------------------------------------------------------
It contains the imx device tree updates for 3.12.

- New pinctrl entry additions for various peripherals
- Devices enabling for imx6, imx5 and imx27 boards
- Add missing device nodes like iim, owire, audmux and sram, etc.
- Various updates on boards like phytec, wandboard and sabresd
- Consolidate pad macros between imx6q and imx6dl

----------------------------------------------------------------
Alexander Shiyan (25):
      ARM: dts: imx27: Add SAHARA2 devicetree node
      ARM: dts: imx27: Add AUDMUX devicetree node
      ARM: dts: imx27: Rename PWM devicetree node
      ARM: dts: imx27: Sort entries by address
      ARM: dts: imx27-phytec-phycore-som: Define minimal memory layout
      ARM: dts: imx27: Add kpp devicetree node
      ARM: dts: i.MX27: Move IIM node under AIPI2 bus
      ARM: dts: i.MX27: Add WEIM node
      ARM: dts: imx27-phytec-phycore-som: Add WEIM node
      ARM: dts: imx27-phytec-phycore-som: Add SRAM node
      ARM: dts: imx27-phytec-phycore-rdk: Add CAN node
      ARM: dts: imx27-phytec-phycore-som: Using labels for reusing UART, I2C and FEC
      ARM: dts: i.MX51: Add WEIM node
      ARM: dts: imx27: Add core voltages
      ARM: dts: i.MX27: Using "wdog_ipg_gate" clock source for watchdog
      ARM: dts: i.MX27: Remove optional "ptp" clock source for FEC
      ARM: dts: i.MX27: Add label to CPU node
      ARM: dts: i.MX27: Increase "clock-latency" value
      ARM: dts: i.MX27: Remove clock name from CPU node
      ARM: dts: imx27-phytec-phycore-som: Fix regulator settings
      ARM: i.MX5 clocks: Remove optional clock setup (CKIH1) from i.MX51 template
      ARM: dts: i.MX27: Disable AUDMUX in the template
      ARM: dts: imx27-phytec-phycore-som: Enable AUDMUX
      ARM: dts: i.MX51: Move pins configuration under "iomuxc" label
      ARM: dts: i.MX51: Add one more I2C2 pinmux entry

Fabio Estevam (13):
      ARM: imx27: Use 'AITC' for the interrupt controller name
      ARM: dts: mx53qsb: Enable VPU support
      ARM: dts: imx6dl-wandboard: Add audio support
      ARM: dts: imx: Add the missing cpus node
      ARM: dts: imx6qdl.dtsi: Add usdhc1 pin groups
      ARM: dts: imx6qdl.dtsi: Add another uart3 pin group
      ARM: dts: imx6dl-wandboard: Add SDHC1 and SDHC2 ports
      ARM: dts: imx6dl-wandboard: Add support for UART3
      ARM: dts: imx6: Add support for imx6q wandboard
      ARM: dts: imx6q-wandboard: Add sata support
      ARM: dts: imx6qdl-sabresd: Allow buttons to wake-up the system
      ARM: dts: imx6qdl-sabresd: Add touchscreen support
      ARM: dts: imx53-qsb: Make USBH1 functional

Huang Shijie (10):
      ARM: dts: imx6dl: add a new pinctrl for ecspi1
      ARM: dts: imx6q: add a new pinctrl for ecspi1
      ARM: dts: imx6qdl-sabresd: enable the SPI NOR
      ARM: dts: imx: add #dma-cells property for sdma
      ARM: dts: imx6sl: add "fsl,imx6q-uart" for uart compatible
      ARM: dts: imx6q{dl}: add DTE pads for uart
      ARM: dts: imx6q{dl}: add a DTE uart pinctrl for uart2
      ARM: dts: enable the uart2 for imx6q-arm2
      ARM: dts: imx6qdl: add a new pinctrl for uart3
      ARM: dts: imx6qdl/imx6sl: add the dma property for uart

Jingchang Lu (1):
      ARM: dts: vf610-twr: enable i2c0 device

Markus Pargmann (8):
      ARM: dts: imx27: Add imx framebuffer device
      ARM: dts: imx27: Add 1-wire
      ARM: dts: imx27 cpufreq-cpu0 frequencies
      ARM: dts: Add device tree support for phycard pca100
      ARM: dts: imx27 phyCARD-S remove wrong I2C RTC
      ARM: dts: imx27 phyCARD-S SOM remove wrong i2c sensor
      ARM: dts: imx27 phyCARD-S, move i2c1 and owire to rdk
      ARM: dts: imx27 phyCARD-S, i2c ADC device node

Matthias Weisser (1):
      ARM: dts: imx25: Make lcdc compatible to imx21 fb

Peter Chen (2):
      ARM: dtsi: imx6qdl-sabresd: Add USB host 1 VBUS regulator
      ARM: dtsi: imx6qdl-sabresd: Add USB OTG vbus pin to pinctrl_hog

Philipp Zabel (4):
      ARM: dts: add sram for imx53 and imx6q
      ARM i.MX6DL: dts: add clock and mux configuration for LDB
      ARM i.MX6Q: dts: Enable SPI NOR flash on Phytec phyFLEX-i.MX6 Ouad module
      ARM i.MX6Q: dts: Enable I2C1 with EEPROM and PMIC on Phytec phyFLEX-i.MX6 Ouad module

Philippe Reynes (1):
      ARM: apf27dev: add rtc ds1374 to the device tree

Richard Zhu (1):
      ARM: dtsi: enable ahci sata on imx6q platforms

Sascha Hauer (16):
      ARM: dts: i.MX6: sync imx6q and imx6dl pinmux entries
      ARM: dts: i.MX6qdl: Add compatible and clock to flexcan nodes
      ARM: dts: i.MX6qdl: Add i.MX31 compatible to gpt node
      ARM: dts: i.MX27: Add iim node
      ARM: dts: i.MX31: Add iim node
      ARM: dts: i.MX25: Add iim node
      ARM: dts: i.MX51: Add iim node
      ARM: dts: i.MX53: Add iim node
      ARM: dts: i.MX25: Add i2c and spi aliases
      ARM: dts: i.MX27: Add i2c aliases
      ARM: dts: i.MX51: Add i2c and spi aliases
      ARM: dts: i.MX53: Add i2c and spi aliases
      ARM: dts: i.MX6: Add i2c and spi aliases
      ARM: dts: i.MX51: move kpp pinmux entry
      ARM: dts: i.MX51 babbage: Add spi-cs-high property to pmic
      ARM: dts: i.MX51: Add USB host1/2 pinmux entries

Shawn Guo (9):
      ARM: dts: imx: share pad macro names between imx6q and imx6dl
      ARM: dts: add more imx6q/dl pin groups
      ARM: dts: imx: remove old DMA binding data from gpmi node
      ARM: dts: imx: add tempmon node for imx6q thermal support
      ARM: dts: imx: add LVDS panel for imx6qdl-sabresd
      ARM: dts: imx: use generic DMA bindings for SSI nodes
      ARM: imx6q: remove board specific CLKO setup
      ARM: dts: imx: ocram size is different between imx6q and imx6dl
      ARM: imx: add ocram clock for imx53

Tony Prisk (1):
      ARM: dts: wandboard: Add support for SDIO bcm4329

 .../devicetree/bindings/clock/imx5-clock.txt       |    1 +
 arch/arm/boot/dts/Makefile                         |    3 +
 arch/arm/boot/dts/imx25.dtsi                       |   35 +-
 arch/arm/boot/dts/imx27-apf27dev.dts               |    5 +
 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts   |   93 +
 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts   |   44 +
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts     |   13 +
 arch/arm/boot/dts/imx27-phytec-phycore-som.dts     |  125 +-
 arch/arm/boot/dts/imx27.dtsi                       |  120 +-
 arch/arm/boot/dts/imx31.dtsi                       |   17 +
 arch/arm/boot/dts/imx51-apf51.dts                  |    4 -
 arch/arm/boot/dts/imx51-babbage.dts                |    5 +
 arch/arm/boot/dts/imx51.dtsi                       |  632 +++---
 arch/arm/boot/dts/imx53-qsb.dts                    |   18 +-
 arch/arm/boot/dts/imx53.dtsi                       |   56 +-
 arch/arm/boot/dts/imx6dl-pinfunc.h                 | 2138 ++++++++++----------
 arch/arm/boot/dts/imx6dl-sabreauto.dts             |   22 -
 arch/arm/boot/dts/imx6dl-sabresd.dts               |   19 -
 arch/arm/boot/dts/imx6dl-wandboard.dts             |   24 +-
 arch/arm/boot/dts/imx6dl.dtsi                      |  254 +--
 arch/arm/boot/dts/imx6q-arm2.dts                   |   14 +-
 arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi         |  112 +-
 arch/arm/boot/dts/imx6q-pinfunc.h                  | 2050 +++++++++----------
 arch/arm/boot/dts/imx6q-sabreauto.dts              |   22 +-
 arch/arm/boot/dts/imx6q-sabrelite.dts              |   22 +-
 arch/arm/boot/dts/imx6q-sabresd.dts                |   19 +-
 arch/arm/boot/dts/imx6q-wandboard.dts              |   26 +
 arch/arm/boot/dts/imx6q.dtsi                       |  393 +---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |   22 +
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |   92 +-
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi           |  137 ++
 arch/arm/boot/dts/imx6qdl.dtsi                     |  770 ++++++-
 arch/arm/boot/dts/imx6sl.dtsi                      |   35 +-
 arch/arm/boot/dts/vf610-twr.dts                    |    7 +
 arch/arm/mach-imx/clk-imx51-imx53.c                |    3 +-
 arch/arm/mach-imx/clk-imx6q.c                      |   11 +
 arch/arm/mach-imx/mach-imx6q.c                     |   69 -
 37 files changed, 4201 insertions(+), 3231 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
 create mode 100644 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts
 create mode 100644 arch/arm/boot/dts/imx6q-wandboard.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-wandboard.dtsi
