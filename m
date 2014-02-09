From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 9 Feb 2014 21:47:07 +0800
Subject: [GIT PULL v2] ARM: imx: i.MX6 DT changes for 3.15, take 1
Message-ID: <20140209134701.GA22132@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx6-dt-3.15

for you to fetch changes up to 22030dea67461df3fefb360ed33c6e2fbd578c9e:

  ARM: dts: imx6q: Add support for Zealz GK802 (2014-02-09 21:30:04 +0800)

----------------------------------------------------------------
i.MX6 device tree changes for 3.15:
 - A good number of new i.MX6 boards support: cm-fx6, dmo-edmqmx6,
   nitrogen6x, Gateworks Ventana gw5xxx family, DFI FS700-M60 and
   Zealz GK802
 - Update imx6q-sabrelite device tree and add Dual Lite/Solo support
 - Move pins that are used by particular client device out of hog group
 - Use GPIO_6 for FEC interrupt to workaround a hardware bug (ERR006687
   ENET: Only the ENET wake-up interrupt request can wake the system
   from Wait mode.)
 - Make pinctrl nodes board specific to avoid floating board specific
   device tree blob with so many unused pinctrl data
 - Use generic node name for fixed regulator
 - Update OPP table for cpufreq support
 - Random updates on various board device tree sources, adding pinctrl
   settings, device nodes, properties, etc.

----------------------------------------------------------------
Anson Huang (7):
      ARM: dts: imx6q: update setting of VDDARM_CAP voltage
      ARM: dts: imx6q: add vddsoc/pu setpoint info
      ARM: dts: imx6dl: enable cpufreq support
      ARM: dts: imx6qdl: add necessary thermal clk
      ARM: dts: imx6qdl-sabresd: Add power key support
      ARM: dts: imx6sl: add ocram device support
      ARM: dts: imx6sl: add keypad support for i.mx6sl-evk board.

Fabio Estevam (6):
      ARM: dts: imx6q-udoo: Add Ethernet support
      ARM: dts: imx6q-sabrelite: Remove duplicate GPIO entry
      ARM: dts: imx6q-sabrelite: Place 'status' as the last node
      ARM: dts: imx6: Use 'vddarm' as the regulator name
      ARM: dts: imx6qdl-sabresd: Add PFUZE100 support
      ARM: dts: imx6qdl-sabreauto: Add LVDS support

Frank Li (1):
      ARM: dts: imx6qdl: enable dma for spi

John Tobias (1):
      ARM: dts: imx6sl: Adding cpu frequency and VDDSOC/PU table.

Lothar Wa?mann (1):
      ARM: dts: imx6qdl: add aliases for can interfaces

Marek Vasut (1):
      ARM: dts: imx6q-sabrelite: Enable PCI express

Markus Pargmann (1):
      ARM: dts: imx6: use imx51-ssi

Nicolin Chen (2):
      ARM: dts: imx: specify the value of audmux pinctrl instead of 0x80000000
      ARM: dts: imx6qdl: add spdif support for sabreauto

Peter Chen (3):
      ARM: dts: imx6q-arm2: enable USB OTG
      ARM: dts: imx6: add anatop phandle for usbphy
      ARM: dts: imx6: add mxs phy controller id

Philipp Zabel (1):
      ARM: dts: imx6q-sabrelite: PHY reset is active-low

Sascha Hauer (4):
      ARM: dts: imx6q: Add spi4 alias
      ARM: dts: imx6qdl: Add mmc aliases
      ARM: dts: imx6: Add DFI FS700-M60 board support
      ARM: dts: imx6q: Add support for Zealz GK802

Shawn Guo (3):
      ARM: dts: imx6qdl: make pinctrl nodes board specific
      ARM: dts: imx6sl: make pinctrl nodes board specific
      ARM: dts: imx6: use generic node name for fixed regulator

Silvio F (2):
      DT: Add Data Modul vendor prefix
      ARM: dts: imx6: Add support for imx6q dmo edmqmx6

Tim Harvey (2):
      ARM: dts: disable flexcan by default
      ARM: dts: add Gateworks Ventana support

Troy Kisky (26):
      ARM: dts: imx: pinfunc: add MX6QDL_PAD_SD1_CLK__OSC32K_32K_OUT
      ARM: dts: imx: imx6qdl.dtsi: add mipi_csi tag
      ARM: dts: imx: imx6q.dtsi: use IRQ_TYPE_LEVEL_HIGH
      ARM: dts: imx: imx6dl.dtsi: use IRQ_TYPE_LEVEL_HIGH
      ARM: dts: imx: imx6sl.dtsi: use IRQ_TYPE_LEVEL_HIGH
      ARM: dts: imx: imx6qdl.dtsi: use IRQ_TYPE_LEVEL_HIGH
      ARM: dts: imx: sabrelite: add Dual Lite/Solo support
      ARM: dts: imx6qdl-sabrelite: Add uart1 support
      ARM: dts: imx6qdl-sabrelite: remove usdhc4 wp-gpio
      ARM: dts: imx6qdl-sabrelite: move USDHC4 CD to pinctrl_usdhc4
      ARM: dts: imx6qdl-sabrelite: move USDHC3 CD/WP to pinctrl_usdhc3
      ARM: dts: imx6qdl-sabrelite: move spi-nor CS to pinctrl_ecspi1
      ARM: dts: imx6qdl-sabrelite: move usbotg power enable to pinctrl_usbotg
      ARM: dts: imx6qdl-sabrelite: move phy reset to pinctrl_enet
      ARM: dts: imx6qdl-sabrelite: explicitly set pad for SGTL5000 sys_mclk
      ARM: dts: imx6qdl-sabrelite: add pwms for backlights
      ARM: dts: imx6qdl-sabrelite: add skews for Micrel phy
      ARM: dts: imx6qdl-sabrelite: fix ENET group
      ARM: dts: imx6qdl-sabrelite: Add over-current pin to usbotg
      ARM: dts: imx: add nitrogen6x board
      ARM: dts: imx6qdl-sabrelite: add gpio-keys
      ARM: dts: imx: pinfunc: add MX6QDL_PAD_GPIO_6__ENET_IRQ
      ARM: dts: imx6qdl: use interrupts-extended for fec
      ARM: dts: imx6qdl-sabrelite: use GPIO_6 for FEC interrupt.
      ARM: dts: imx6qdl-sabreauto: use GPIO_6 for FEC interrupt.
      ARM: dts: imx6q-arm2: use GPIO_6 for FEC interrupt.

Valentin Raevsky (1):
      ARM: dts: Add initial support for cm-fx6.

 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 arch/arm/boot/dts/Makefile                         |   17 +
 arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dts         |   23 +
 arch/arm/boot/dts/imx6dl-gw51xx.dts                |   19 +
 arch/arm/boot/dts/imx6dl-gw52xx.dts                |   19 +
 arch/arm/boot/dts/imx6dl-gw53xx.dts                |   19 +
 arch/arm/boot/dts/imx6dl-gw54xx.dts                |   19 +
 arch/arm/boot/dts/imx6dl-nitrogen6x.dts            |   21 +
 arch/arm/boot/dts/imx6dl-pinfunc.h                 |    2 +
 arch/arm/boot/dts/imx6dl-sabrelite.dts             |   20 +
 arch/arm/boot/dts/imx6dl.dtsi                      |   29 +-
 arch/arm/boot/dts/imx6q-arm2.dts                   |  140 ++-
 arch/arm/boot/dts/imx6q-cm-fx6.dts                 |  107 +++
 arch/arm/boot/dts/imx6q-dfi-fs700-m60.dts          |   23 +
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts            |  372 ++++++++
 arch/arm/boot/dts/imx6q-gk802.dts                  |  171 ++++
 arch/arm/boot/dts/imx6q-gw51xx.dts                 |   19 +
 arch/arm/boot/dts/imx6q-gw52xx.dts                 |   23 +
 arch/arm/boot/dts/imx6q-gw53xx.dts                 |   23 +
 arch/arm/boot/dts/imx6q-gw5400-a.dts               |  546 ++++++++++++
 arch/arm/boot/dts/imx6q-gw54xx.dts                 |   23 +
 arch/arm/boot/dts/imx6q-nitrogen6x.dts             |   25 +
 arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi         |   85 +-
 arch/arm/boot/dts/imx6q-pinfunc.h                  |    2 +
 arch/arm/boot/dts/imx6q-sabrelite.dts              |  178 +---
 arch/arm/boot/dts/imx6q-sbc6x.dts                  |   58 +-
 arch/arm/boot/dts/imx6q-udoo.dts                   |   54 +-
 arch/arm/boot/dts/imx6q.dtsi                       |   21 +-
 arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi       |  199 +++++
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi              |  374 ++++++++
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi              |  490 ++++++++++
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi              |  553 ++++++++++++
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              |  580 ++++++++++++
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |  422 +++++++++
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |  246 ++++-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi           |  423 +++++++++
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |  272 +++++-
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi           |  128 ++-
 arch/arm/boot/dts/imx6qdl.dtsi                     |  938 +++-----------------
 arch/arm/boot/dts/imx6sl-evk.dts                   |  210 ++++-
 arch/arm/boot/dts/imx6sl.dtsi                      |  385 +++-----
 41 files changed, 5919 insertions(+), 1360 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-gw51xx.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-gw52xx.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-gw53xx.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-gw54xx.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-nitrogen6x.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-sabrelite.dts
 create mode 100644 arch/arm/boot/dts/imx6q-cm-fx6.dts
 create mode 100644 arch/arm/boot/dts/imx6q-dfi-fs700-m60.dts
 create mode 100644 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gk802.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw51xx.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw52xx.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw53xx.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw5400-a.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw54xx.dts
 create mode 100644 arch/arm/boot/dts/imx6q-nitrogen6x.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
