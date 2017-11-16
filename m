From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Nov 2017 00:29:43 +0100
Subject: [GIT PULL 3/3] ARM: SoC DT updates for 4.15
Message-ID: <CAK8P3a0ii5iJrKepKDe4aee-NLQbFShGQAp73u_=YQ9afrncmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 8a5776a5f49812d29fe4b2d0a2d71675c3facf3f:

  Linux 4.14-rc4 (2017-10-08 20:53:29 -0700)

are available in the git repository at:

  ssh://git at gitolite.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
tags/armsoc-dt

for you to fetch changes up to ba5b5034bd29ad94a16d73ed64fbeab0fa863f4d:

  arm64: dts: uniphier: route on-board device IRQ to GPIO controller
for PXs3 (2017-11-16 17:16:55 +0100)

----------------------------------------------------------------
ARM: Device-tree updates for 4.15

We add device tree files for a couple of additional SoCs in various areas:

Allwinner R40/V40 for entertainment, Broadcom Hurricane 2 for networking,
Amlogic A113D for audio, and Renesas R-Car V3M for automotive.

As usual, lots of new boards get added based on those and other SoCs:

 - Actions S500 based CubieBoard6 single-board computer

 - Amlogic Meson-AXG A113D based development board
 - Amlogic S912 based Khadas VIM2 single-board computer
 - Amlogic S912 based Tronsmart Vega S96 set-top-box

 - Allwinner H5 based NanoPi NEO Plus2 single-board computer
 - Allwinner R40 based Banana Pi M2 Ultra and Berry single-board computers
 - Allwinner A83T based TBS A711 Tablet

 - Broadcom Hurricane 2 based Ubiquiti UniFi Switch 8
 - Broadcom bcm47xx based Luxul XAP-1440/XAP-810/ABR-4500/XBR-4500
     wireless access points and routers

 - NXP i.MX51 based Zodiac Inflight Innovations RDU1 board
 - NXP i.MX53 based GE Healthcare PPD biometric monitor
 - NXP i.MX6 based Pistachio single-board computer
 - NXP i.MX6 based Vining-2000 automotive diagnostic interface
 - NXP i.MX6 based Ka-Ro TX6 Computer-on-Module in additional variants

 - Qualcomm MSM8974 (Snapdragon 800) based Fairphone 2 phone
 - Qualcomm MSM8974pro (Snapdragon 801) based Sony Xperia Z2 Tablet

 - Realtek RTD1295 based set-top-boxes MeLE V9 and PROBOX2 AVA

 - Renesas R-Car V3M (R8A77970) SoC and "Eagle" reference board
 - Renesas H3ULCB and M3ULCB "Kingfisher" extension infotainment boards
 - Renasas r8a7745 based iWave G22D-SODIMM SoM

 - Rockchip rk3288 based Amarula Vyasa single-board computer

 - Samsung Exynos5800 based Odroid HC1 single-board computer

For existing SoC support, there was a lot of ongoing work, as usual
most of that concentrated on the Renesas, Rockchip, OMAP, i.MX, Amlogic
and Allwinner platforms, but others were also active.

Rob Herring and many others worked on reducing the number of issues that
the latest version of 'dtc' now warns about. Unfortunately there is still
a lot left to do.

A rework of the ARM foundation model introduced several new files
for common variations of the model.

----------------------------------------------------------------

Alan Tull (2):
      arm64: dts: stratix10: add gpio header
      arm64: dts: stratix10: enable gpio and leds

Alexandre Belloni (1):
      ARM: dts: at91: usb_a9g20: fix rtc node

Alexandre Torgue (1):
      ARM: dts: stm32: change pinctrl bindings definition

Amelie Delaunay (5):
      ARM: dts: stm32: Add USB HS support for STM32F746 MCU
      ARM: dts: stm32: Enable USB HS on stm32746g-eval
      ARM: dts: stm32: Enable USB HS on stm32f746-disco
      ARM: dts: stm32: Add USB FS support for STM32F746 MCU
      ARM: dts: stm32: Enable USB FS on stm32f746-disco

Andreas F?rber (13):
      arm64: dts: realtek: Clean up RTD1295 UART reg property
      dt-bindings: Add vendor prefix for ProBox2
      dt-bindings: arm: realtek: Add ProBox2 AVA
      arm64: dts: realtek: Add ProBox2 Ava
      arm64: dts: realtek: Factor out common RTD129x parts
      dt-bindings: Add vendor prefix for MeLE
      dt-bindings: arm: realtek: Document MeLE V9
      arm64: dts: realtek: Add MeLE V9
      ARM: dts: owl-s500: Set power domains for CPU2 and CPU3
      ARM: dts: owl-s500-guitar-bb-rev-b: Add fake uart3 clock
      dt-bindings: arm: actions: Add CubieBoard6
      ARM: dts: owl-s500: Add CubieBoard6
      arm64: dts: actions: s900-bubblegum-96: Add fake uart5 clock

Andrew F. Davis (10):
      ARM: dts: am43xx: Introduce additional pinmux definitions for DS0
      ARM: dts: am43xx-epos-evm: Add sleep pinmux for spi0 and spi1
      ARM: dts: am43xx-epos-evm: Add sleep pinmux for qspi1
      ARM: dts: am43xx-epos-evm: Add sleep pinmux for ecap0
      ARM: dts: am43xx-epos-evm: Add sleep pinmux for gpmc
      ARM: dts: am43xx-epos-evm: Add sleep pinmux for pixcir_ts
      ARM: dts: am43xx-epos-evm: Add sleep pinmux for mmc1
      ARM: dts: am43xx-epos-evm: Add default and sleep pinmux for uart0
      ARM: dts: am43xx-epos-evm: Add default and sleep pinmux for
usb2_phy1 and usb2_phy2
      ARM: dts: am43xx-epos-evm: Add default pinmux for unused pins

Andrew Jeffery (1):
      ARM: dts: aspeed: Move pinctrl subnodes to improve readability

Andrzej Pietrasiewicz (1):
      ARM: dts: exynos: Add dwc3 SUSPHY quirk

Andy Gross (1):
      ARM: dts: qcom-apq8064: Fix dsi and hdmi phy cells

Antoine Tenart (8):
      arm64: dts: marvell: extend the cp110 syscon register area length
      arm64: dts: marvell: add comphy nodes on cp110 master and slave
      arm64: dts: marvell: cp110: add PPv2 port interrupts
      arm64: dts: marvell: 37xx: remove empty line
      arm64: dts: marvell: mcbin: add comphy references to Ethernet ports
      arm64: dts: marvell: 7040-db: add comphy reference to Ethernet port
      arm64: dts: marvell: 7040-db: enable the SFP port
      arm64: dts: marvell: 8040-db: enable the SFP ports

Antony Antony (1):
      arm64: allwinner: h5: add NanoPi NEO Plus2 DT support

Arnd Bergmann (48):
      Merge tag 'integrator-pciv3-dts' of
git://git.kernel.org/.../linusw/linux-integrator into next/soc
      Merge tag 'renesas-arm64-dt-for-v4.15' of
https://git.kernel.org/.../horms/renesas into next/soc
      Merge tag 'renesas-dt-bindings-for-v4.15' of
https://git.kernel.org/.../horms/renesas into next/soc
      Merge tag 'renesas-dt-for-v4.15' of
https://git.kernel.org/.../horms/renesas into next/soc
      Merge tag 'socfpga_dts_for_v4.15_part1' of
git://git.kernel.org/.../dinguyen/linux into next/soc
      Merge tag 'aspeed-4.15-devicetree' of
git://git.kernel.org/.../joel/aspeed into next/soc
      Merge tag 'juno-updates-4.15' of
git://git.kernel.org/.../sudeep.holla/linux into next/soc
      Merge tag 'hisi-arm64-dt-for-4.15' of
git://github.com/hisilicon/linux-hisi into next/soc
      Merge tag 'davinci-for-v4.15/dt' of
git://git.kernel.org/.../nsekhar/linux-davinci into next/soc
      Merge tag 'samsung-dt-4.15' of
git://git.kernel.org/.../krzk/linux into next/soc
      Merge tag 'zynq-dt-for-4.15' of
https://github.com/Xilinx/linux-xlnx into next/soc
      Merge tag 'qcom-arm64-for-4.15' of
git://git.kernel.org/.../agross/linux into next/soc
      Merge tag 'qcom-dts-for-4.15' of
git://git.kernel.org/.../agross/linux into next/soc
      Merge tag 'stm32-dt-for-v4.15-1' of
git://git.kernel.org/.../atorgue/stm32 into next/soc
      Merge tag 'v4.15-rockchip-dts32-1' of
git://git.kernel.org/.../mmind/linux-rockchip into next/soc
      Merge tag 'v4.15-rockchip-dts64-1' of
git://git.kernel.org/.../mmind/linux-rockchip into next/soc
      Merge tag 'omap-for-v4.15/fixes-dt-signed' of
git://git.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'omap-for-v4.15/dt-signed' of
git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'sunxi-dt-for-4.15' of
https://git.kernel.org/.../sunxi/linux into next/dt
      Merge tag 'renesas-dt2-for-v4.15' of
https://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'tegra-for-4.15-dt-bindings' of
git://git.kernel.org/.../tegra/linux into next/dt
      Merge tag 'tegra-for-4.15-arm-dt' of
git://git.kernel.org/.../tegra/linux into next/dt
      Merge tag 'arm-soc/for-4.15/devicetree' of
http://github.com/Broadcom/stblinux into next/dt
      Merge tag 'keystone_dts_for_4.15' of
git://git.kernel.org/.../ssantosh/linux-keystone into next/dt
      Merge tag 'amlogic-dt' of
git://git.kernel.org/.../khilman/linux-amlogic into next/dt
      Merge tag 'uniphier-dt-v4.15' of
git://git.kernel.org/.../masahiroy/linux-uniphier into next/dt
      Merge tag 'imx-dt-4.15' of
git://git.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'at91-ab-4.15-dt' of
git://git.kernel.org/.../abelloni/linux into next/dt
      Merge tag 'amlogic-dt-2' of
git://git.kernel.org/.../khilman/linux-amlogic into next/dt
      Merge tag 'sunxi-dt64-for-4.15' of
https://git.kernel.org/.../sunxi/linux into next/dt
      Merge tag 'uniphier-dt64-v4.15' of
git://git.kernel.org/.../masahiroy/linux-uniphier into next/dt
      Merge tag 'renesas-arm64-dt2-for-v4.15' of
https://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'tegra-for-4.15-arm64-dt' of
git://git.kernel.org/.../tegra/linux into next/dt
      Merge tag 'mvebu-dt64-4.15-1' of
git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'amlogic-dt64' of
git://git.kernel.org/.../khilman/linux-amlogic into next/dt
      Merge tag 'v4.14-next-dts64' of
https://github.com/mbgg/linux-mediatek into next/dt
      Merge tag 'imx-dt64-4.15' of
git://git.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'amlogic-dt64-2' of
git://git.kernel.org/.../khilman/linux-amlogic into next/dt
      Merge tag 'socfpga_dts_for_v4.15_part2' of
ssh://gitolite.kernel.org/.../dinguyen/linux into next/dt
      Merge tag 'actions-arm-dt-for-4.15' of
ssh://gitolite.kernel.org/.../afaerber/linux-actions into next/dt
      Merge tag 'actions-arm64-dt-for-4.15' of
ssh://gitolite.kernel.org/.../afaerber/linux-actions into next/dt
      Merge tag 'realtek-arm64-dt-for-4.15' of
ssh://gitolite.kernel.org/.../afaerber/linux-realtek into next/dt
      Merge tag 'v4.14-next-dts32-2' of
https://github.com/mbgg/linux-mediatek into next/dt
      Merge tag 'sunxi-dt-for-4.15-2' of
ssh://gitolite.kernel.org/.../sunxi/linux into next/dt
      Merge tag 'mvebu-dt64-4.15-2' of
git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'sunxi-dt64-for-4.15-2' of
ssh://gitolite.kernel.org/.../sunxi/linux into next/dt
      Merge tag 'v4.15-rockchip-dts32-2' of
ssh://gitolite.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'v4.15-rockchip-dts64-2' of
ssh://gitolite.kernel.org/.../mmind/linux-rockchip into next/dt

Baruch Siach (1):
      arm64: dts: marvell: enable AP806 watchdog

Benjamin Gaignard (1):
      ARM: dts: stm32: add Timers driver for stm32f746 MCU

Biju Das (26):
      ARM: dts: r8a7743: Add SDHI controllers
      ARM: dts: iwg20m: Enable SDHI0 controller
      ARM: dts: iwg20d-q7: Add SDHI1 support
      ARM: dts: r8a7745: Add GPIO support
      ARM: dts: iwg22m: Add iWave RZG1E SODIMM SOM
      ARM: dts: iwg22d-sodimm: Add support for iWave G22D-SODIMM board
      ARM: dts: r8a7745: Add Ethernet AVB support
      ARM: dts: iwg20d-q7: Add chosen node
      ARM: dts: iwg20d-q7: Add RTC support
      ARM: dts: iwg22d-sodimm: Add pinctl support for scif4
      ARM: dts: iwg22d-sodimm: Add Ethernet AVB support
      ARM: dts: r8a7743: Add internal PCI bridge nodes
      ARM: dts: r8a7743: Add USB PHY DT support
      ARM: dts: r8a7743: Link PCI USB devices to USB PHY
      ARM: dts: iwg20d-q7: Enable internal PCI
      ARM: dts: iwg20d-q7: Enable USB PHY
      ARM: dts: r8a7743: Add IIC cores to dtsi
      ARM: dts: r8a7745: Add internal PCI bridge nodes
      ARM: dts: r8a7745: Add USB PHY DT support
      ARM: dts: r8a7745: Link PCI USB devices to USB PHY
      ARM: dts: iwg22d-sodimm: Enable internal PCI
      ARM: dts: iwg22d-sodimm: Enable USB PHY
      ARM: dts: r8a7743: Add HS-USB device node
      ARM: dts: iwg20d-q7: Enable HS-USB
      ARM: dts: r8a7743: Add USB-DMAC device nodes
      ARM: dts: r8a7743: Enable DMA for HSUSB

Bjorn Andersson (3):
      ARM: dts: qcom: msm8974: Add Sony Xperia Z2 Tablet
      arm64: dts: qcom: Specify dload address for msm8916 and msm8996
      arm64: dts: msm8916: Mark rmtfs node as qcom, rmtfs-mem compatible

Brian Kim (1):
      ARM: dts: exynos: Add power button for Odroid XU3/4

Carlo Caione (1):
      ARM: dts: meson8b: add support for booting the secondary CPU cores

Chen-Yu Tsai (16):
      ARM: dts: sun6i: Add cross pipeline connections between DRCs and TCONs
      ARM: dts: sun8i: Add basic dtsi file for Allwinner R40
      ARM: dts: sun8i: Add board dts file for Banana Pi M2 Ultra
      ARM: dts: sun6i: Add device node for HDMI controller
      ARM: dts: sun6i: Enable HDMI support on some A31/A31s devices
      ARM: dts: sun5i: reference-design-tablet: Enable AXP209 AC and battery
      ARM: dts: sun4i: Add device nodes for display pipelines
      ARM: dts: sun7i: Enable HDMI support on some A20 devices
      ARM: dts: sun4i: Enable HDMI support on some A10 devices
      ARM: dts: sunxi: Add dtsi for AXP81x PMIC
      ARM: dts: sun8i: a83t: cubietruck-plus: Add AXP818 regulator nodes
      ARM: dts: sun8i: a83t: bananapi-m3: Add AXP813 regulator nodes
      ARM: dts: sun8i: a83t: allwinner-h8homlet-v2: Add AXP818 regulator nodes
      ARM: dts: sun8i: a83t: Move mmc1 pinctrl setting to dtsi file
      ARM: dts: sun8i: a83t: cubietruck-plus: Enable AP6330 WiFi on mmc1
      ARM: dts: sun8i: a83t: bananapi-m3: Enable AP6212 WiFi on mmc1

Christine Gharzuzi (1):
      arm64: dts: marvell: Enable Armada-8040-DB CPS SPI1

Christoph Fritz (1):
      ARM: dts: imx6sx: add vining-2000 board support

Christopher Spinrath (1):
      ARM: dts: imx6q-utilite-pro: add HDMI CEC pinctrl

Claudiu Beznea (4):
      ARM: dts: at91: sama5d27_som1_ek: add disabled status
      ARM: dts: at91: sama5d27_som1_ek: enable i2c2
      ARM: dts: at91: sama5d27_som1_ek: add pinmuxing for pwm0
      ARM: dts: at91: sama5d2_xplained: add pinmuxing for pwm0

Corentin LABBE (7):
      ARM: dts: sunxi: h3/h5: Fix simple-bus unit address format error
      ARM: dts: sunxi: h3/h5: Fix i2c2 register address
      ARM: dts: sunxi: h3/h5: Fix node with unit name and no reg property
      ARM: dts: sun8i: h3: Fix node with unit name and no reg property
      ARM: dts: sun8i: a83t: Fix simple-bus unit address format error
      arm64: allwinner: a64: Fix simple-bus unit address format error
      arm64: allwinner: a64: Fix node with unit name and no reg property

Corentin Labbe (8):
      dt-bindings: net: Restore sun8i dwmac binding
      arm64: dts: allwinner: A64: Restore EMAC changes
      arm64: dts: allwinner: add snps,dwmac-mdio compatible to emac/mdio
      dt-bindings: net: dwmac-sun8i: update documentation about integrated PHY
      arm: dts: sunxi: h3/h5: Restore EMAC changes
      ARM: dts: sunxi: h3/h5: represent the mdio switch used by sun8i-h3-emac
      ARM: dts: sunxi: Restore EMAC changes (boards)
      arm64: dts: allwinner: H5: Restore EMAC changes

Craig Tatlor (1):
      arm64: dts: qcom: msm8916: Shrink mdp address length for msm8916

Dan Haab (4):
      ARM: dts: BCM5301X: Add DT for Luxul XBR-4500
      ARM: dts: BCM5301X: Add DT for Luxul ABR-4500
      ARM: dts: BCM53573: Add DT for Luxul XAP-810
      ARM: dts: BCM53573: Add DT for Luxul XAP-1440

Daniel Thompson (1):
      arm64: dts: foundation-v8: Enable PSCI mode

Derald D. Woods (4):
      ARM: dts: omap3-evm-37xx: Add common processor module support
      ARM: dts: omap3-evm: Add OMAP3530 specific device tree processor data
      ARM: dts: omap3: Add Sharp LS037V7DW01 'envdd' supply
      ARM: dts: omap3-evm: Add DSS {vdds_dsi,vdda_video}-supply references

Dietmar Eggemann (3):
      ARM: dts: exynos: add exynos5420 cpu capacity-dmips-mhz information
      ARM: dts: exynos: add exynos5422 cpu capacity-dmips-mhz information
      ARM: dts: r8a7790: add cpu capacity-dmips-mhz information

Dinh Nguyen (6):
      arm64: dts: stratix10: fix up the gic register for the Stratix10 platform
      arm64: dts: stratix10: add ethernet/sdmmc support to the S10 devkit
      arm64: dts: stratix10: include the reset manager bindings
      arm64: dts: stratix10: add the 'altr,modrst-off' property
      arm64: dts: stratix10: add reset property for various peripherals
      arm64: dts: stratix10: fix interrupt number for gpio1

Emil Renner Berthing (1):
      arm64: dts: rockchip: enable touchpad button for rk3399-gru-kevin

Emiliano Ingrassia (2):
      ARM: dts: meson: enabling the USB Host controller on Odroid-C1/C1+ board
      ARM: dts: meson: fixing USB support on Meson6, Meson8 and Meson8b

Eric Anholt (2):
      ARM: dts: cygnus: Add the CLCD controller
      ARM: dts: cygnus: Add the PWM node

Fabien Lahoudere (1):
      ARM: dts: imx53: Add GE Healthcare PPD

Fabio Estevam (12):
      ARM: dts: imx6qdl-sabresd: Use the 'vpcie-supply' property
      ARM: dts: imx6qdl-sabresd: Add CEC support
      ARM: dts: imx25-pdk: Add touchscreen support
      ARM: dts: imx6qdl-wandboard: Add support for the revd1 variants
      ARM: dts: imx6q-novena: Use the 'vpcie-supply' property
      ARM: dts: imx6q-cm-fx6: Use the 'vpcie-supply' property
      ARM: dts: imx6qp-wandboard-revd1: Add sata support
      ARM: dts: imx6ul-pico-hobbit: Fix the 'interrupts' property
      ARM: dts: imx6sx-softing-vining-2000: Fix the 'interrupt-parent' property
      ARM: dts: imx35-eukrea-mbimxsd35-baseboard: Fix the 'cd-gpios' property
      ARM: dts: imx50: Pass the 'dma-cells' property
      ARM: dts: imx25-eukrea-mbimxsd25-baseboard: Fix the 'cd-gpios' property

Fabrice Gasnier (2):
      ARM: dts: stm32: add vrefbuf to stm32h743
      ARM: dts: stm32: Add lptimer definitions to stm32h743

Fabrizio Castro (17):
      dt-bindings: apmu: Document r8a7745 support
      ARM: dts: r8a7745: Add I2C DT support
      ARM: dts: r8a7745: Add MMC interface support
      ARM: dts: iwg22m: Add eMMC support
      ARM: dts: iwg22m: Add RTC support
      ARM: dts: r8a7745: Add SDHI controllers
      ARM: dts: iwg22m: Enable SDHI1 controller
      ARM: dts: r8a7743: Add QSPI support
      ARM: dts: iwg20m: Add SPI NOR support
      ARM: dts: r8a7745: Add QSPI support
      ARM: dts: iwg22m: Add SPI NOR support
      ARM: dts: iwg22d: Enable SDHI0 controller
      ARM: dts: r8a7745: Add MSIOF[012] support
      ARM: dts: r8a7743: Add MSIOF[012] support
      ARM: dts: iwg20d-q7: Rework DT architecture
      ARM: dts: iwg20d-q7-dbcm-ca: Add device trees for camera DB
      ARM: dts: r8a7743: Add xhci support to SoC dtsi

Florian Fainelli (7):
      Merge tag 'bcm2835-dt-fixes-2017-10-06' into devicetree/next
      Merge tag 'bcm2835-dt-next-2017-10-06' into devicetree/next
      dt-bindings: Add documentation for Broadcom Hurricane 2 SoCs
      dt-bindings: Document Broadcom Hurricane 2 clocks
      ARM: dts: Add Broadcom Hurricane 2 DTS include file
      dt-bindings: Add Ubiquiti Networks vendor prefix
      ARM: dts: Hurricane 2: Add basic support for Ubiquiti UniFi Switch 8

Gabriel Fernandez (2):
      ARM: dts: stm32: fix hse clock frequency on STM32H743 Eval board
      ARM: dts: stm32: Enable STM32H743 clock driver

Geert Uytterhoeven (43):
      dt-bindings: display: renesas: dw-hdmi: Drop bogus node name suffix
      ARM: shmobile: Document R-Car V3M SoC DT bindings
      MAINTAINERS: Add Renesas SoC DT bindings doc to Renesas ARM sections
      ARM: dts: r8a7790: Convert to new CPG/MSSR bindings
      ARM: dts: r8a7792: Convert to new CPG/MSSR bindings
      ARM: dts: r8a7793: Convert to new CPG/MSSR bindings
      ARM: dts: r8a7794: Convert to new CPG/MSSR bindings
      ARM: dts: r8a7790: Stop grouping clocks under a "clocks" subnode
      ARM: dts: r8a7793: Stop grouping clocks under a "clocks" subnode
      ARM: dts: r8a7794: Stop grouping clocks under a "clocks" subnode
      arm64: dts: renesas: r8a7795-es1: Drop extra zero from usb unit address
      arm64: dts: renesas: r8a7795: Drop bogus HDMI node names suffixes
      arm64: renesas: Add Renesas R8A77970 Kconfig support
      arm64: dts: renesas: r8a77995: Use r8a7795-sysc binding definitions
      arm64: dts: renesas: r8a77995: Use r8a7795-cpg-mssr binding definitions
      ARM: dts: r8a7791: Convert to new CPG/MSSR bindings
      ARM: dts: r8a7791: Stop grouping clocks under a "clocks" subnode
      ARM: dts: r8a7790: Add reset control properties
      ARM: dts: r8a7791: Add reset control properties
      ARM: dts: r8a7792: Add reset control properties
      ARM: dts: r8a7793: Add reset control properties
      ARM: dts: r8a7794: Add reset control properties
      arm64: dts: draak: Add serial console pins
      ARM: dts: r8a7790: Use generic node name for VSP1 nodes
      ARM: dts: r8a7791: Use generic node name for VSP1 nodes
      ARM: dts: r8a7792: Use generic node name for VSP1 nodes
      ARM: dts: r8a7794: Use generic node name for VSP1 nodes
      arm64: dts: r8a7796: Add INTC-EX device node
      arm64: dts: r8a77970: Add INTC-EX device node
      arm64: dts: r8a77995: Add INTC-EX device node
      ARM: dts: r8a73a4: Add clock for CA15 CPU0 core
      ARM: dts: r8a7743: Add missing clock for secondary CA15 CPU core
      ARM: dts: r8a7778: Add clock for CA9 CPU core
      ARM: dts: r8a7779: Add clocks for CA9 CPU cores
      ARM: dts: r8a7790: Add missing clocks for secondary CA15 CPU cores
      ARM: dts: r8a7790: Add clocks for CA7 CPU cores
      ARM: dts: r8a7791: Add missing clock for secondary CA15 CPU core
      ARM: dts: r8a7792: Add missing clock for secondary CA15 CPU core
      ARM: dts: r8a7793: Add missing clock for secondary CA15 CPU core
      ARM: dts: r8a7794: Add missing clock for secondary CA7 CPU core
      ARM: dts: sh73a0: Add clocks for CA9 CPU cores
      dt-bindings: clk: r7s72100: Add missing I and G clocks
      ARM: dts: r7s72100: Add clock for CA9 CPU core

Gregory CLEMENT (4):
      arm64: dts: marvell: armada-3720-db: Add vmmc regulator for SD slot
      arm64: dts: marvell: add NAND support on the 7040-DB board
      arm64: dts: marvell: 7040-db: Document the gpio expander
      arm64: dts: marvell: 7040-db: Add the carrier detect pin for SD card on CP

Hans Verkuil (5):
      ARM: tegra: Add CEC support for Tegra124
      ARM: tegra: Enable CEC support on Jetson TK1
      ARM: dts: rockchip: add the cec clk for dw-hdmi on rk3288
      ARM: dts: rockchip: define the two possible rk3288 CEC pins
      ARM: dts: rockchip: enable the hdmi output on the rk3288-firefly-reload

Harald Geyer (1):
      ARM: dts: sun7i: Enable power supplies on A20-OLinuxIno-Micro

Heiko Stuebner (12):
      arm64: dts: rockchip: enable display subsystem on rk3399-firefly
      dt-bindings: gpu: mali-utgard: Add Rockchip Utgard Malis
      dt-bindings: gpu: mali-utgard: add optional supply regulator
      dt-bindings: gpu: mali-utgard: add optional power-domain reference
      ARM: dts: rockchip: add rk3036 gpu node
      ARM: dts: rockchip: enable the gpu on rk3036-kylin boards
      ARM: dts: rockchip: add rk322x gpu node
      ARM: dts: rockchip: add gpu nodes on rk3066/rk3188
      ARM: dts: rockchip: enable gpu on rk3188-radxarock
      ARM: dts: rockchip: fix mali400 ppmmu interrupt names
      clk: rockchip: add more rk3188 graphics clock ids
      Merge branch 'v4.15-shared/clkids' into v4.15-armsoc/dts64

Heinrich Schuchardt (1):
      arm64: dts: rockchip: default serial for Firefly-RK3399

Hoegeun Kwon (2):
      ARM: dts: exynos: Remove the display-timing and delay from Rinato
      ARM: dts: exynos: Use specific compatibles for proper Gscaler
limits on Exynos5250 and Exynos5420

Hou Zhiqiang (3):
      arm64: dts: ls2088a: add pcie support
      arm64: dts: ls1088a: add gicv3 ITS DT node
      arm64: dts: ls1088a: add PCIe controller DT nodes

Icenowy Zheng (7):
      ARM: sun7i: a20: enable ac/battery power supplies for Lamobo R1 board
      ARM: dts: sun8i: Add board dts file for Banana Pi M2 Berry
      ARM: dts: sun8i: r40: add watchdog device node
      ARM: sun8i: r40: add USB host port nodes for R40
      ARM: sun8i: r40: add 5V regulator for Banana Pi M2 Ultra
      ARM: sun8i: v40: add 5V regulator for Banana Pi M2 Berry
      ARM: sun8i: r40: enable USB host for Banana Pi M2 Ultra

Jacob Chen (2):
      ARM: dts: rockchip: add RGA device node for RK3288
      arm64: dts: rockchip: add RGA device node for RK3399

Jacopo Mondi (7):
      ARM: dts: gr-peach: Remove empty line
      ARM: dts: gr-peach: Add SCIF2 pin group
      ARM: dts: gr-peach: Add user led device nodes
      ARM: dts: gr-peach: Fix 'leds' node name indent
      ARM: dts: gr-peach: Enable MTU2 timer pulse unit
      ARM: dts: gr-peach: Add ETHER pin group
      ARM: dts: gr-peach: Enable ostm0 and ostm1 timers

Jagan Teki (16):
      dt-bindings: Add vendor prefix for Amarula Solutions
      ARM: dts: rockchip: Add rk3288 vyasa board
      ARM: dts: rockchip: enable vops and hdmi output on rk3288-vyasa
      ARM: dts: rockchip: Enable mali GPU node on rk3288-vyasa
      ARM: dts: imx6qdl-icore: Add Sound card support
      ARM: dts: imx6qdl-icore-rqs: Move Sound nodes to dtsi
      ARM: dts: imx6qdl-icore-rqs: Switch to use simple-audio-card
      ARM: dts: imx6dl-icore: Add touchscreen node
      ARM: dts: imx6qdl-icore-rqs: Add CAN nodes
      ARM: dts: rockchip: Remove vdd_log from rk808, DCDC_REG1 on rk3288-vyasa
      ARM: dts: rockchip: Use vmmc-supply from PMIC on rk3288-vyasa
      ARM: dts: rockchip: Add regulators for rk3288-vyasa
      ARM: dts: rockchip: Add gmac support for rk3288-vyasa board
      ARM: dts: rockchip: Add usb host for rk3288-vyasa
      ARM: dts: rockchip: Add usb otg for rk3288-vyasa
      ARM: dts: rockchip: Add io domains for rk3288-vyasa

James Liao (1):
      arm64: dts: mediatek: Add cpuidle support for MT2712

Javier Martinez Canillas (1):
      ARM: dts: zynq: Add generic compatible string for I2C EEPROM

Jeffy Chen (1):
      arm64: dts: rockchip: Add rt5514 dsp for rk3399 gru

Jerome Brunet (14):
      ARM64: dts: meson-gxl-libretech-cc: enable saradc
      ARM64: dts: meson-gxl-libretech-cc: enable internal phy leds
      ARM: dts: meson8: remove gpio offset
      ARM64: dts: meson-gx: remove gpio offset
      ARM64: dts: meson-gx: adjust gpio-ranges for TEST_N
      ARM64: dts: meson-gxbb: adjust nanopi-k2 gpio-line-names
      ARM64: dts: meson-gxbb: adjust odroid-c2 gpio-line-names
      ARM64: dts: meson-gxl: adjust kvim gpio-line-names
      ARM64: dts: meson-gxl: adjust libretech-cc gpio-line-names
      ARM64: dts: meson-gxm: enable HS400 on the vim2
      ARM64: meson: enable MESON_IRQ_GPIO in Kconfig
      ARM64: dts: meson-gx: add gpio interrupt controller
      ARM64: dts: meson-gx: add external PHY interrupt on some platforms
      ARM: dts: meson8b: enable gpio interrupt controller

Joel Stanley (12):
      ARM: dts: aspeed: Reorder ADC node
      ARM: dts: aspeed: Add I2C buses
      ARM: dts: aspeed-romulus: Add I2C devices
      ARM: dts: aspeed-palmetto: Add I2C devices
      ARM: dts: aspeed-ast2500: Add I2C devices
      ARM: dts: aspeed: Add aliases for UARTs
      ARM: dts: aspeed: Correctly order UART nodes
      ARM: dts: aspeed: Clean up UART nodes
      ARM: dts: aspeed: Remove undocumented wdt properties
      ARM: dts: aspeed: Enable watchdog two
      ARM: dts: aspeed-palmetto: Enable VUART
      ARM: dts: aspeed-romulus: Enable VUART

Jonathan Liu (1):
      ARM: dts: sun7i: Add device nodes for display pipelines

Kabir Sahane (1):
      ARM: dts: am43xx-epos-evm: Add default and sleep pinmux for matrix_keypad0

Keiji Hayashibara (1):
      arm64: dts: uniphier: add efuse node for LD11, LD20, and PXs3

Kevin Wangtao (2):
      dt-bindings: Document the hi3660 thermal sensor binding
      arm64: dts: Register Hi3660's thermal sensor

Krzysztof Kozlowski (1):
      dt-bindings: samsung: Document binding for new Odroid HC1 board

Kunihiko Hayashi (2):
      ARM: dts: uniphier: add nodes of thermal monitor and thermal zone for PXs2
      arm64: dts: uniphier: add nodes of thermal monitor and thermal
zone for LD20

Kuninori Morimoto (2):
      arm64: renesas: salvator-common: fixup audio_clkout
      arm64: renesas: ulcb: fixup audio_clkout

Lars Poeschel (1):
      ARM: dts: omap3: Replace deprecated mcp prefix

Laurent Pinchart (2):
      arm64: dts: renesas: r8a7796: Add FDP1 instance
      arm64: dts: renesas: ulcb: Enable display output

Leonard Crestez (2):
      ARM: dts: imx6sx: Use nvmem-cells for tempmon
      ARM: dts: imx6ul: Add imx6ul-tempmon

Li Pengcheng (1):
      arm64: dts: hi6220: add coresight dt nodes

Liang Chen (2):
      arm64: dts: rockchip: add mmc nodes for rk3328 evaluation board
      arm64: dts: rockchip: add cpu regulator for rk3328 evaluation board

Linus L?ssing (1):
      ARM: dts: meson8b: add reserved memory zone to fix silent freezes

Linus Walleij (8):
      ARM: dts: add the PCI clock to the device tree
      ARM: dts: integratorap: Fix PCI windows
      ARM: dts: Update Integrator/AP PCI v3 compatible
      arm64: dts: hikey960: Update HiKey960 with GPIO line names
      arm64: dts: hisilicon: Standardize Poplar GPIO line names
      ARM: dts: qcom: add MSM8660 GSBI6 and GSBI7
      arm64: dts: qcom: sbc: Name GPIO lines
      ARM: dts: Add TVE200 to the Gemini SoC DTSI

Loic Poulain (1):
      ARM: dts: bcm2837-rpi-3-b: Add bcm43438 serial slave

Lothar Wa?mann (23):
      ARM: dts: imx28-tx28: Relicense the TX28 dts file under GPLv2/X11
      ARM: dts: imx28-tx28: remove the regulators bus
      ARM: dts: imx28-tx28: add trickle-charge config for DS1339
      ARM: dts: imx53-tx53: Relicense the TX53 dts files under GPLv2/X11
      ARM: dts: imx53-tx53: remove the regulators bus
      ARM: dts: imx53-tx53: remove obsolete eeti,egalax_ts
      ARM: dts: imx53-tx53: add trickle-charge config for DS1339
      ARM: dts: imx53-tx53: use explicit pad_ctl settings for I2C pins
      ARM: dts: imx53-tx53: add support for I2C bus recovery
      ARM: dts: imx6-tx6: update model property to match current
module HW revision
      ARM: dts: imx6-tx6: remove obsolete eeti,egalax_ts
      ARM: dts: imx6-tx6: remove obsolete ipu1 alias
      ARM: dts: imx6-tx6: add trickle-charge config for DS1339
      ARM: dts: imx6-tx6: improve ethernet related pinctrl setup
      ARM: dts: imx6-tx6: specify ethernet phy reset post-delay
      ARM: dts: imx6-tx6: convert to using simple-audio-card
      ARM: dts: imx6-tx6: add support for I2C bus recovery
      ARM: dts: imx6-tx6: move display configuration to .dtsi file
      ARM: dts: imx6-tx6: add a .dtsi file for the MB7 baseboard
      ARM: dts: imx: add support for TX6QP
      ARM: dts: imx: add support for TX6 modules on MB7 baseboard
      ARM: dts: imx28-tx28: fix interrupt flags
      ARM: dts: imx53-tx53: fix interrupt flags

Luca Weiss (5):
      ARM: dts: qcom: Add initial DTS file for Fairphone 2 phone
      ARM: dts: msm8974-FP2: Introduce gpio-keys nodes
      ARM: dts: msm8974-FP2: Add regulator nodes for FP2
      ARM: dts: msm8974-FP2: Add sdhci1 node
      ARM: dts: msm8974-FP2: Add USB node

Lucas Stach (3):
      ARM: dts: imx6: RDU2: disable over-current detection on USB H1
      ARM: dts: imx6: RDU2: disallow RMI4 device sleep
      ARM: dts: imx: add ZII RDU1 board

Ludovic Desroches (4):
      ARM: dts: at91: sama5d27_som1_ek: update serial aliases
      ARM: dts: at91: sama5d27_som1_ek: set USER button as a wakeup source
      ARM: dts: at91: sama5d27_som1_ek: add aliases for i2c
      ARM: dts: at91: sama5d2_xplained: set PB_USER as wakeup source

Lukasz Majewski (1):
      ARM: dts: display5: Device tree description of LWN's DISPLAY5 board

Maciej Purski (1):
      ARM: dts: exynos: Add HDMI and Sil9234 to Trats2 board

Madalin Bucur (1):
      arm64: dts: update the DPAA QBMan nodes

Manikanta Maddireddy (2):
      arm64: tegra: Add PCIe node for Tegra186
      arm64: tegra: Enable PCIe on Jetson TX2

Marco Franchi (9):
      ARM: dts: imx6ul: Remove leading zeroes from unit addresses
      ARM: dts: imx6qdl: Remove leading zeroes from unit addresses
      ARM: dts: imx: Fix incorrect display nodes notation
      ARM: dts: imx51: Fix inconsistent display port names
      ARM: dts: imx51-apf51dev: Fix 'backlight at bl1' node with unit
name and no reg property
      ARM: dts: imx51-ts4800: Fix 'port at 0' node with unit name and no
reg property
      ARM: dts: imx53: Fix 'usbphy at x' node with unit name and no reg property
      ARM: dts: imx53-m53evk: Fix 'led_gpio at 0' node with unit name and
no reg property
      ARM: dts: imx53-qsb-common: Fix 'led_gpio7_7 at 0' node with unit
name and no reg property

Marcus Cooper (2):
      ARM: dts: sun6i: a31: Add DAI nodes
      ARM: dts: sunxi: h3/h5: Add DAI nodes

Marek Szyprowski (7):
      ARM: dts: exynos: Remove redundant interrupt properties in
gpio-keys on Odroid boards
      ARM: dts: exynos: Move HDMI PHY node from boards to exynos5250.dtsi
      ARM: dts: exynos: Cleanup HDMI DCC definitions on Exynos5250 and
Exynos542x boards
      ARM: dts: exynos: Add status property to Exynos 5250 HDMI and Mixer nodes
      ARM: dts: exynos: Add status property to Exynos 542x Mixer nodes
      ARM: dts: exynos: Move audio clocks configuration to odroidxu3-audio.dtsi
      ARM: dts: exynos: Add support for Hardkernel's Odroid HC1 board

Martin Blumenstingl (5):
      dt-bindings: Amlogic: add documentation for the SoC info register areas
      ARM: dts: meson: add SoC information nodes
      ARM: dts: meson: add the SDIO MMC controller
      ARM: dts: meson8: add support for booting the secondary CPU cores
      ARM: dts: meson: add the efuse node

Martyn Welch (1):
      dt-bindings: misc: achc: Add device tree binding for GE ACHC

Masahiro Yamada (13):
      ARM: dts: uniphier: fix W=2 build warnings
      arm64: dts: uniphier: enable NAND for PXs3 reference board
      arm64: dts: uniphier: fix W=2 build warnings
      ARM: dts: uniphier: add GPIO controller nodes
      ARM: dts: uniphier: route on-board device IRQ to GPIO controller
      ARM: dts: uniphier: add GPIO hog definition
      arm64: dts: uniphier: add GPIO controller nodes
      arm64: dts: uniphier: route on-board device IRQ to GPIO controller
      arm64: dts: uniphier: add GPIO hog definition
      arm64: dts: uniphier: add eMMC hardware reset provider node
      ARM: dts: uniphier: add resets properties
      arm64: dts: uniphier: add resets properties
      arm64: dts: uniphier: route on-board device IRQ to GPIO
controller for PXs3

Maxime Ripard (26):
      arm: dts: sun8i: a83t: Remove useless, empty nodes
      arm: dts: sun8i: a83t: Add MMC1 pins
      arm: dts: sun8i: a83t: Add the UART1 controller
      arm: dts: sun8i: Add the TBS A711 tablet devicetree
      ARM: dts: sunxi: Remove leading zeros from unit-addresses
      ARM: dts: axp209: Rename usb_power_supply node to avoid warnings
      ARM: dts: sun4i: Change framebuffer node names to avoid warnings
      ARM: dts: sun4i: Change clock node names to avoid warnings
      ARM: dts: sun4i: Remove SoC node unit-name to avoid warnings
      ARM: dts: sun4i: Rename thermal nodes to avoid warnings
      ARM: dts: sun4i: Remove all useless pinctrl nodes
      ARM: dts: sun9i: Remove skeleton to avoid warnings
      ARM: dts: sun9i: Remove GPIO pinctrl nodes to avoid warnings
      ARM: dts: sun9i: Rename pinctrl nodes to avoid warnings
      ARM: dts: sun9i: optimus: Remove card detect pull-up
      ARM: dts: sun9i: cubieboard4: Remove card detect pull-up
      ARM: dts: sun4i: Remove gpio-keys warnings
      ARM: dts: sun4i: Remove skeleton and memory to avoid warnings
      ARM: dts: sun4i: Change LRADC node names to avoid warnings
      ARM: dts: sun4i: Change pinctrl nodes to avoid warning
      ARM: dts: sun4i: Provide default muxing for relevant controllers
      ARM: dts: sun4i: Remove underscores from nodes names
      ARM: dts: sun9i: Change node names to remove underscores
      ARM: dts: sun9i: Change node names to remove underscores
      ARM: dts: sun8i: a711: Add regulator support
      ARM: dts: sun8i: a711: Enable USB OTG

Michael Trimarchi (1):
      ARM: dts: rockchip: Enable thermal on rk3288-vyasa board

Mikko Perttunen (5):
      dt-bindings: Add bindings for nvidia,tegra186-bpmp-thermal
      arm64: tegra: Add #power-domain-cells for BPMP
      arm64: tegra: Add host1x on Tegra186
      arm64: tegra: Add VIC on Tegra186
      arm64: tegra: Add BPMP thermal sensor to Tegra186

Miquel Raynal (4):
      arm64: dts: marvell: armada-37xx: add UART clock
      arm64: dts: marvell: armada-37xx: add second UART port
      arm64: dts: marvell: armada-3720-db: enable second UART port
      arm64: dts: marvell: armada-3720-espressobin: fill UART nodes

Murali Karicheri (2):
      ARM: dts: keystone-k2g-evm: Add I2C EEPROM DT entry
      ARM: dts: keystone-k2g-evm: add bindings for SPI NOR flash

Neil Armstrong (8):
      ARM64: dts: meson-gxl: Take eMMC data strobe out of eMMC pins
      ARM64: dts: meson-gxm: Add support for Khadas VIM2
      ARM64: dts: meson-gxm: Add Vega S96 board
      dt-bindings: arm: amlogic: Add Tronsmart Vega S96 binding
      ARM64: dts: meson-gxl: Add alternate ARM Trusted Firmware
reserved memory zone
      ARM64: dts: meson-gx: remove unnecessary clocks properties
      ARM64: dts: meson-gx: remove unnecessary uart compatible
      ARM64: dts: meson-gxbb-odroidc2: fix usb1 power supply

Nicolas Ferre (6):
      ARM: dts: at91: sama5d27_som1_ek: remove not connected CAN0
      ARM: dts: at91: sama5d27_som1_ek: remove pull-up on SD/MMC lines
      ARM: dts: at91: sama5d2_xplained: remove pull-up on SD/MMC lines
      ARM: dts: at91: at91sam9x25ek: add CAN1 interface
      ARM: dts: at91: at91sam9x25ek: add pwm0
      ARM: dts: at91: at91sam9x5ek: use DMA for USART0

Peter Korsgaard (1):
      ARM64: dts: meson-gxbb-nexbox-a95x: Enable USB Nodes

Peter Ujfalusi (1):
      ARM: dts: keystone-k2g: Add McASP nodes

Philipp Rossak (6):
      ARM: dts: sun8i: h3: nanopi-m1: Enable IR controller
      ARM: dts: sun8i: h3: nanopi-m1-plus: Enable IR controller
      ARM: dts: sun8i: h3: Adding UART3 RTS and CTS Pins
      ARM: dts: sun8i: h3: Enable AP6212 BT on uart3 on Nanopi M1 Plus
      ARM: dts: sun8i: h3: Enable AP6212 WiFi on mmc1 on Nanopi M1 Plus
      ARM: dts: sun8i: h3: Fix Pincrtl bindings on Bananapi M2 Plus

Philipp Zabel (1):
      ARM: dts: imx6ul-14x14-evk: switch lcdif pixel clock to video pll

Pierre-Hugues Husson (2):
      arm64: dts: rockchip: add the cec clk for dw-mipi-hdmi on rk3399
      arm64: dts: rockchip: enable cec pin for rk3399 firefly

Pierre-Yves MORDRET (4):
      ARM: dts: stm32: Add I2C1 support for STM32F746 SoC
      ARM: dts: stm32: Add I2C1 support for STM32F746 eval board
      ARM: dts: stm32: Add DMAMUX support for STM32H743 SoC
      ARM: dts: stm32: Add MDMA support for STM32H743 SoC

Priit Laes (3):
      ARM: dts: sun7i: Convert to CCU
      ARM: dts: sun4i: Convert to CCU
      ARM: dts: sun4i: Add i2s0 block to dtsi

Rafa? Mi?ecki (1):
      ARM: dts: BCM5301X: Specify USB ports for USB LED of Luxul XWR-1200

Rajendra Nayak (1):
      arm64: dts: msm8996: Add the rpm clock controller node

Ravikumar Kattekola (3):
      ARM: dts: dra7: Increase max-voltage of pbias regulator
      ARM: dts: omap5: Increase max-voltage of pbias regulator
      ARM: dts: dra7-evm: Move pcie RC node to common file

Rob Herring (2):
      arm: dts: fix unit-address leading 0s
      arm64: dts: fix unit-address leading 0s

Rocky Hao (3):
      ARM: dts: rockchip: add tsadc node for RV1108 SoC
      ARM: dts: rockchip: add thermal nodes for RV1108 SoC
      ARM: dts: rockchip: enable tsadc module on RV1108 evaluation board

Roger Quadros (1):
      ARM: dts: k2g-evm: Enable USB 0 and 1

Romain Izard (1):
      ARM: dts: at91: sama5d2 Xplained: Describe the SD card power supply

Romain Perier (2):
      clk: rockchip: add clock id for PCLK_EFUSE256 of RK3368 SoCs
      arm64: dts: rockchip: add efuse for RK3368 SoCs

Ryder Lee (4):
      arm: dts: mediatek: update audio node for mt2701 and mt7623
      arm: dts: mt7623: update crypto node
      arm: dts: mt7623: update usb related nodes
      arm: dts: mt7623: remove unused compatible string for pio node

Sandy Huang (1):
      ARM: dts: rockchip: add LVDS node for rk3288

Sebastien Bourdelin (1):
      dt-bindings: bus: Add documentation for the Technologic Systems NBUS

Sergei Shtylyov (8):
      dt-bindings: power: add R8A77970 SYSC power domain definitions
      arm64: dts: renesas: initial R8A77970 SoC device tree
      arm64: dts: renesas: r8a77970: add SYS-DMAC support
      arm64: dts: renesas: r8a77970: add [H]SCIF support
      arm64: dts: renesas: r8a77970: add EtherAVB support
      arm64: renesas: document Eagle board bindings
      arm64: dts: renesas: initial Eagle board device tree
      arm64: dts: renesas: eagle: add EtherAVB support

Simon Horman (11):
      ARM: shmobile: remove inconsistent ; from documentation
      ARM: dts: r8a7778: Use R-Car GPIO Gen1 fallback compat string
      ARM: dts: r8a7779: Use R-Car GPIO Gen1 fallback compat string
      ARM: dts: r8a7743: Use R-Car GPIO Gen2 fallback compat string
      ARM: dts: r8a7790: Use R-Car GPIO Gen2 fallback compat string
      ARM: dts: r8a7791: Use R-Car GPIO Gen2 fallback compat string
      ARM: dts: r8a7792: Use R-Car GPIO Gen2 fallback compat string
      ARM: dts: r8a7793: Use R-Car GPIO Gen2 fallback compat string
      ARM: dts: r8a7794: Use R-Car GPIO Gen2 fallback compat string
      arm64: dts: r8a7795: Use R-Car GPIO Gen3 fallback compat string
      arm64: dts: r8a7796: Use R-Car GPIO Gen3 fallback compat string

Srinivas Kandagatla (5):
      ARM: dts: qcom-apq8064: disable gsbi6 i2c by default at soc dtsi
      arm64: dts: qcom: msm8996: add support to pcie
      arm64: dts: apq8096-db820c: Enable on board 3 pcie root complex
      arm64: dts: apq8096-db820c: never disable regulator on LS expansion
      arm64: dts: apq8016-sbc: add mbhc buttons support

Stefan Br?ns (4):
      arm64: allwinner: a64: add SPI nodes
      arm64: allwinner: a64: Add device node for DMA controller
      arm64: allwinner: a64: add dma controller references to spi nodes
      arm: allwinner: Correct unit name in devicetree binding example

Stefan Mavrodiev (2):
      ARM: dts: sun7i: Add dts file for A20-OLinuXino-MICRO-eMMC
      ARM: dts: sun7i: Fix A20-OLinuXino-MICRO dts for LAN8710

Suman Anna (3):
      ARM: dts: da850: Add DSP node
      ARM: dts: da850-lcdk: Add and enable CMA reserved pool for DSP
      ARM: davinci: da8xx-dt: Add OF_DEV_AUXDATA entry for DSP clock matching

Sumit Garg (1):
      arm64: dts: ls: Add optee node

Surender Polsani (1):
      arm: boot: dts: artpec6: Remove unnecessary interrupt-parent
property from sub-nodes

Thierry Reding (2):
      dt-bindings: clock: tegra: Add sor1_out clock
      Merge branch 'for-4.15/dt-bindings' into for-4.15/arm64/dt

Thomas Petazzoni (2):
      arm64: dts: marvell: add UART muxing on Armada 7K/8K
      arm64: dts: marvell: enable additional PCIe ports on Armada 8040 DB

Tim Harvey (1):
      ARM: dts: imx: ventana: remove container node from iomuxc nodes

Tomas Novotny (1):
      dt-bindings: add vendor prefix for Touchless Biometric Systems AG

Tony Lindgren (18):
      ARM: dts: Add missing dma hwmods property for omap3
      ARM: dts: Configure pmu without interrupt for omap4430
      ARM: dts: Add missing properties for omap4 control modules
      ARM: dts: Add missing hwmods property for omap4 dma
      ARM: dts: Add missing smartreflex node and binding for omap4
      ARM: dts: Add missing onewire node for omap4
      ARM: dts: Add missing hsi node for omap4
      ARM: dts: Add missing wdt3 node for omap4
      ARM: dts: Add missing dma hwmod property for omap5
      ARM: dts: Add missing hwmod related nodes for am33xx
      ARM: dts: Add missing hwmod related properties for dra7
      ARM: dts: Configure earlycon for n8x0
      ARM: dts: Configure earlycon for pandaboard
      ARM: dts: Configure earlycon for omap5-common
      dt-bindings: bus: Minimal TI sysc interconnect target module binding
      ARM: dts: Add nodes for missing omap4 interconnect target modules
      ARM: dts: Configure SmartReflex only to idle the interconnect
target module
      ARM: dts: Fix typo for omap4 mcasp rx path

Vanessa Maegima (1):
      ARM: dts: imx7d-pico: Add Wifi support

Vignesh R (2):
      ARM: dts: keystone-k2g: Add ECAP PWM DT nodes
      ARM: dts: keystone-k2g-evm: Enable PWM ECAP0

Vitaly Andrianov (3):
      ARM: dts: keystone-k2g: Add I2C nodes
      ARM: dts: k2g: Add USB instances
      ARM: dts: keystone-k2g: Add SPI nodes

Vladimir Barinov (16):
      arm: shmobile: Document Kingfisher board DT bindings
      arm64: dts: ulcb-kf: initial device tree
      arm64: dts: m3ulcb-kf: initial device tree
      arm64: dts: h3ulcb-kf: ES1.x SoC initial device tree
      arm64: dts: h3ulcb-kf: ES2.0+ SoC initial device tree
      arm64: dts: ulcb-kf: enable SCIF1
      arm64: dts: ulcb-kf: enable CAN0/1
      arm64: dts: ulcb-kf: enable HSUSB
      arm64: dts: ulcb-kf: enable USB2.0 Host channel 0
      arm64: dts: ulcb-kf: enable PCIE0/1
      arm64: dts: ulcb-kf: enable USB3.0 Host
      arm64: dts: ulcb-kf: enable TCA9539 on I2C2
      arm64: dts: ulcb-kf: enable TCA9539 on I2C4
      arm64: dts: ulcb-kf: enable PCA9548 on I2C2
      arm64: dts: ulcb-kf: enable PCA9548 on I2C4
      arm64: dts: ulcb-kf: hog USB3 hub control gpios

Weiqing Kong (2):
      arm: dts: mt2701: add pwm backlight device node
      arm: dts: mt2701: enable display pwm backlight

Wenyou Yang (1):
      ARM: dts: at91: sama5d2_xplained: Add charger node

Willy Wolff (1):
      ARM: dts: exynos: fix incomplete Odroid-XU3/4 thermal-zones definition

Wolfram Sang (1):
      ARM: dts: alt: use correct logic for SD WP pins

Yixun Lan (2):
      dt-bindings: arm: amlogic: Add Meson AXG binding
      arm64: dts: meson-axg: add initial A113D SoC DT support

Yoshihiro Shimoda (17):
      arm64: dts: renesas: r8a77995: update PFC node name to pin-controller
      arm64: dts: renesas: r8a77995: add GPIO device nodes
      arm64: dts: renesas: r8a77995: Add EthernetAVB device node
      arm64: dts: renesas: r8a77995: Add USB2.0 PHY device node
      arm64: dts: renesas: r8a77995: add USB2.0 Host (EHCI/OHCI) device node
      arm64: dts: renesas: r8a77995: draak: enable USB2.0 PHY
      arm64: dts: renesas: r8a77995: draak: enable USB2.0 Host (EHCI/OHCI)
      arm64: dts: renesas: r8a77995: draak: enable EthernetAVB
      arm64: dts: renesas: r8a7795: add USB3.0 peripheral device node
      arm64: dts: renesas: r8a7796: add USB3.0 peripheral device node
      arm64: dts: renesas: salvator-common: drop "avb_phy_int" from avb_pins
      arm64: dts: renesas: ulcb: drop "avb_phy_int" from avb_pins
      arm64: dts: renesas: r8a77995: draak: drop "avb_phy_int" from avb_pins
      arm64: dts: renesas: salvator-common: add pfc node for USB3.0 channel 0
      arm64: dts: renesas: r8a77995: add PWM device nodes
      arm64: dts: renesas: r8a77995: draak: enable PWM channel 0 and 1
      arm64: dts: renesas: salvator-common: add dr_mode property for
USB2.0 channel 0

Yuan Yao (3):
      arm64: dts: ls1012a: add the DTS node for DSPI support
      dt-bindings: spi: Add fsl,ls1012a-dspi compatible string
      dt-bindings: mtd: add sst25wf040b and en25s64 to sip-nor list

YuanCheng Cheng (1):
      ARM: dts: Add initial Pistachio i.mx6q board support.

allen yan (1):
      arm64: dts: marvell: Fix A37xx UART0 register size

 Documentation/devicetree/bindings/arm/actions.txt  |    1 +
 Documentation/devicetree/bindings/arm/amlogic.txt  |    8 +
 .../devicetree/bindings/arm/amlogic/analog-top.txt |   20 +
 .../devicetree/bindings/arm/amlogic/assist.txt     |   17 +
 .../devicetree/bindings/arm/amlogic/bootrom.txt    |   17 +
 .../devicetree/bindings/arm/bcm/brcm,hr2.txt       |   14 +
 .../devicetree/bindings/arm/omap/ctrl.txt          |    2 +
 Documentation/devicetree/bindings/arm/realtek.txt  |    2 +
 Documentation/devicetree/bindings/arm/rockchip.txt |    4 +
 .../bindings/arm/samsung/samsung-boards.txt        |    1 +
 Documentation/devicetree/bindings/arm/shmobile.txt |   16 +-
 Documentation/devicetree/bindings/bus/ti-sysc.txt  |   93 +
 Documentation/devicetree/bindings/bus/ts-nbus.txt  |   50 +
 .../bindings/clock/brcm,iproc-clocks.txt           |   14 +
 .../bindings/display/bridge/renesas,dw-hdmi.txt    |    2 +-
 .../devicetree/bindings/dma/sun6i-dma.txt          |    2 +-
 .../devicetree/bindings/gpu/arm,mali-utgard.txt    |   16 +
 Documentation/devicetree/bindings/hsi/omap-ssi.txt |   13 +-
 .../bindings/memory-controllers/ti/emif.txt        |    6 +-
 Documentation/devicetree/bindings/misc/ge-achc.txt |   26 +
 .../devicetree/bindings/mtd/jedec,spi-nor.txt      |    2 +
 .../devicetree/bindings/net/dwmac-sun8i.txt        |  207 +++
 .../bindings/pinctrl/st,stm32-pinctrl.txt          |   22 +-
 .../devicetree/bindings/power/renesas,apmu.txt     |    1 +
 .../devicetree/bindings/power/ti-smartreflex.txt   |   47 +
 .../devicetree/bindings/serial/mvebu-uart.txt      |    2 +-
 .../devicetree/bindings/spi/spi-fsl-dspi.txt       |    1 +
 .../bindings/thermal/hisilicon-thermal.txt         |    9 +
 .../thermal/nvidia,tegra186-bpmp-thermal.txt       |   32 +
 .../devicetree/bindings/vendor-prefixes.txt        |    6 +
 MAINTAINERS                                        |    2 +
 arch/arm/boot/dts/Makefile                         |   41 +-
 arch/arm/boot/dts/am33xx.dtsi                      |   10 +-
 arch/arm/boot/dts/am43x-epos-evm.dts               |  239 ++-
 arch/arm/boot/dts/armada-370-synology-ds213j.dts   |   12 +-
 arch/arm/boot/dts/armada-385-synology-ds116.dts    |   12 +-
 arch/arm/boot/dts/armada-xp-synology-ds414.dts     |   12 +-
 arch/arm/boot/dts/artpec6.dtsi                     |    3 -
 arch/arm/boot/dts/aspeed-ast2500-evb.dts           |   19 +
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts      |   56 +-
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts       |   58 +
 arch/arm/boot/dts/aspeed-g4.dtsi                   | 1818 +++++++++++---------
 arch/arm/boot/dts/aspeed-g5.dtsi                   | 1808 ++++++++++---------
 arch/arm/boot/dts/at91-ariag25.dts                 |    4 +-
 arch/arm/boot/dts/at91-ariettag25.dts              |    4 +-
 arch/arm/boot/dts/at91-cosino_mega2560.dts         |    4 +-
 arch/arm/boot/dts/at91-kizbox2.dts                 |    4 +-
 arch/arm/boot/dts/at91-kizboxmini.dts              |    4 +-
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts        |   52 +-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |   47 +-
 arch/arm/boot/dts/at91-sama5d3_xplained.dts        |    6 +-
 arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts        |    6 +-
 arch/arm/boot/dts/at91-sama5d4_xplained.dts        |    6 +-
 arch/arm/boot/dts/at91-sama5d4ek.dts               |    6 +-
 arch/arm/boot/dts/at91-vinco.dts                   |    6 +-
 arch/arm/boot/dts/at91rm9200.dtsi                  |    4 +-
 arch/arm/boot/dts/at91rm9200ek.dts                 |    2 +-
 arch/arm/boot/dts/at91sam9260.dtsi                 |    2 +-
 arch/arm/boot/dts/at91sam9261.dtsi                 |    4 +-
 arch/arm/boot/dts/at91sam9261ek.dts                |    2 +-
 arch/arm/boot/dts/at91sam9263.dtsi                 |    6 +-
 arch/arm/boot/dts/at91sam9263ek.dts                |    2 +-
 arch/arm/boot/dts/at91sam9g20.dtsi                 |    4 +-
 arch/arm/boot/dts/at91sam9g45.dtsi                 |    6 +-
 arch/arm/boot/dts/at91sam9m10g45ek.dts             |    4 +-
 arch/arm/boot/dts/at91sam9n12.dtsi                 |    4 +-
 arch/arm/boot/dts/at91sam9n12ek.dts                |    2 +-
 arch/arm/boot/dts/at91sam9rl.dtsi                  |    4 +-
 arch/arm/boot/dts/at91sam9rlek.dts                 |    2 +-
 arch/arm/boot/dts/at91sam9x25ek.dts                |   10 +
 arch/arm/boot/dts/at91sam9x5.dtsi                  |    6 +-
 arch/arm/boot/dts/at91sam9x5ek.dtsi                |    6 +-
 arch/arm/boot/dts/at91sam9xe.dtsi                  |    4 +-
 arch/arm/boot/dts/axp209.dtsi                      |    2 +-
 arch/arm/boot/dts/axp81x.dtsi                      |  139 ++
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |   28 +-
 arch/arm/boot/dts/bcm-hr2.dtsi                     |  368 ++++
 arch/arm/boot/dts/bcm-nsp.dtsi                     |    8 +-
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts           |    9 +-
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts              |   10 +
 arch/arm/boot/dts/bcm283x.dtsi                     |    7 +-
 arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts      |    3 +-
 arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts      |   63 +
 arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts      |   63 +
 arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts      |   50 +
 arch/arm/boot/dts/bcm47189-luxul-xap-810.dts       |   87 +
 arch/arm/boot/dts/bcm5301x.dtsi                    |    6 +-
 arch/arm/boot/dts/bcm53340-ubnt-unifi-switch8.dts  |   85 +
 arch/arm/boot/dts/bcm53573.dtsi                    |    2 +-
 arch/arm/boot/dts/berlin2.dtsi                     |    6 +-
 arch/arm/boot/dts/berlin2cd.dtsi                   |    6 +-
 arch/arm/boot/dts/berlin2q.dtsi                    |    6 +-
 arch/arm/boot/dts/da850-lcdk.dts                   |   18 +
 arch/arm/boot/dts/da850.dtsi                       |   12 +
 arch/arm/boot/dts/dove.dtsi                        |   14 +-
 arch/arm/boot/dts/dra7-evm-common.dtsi             |    4 +
 arch/arm/boot/dts/dra7-evm.dts                     |    4 -
 arch/arm/boot/dts/dra7.dtsi                        |   36 +-
 arch/arm/boot/dts/ep7211-edb7211.dts               |    2 +-
 arch/arm/boot/dts/exynos3250-artik5.dtsi           |    2 +-
 arch/arm/boot/dts/exynos3250-monk.dts              |    2 +-
 arch/arm/boot/dts/exynos3250-rinato.dts            |   24 +-
 arch/arm/boot/dts/exynos3250.dtsi                  |    2 +-
 arch/arm/boot/dts/exynos4.dtsi                     |    4 +-
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi          |    2 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |    2 +-
 arch/arm/boot/dts/exynos4210.dtsi                  |    4 +-
 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi    |    2 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |    8 +-
 arch/arm/boot/dts/exynos4412-odroidx.dts           |    2 -
 arch/arm/boot/dts/exynos4412-origen.dts            |    2 +-
 arch/arm/boot/dts/exynos4412-pinctrl.dtsi          |    2 +-
 arch/arm/boot/dts/exynos4412-trats2.dts            |  117 +-
 arch/arm/boot/dts/exynos4412.dtsi                  |    2 +-
 arch/arm/boot/dts/exynos5250-arndale.dts           |   22 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   20 +-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi      |   20 +-
 arch/arm/boot/dts/exynos5250-spring.dts            |   18 +-
 arch/arm/boot/dts/exynos5250.dtsi                  |   24 +-
 arch/arm/boot/dts/exynos5410-odroidxu.dts          |    6 +-
 arch/arm/boot/dts/exynos5410-smdk5410.dts          |    2 +-
 arch/arm/boot/dts/exynos5410.dtsi                  |    4 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |    6 +-
 arch/arm/boot/dts/exynos5420-cpus.dtsi             |    8 +
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |    4 +
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |    9 +-
 arch/arm/boot/dts/exynos5420.dtsi                  |   11 +-
 arch/arm/boot/dts/exynos5422-cpus.dtsi             |    8 +
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |  443 +++++
 arch/arm/boot/dts/exynos5422-odroidhc1.dts         |  213 +++
 arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi  |   13 +
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  711 +++-----
 arch/arm/boot/dts/exynos5440-ssdk5440.dts          |    2 +-
 arch/arm/boot/dts/exynos5440.dtsi                  |    2 +-
 arch/arm/boot/dts/exynos54xx.dtsi                  |    4 +-
 arch/arm/boot/dts/ge863-pro3.dtsi                  |    2 +-
 arch/arm/boot/dts/gemini.dtsi                      |   21 +
 arch/arm/boot/dts/hip01.dtsi                       |    4 +-
 arch/arm/boot/dts/hip04-d01.dts                    |    2 +-
 arch/arm/boot/dts/hisi-x5hd2.dtsi                  |   30 +-
 arch/arm/boot/dts/imx1.dtsi                        |   44 +-
 .../boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts  |    2 +-
 arch/arm/boot/dts/imx25-pdk.dts                    |   10 +-
 arch/arm/boot/dts/imx28-apx4devkit.dts             |    2 +-
 arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi       |    2 +-
 arch/arm/boot/dts/imx28-evk.dts                    |    2 +-
 arch/arm/boot/dts/imx28-m28evk.dts                 |    2 +-
 arch/arm/boot/dts/imx28-tx28.dts                   |  177 +-
 .../boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts  |    2 +-
 arch/arm/boot/dts/imx50.dtsi                       |    3 +-
 arch/arm/boot/dts/imx51-apf51dev.dts               |   10 +-
 arch/arm/boot/dts/imx51-babbage.dts                |   14 +-
 arch/arm/boot/dts/imx51-ts4800.dts                 |    8 +-
 arch/arm/boot/dts/imx51-zii-rdu1.dts               |  834 +++++++++
 arch/arm/boot/dts/imx51.dtsi                       |    4 +-
 arch/arm/boot/dts/imx53-m53evk.dts                 |    6 +-
 arch/arm/boot/dts/imx53-mba53.dts                  |    2 +-
 arch/arm/boot/dts/imx53-ppd.dts                    | 1042 +++++++++++
 arch/arm/boot/dts/imx53-qsb-common.dtsi            |    6 +-
 arch/arm/boot/dts/imx53-smd.dts                    |    4 +-
 arch/arm/boot/dts/imx53-tx53-x03x.dts              |   86 +-
 arch/arm/boot/dts/imx53-tx53-x13x.dts              |  116 +-
 arch/arm/boot/dts/imx53-tx53.dtsi                  |  166 +-
 arch/arm/boot/dts/imx53-voipac-bsb.dts             |    2 +-
 arch/arm/boot/dts/imx53.dtsi                       |    6 +-
 arch/arm/boot/dts/imx6dl-aristainetos2_4.dts       |    2 +-
 arch/arm/boot/dts/imx6dl-aristainetos_4.dts        |    2 +-
 arch/arm/boot/dts/imx6dl-aristainetos_7.dts        |    2 +-
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts       |    2 +-
 arch/arm/boot/dts/imx6dl-icore.dts                 |    9 +
 arch/arm/boot/dts/imx6dl-riotboard.dts             |    4 +-
 arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts          |   74 +-
 arch/arm/boot/dts/imx6dl-tx6s-8034-mb7.dts         |   48 +
 arch/arm/boot/dts/imx6dl-tx6s-8034.dts             |  171 +-
 arch/arm/boot/dts/imx6dl-tx6s-8035-mb7.dts         |   48 +
 arch/arm/boot/dts/imx6dl-tx6s-8035.dts             |  171 +-
 arch/arm/boot/dts/imx6dl-tx6u-801x.dts             |  161 +-
 arch/arm/boot/dts/imx6dl-tx6u-8033-mb7.dts         |   48 +
 arch/arm/boot/dts/imx6dl-tx6u-8033.dts             |  170 +-
 arch/arm/boot/dts/imx6dl-tx6u-80xx-mb7.dts         |   48 +
 arch/arm/boot/dts/imx6dl-tx6u-811x.dts             |  132 +-
 arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dts         |  215 +--
 arch/arm/boot/dts/imx6dl-wandboard-revd1.dts       |   22 +
 arch/arm/boot/dts/imx6dl.dtsi                      |   16 +-
 arch/arm/boot/dts/imx6q-apalis-eval.dts            |    2 +-
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts      |    2 +-
 arch/arm/boot/dts/imx6q-apalis-ixora.dts           |    2 +-
 arch/arm/boot/dts/imx6q-bx50v3.dtsi                |    2 +-
 arch/arm/boot/dts/imx6q-cm-fx6.dts                 |    5 +-
 .../dts/imx6q-display5-tianma-tm070-1280x768.dts   |   51 +
 arch/arm/boot/dts/imx6q-display5.dtsi              |  596 +++++++
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts            |    2 +-
 arch/arm/boot/dts/imx6q-gw5400-a.dts               |  221 ++-
 arch/arm/boot/dts/imx6q-h100.dts                   |    4 +-
 arch/arm/boot/dts/imx6q-icore-rqs.dts              |   24 -
 arch/arm/boot/dts/imx6q-mccmon6.dts                |    2 +-
 arch/arm/boot/dts/imx6q-novena.dts                 |    6 +-
 arch/arm/boot/dts/imx6q-pistachio.dts              |  693 ++++++++
 arch/arm/boot/dts/imx6q-tbs2910.dts                |    2 +-
 arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts       |   74 +-
 arch/arm/boot/dts/imx6q-tx6q-1010.dts              |  163 +-
 arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts       |   74 +-
 arch/arm/boot/dts/imx6q-tx6q-1020.dts              |  162 +-
 arch/arm/boot/dts/imx6q-tx6q-1036-mb7.dts          |   48 +
 arch/arm/boot/dts/imx6q-tx6q-1036.dts              |  170 +-
 arch/arm/boot/dts/imx6q-tx6q-10x0-mb7.dts          |   48 +
 arch/arm/boot/dts/imx6q-tx6q-1110.dts              |  134 +-
 arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dts          |  222 +--
 arch/arm/boot/dts/imx6q-utilite-pro.dts            |    8 +
 arch/arm/boot/dts/imx6q-wandboard-revd1.dts        |   26 +
 arch/arm/boot/dts/imx6q.dtsi                       |   16 +-
 arch/arm/boot/dts/imx6qdl-apalis.dtsi              |    4 +-
 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi             |    4 +-
 arch/arm/boot/dts/imx6qdl-colibri.dtsi             |    4 +-
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi              |  300 ++--
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi              |  374 ++--
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi              |  360 ++--
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              |  390 +++--
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi              |  182 +-
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi              |  174 +-
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi        |    2 +-
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi           |   94 +-
 arch/arm/boot/dts/imx6qdl-icore.dtsi               |   97 ++
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi           |    4 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi       |    6 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi      |    6 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |    6 +-
 arch/arm/boot/dts/imx6qdl-rex.dtsi                 |    2 +-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |    2 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi           |    4 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |   14 +-
 arch/arm/boot/dts/imx6qdl-tx6-lcd.dtsi             |  252 +++
 arch/arm/boot/dts/imx6qdl-tx6-lvds.dtsi            |  286 +++
 arch/arm/boot/dts/imx6qdl-tx6-mb7.dtsi             |   99 ++
 arch/arm/boot/dts/imx6qdl-tx6.dtsi                 |  106 +-
 arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi     |  196 +++
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi           |    2 +-
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi            |    5 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |  178 +-
 arch/arm/boot/dts/imx6qp-tx6qp-8037-mb7.dts        |   48 +
 arch/arm/boot/dts/imx6qp-tx6qp-8037.dts            |   86 +
 arch/arm/boot/dts/imx6qp-tx6qp-8137-mb7.dts        |   57 +
 arch/arm/boot/dts/imx6qp-tx6qp-8137.dts            |   90 +
 arch/arm/boot/dts/imx6qp-wandboard-revd1.dts       |   26 +
 arch/arm/boot/dts/imx6qp.dtsi                      |    6 +-
 arch/arm/boot/dts/imx6sl-evk.dts                   |    2 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |  134 +-
 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts           |    2 +-
 arch/arm/boot/dts/imx6sx-sdb-reva.dts              |    2 +-
 arch/arm/boot/dts/imx6sx-sdb.dts                   |    2 +-
 arch/arm/boot/dts/imx6sx-softing-vining-2000.dts   |  572 ++++++
 arch/arm/boot/dts/imx6sx-udoo-neo.dtsi             |    2 +-
 arch/arm/boot/dts/imx6sx.dtsi                      |  199 ++-
 arch/arm/boot/dts/imx6ul-14x14-evk.dts             |    2 +
 arch/arm/boot/dts/imx6ul-pico-hobbit.dts           |    6 +-
 arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dts       |    2 +-
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi                |    4 +-
 arch/arm/boot/dts/imx6ul.dtsi                      |  161 +-
 arch/arm/boot/dts/imx7-colibri.dtsi                |    2 +-
 arch/arm/boot/dts/imx7d-nitrogen7.dts              |    2 +-
 arch/arm/boot/dts/imx7d-pico.dts                   |   43 +-
 arch/arm/boot/dts/imx7d-sdb.dts                    |    2 +-
 arch/arm/boot/dts/imx7s-warp.dts                   |    4 +-
 arch/arm/boot/dts/integrator.dtsi                  |   10 +-
 arch/arm/boot/dts/integratorap.dts                 |   25 +-
 arch/arm/boot/dts/iwg20d-q7-common.dtsi            |  152 ++
 arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi           |   43 +
 arch/arm/boot/dts/keystone-k2e.dtsi                |    6 +-
 arch/arm/boot/dts/keystone-k2g-evm.dts             |   93 +
 arch/arm/boot/dts/keystone-k2g.dtsi                |  242 ++-
 arch/arm/boot/dts/keystone-k2hk.dtsi               |    8 +-
 arch/arm/boot/dts/keystone-k2l.dtsi                |   12 +-
 arch/arm/boot/dts/keystone.dtsi                    |   12 +-
 arch/arm/boot/dts/kirkwood-synology.dtsi           |   12 +-
 arch/arm/boot/dts/kirkwood-ts219.dtsi              |   12 +-
 arch/arm/boot/dts/kirkwood.dtsi                    |    4 +-
 arch/arm/boot/dts/lpc3250-ea3250.dts               |    8 +-
 arch/arm/boot/dts/lpc3250-phy3250.dts              |   10 +-
 arch/arm/boot/dts/lpc32xx.dtsi                     |    2 +-
 arch/arm/boot/dts/meson.dtsi                       |   47 +-
 arch/arm/boot/dts/meson6.dtsi                      |    3 +
 arch/arm/boot/dts/meson8.dtsi                      |   40 +-
 arch/arm/boot/dts/meson8b-odroidc1.dts             |   23 +
 arch/arm/boot/dts/meson8b.dtsi                     |   59 +-
 arch/arm/boot/dts/mpa1600.dts                      |    2 +-
 arch/arm/boot/dts/mt2701-evb.dts                   |   23 +
 arch/arm/boot/dts/mt2701.dtsi                      |   13 +-
 arch/arm/boot/dts/mt6589.dtsi                      |    2 +-
 arch/arm/boot/dts/mt7623.dtsi                      |   30 +-
 arch/arm/boot/dts/nspire.dtsi                      |    2 +-
 arch/arm/boot/dts/omap2420-n8x0-common.dtsi        |    4 +
 arch/arm/boot/dts/omap3-evm-37xx.dts               |  209 +--
 arch/arm/boot/dts/omap3-evm-processor-common.dtsi  |  216 +++
 arch/arm/boot/dts/omap3-evm.dts                    |   76 +-
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi            |    2 +-
 arch/arm/boot/dts/omap3-n900.dts                   |    2 +-
 .../boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi    |    1 +
 arch/arm/boot/dts/omap3.dtsi                       |    1 +
 arch/arm/boot/dts/omap4-panda-common.dtsi          |    4 +
 arch/arm/boot/dts/omap4.dtsi                       |  256 ++-
 arch/arm/boot/dts/omap5-board-common.dtsi          |    4 +
 arch/arm/boot/dts/omap5.dtsi                       |    3 +-
 arch/arm/boot/dts/owl-s500-cubieboard6.dts         |   44 +
 arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts     |    7 +
 arch/arm/boot/dts/owl-s500.dtsi                    |    3 +
 arch/arm/boot/dts/ox810se.dtsi                     |    4 +-
 arch/arm/boot/dts/ox820.dtsi                       |    2 +-
 arch/arm/boot/dts/picoxcell-pc3x2.dtsi             |    2 +-
 arch/arm/boot/dts/picoxcell-pc3x3.dtsi             |    2 +-
 arch/arm/boot/dts/pm9g45.dts                       |    4 +-
 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts     |   12 +-
 arch/arm/boot/dts/qcom-apq8064.dtsi                |    5 +-
 arch/arm/boot/dts/qcom-msm8660.dtsi                |   89 +-
 arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts   |  321 ++++
 .../boot/dts/qcom-msm8974-sony-xperia-castor.dts   |  641 +++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi                |   30 +-
 arch/arm/boot/dts/qcom-msm8974pro.dtsi             |   18 +
 arch/arm/boot/dts/r7s72100-gr-peach.dts            |   73 +-
 arch/arm/boot/dts/r7s72100.dtsi                    |    1 +
 arch/arm/boot/dts/r8a73a4.dtsi                     |    1 +
 arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dts    |   19 +
 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts            |   42 +-
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi              |   43 +
 arch/arm/boot/dts/r8a7743.dtsi                     |  339 +++-
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts        |  109 ++
 arch/arm/boot/dts/r8a7745-iwg22m.dtsi              |  111 ++
 arch/arm/boot/dts/r8a7745.dtsi                     |  429 +++++
 arch/arm/boot/dts/r8a7778.dtsi                     |   11 +-
 arch/arm/boot/dts/r8a7779.dtsi                     |   18 +-
 arch/arm/boot/dts/r8a7790-lager.dts                |    7 +-
 arch/arm/boot/dts/r8a7790.dtsi                     |  783 +++------
 arch/arm/boot/dts/r8a7791-koelsch.dts              |    4 +-
 arch/arm/boot/dts/r8a7791-porter.dts               |    4 +-
 arch/arm/boot/dts/r8a7791.dtsi                     |  777 +++------
 arch/arm/boot/dts/r8a7792-blanche.dts              |    3 +-
 arch/arm/boot/dts/r8a7792-wheat.dts                |    3 +-
 arch/arm/boot/dts/r8a7792.dtsi                     |  409 ++---
 arch/arm/boot/dts/r8a7793-gose.dts                 |    4 +-
 arch/arm/boot/dts/r8a7793.dtsi                     |  643 +++----
 arch/arm/boot/dts/r8a7794-alt.dts                  |    7 +-
 arch/arm/boot/dts/r8a7794-silk.dts                 |    3 +-
 arch/arm/boot/dts/r8a7794.dtsi                     |  715 +++-----
 arch/arm/boot/dts/rk3036-kylin.dts                 |    5 +
 arch/arm/boot/dts/rk3036.dtsi                      |   19 +
 arch/arm/boot/dts/rk3066a-rayeager.dts             |    2 +-
 arch/arm/boot/dts/rk3066a.dtsi                     |   24 +
 arch/arm/boot/dts/rk3188-radxarock.dts             |    4 +
 arch/arm/boot/dts/rk3188.dtsi                      |   24 +
 arch/arm/boot/dts/rk322x.dtsi                      |   21 +
 arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi  |    2 +
 arch/arm/boot/dts/rk3288-firefly-reload.dts        |   11 +
 arch/arm/boot/dts/rk3288-popmetal.dts              |    2 +-
 arch/arm/boot/dts/rk3288-vyasa.dts                 |  498 ++++++
 arch/arm/boot/dts/rk3288.dtsi                      |   75 +-
 arch/arm/boot/dts/rk3xxx.dtsi                      |   11 +
 arch/arm/boot/dts/rv1108-evb.dts                   |    4 +
 arch/arm/boot/dts/rv1108.dtsi                      |   67 +
 arch/arm/boot/dts/sama5d2.dtsi                     |   12 +-
 arch/arm/boot/dts/sama5d3.dtsi                     |    8 +-
 arch/arm/boot/dts/sama5d3xmb.dtsi                  |    6 +-
 arch/arm/boot/dts/sama5d3xmb_cmp.dtsi              |    2 +-
 arch/arm/boot/dts/sama5d4.dtsi                     |   10 +-
 arch/arm/boot/dts/sh73a0.dtsi                      |    2 +
 arch/arm/boot/dts/ste-href-stuib.dtsi              |    2 +-
 arch/arm/boot/dts/ste-href-tvk1281618.dtsi         |    2 +-
 arch/arm/boot/dts/stih407-clock.dtsi               |    6 +-
 arch/arm/boot/dts/stih407-family.dtsi              |   18 +-
 arch/arm/boot/dts/stih407-pinctrl.dtsi             |   52 +-
 arch/arm/boot/dts/stih410-b2120.dts                |    2 +-
 arch/arm/boot/dts/stih410-b2260.dts                |    4 +-
 arch/arm/boot/dts/stih410-clock.dtsi               |    6 +-
 arch/arm/boot/dts/stih410.dtsi                     |    2 +-
 arch/arm/boot/dts/stih418-b2199.dts                |    4 +-
 arch/arm/boot/dts/stih418-clock.dtsi               |    6 +-
 arch/arm/boot/dts/stih418.dtsi                     |    2 +-
 arch/arm/boot/dts/stihxxx-b2120.dtsi               |    6 +-
 arch/arm/boot/dts/stm32746g-eval.dts               |   24 +
 arch/arm/boot/dts/stm32f4-pinctrl.dtsi             |  176 +-
 arch/arm/boot/dts/stm32f746-disco.dts              |   30 +
 arch/arm/boot/dts/stm32f746.dtsi                   |  363 +++-
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi           |   32 +-
 arch/arm/boot/dts/stm32h743.dtsi                   |  177 +-
 arch/arm/boot/dts/stm32h743i-eval.dts              |    2 +-
 arch/arm/boot/dts/sun4i-a10-a1000.dts              |   28 +-
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts         |   16 +-
 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts    |   20 +-
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts         |   45 +-
 arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts   |   50 +-
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts           |   23 +-
 arch/arm/boot/dts/sun4i-a10-hackberry.dts          |   24 +-
 arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts       |   10 +-
 arch/arm/boot/dts/sun4i-a10-inet1.dts              |   36 +-
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts          |   24 +-
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts       |   68 +-
 .../boot/dts/sun4i-a10-itead-iteaduino-plus.dts    |   21 +-
 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts         |   26 +-
 arch/arm/boot/dts/sun4i-a10-marsboard.dts          |   25 +-
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts         |   10 +-
 arch/arm/boot/dts/sun4i-a10-mk802.dts              |   24 +-
 arch/arm/boot/dts/sun4i-a10-mk802ii.dts            |    6 +-
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts     |   47 +-
 arch/arm/boot/dts/sun4i-a10-pcduino.dts            |   32 +-
 arch/arm/boot/dts/sun4i-a10-pcduino2.dts           |    9 -
 arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts   |   43 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                   | 1166 ++++++-------
 arch/arm/boot/dts/sun5i-a10s.dtsi                  |    6 +-
 arch/arm/boot/dts/sun5i-a13.dtsi                   |    4 +-
 arch/arm/boot/dts/sun5i-gr8.dtsi                   |    8 +-
 .../boot/dts/sun5i-reference-design-tablet.dtsi    |    8 +
 arch/arm/boot/dts/sun5i.dtsi                       |   86 +-
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts        |   21 +
 arch/arm/boot/dts/sun6i-a31.dtsi                   |  221 ++-
 arch/arm/boot/dts/sun6i-a31s-primo81.dts           |   25 +
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts           |   25 +
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts   |   25 +
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts        |   25 +
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         |   25 +
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts          |   33 +
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts     |   25 +
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts    |   25 +
 .../boot/dts/sun7i-a20-olinuxino-micro-emmc.dts    |   70 +
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts    |   44 +-
 arch/arm/boot/dts/sun7i-a20.dtsi                   | 1147 +++++-------
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               |   62 +-
 arch/arm/boot/dts/sun8i-a23.dtsi                   |    4 +-
 arch/arm/boot/dts/sun8i-a33.dtsi                   |   18 +-
 .../boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts  |  147 +-
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts       |  169 +-
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts   |  187 +-
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts          |  349 ++++
 arch/arm/boot/dts/sun8i-a83t.dtsi                  |   41 +-
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts  |    9 +
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    |   39 +-
 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts      |   71 +
 arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts           |    6 +
 arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts          |    7 +
 arch/arm/boot/dts/sun8i-h3-nanopi.dtsi             |    8 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts          |   16 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts       |    6 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts        |   14 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts    |    5 +
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         |   14 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts       |   24 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-plus2e.dts     |   16 +
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |  209 +++
 arch/arm/boot/dts/sun8i-r40.dtsi                   |  473 +++++
 arch/arm/boot/dts/sun8i-v3s.dtsi                   |   32 +-
 arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts  |  173 ++
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts        |   30 +-
 arch/arm/boot/dts/sun9i-a80-optimus.dts            |   50 +-
 arch/arm/boot/dts/sun9i-a80.dtsi                   |  117 +-
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 |  164 +-
 arch/arm/boot/dts/sunxi-itead-core-common.dtsi     |    4 -
 arch/arm/boot/dts/tango4-common.dtsi               |    2 +-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts          |    4 +
 arch/arm/boot/dts/tegra124.dtsi                    |   12 +-
 arch/arm/boot/dts/uniphier-ld4-ref.dts             |   10 +-
 arch/arm/boot/dts/uniphier-ld4.dtsi                |   25 +-
 arch/arm/boot/dts/uniphier-ld6b-ref.dts            |   10 +-
 arch/arm/boot/dts/uniphier-pinctrl.dtsi            |   46 +-
 arch/arm/boot/dts/uniphier-pro4-ref.dts            |   10 +-
 arch/arm/boot/dts/uniphier-pro4.dtsi               |   27 +-
 arch/arm/boot/dts/uniphier-pro5.dtsi               |   29 +-
 arch/arm/boot/dts/uniphier-pxs2.dtsi               |   80 +-
 arch/arm/boot/dts/uniphier-sld8-ref.dts            |   10 +-
 arch/arm/boot/dts/uniphier-sld8.dtsi               |   29 +-
 arch/arm/boot/dts/uniphier-support-card.dtsi       |    3 +-
 arch/arm/boot/dts/usb_a9263.dts                    |    2 +-
 arch/arm/boot/dts/usb_a9g20_common.dtsi            |    4 +-
 arch/arm/boot/dts/vf610-twr.dts                    |    2 +-
 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts          |    2 +-
 arch/arm/boot/dts/zx296702.dtsi                    |    4 +-
 arch/arm/boot/dts/zynq-zc702.dts                   |    2 +-
 arch/arm/boot/dts/zynq-zc706.dts                   |    2 +-
 arch/arm/mach-davinci/da8xx-dt.c                   |    1 +
 arch/arm64/Kconfig.platforms                       |    7 +
 arch/arm64/boot/dts/actions/s900-bubblegum-96.dts  |    7 +
 arch/arm64/boot/dts/allwinner/Makefile             |    1 +
 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts |   16 +
 .../boot/dts/allwinner/sun50i-a64-pine64-plus.dts  |   15 +
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |   26 +-
 .../dts/allwinner/sun50i-a64-sopine-baseboard.dts  |   16 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      |   97 +-
 .../dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts   |  193 +++
 .../boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts   |   17 +
 .../boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts  |   17 +
 .../dts/allwinner/sun50i-h5-orangepi-prime.dts     |   17 +
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |   38 +-
 .../boot/dts/altera/socfpga_stratix10_socdk.dts    |   62 +-
 arch/arm64/boot/dts/amlogic/Makefile               |    3 +
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts     |   22 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi         |  204 +++
 .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi |    2 +-
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          |   22 +-
 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts      |   14 +-
 .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    |   31 +-
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |   15 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts    |    2 +
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   |    2 +-
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      |    2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |   18 +-
 .../boot/dts/amlogic/meson-gxl-s905d-p230.dts      |    2 +
 .../dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts |    2 +-
 .../dts/amlogic/meson-gxl-s905x-khadas-vim.dts     |    8 +-
 .../dts/amlogic/meson-gxl-s905x-libretech-cc.dts   |   27 +-
 .../dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts    |    2 +-
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dtsi     |    2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |   26 +-
 .../boot/dts/amlogic/meson-gxm-khadas-vim2.dts     |  400 +++++
 .../arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts |    2 +-
 arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts     |    2 +
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts |    2 +-
 arch/arm64/boot/dts/amlogic/meson-gxm-vega-s96.dts |   38 +
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi         |    6 +-
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |    4 +-
 arch/arm64/boot/dts/arm/Makefile                   |    4 +-
 arch/arm64/boot/dts/arm/foundation-v8-gicv2.dtsi   |   19 +
 .../boot/dts/arm/foundation-v8-gicv3-psci.dts      |    9 +
 arch/arm64/boot/dts/arm/foundation-v8-gicv3.dts    |   25 +-
 arch/arm64/boot/dts/arm/foundation-v8-gicv3.dtsi   |   28 +
 arch/arm64/boot/dts/arm/foundation-v8-psci.dts     |    9 +
 arch/arm64/boot/dts/arm/foundation-v8-psci.dtsi    |   28 +
 .../boot/dts/arm/foundation-v8-spin-table.dtsi     |   25 +
 arch/arm64/boot/dts/arm/foundation-v8.dts          |   16 +-
 arch/arm64/boot/dts/arm/foundation-v8.dtsi         |   30 +-
 arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts         |    2 +-
 arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi   |   24 +-
 .../boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts      |    2 +-
 .../arm64/boot/dts/broadcom/northstar2/ns2-xmc.dts |    2 +-
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi   |    4 +-
 .../boot/dts/broadcom/stingray/stingray-clock.dtsi |   12 +-
 .../boot/dts/broadcom/stingray/stingray-fs4.dtsi   |    4 +-
 .../dts/broadcom/stingray/stingray-pinctrl.dtsi    |    4 +-
 .../boot/dts/broadcom/stingray/stingray-sata.dtsi  |   32 +-
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |   66 +-
 arch/arm64/boot/dts/cavium/thunder-88xx.dts        |    2 +-
 arch/arm64/boot/dts/cavium/thunder-88xx.dtsi       |   32 +-
 arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts  |   33 +
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     |   20 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |   11 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |   11 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     |   88 +
 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi     |    4 +
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |    7 +
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts  |  319 ++++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |    7 +
 .../boot/dts/hisilicon/hi3798cv200-poplar.dts      |   20 +-
 .../arm64/boot/dts/hisilicon/hi6220-coresight.dtsi |  381 ++++
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |    2 +
 arch/arm64/boot/dts/hisilicon/hip05-d02.dts        |    2 +-
 arch/arm64/boot/dts/hisilicon/hip06-d03.dts        |    2 +-
 arch/arm64/boot/dts/marvell/armada-3720-db.dts     |   20 +-
 .../boot/dts/marvell/armada-3720-espressobin.dts   |   12 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |   22 +-
 arch/arm64/boot/dts/marvell/armada-7040-db.dts     |   57 +-
 arch/arm64/boot/dts/marvell/armada-70x0.dtsi       |   14 +
 arch/arm64/boot/dts/marvell/armada-8040-db.dts     |   59 +-
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts  |   13 +-
 arch/arm64/boot/dts/marvell/armada-8080-db.dts     |    2 +-
 arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi |    4 +-
 arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi |    4 +-
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |   11 +
 .../dts/marvell/armada-ap810-ap0-octa-core.dtsi    |    4 +-
 .../boot/dts/marvell/armada-cp110-master.dtsi      |   59 +-
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi |   58 +-
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi         |    6 +-
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi          |   25 +
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts |   24 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  214 +++
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          |  177 +-
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       |   32 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   13 +-
 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi         |  195 +++
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |  191 +-
 arch/arm64/boot/dts/realtek/Makefile               |    2 +
 arch/arm64/boot/dts/realtek/rtd1295-mele-v9.dts    |   31 +
 .../arm64/boot/dts/realtek/rtd1295-probox2-ava.dts |   31 +
 arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts  |    6 -
 arch/arm64/boot/dts/realtek/rtd1295.dtsi           |   62 +-
 arch/arm64/boot/dts/realtek/rtd129x.dtsi           |   72 +
 arch/arm64/boot/dts/renesas/Makefile               |    4 +
 .../boot/dts/renesas/r8a7795-es1-h3ulcb-kf.dts     |   19 +
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi       |    2 +-
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb-kf.dts  |   19 +
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |   31 +-
 arch/arm64/boot/dts/renesas/r8a7796-m3ulcb-kf.dts  |   19 +
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           |   53 +-
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts     |   57 +
 arch/arm64/boot/dts/renesas/r8a77970.dtsi          |  382 ++++
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts     |   78 +
 arch/arm64/boot/dts/renesas/r8a77995.dtsi          |  267 ++-
 arch/arm64/boot/dts/renesas/salvator-common.dtsi   |   16 +-
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi           |  169 ++
 arch/arm64/boot/dts/renesas/ulcb.dtsi              |    9 +-
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts        |   72 +-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |   16 +
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts    |   27 +
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts  |    4 +
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       |    3 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   19 +-
 .../arm64/boot/dts/socionext/uniphier-ld11-ref.dts |   11 +-
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   |   65 +-
 .../arm64/boot/dts/socionext/uniphier-ld20-ref.dts |   11 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   |  105 +-
 .../arm64/boot/dts/socionext/uniphier-pxs3-ref.dts |    7 +-
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi   |   58 +-
 include/dt-bindings/clock/r7s72100-clock.h         |    2 +
 include/dt-bindings/clock/rk3188-cru-common.h      |    9 +-
 include/dt-bindings/clock/rk3368-cru.h             |    1 +
 include/dt-bindings/clock/tegra210-car.h           |    1 +
 include/dt-bindings/pinctrl/am43xx.h               |   12 +
 include/dt-bindings/pinctrl/stm32-pinfunc.h        |   30 +
 include/dt-bindings/pinctrl/stm32f429-pinfunc.h    | 1239 -------------
 include/dt-bindings/pinctrl/stm32f746-pinfunc.h    | 1324 --------------
 include/dt-bindings/pinctrl/stm32h7-pinfunc.h      | 1612 -----------------
 include/dt-bindings/power/r8a77970-sysc.h          |   32 +
 .../dt-bindings/thermal/tegra186-bpmp-thermal.h    |   14 +
 617 files changed, 28530 insertions(+), 15915 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic/analog-top.txt
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic/assist.txt
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic/bootrom.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,hr2.txt
 create mode 100644 Documentation/devicetree/bindings/bus/ti-sysc.txt
 create mode 100644 Documentation/devicetree/bindings/bus/ts-nbus.txt
 create mode 100644 Documentation/devicetree/bindings/misc/ge-achc.txt
 create mode 100644 Documentation/devicetree/bindings/net/dwmac-sun8i.txt
 create mode 100644 Documentation/devicetree/bindings/power/ti-smartreflex.txt
 create mode 100644
Documentation/devicetree/bindings/thermal/nvidia,tegra186-bpmp-thermal.txt
 create mode 100644 arch/arm/boot/dts/axp81x.dtsi
 create mode 100644 arch/arm/boot/dts/bcm-hr2.dtsi
 create mode 100644 arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts
 create mode 100644 arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts
 create mode 100644 arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
 create mode 100644 arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
 create mode 100644 arch/arm/boot/dts/bcm53340-ubnt-unifi-switch8.dts
 create mode 100644 arch/arm/boot/dts/exynos5422-odroid-core.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5422-odroidhc1.dts
 create mode 100644 arch/arm/boot/dts/imx51-zii-rdu1.dts
 create mode 100644 arch/arm/boot/dts/imx53-ppd.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-tx6s-8034-mb7.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-tx6s-8035-mb7.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-tx6u-8033-mb7.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-tx6u-80xx-mb7.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-wandboard-revd1.dts
 create mode 100644 arch/arm/boot/dts/imx6q-display5-tianma-tm070-1280x768.dts
 create mode 100644 arch/arm/boot/dts/imx6q-display5.dtsi
 create mode 100644 arch/arm/boot/dts/imx6q-pistachio.dts
 create mode 100644 arch/arm/boot/dts/imx6q-tx6q-1036-mb7.dts
 create mode 100644 arch/arm/boot/dts/imx6q-tx6q-10x0-mb7.dts
 create mode 100644 arch/arm/boot/dts/imx6q-wandboard-revd1.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-tx6-lcd.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-tx6-lvds.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-tx6-mb7.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qp-tx6qp-8037-mb7.dts
 create mode 100644 arch/arm/boot/dts/imx6qp-tx6qp-8037.dts
 create mode 100644 arch/arm/boot/dts/imx6qp-tx6qp-8137-mb7.dts
 create mode 100644 arch/arm/boot/dts/imx6qp-tx6qp-8137.dts
 create mode 100644 arch/arm/boot/dts/imx6qp-wandboard-revd1.dts
 create mode 100644 arch/arm/boot/dts/imx6sx-softing-vining-2000.dts
 create mode 100644 arch/arm/boot/dts/iwg20d-q7-common.dtsi
 create mode 100644 arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-evm-processor-common.dtsi
 create mode 100644 arch/arm/boot/dts/owl-s500-cubieboard6.dts
 create mode 100644 arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts
 create mode 100644 arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts
 create mode 100644 arch/arm/boot/dts/qcom-msm8974pro.dtsi
 create mode 100644 arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dts
 create mode 100644 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
 create mode 100644 arch/arm/boot/dts/r8a7745-iwg22m.dtsi
 create mode 100644 arch/arm/boot/dts/rk3288-vyasa.dts
 create mode 100644 arch/arm/boot/dts/sun7i-a20-olinuxino-micro-emmc.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
 create mode 100644 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
 create mode 100644 arch/arm/boot/dts/sun8i-r40.dtsi
 create mode 100644 arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-axg.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-vega-s96.dts
 create mode 100644 arch/arm64/boot/dts/arm/foundation-v8-gicv2.dtsi
 create mode 100644 arch/arm64/boot/dts/arm/foundation-v8-gicv3-psci.dts
 create mode 100644 arch/arm64/boot/dts/arm/foundation-v8-gicv3.dtsi
 create mode 100644 arch/arm64/boot/dts/arm/foundation-v8-psci.dts
 create mode 100644 arch/arm64/boot/dts/arm/foundation-v8-psci.dtsi
 create mode 100644 arch/arm64/boot/dts/arm/foundation-v8-spin-table.dtsi
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1295-mele-v9.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1295-probox2-ava.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd129x.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb-kf.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb-kf.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7796-m3ulcb-kf.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77970.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
 create mode 100644 include/dt-bindings/pinctrl/stm32-pinfunc.h
 delete mode 100644 include/dt-bindings/pinctrl/stm32f429-pinfunc.h
 delete mode 100644 include/dt-bindings/pinctrl/stm32f746-pinfunc.h
 delete mode 100644 include/dt-bindings/pinctrl/stm32h7-pinfunc.h
 create mode 100644 include/dt-bindings/power/r8a77970-sysc.h
 create mode 100644 include/dt-bindings/thermal/tegra186-bpmp-thermal.h
