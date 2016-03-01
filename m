From: shawnguo@kernel.org (Shawn Guo)
Date: Tue,  1 Mar 2016 23:00:01 +0800
Subject: [GIT PULL 2/4] ARM: imx: device tree changes for 4.6
In-Reply-To: <1456844403-26176-1-git-send-email-shawnguo@kernel.org>
References: <1456844403-26176-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1456844403-26176-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc maintainers,

This is the i.MX device tree updates for 4.6.  To resolve the dependency
between clock drivers and DTS files on some new clock ID additions, the
branch imx/clk are pulled into the branch.  The imx/clk changes have
been sent to clk folks as a stable branch.

Shawn

The following changes since commit f6c3aec2f7a218abec9e5c00353abc02224be49e:

  clk: imx: add kpp clock for i.MX6UL (2016-02-28 10:45:29 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.6

for you to fetch changes up to 3631c597ca33df06610a5482447912d36d0a9ff2:

  ARM: dts: imx53-qsb: Fix gpio button polarity (2016-03-01 21:40:50 +0800)

----------------------------------------------------------------
The i.MX device tree updates for 4.6:
- New i.MX6 board support: NXP/Freescale imx6qp boards, Advantech/GE,
  Uniwest evi, Engicam IMX6 Q7, Toradex Apalis SoM and Ixora carrier
  boards
- Relicense vf610 dts files under GPLv2/X11
- A patch series from Stefan updating Vybrid Colibri board support with
  PMU, regulators and other devices enabled
- Correct PWM pinmux for Ventana boards and add more pinmux for GW54xx
- Clean up imx6q-tbs2910 dts file and add SATA PHY configuration
- A series from Russell cleaning up hummingboard dts files
- A series from Lothar updating Ka-Ro i.MX28, i.MX53 and i.MX6 boards
  to use better audio codec frequency and display configurations
- Clean up whitespaces in i.MX6UL pinctrl header and add more devices
  support for the SoC
- Other random dts updates to enable various devices

----------------------------------------------------------------
Akshay Bhat (5):
      of: Add vendor prefix for Advantech Corporation
      of: Add vendor prefix for General Electric Company
      ARM: dts: imx: Add support for Advantech/GE B450v3
      ARM: dts: imx: Add support for Advantech/GE B650v3
      ARM: dts: imx: Add support for Advantech/GE B850v3

Bai Ping (3):
      ARM: dts: imx: Add basic dts support for imx6qp SOC
      ARM: dts: imx: Add basic dts support for imx6qp-sabreauto
      ARM: dts: imx: Add basic dts support for imx6qp-sabresd

Bhuvanchandra DV (2):
      ARM: dts: vf-colibri-eval-v3: Use enable-gpios for BL_ON
      ARM: dts: colibri-vf: Add pinmux for UART_0 aka UART_A RTS/CTS pins

Christoph Fritz (1):
      ARM: dts: imx6sx-sdb: add i2c3 node

Denis Carikli (1):
      ARM: dts: imx25: Add TSC and ADC support

Frank Li (1):
      ARM: dts: imx7d: add arch timer

Heinrich Schuchardt (1):
      ARM: dts: imx6dlq-wandboard-revb1.dts: use unique model id

Joshua Clayton (1):
      ARM: dts: Add dts for Uniwest evi

Justin Waters (2):
      ARM: dts: imx: Add Advantech BA-16 Qseven module
      ARM: dts: imx: Add support for Advantech/GE Bx50v3

Lothar Wa?mann (21):
      ARM: dts: imx28-tx28: use correct mclk frequency
      ARM: dts: imx6: use correct mclk frequency for audio codec
      ARM: dts: imx6qdl-tx6: add ENET_OUT clock to fec node
      ARM: dts: imx53: fix LVDS data-mapping and data-width
      ARM: dts: imx53: add display timing for NL12880BC20
      ARM: dts: imx53-tx53: set correct mclk frequency
      ARM: dts: imx6ul: whitespace cleanup; no functional change
      ARM: dts: imx6ul: add missing input_sel config for various pins
      ARM: dts: imx51: remove bogus pin definition
      ARM: dts: imx6ul: move tsc node to appropriate place in the DTB
      ARM: dts: imx6ul: move dt-bindings/input/input.h include to dtsi file
      ARM: dts: imx6ul: specify proper clocks for GPT node
      ARM: dts: imx6ul: specify proper clocks for the PWM nodes
      ARM: dts: imx6ul: disable PWMs by default
      ARM: dts: imx6ul: add pwm[1-4] nodes
      ARM: dts: imx6ul: add sdma support
      ARM: dts: imx6ul: add flexcan support
      ARM: dts: imx6ul: add sai support
      ARM: dts: imx6ul: add lcdif support
      ARM: dts: imx6ul: add gpmi support
      ARM: dts: imx6ul: add kpp support

Maciej S. Szmigiero (1):
      ARM: dts: imx6qdl-udoo: add sound support

Michael Trimarchi (1):
      ARM: dts: imx6q-icore-rqs: Add Engicam IMX6 Q7 initial support

Minghuan Lian (1):
      ARM: dts: ls1021a: add PCIe dts node

Peter Chen (2):
      ARM: dts: imx25.dtsi: change the clock information for usb
      ARM: dts: imx35.dtsi: change the clock information for usb

Petr ?tetiar (2):
      ARM: dts: imx6: Add support for Toradex Apalis iMX6Q/D SoM
      ARM: dts: imx6: Add support for Toradex Ixora carrier board

Philipp Zabel (1):
      ARM: dts: imx6q: add missing links between ipu2 and mipi dsi

Russell King (3):
      ARM: dts: imx6qdl-microsom.dtsi: avoid boot-time UHS warning
      ARM: dts: imx6*-hummingboard: use proper gpio flags definitions
      ARM: dts: imx6*-hummingboard: fix pcie reset GPIO specification

Sanchayan Maity (1):
      ARM: dts: vfxxx: Add DAC node for Vybrid SoC

Sascha Hauer (2):
      ARM: dts: imx6: Use correct SDMA script for SPI cores
      ARM: dts: imx53-qsb: Fix gpio button polarity

Soeren Moch (4):
      ARM: dts: imx6q-tbs2910: add SATA PHY configuration
      ARM: dts: imx6q-tbs2910: avoid sdhci boot warnings
      ARM: dts: imx6q-tbs2910: remove unnecessary iomuxc container nodes
      ARM: dts: imx6q-tbs2910: remove artificial simple-bus for regulators

Stefan Agner (12):
      ARM: dts: vf610: add remaining SAI instaces
      ARM: dts: vf610: Add alias for ethernet controller
      ARM: dts: vf610: relicense vf???.dtsi under GPLv2/X11
      ARM: dts: vf610-colibri: relicense vf*colibri* under GPLv2/X11
      ARM: dts: vf610-twr: relicense vf610-twr.dts under GPLv2/X11
      ARM: dts: vf610twr: assign Ethernet clock explicitly
      ARM: dts: vf-colibri: assign Ethernet clock explicitly
      ARM: dts: vf-colibri: remove regulator container node
      ARM: dts: vf-colibri: add basic supply regulators
      ARM: dts: vf-colibri: add carrier boards 3.3V supply
      ARM: dts: vf-colibri: disable write-protection for SD-card
      ARM: dts: vf610: add performance monitoring unit

Sudeep Holla (1):
      ARM: dts: imx: replace legacy wakeup property with 'wakeup-source'

Tim Harvey (2):
      ARM: dts: imx: ventana: fix PWM pinmux for Ventana boards
      ARM: dts: imx: ventana: add alternate PWM4 pinmux for GW54xx

 .../devicetree/bindings/vendor-prefixes.txt        |    2 +
 arch/arm/boot/dts/Makefile                         |   10 +-
 .../boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts  |    2 +-
 arch/arm/boot/dts/imx25.dtsi                       |   37 +-
 arch/arm/boot/dts/imx28-apf28dev.dts               |    2 +-
 arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi       |    4 +-
 arch/arm/boot/dts/imx28-tx28.dts                   |    4 +-
 .../boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts  |    2 +-
 arch/arm/boot/dts/imx35.dtsi                       |    8 +-
 arch/arm/boot/dts/imx51-babbage.dts                |    2 +-
 arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi  |    2 +-
 .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts  |    2 +-
 arch/arm/boot/dts/imx51-pinfunc.h                  |    1 -
 arch/arm/boot/dts/imx53-ard.dts                    |    6 +-
 arch/arm/boot/dts/imx53-qsb-common.dtsi            |   16 +-
 arch/arm/boot/dts/imx53-tx53-x03x.dts              |    2 +-
 arch/arm/boot/dts/imx53-tx53-x13x.dts              |   42 +-
 arch/arm/boot/dts/imx53-tx53.dtsi                  |    4 +-
 arch/arm/boot/dts/imx6dl-tx6u-811x.dts             |    2 +-
 arch/arm/boot/dts/imx6dl-wandboard-revb1.dts       |    2 +-
 arch/arm/boot/dts/imx6q-apalis-ixora.dts           |  272 +++
 arch/arm/boot/dts/imx6q-b450v3.dts                 |   88 +
 arch/arm/boot/dts/imx6q-b650v3.dts                 |   88 +
 arch/arm/boot/dts/imx6q-b850v3.dts                 |  157 ++
 arch/arm/boot/dts/imx6q-ba16.dtsi                  |  632 +++++++
 arch/arm/boot/dts/imx6q-bx50v3.dtsi                |  225 +++
 arch/arm/boot/dts/imx6q-evi.dts                    |  502 ++++++
 arch/arm/boot/dts/imx6q-gk802.dts                  |    2 +-
 arch/arm/boot/dts/imx6q-icore-rqs.dts              |   78 +
 arch/arm/boot/dts/imx6q-tbs2910.dts                |  318 ++--
 arch/arm/boot/dts/imx6q-tx6q-1110.dts              |    2 +-
 arch/arm/boot/dts/imx6q-wandboard-revb1.dts        |    2 +-
 arch/arm/boot/dts/imx6q.dtsi                       |    4 +-
 arch/arm/boot/dts/imx6qdl-apalis.dtsi              |  984 +++++++++++
 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi             |    2 +-
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi              |    4 +-
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi              |    2 +-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi              |    2 +-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              |   15 +-
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi              |    2 +-
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi        |    8 +-
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi           |  411 +++++
 arch/arm/boot/dts/imx6qdl-microsom.dtsi            |    1 +
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi       |    2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |    2 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi           |    2 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |    7 +-
 arch/arm/boot/dts/imx6qdl-tx6.dtsi                 |   13 +-
 arch/arm/boot/dts/imx6qdl-udoo.dtsi                |   57 +
 arch/arm/boot/dts/imx6qdl.dtsi                     |    8 +-
 arch/arm/boot/dts/imx6qp-sabreauto.dts             |   93 +
 arch/arm/boot/dts/imx6qp-sabresd.dts               |   93 +
 arch/arm/boot/dts/imx6qp.dtsi                      |   86 +
 arch/arm/boot/dts/imx6sl-warp.dts                  |    2 +-
 arch/arm/boot/dts/imx6sx-sabreauto.dts             |    2 +-
 arch/arm/boot/dts/imx6sx-sdb.dtsi                  |   18 +-
 arch/arm/boot/dts/imx6ul-14x14-evk.dts             |    5 +-
 arch/arm/boot/dts/imx6ul-pinfunc.h                 | 1836 ++++++++++----------
 arch/arm/boot/dts/imx6ul.dtsi                      |  220 ++-
 arch/arm/boot/dts/imx7d-sbc-imx7.dts               |    2 +-
 arch/arm/boot/dts/imx7d-sdb.dts                    |    2 +-
 arch/arm/boot/dts/imx7d.dtsi                       |    9 +
 arch/arm/boot/dts/ls1021a.dtsi                     |   44 +
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi          |   94 +-
 arch/arm/boot/dts/vf-colibri.dtsi                  |   76 +-
 arch/arm/boot/dts/vf500-colibri-eval-v3.dts        |   40 +-
 arch/arm/boot/dts/vf500-colibri.dtsi               |   40 +-
 arch/arm/boot/dts/vf500.dtsi                       |   49 +-
 arch/arm/boot/dts/vf610-colibri-eval-v3.dts        |   42 +-
 arch/arm/boot/dts/vf610-colibri.dtsi               |   40 +-
 arch/arm/boot/dts/vf610-twr.dts                    |   44 +-
 arch/arm/boot/dts/vf610.dtsi                       |   40 +-
 arch/arm/boot/dts/vfxxx.dtsi                       |  102 +-
 73 files changed, 5766 insertions(+), 1257 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6q-apalis-ixora.dts
 create mode 100644 arch/arm/boot/dts/imx6q-b450v3.dts
 create mode 100644 arch/arm/boot/dts/imx6q-b650v3.dts
 create mode 100644 arch/arm/boot/dts/imx6q-b850v3.dts
 create mode 100644 arch/arm/boot/dts/imx6q-ba16.dtsi
 create mode 100644 arch/arm/boot/dts/imx6q-bx50v3.dtsi
 create mode 100644 arch/arm/boot/dts/imx6q-evi.dts
 create mode 100644 arch/arm/boot/dts/imx6q-icore-rqs.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-apalis.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qp-sabreauto.dts
 create mode 100644 arch/arm/boot/dts/imx6qp-sabresd.dts
 create mode 100644 arch/arm/boot/dts/imx6qp.dtsi
