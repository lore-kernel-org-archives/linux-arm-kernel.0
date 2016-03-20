From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 20 Mar 2016 21:59:46 +0100
Subject: [GIT PULL 5/8] ARM: DT updates for v4.6
In-Reply-To: <10465240.PKeEEAAbCF@wuerfel>
References: <10465240.PKeEEAAbCF@wuerfel>
Message-ID: <3475971.PCyzFcSY1x@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 949024d6702d1da8a266f42226d8402f0df078dc:

  ARM: dts: porter: remove enable prop from HS-USB device node (2016-03-02 09:46:56 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt

for you to fetch changes up to 2ef7d5f342c12c02e68da225c0715b0c9cefce70:

  ARM, ARM64: dts: drop "arm,amba-bus" in favor of "simple-bus" (2016-03-12 17:40:34 -0800)

----------------------------------------------------------------
ARM: DT updates for v4.6

These are all the updates to device tree files for 32-bit platforms,
plus a couple of related 64-bit updates:

New SoC support:
 - Allwinner A83T
 - Axis Artpec-6 SoC
 - Mediatek MT7623 SoC
 - TI Keystone K2G SoC
 - ST Microelectronics stm32f469

New board or machine support:
 - ARM Juno R2
 - Buffalo Linkstation LS-QVL and LS-GL
 - Cubietruck plus
 - D-Link DIR-885L
 - DT support for ARM RealView PB1176 and PB11MPCore
 - Google Nexus 7
 - Homlet v2
 - Itead Ibox
 - Lamobo R1
 - LG Optimus Black
 - Logicpd dm3730
 - Raspberry Pi Model A

Other changes include
 - Lots of updates for Qualcomm APQ8064, MSM8974 and others
 - Improved support for Nokia N900 and other OMAP machines
 - Common clk support for lpc32xx
 - HDLCD display on ARM
 - Improved stm32f429 support
 - Improved Renesas device support, r8a779x and others
 - Lots of Rockchip updates
 - Samsung cleanups
 - ADC support for Atmel SAMA5D2
 - BCM2835 (Raspberry Pi) improvements
 - Broadcom Northstar Plus enhancements
 - OMAP GPMC rework
 - Several improvements for Atmel SAMA5D2 / Xplained
 - Global change to remove inofficial "arm,amba-bus" compatible string

----------------------------------------------------------------
Aaro Koskinen (4):
      ARM: dts: kirkwood: fix pin names for UART/SD selection for OpenRD
      ARM: dts: kirkwood: fix SD slot default configuration for OpenRD
      ARM: dts: kirkwood: provide template for RS-232/485 configuration for OpenRD
      ARM: dts: kirkwood: fix audio for OpenRD clients

Adam Ford (9):
      ARM: dts: LogicPD Torpedo: Add MT9P031 Support
      ARM: dts: LogicPD Torpedo: Add AT24 EEPROM Support
      ARM: dts: LogicPD Torpedo: Fix Panel Sleep
      ARM: dts: LogicPD Torpedo: Add SPI EEPROM
      ARM: dts: LogicPD Torpedo: Set HSUSB0 Pin Mux
      ARM: dts: omap3logic: Add PWM-Backlight
      ARM: DTS: Add minimal Support for Logic PD DM3730 SOM-LV
      ARM: dts: Add HSUSB2 EHCI Support to Logic PD DM37xx SOM-LV
      ARM: dts: dm3730-torpedo-devkit: Add "Wireless" to model

Addy Ke (1):
      ARM: dts: rockchip: Add arm, pl330-broken-no-flushp quirk for rk3288 platform

Alexander Aring (1):
      ARM: bcm2835: Add the Raspberry Pi power domain driver to the DT.

Alexandre TORGUE (3):
      ARM: dts: stm32f429: Add system config bank node
      ARM: dts: stm32f429: Add Ethernet support
      ARM: dts: stm32f429: Enable Ethernet on Eval board

Andre Przywara (4):
      arm64: dts: prepare foundation-v8.dts to cope with GICv3
      arm64: dts: Foundation model: increase GICC region to allow EOImode=1
      arm64: dts: split Foundation model dts to put the GIC separately
      arm64: dts: add .dts for GICv3 Foundation model

Andy Yan (2):
      ARM: dts: rockchip: enable pwm3 as pwm regulator for rk3066a based boards
      ARM: dts: rockchip: increase vdd_arm voltage for rk3066a based boards

Antoine Tenart (1):
      ARM: dts: alpine: add the MSIX node

Arnd Bergmann (16):
      Merge tag 'v4.5-next-dts' of https://github.com/mbgg/linux-mediatek into next/dt
      Merge tag 'omap-for-v4.6/dt-pt1' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'keystone_dts_for_4.6_v2' of git://git.kernel.org/.../ssantosh/linux-keystone into next/dt
      Merge tag 'zynq-dt-for-4.6' of https://github.com/Xilinx/linux-xlnx into next/dt
      Merge tag 'arm-soc/for-4.6/devicetree' of http://github.com/Broadcom/stblinux into next/dt
      Revert "arm: dts: Add pinctrl/GPIO/EINT node for mt2701"
      Merge tag 'renesas-dt2-for-v4.6' of git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'mvebu-dt-4.6-2' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'sunxi-dt-for-4.6' of https://git.kernel.org/.../mripard/linux into next/dt
      Merge tag 'pxa-dt-4.6' of https://github.com/rjarzmik/linux into next/dt
      Merge tag 'qcom-dt-for-4.6' of git://git.kernel.org/.../agross/linux into next/dt
      Merge tag 'samsung-dt-4.6-2' of git://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'omap-for-v4.6/dt-pt2' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'stm32-dt-for-v4.6-2' of git://git.kernel.org/.../mcoquelin/stm32 into next/dt
      Merge tag 'at91-dt2' of git://git.kernel.org/.../nferre/linux-at91 into next/dt
      Merge tag 'renesas-dt-fixes2-for-v4.5' of git://git.kernel.org/.../horms/renesas into next/dt

Bartlomiej Zolnierkiewicz (2):
      ARM: dts: Add cluster regulator supply properties for exynos542x/5800
      ARM: dts: Extend existing CPU OPP for exynos5800

Biao Huang (1):
      arm: dts: Add pinctrl/GPIO/EINT node for mt2701

Bjorn Andersson (3):
      ARM: dts: qcom: msm8974: Add additional reserved regions
      ARM: dts: qcom: msm8974: Add smsm node
      ARM: dts: qcom: msm8974: Add WCNSS SMP2P node

Caesar Wang (11):
      ARM: dts: rockchip: set the pinctrl default setting for rk3036 i2s
      ARM: dts: rockchip: add the sound setup for rk3036-kylin board
      ARM: dts: rockchip: enable the uart0 for kylin board
      ARM: dts: rockchip: enable the high speed on sdio for kylin board
      ARM: dts: rockchip: add the sdio power sequence for kylin board
      ARM: dts: rockchip: add the sdmmc for kylin board
      ARM: dts: rockchip: add soc-specific compatibles for rk3036 SoCs
      ARM: dts: rockchip: add the leds control for rk3036-kylin board
      ARM: dts: rockchip: add mclk for rt5616 on rk3036 kylin board
      ARM: dts: rockchip: support the spi for rk3036
      ARM: dts: rockchip: add arm,pl330-broken-no-flushp quirk for rk3036 SoCs

Chen-Yu Tsai (14):
      ARM: dts: sun8i: Add watchdog device node for A83T
      ARM: dts: sun8i: Add device tree for Cubietruck Plus
      ARM: dts: sun8i: sina33: Enable hardware reset and HS-DDR for eMMC
      ARM: dts: sun9i: Use sun9i specific mmc compatible
      ARM: dts: sun6i: Add mmc3 pins for 8 bit emmc
      ARM: dts: sun6i: sina31s: Switch to mmc3 for onboard eMMC
      ARM: dts: sun8i: Include SDC2_RST pin in mmc2_8bit_pins
      ARM: dts: sun9i: Include SDC2_RST pin in mmc2_8bit_pins
      ARM: dts: sun9i: a80-optimus: Enable hardware reset and HS-DDR for eMMC
      ARM: dts: sun9i: cubieboard4: Enable hardware reset and HS-DDR for eMMC
      ARM: dts: sun9i: a80-optimus: Remove i2c3 and uart4
      ARM: dts: sun8i-a83t: Correct low speed oscillator clocks
      ARM: dts: sun8i: sinlinx-sina33: Add AXP223 PMIC device and regulator nodes
      ARM: dts: sun8i: q8-common: Add AXP223 PMIC device and regulator nodes

Chris Zhong (1):
      ARM: dts: rockchip: add rk3288 mipi_dsi nodes

Cyrille Pitchen (1):
      ARM: dts: at91: sama5d2 Xplained: set pin muxing for usb gadget and usb host

Enric Balletbo i Serra (3):
      ARM: dts: igep00x0: Specify the device to be used for boot console output.
      ARM: dts: am335x-sl50: Specify the device to be used for boot console output.
      ARM: dts: am335x-sl50: Fix audio codec setup.

Felipe Balbi (1):
      ARM: dts: remove deprecated property dwc3

Florian Fainelli (1):
      Merge tag 'bcm2835-dt-next-2016-02-17' into devicetree/next

Fu Wei (1):
      arm64: dts: foundation-v8: add SBSA Generic Watchdog device node

Geert Uytterhoeven (25):
      ARM: dts: r8a7778: Add SCIF fallback compatibility strings
      ARM: dts: r8a7779: Add SCIF fallback compatibility strings
      ARM: dts: r8a7790: Add SCIF fallback compatibility strings
      ARM: dts: r8a7791: Add SCIF fallback compatibility strings
      ARM: dts: r8a7793: Add SCIF fallback compatibility strings
      ARM: dts: r8a7794: Add SCIF fallback compatibility strings
      ARM: dts: r8a7778: Add BRG support for SCIF
      ARM: dts: r8a7779: Add BRG support for SCIF
      ARM: dts: r8a7790: Add BRG support for (H)SCIF
      ARM: dts: r8a7791: Add BRG support for (H)SCIF
      ARM: dts: r8a7793: Add BRG support for SCIF
      ARM: dts: r8a7794: Add BRG support for (H)SCIF
      ARM: dts: alt: Enable SCIF_CLK frequency and pins
      ARM: dts: bockw: Enable SCIF_CLK frequency and pins
      ARM: dts: gose: Enable SCIF_CLK frequency and pins
      ARM: dts: koelsch: Enable SCIF_CLK frequency and pins
      ARM: dts: lager: Enable SCIF_CLK frequency and pins
      ARM: dts: marzen: Enable SCIF_CLK frequency and pins
      ARM: dts: porter: Enable SCIF_CLK frequency and pins
      ARM: dts: silk: Enable SCIF_CLK frequency and pins
      ARM: dts: r8a73a4: Add L2 cache-controller nodes
      ARM: dts: r8a7790: Add L2 cache-controller nodes
      ARM: dts: r8a7791: Add L2 cache-controller node
      ARM: dts: r8a7793: Add L2 cache-controller node
      ARM: dts: r8a7794: Add L2 cache-controller node

Georgi Djakov (1):
      arm: dts: qcom: apq8064: Add RPMCC DT node

Gregory CLEMENT (3):
      ARM: dts: armada-38x: use usb-nop-xceiv PHY for the xhci nodes on Armada 388 GP
      ARM: dts: armada-370: Update the mpp63 function in the device tree on Armada 370
      Merge branch 'mvebu/fixes' into mvebu/dt

Hakjoo Kim (1):
      ARM: dts: Add pinctrl support to exynos5410

Hans de Goede (4):
      ARM: dts: sun4i: Add touchscreen node to inet9f-rev03 tablet dts file
      ARM: dts: sun4i: Add touchscreen node to chuwi-v7 dts file
      ARM: dts: sun4i: Add touchscreen node to inet97fv2 dts file
      ARM: dts: sun8i: Add ir receiver nodes to H3 dtsi

Heiko Stuebner (3):
      ARM: dts: rockchip: swap i2s clock ordering on rk3036
      ARM: dts: rockchip: add clock-cells for usb phy nodes
      Merge branch 'v4.6-shared/clkids' into v4.6-armsoc/dts32

Ivaylo Dimitrov (1):
      ARM: dts: omap3-n900: Allow gpio keys to be disabled

James Chao (1):
      ARM: dts: cros-ec-keyboard: Add LOCK key to keyboard matrix

Javier Martinez Canillas (1):
      ARM: dts: exynos: Move syscon reboot/poweroff to common dtsi

Jelle de Jong (1):
      ARM: dts: sun7i: Add dts file for the lamobo-r1 board

John Crispin (3):
      Document: DT: Add bindings for mediatek MT7623 SoC Platform
      ARM: dts: mediatek: add MT7623 basic support
      ARM: dts: mt7623: enable SMP bringup

John Stultz (2):
      devicetree: qcom-apq8064.dtsi: Add i2c3 address-cells and size-cells values
      devicetree: Add DTS file to support the Nexus7 2013 (flo) device.

Jon Mason (5):
      ARM: dts: NSP: Fix PCIE DT issue
      ARM: dts: NSP: Fix CPU DT issue
      ARM: dts: NSP: Add PMU Support to DT
      ARM: dts: NSP: Add SP804 Support to DT
      ARM: dts: NSP: Add SP805 Support to DT

Keerthy (4):
      ARM: dts: DRA7: Add DSPEVE thermal data
      ARM: dts: DRA7: Add IVA thermal data
      ARM: dts: DRA7: Add missing IVA and DSPEVE thermal domain data
      ARM: dts: am43x-epos-evm: Add the am438 compatible string

Kishon Vijay Abraham I (4):
      ARM: dts: dra7: Add dt node for the sycon pcie
      ARM: dts: dra7: Use "syscon-phy-power" and "syscon-pcs" in PCIe PHY node
      ARM: dts: dra7: Use "ti,dra7x-usb2-phy2" compatible string for USB2 PHY2
      ARM: dts: am4372/dra7/omap5: Use "syscon-phy-power" instead of "ctrl-module"

Krzysztof Adamski (4):
      ARM: dts: sunxi: Fix #interrupt-cells for PIO in H3
      dts: sun8i-h3: Add APB0 related clocks and resets
      ARM: dts: sun8i-h3: Add R_PIO controller node to the dtsi
      ARM: dts: sun8i: Add leds and switch on Orangepi Plus boards

Krzysztof Kozlowski (6):
      Merge tag 'samsung-dt-srom-4.6' into next/dt
      ARM: dts: Allow simultaneous usage exynos-rng and s5p-sss drivers on exynos5
      ARM: dts: Make CPU configuration more readable on exynos542x/5800
      ARM: dts: exynos: Add cooling levels for Exynos5420 CPUs
      ARM: dts: exynos: Add cooling levels for Exynos5422/5800 CPUs
      ARM: dts: exynos: Don't overheat the Odroid XU3-Lite on high load

Kuninori Morimoto (3):
      ARM: dts: r8a7790: enable to use thermal-zone
      ARM: dts: r8a7791: enable to use thermal-zone
      ARM: dts: r8a7793: enable to use thermal-zone

Lars Persson (4):
      ARM: add device-tree SoC bindings for Axis Artpec-6
      ARM: dts: artpeg: add Artpec-6 SoC dtsi file
      ARM: dts: artpec: add Artpec-6 development board dts
      ARM: dts: artpec: dual-license on artpec6.dtsi

Laurent Pinchart (11):
      ARM: dts: r8a7793: Add I2C master nodes to DT
      ARM: dts: sh73a0: Rename the serial port clock to fck
      ARM: dts: r7s72100: Rename the serial port clock to fck
      ARM: dts: r8a73a4: Rename the serial port clock to fck
      ARM: dts: r8a7740: Rename the serial port clock to fck
      ARM: dts: r8a7778: Rename the serial port clock to fck
      ARM: dts: r8a7779: Rename the serial port clock to fck
      ARM: dts: r8a7790: Rename the serial port clock to fck
      ARM: dts: r8a7791: Rename the serial port clock to fck
      ARM: dts: r8a7793: Rename the serial port clock to fck
      ARM: dts: r8a7794: Rename the serial port clock to fck

Lee Jones (1):
      ARM: stm32: Supply a DTS file for the STM32F469 Discovery board

Linus Walleij (9):
      ARM: realview: add flash devices to the PB1176 DTS
      ARM: realview: fix up PB11MP flash compat strings
      ARM: pb1176: add ICST307 clocks to the device tree
      ARM: pb1176: add AACI to the device tree
      ARM: pb1176: add ISP1761 USB OTG host controller
      ARM: pb1176: add ethernet to devicetree
      ARM: realview: add the DS1338 RTC to PB1176 DT
      ARM: versatile: move restart to the device tree
      ARM: dts: ux500: add synaptics RMI4 for Ux500 TVK DT

Lior Amsalem (1):
      ARM: dts: armada-375: use armada-370-sata for SATA

Liviu Dudau (2):
      Documentation: drm: Add DT bindings for ARM HDLCD
      arm64: dts: Add HDLCD support on Juno platforms

Lokesh Vutla (1):
      ARM: dts: DRA7: change address-cells and size-cells

Louis Yu (1):
      ARM: dts: mt2701: enable basic SMP bringup for mt2701

Lubomir Rintel (1):
      ARM: bcm2835: dt: Add Raspberry Pi Model A

Ludovic Desroches (3):
      ARM: dts: at91: sama5d2: add adc device
      ARM: dts: at91: sama5d2 Xplained: enable the adc device
      ARM: dts: at91: sama5d2 Xplained: add user push button

M'boumba Cedric Madianga (1):
      ARM: dts: Add STM32 DMA support for STM32F429 MCU

Magnus Damm (1):
      ARM: dts: r8a7793: gose: Add HDMI video out support

Marcus Cooper (6):
      ARM: dts: sunxi: Add sunxi-itead-core-common.dtsi
      ARM: dts: sun7i: Add Itead Ibox support
      ARM: dts: sun4i: Itead Iteaduino to use common code
      ARM: dts: sun7i: Enable USB DRC on MK808C
      ARM: dts: sun7i: Enable USB DRC on Olimex A20 EVB
      ARM: dts: sun4i: Enable USB DRC on the MK802

Marek Szyprowski (1):
      ARM: dts: Add GSCL block parent clock management to pm domain on exynos542x

Mario Lange (1):
      ARM: dts: kirkwood: add device tree for buffalo linkstation ls-qvl

Martin Sperl (3):
      ARM: bcm2835: add the auxiliary spi1 and spi2 to the device tree
      ARM: bcm2835: follow dt uart node-naming convention
      ARM: bcm2835: add bcm2835-aux-uart support to DT

Masahiro Yamada (1):
      ARM, ARM64: dts: drop "arm,amba-bus" in favor of "simple-bus"

Maxime Coquelin (7):
      includes: dt-bindings: Add STM32F429 pinctrl DT bindings
      ARM: dts: Add pinctrl node to STM32F429
      ARM: dts: Add USART1 pin config to STM32F429 boards
      ARM: dts: Add leds support to STM32F429 boards
      ARM: dts: stm32f429: Boost perfs by remapping SDRAM Bank 1 to 0x0
      ARM: dts: stm32f429: Fix clocks referenced by GPIO banks
      ARM: dts: stm32429i-eval: Add USB HS host mode support

Maxime Ripard (1):
      ARM: sun5i: chip: Add CPU regulator for cpufreq

Michal Simek (1):
      ARM: zynq: Use earlycon instead of earlyprintk

Minghuan Lian (1):
      dts/ls2080a: Update PCIe compatible

Nathan Rossi (1):
      ARM: dts: zynq: Enable USB and USB PHY for ZYBO

Nicolas Ferre (1):
      ARM: dts: at91: sama5d2: add dma properties to UART nodes

Nishanth Menon (2):
      ARM: dts: am57xx-beagle-x15: Add eeprom information
      ARM: keystone: Create new binding for K2G SoC

Olof Johansson (10):
      Merge tag 'mvebu-dt-4.6-1' of git://git.infradead.org/linux-mvebu into next/dt
      Merge branch 'lpc32xx/dt' of https://github.com/vzapolskiy/linux into next/dt
      Merge tag 'vexpress-for-v4.6/dt-updates' of git://git.kernel.org/.../sudeep.holla/linux into next/dt
      Merge tag 'stm32-dt-for-v4.6-1' of git://git.kernel.org/.../mcoquelin/stm32 into next/dt
      Merge tag 'v4.6-rockchip-dts32-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'renesas-dt-for-v4.6' of git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'samsung-dt-4.6' of git://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'versatile-dt-cleanup-1' of git://git.kernel.org/.../linusw/linux-integrator into next/dt
      Merge tag 'at91-ab-4.6-dt' of git://git.kernel.org/.../abelloni/linux into next/dt
      Merge tag 'vexpress-for-v4.6/dt-updates-2' of git://git.kernel.org/.../sudeep.holla/linux into next/dt

Pali Roh?r (3):
      ARM: dts: n900: Include adp1653 device
      ARM: dts: omap3: Include missing bandgap data for ti-soc-thermal driver
      ARM: dts: n900: Use linux input defines instead hardcoded constants

Pankaj Dubey (2):
      ARM: dts: Add SROM device node for exynos4
      ARM: dts: Add SROM device node for exynos5

Pau Pajuel (1):
      ARM: dts: omap3-igep0030-common: Add USB Host support

Paul Kocialkowski (3):
      ARM: dts: LG Optimus Black codename sniper basic support
      ARM: dts: omap3-sniper: USB OTG support
      ARM: dts: omap3-sniper: TWL4030 keypad support

Pavel Fedin (2):
      ARM: dts: Add SROM to exynos5410
      ARM: dts: Add Ethernet chip to exynos5410-smdk5410

Pawe? Jarosz (2):
      clk: rockchip: Add new id for rk3066 tsadc clock
      ARM: dts: rockchip: add tsadc node

Peter Korsgaard (1):
      ARM: dts: sun4i: Enable USB DRC on Hyundai-a7hd

Rafa? Mi?ecki (1):
      ARM: BCM5301X: Add DT for D-Link DIR-885L

Remi Pommarel (1):
      ARM: bcm2835: Add PWM clock support to the device tree

Robert Jarzmik (1):
      ARM: dts: pxa: fix dma engine node to pxa3xx-nand

Roger Quadros (11):
      ARM: dts: dra7: Fix NAND device nodes
      ARM: dts: dra7: Remove redundant nand property
      ARM: dts: am437x: Fix NAND device nodes
      ARM: dts: am437x: Disable wait pin monitoring for NAND
      ARM: dts: am335x: Fix NAND device nodes
      ARM: dts: am335x: Disable wait pin monitoring for NAND
      ARM: dts: dm816x: Fix NAND device nodes
      ARM: dts: dm8168-evm: ARM: dts: Disable wait pin monitoring for NAND
      ARM: dts: omap3: Fix NAND device nodes
      ARM: dts: dm814x: dra62x: Fix NAND device nodes
      ARM: dts: dm814x: dra62x: Disable wait pin monitoring for NAND

Roger Shimizu (5):
      ARM: dts: kirkwood: relicense dts of ls-wvl/vl and ls-wxl/wsxl under GPLv2/X11
      ARM: dts: kirkwood: split lswxl dts to linkstation lswsxl and lswxl
      ARM: dts: kirkwood: split lswvl dts to linkstation lsvl and lswvl
      ARM: dts: orion5x: split linkstation lswtgl into common and device parts
      ARM: dts: orion5x: add device tree for buffalo linkstation ls-gl

Romain Izard (2):
      ARM: dts: at91: sama5d2 Xplained: Correct the macb irq pinctrl node
      ARM: dts: at91: sama5d2: add nand0 and nfc0 nodes

Romain Perier (1):
      ARM: dts: rockchip: Add LEDs via gpio-leds for Radxa Rock2 Square

Sebastian Reichel (4):
      ARM: dts: N950: Add wlan support
      ARM: dts: OMAP3-N950-N9: Enable SSI module
      ARM: dts: OMAP3-N950-N9: Enable modem
      ARM: dts: OMAP3-N950-N9: Add ssi idle pinctrl state

Sergei Shtylyov (6):
      ARM: dts: porter: add DU DT support
      ARM: dts: silk: add DU DT support
      ARM: dts: porter: add sound support
      ARM: dts: porter: fix JP3 jumper description
      ARM: dts: r8a7794: add EtherAVB clock
      ARM: dts: r8a7794: add EtherAVB support

Shawn Lin (3):
      dt-bindings: rockchip-dw-mshc: add RK3368 dw-mshc description
      dt-bindings: rockchip-dw-mshc: add RK3036 dw-mshc description
      ARM: dts: rockchip: Add arm, pl330-broken-no-flushp quirk for rk3xxx platform

Simon Horman (40):
      ARM: dts: gose: Add GPIO keys to DT
      ARM: dts: gose: Add GPIO leds to DT
      ARM: dts: alt: Add QSPI device to DT
      ARM: dts: r8a7790: use fallback usbhs compatibility string
      ARM: dts: r8a7791: use fallback usbhs compatibility string
      ARM: dts: r8a7794: use fallback usbhs compatibility string
      ARM: dts: r8a7793: move dmac nodes
      ARM: dts: gose: add i2c2 bus to device tree
      ARM: dts: r8a7790: use GIC_* defines
      ARM: dts: r8a7791: use GIC_* defines
      ARM: dts: r8a7793: use GIC_* defines
      ARM: dts: r8a7794: use GIC_* defines
      ARM: dts: r8a7778: use GIC_* defines
      ARM: dts: r8a7779: use GIC_* defines
      ARM: dts: r8a73a4: use GIC_* defines
      ARM: dts: r8a7740: use GIC_* defines
      ARM: dts: r8a7793: add MSTP10 clocks to device tree
      ARM: dts: r8a7793: add audio clock to device tree
      ARM: dts: r8a7793: add m2 clock to device tree
      ARM: dts: r8a7793: add R-Car sound support to device tree
      ARM: dts: r8a7793: add DVC support to device tree
      ARM: dts: r8a7793: add audio DMAC clocks to device tree
      ARM: dts: r8a7793: add audio DMAC to device tree
      ARM: dts: r8a7793: enable Audio DMAC peri peri via sound driver
      ARM: dts: gose: Enable sound PIO support in device tree
      ARM: dts: gose: enable sound DMA support in device tree
      ARM: dts: gose: enable sound DMA support via BUSIF in device tree
      ARM: dts: gose: enable sound DMA support via SRC in device tree
      ARM: dts: gose: enable sound DMA support via DVC in device tree
      ARM: dts: r8a7793: enable audio DMAC in device tree
      ARM: dts: r7s72100: use GIC_* defines
      ARM: dts: sh73a0: use GIC_* defines
      ARM: dts: emev2: use GIC_* defines
      ARM: dts: r8a7790: use fallback pcie compatibility string
      ARM: dts: r8a7791: use fallback pcie compatibility string
      ARM: dts: r8a7790: use fallback pci compatibility string
      ARM: dts: r8a7791: use fallback pci compatibility string
      ARM: dts: r8a7794: use fallback pci compatibility string
      ARM: dts: r8a7794: replace gpio-key, wakeup with wakeup-source property
      ARM: dts: r8a7790: use fallback etheravb compatibility string

Simran Rai (1):
      ARM: dts: Add audio clock to the existing Broadcom Cygnus clock DT

Sjoerd Simons (3):
      ARM: dts: rockchip: Add the iodomains for the Rock2 SOM
      ARM: dts: rockchip: Add the SDIO wifi on Radxa Rock2 square
      ARM: dts: rockchip: Assign RK3288 EDP_24M input centrally

Sricharan R (2):
      dts: msm8974: Add blsp2_bam dma node
      dts: msm8974: Add dma channels for blsp2_i2c1 node

Srinivas Kandagatla (11):
      ARM: dts: qcom: fix i2c lables to be inline with others
      ARM: dts: apq8064: move pinctrls to dedicated dtsi
      ARM: dts: apq8064: add pci support in CM QS600
      ARM: dts: apq8064: add i2c sleep pinctrl states.
      ARM: dts: apq8064: add spi5 device node.
      ARM: dts: ifc6410: enable spi device on expansion
      ARM: dts: apq8064: add missing i2c2 pinctrl info
      ARM: dts: apq8064: add gsbi4 with i2c node.
      ARM: dts: ifc6410: enable cam i2c device
      ARM: dts: apq8064: add i2c6 device node.
      ARM: dts: ifc6410: add correct aliases to the i2c and spi bus

Stephen Boyd (4):
      devicetree: bindings: Document Kryo cpu
      arm: dts: qcom: Add more board clocks
      devicetree: bindings: Document qcom board compatible format
      ARM: dts: qcom: Remove size elements from pmic reg properties

Sudeep Holla (7):
      ARM: dts: Replace legacy *,wakeup property with wakeup-source on s5pv210
      ARM: dts: Replace legacy *,wakeup property with wakeup-source for exynos boards
      arm64: dts: move juno pcie-controller to base file
      arm64: dts: Add support for Juno r2 board
      ARM: dts: rockchip: replace gpio-key,wakeup with wakeup-source property
      ARM: dts: spear: replace gpio-key,wakeup with wakeup-source property
      arm64: dts: juno/vexpress: fix node name unit-address presence warnings

Thomas Abraham (1):
      ARM: dts: Add CPU OPP properties for exynos542x/5800

Thomas Petazzoni (5):
      ARM: dts: armada-38x: adjust board name and compatible for Armada 388 GP
      ARM: dts: armada-38x: use regulator-boot-on for SATA regulators on Armada 388 GP
      ARM: dts: armada-38x: change order of ethernet DT nodes on Armada 38x
      ARM: dts: armada-38x: add reference to ETH connectors for A385-AP
      ARM: dts: mvebu: add NAND description to Armada 370 DB and Armada XP DB

Tony Lindgren (9):
      ARM: dts: The rate for auxclk is 22.59792 by default
      ARM: dts: Add support for GPMC for dm814x and dra62x
      ARM: dts: Add NAND support for j5-eco evm
      ARM: dts: Add NAND support for dm8148-evm
      Merge branch 'n900-keys' into omap-for-v4.6/dt
      Merge branch 'omap-for-v4.6/dt-gpmc' into omap-for-v4.6/dt
      ARM: dts: Add RTC entry for dm814x and dra62x
      ARM: dts: Add RTC entry for dm816x
      Revert "ARM: dts: DRA7: Add dt nodes for PWMSS"

Uri Mashiach (4):
      ARM: dts: cm-t335: Add support for CAN bus
      ARM: dts: cm-t335: add touchscreen support
      ARM: dts: cm-t335: add audio support
      ARM: dts: add spi wifi support to cm-t335

Vignesh R (2):
      ARM: dts: DRA7: Add TBCLK for PWMSS
      ARM: dts: DRA7: Add dt nodes for PWMSS

Vishnu Patekar (3):
      ARM: dts: sun8i: Add Allwinner A83T dtsi
      ARM: dts: sun8i: Add A83T HomletV2 Board by Allwinner
      ARM: dts: sun8i: Enable timer node for A83T

Vitaly Andrianov (2):
      ARM: dts: keystone: Add Initial DT support for TI K2G SoC family
      ARM: dts: keystone: Add minimum support for K2G evm

Vladimir Zapolskiy (9):
      dt-bindings: create arm/nxp folder and move LPC32xx SoC description to it
      arm: dts: lpc32xx: add device nodes for external oscillators
      arm: dts: lpc32xx: add clock controller device node
      arm: dts: lpc32xx: add clock properties to device nodes
      arm: dts: lpc32xx: add USB clock controller
      arm: dts: lpc32xx: remove clock frequency property from UART device nodes
      arm: dts: lpc32xx: assign interrupt types
      arm: dts: phy3250: add lcd and backlight fixed regulators
      arm: dts: phy3250: add SD fixed regulator

Wadim Egorov (1):
      ARM: dts: rockchip: Bump sd card pin drive strength up on firefly boards

Wenyou Yang (1):
      ARM: dts: at91: sama5d2 Xplained: add leds node

Wolfram Sang (1):
      ARM: dts: r8a7790: lager: use demuxer for IIC0/I2C0

Xing Zheng (1):
      ARM: dts: rockchip: increase the mclk_fs to 512 for kylin board

Yendapally Reddy Dhananjaya Reddy (1):
      ARM: dts: enable GPIO-a for Broadcom NSP

 Documentation/devicetree/bindings/arm/arm-boards   |    1 +
 Documentation/devicetree/bindings/arm/axis.txt     |   29 +
 Documentation/devicetree/bindings/arm/cpus.txt     |    1 +
 .../devicetree/bindings/arm/keystone/keystone.txt  |    5 +
 Documentation/devicetree/bindings/arm/lpc32xx.txt  |    8 -
 .../bindings/arm/marvell/marvell,kirkwood.txt      |    7 +-
 Documentation/devicetree/bindings/arm/mediatek.txt |    4 +
 .../devicetree/bindings/arm/nxp/lpc32xx.txt        |    8 +
 .../devicetree/bindings/arm/omap/omap.txt          |    2 +-
 Documentation/devicetree/bindings/arm/qcom.txt     |   51 +
 .../devicetree/bindings/display/arm,hdlcd.txt      |   79 ++
 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |    2 +
 .../devicetree/bindings/pci/layerscape-pci.txt     |    2 +-
 .../pinctrl/marvell,armada-370-pinctrl.txt         |    5 +-
 .../devicetree/bindings/serial/mtk-uart.txt        |    1 +
 .../bindings/timer/mediatek,mtk-timer.txt          |    1 +
 arch/arm/boot/dts/Makefile                         |   23 +-
 arch/arm/boot/dts/alpine.dtsi                      |   10 +
 arch/arm/boot/dts/am335x-baltos-ir5221.dts         |    9 +-
 arch/arm/boot/dts/am335x-chilisom.dtsi             |    8 +-
 arch/arm/boot/dts/am335x-cm-t335.dts               |  180 ++-
 arch/arm/boot/dts/am335x-evm.dts                   |    7 +-
 arch/arm/boot/dts/am335x-igep0033.dtsi             |    8 +-
 arch/arm/boot/dts/am335x-phycore-som.dtsi          |    8 +-
 arch/arm/boot/dts/am335x-sl50.dts                  |   24 +-
 arch/arm/boot/dts/am33xx.dtsi                      |    2 +
 arch/arm/boot/dts/am4372.dtsi                      |   18 +-
 arch/arm/boot/dts/am437x-cm-t43.dts                |   11 +-
 arch/arm/boot/dts/am437x-gp-evm.dts                |    8 +-
 arch/arm/boot/dts/am43x-epos-evm.dts               |   10 +-
 arch/arm/boot/dts/am57xx-beagle-x15.dts            |    7 +-
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts          |    2 +-
 arch/arm/boot/dts/arm-realview-pb1176.dts          |  118 ++
 arch/arm/boot/dts/arm-realview-pb11mp.dts          |    4 +-
 arch/arm/boot/dts/armada-370-db.dts                |   27 +
 arch/arm/boot/dts/armada-370-mirabox.dts           |    2 +-
 arch/arm/boot/dts/armada-370-netgear-rn104.dts     |    2 +-
 arch/arm/boot/dts/armada-370-synology-ds213j.dts   |    2 +-
 arch/arm/boot/dts/armada-375.dtsi                  |    2 +-
 arch/arm/boot/dts/armada-385-db-ap.dts             |    3 +
 arch/arm/boot/dts/armada-388-gp.dts                |   36 +-
 arch/arm/boot/dts/armada-38x.dtsi                  |   30 +-
 arch/arm/boot/dts/armada-xp-db.dts                 |   28 +
 arch/arm/boot/dts/artpec6-devboard.dts             |   64 +
 arch/arm/boot/dts/artpec6.dtsi                     |  270 +++++
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |   92 ++
 arch/arm/boot/dts/axm55xx.dtsi                     |    2 +-
 arch/arm/boot/dts/bcm-cygnus-clock.dtsi            |    9 +
 arch/arm/boot/dts/bcm-nsp.dtsi                     |  205 ++--
 arch/arm/boot/dts/bcm2835-rpi-a.dts                |   24 +
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |   16 +
 arch/arm/boot/dts/bcm283x.dtsi                     |   43 +-
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts      |  111 ++
 arch/arm/boot/dts/cros-ec-keyboard.dtsi            |    1 +
 arch/arm/boot/dts/dm8148-evm.dts                   |   58 +
 arch/arm/boot/dts/dm814x-clocks.dtsi               |    4 +-
 arch/arm/boot/dts/dm814x.dtsi                      |   21 +
 arch/arm/boot/dts/dm8168-evm.dts                   |    8 +-
 arch/arm/boot/dts/dm816x.dtsi                      |    9 +
 arch/arm/boot/dts/dra62x-j5eco-evm.dts             |   58 +
 arch/arm/boot/dts/dra7-dspeve-thermal.dtsi         |   27 +
 arch/arm/boot/dts/dra7-evm.dts                     |    9 +-
 arch/arm/boot/dts/dra7-iva-thermal.dtsi            |   27 +
 arch/arm/boot/dts/dra7.dtsi                        |  102 +-
 arch/arm/boot/dts/dra72-evm.dts                    |    9 +-
 arch/arm/boot/dts/dra74x.dtsi                      |    1 -
 arch/arm/boot/dts/dra7xx-clocks.dtsi               |   24 +
 arch/arm/boot/dts/emev2.dtsi                       |   39 +-
 arch/arm/boot/dts/exynos-syscon-restart.dtsi       |   27 +
 arch/arm/boot/dts/exynos3250-monk.dts              |    6 +-
 arch/arm/boot/dts/exynos3250-rinato.dts            |    6 +-
 arch/arm/boot/dts/exynos3250.dtsi                  |   17 +-
 arch/arm/boot/dts/exynos4.dtsi                     |   22 +-
 arch/arm/boot/dts/exynos4210-origen.dts            |   10 +-
 arch/arm/boot/dts/exynos4210-smdkv310.dts          |    2 +-
 arch/arm/boot/dts/exynos4210-trats.dts             |    2 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |    4 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |    2 +-
 arch/arm/boot/dts/exynos4412-odroidx.dts           |    2 +-
 arch/arm/boot/dts/exynos4412-origen.dts            |    2 +-
 arch/arm/boot/dts/exynos4412-smdk4412.dts          |    2 +-
 arch/arm/boot/dts/exynos4412-trats2.dts            |    4 +-
 arch/arm/boot/dts/exynos4415.dtsi                  |    2 +-
 arch/arm/boot/dts/exynos5.dtsi                     |   20 +-
 arch/arm/boot/dts/exynos5250-arndale.dts           |   12 +-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi      |    4 +-
 arch/arm/boot/dts/exynos5250-spring.dts            |    4 +-
 arch/arm/boot/dts/exynos5250.dtsi                  |    4 +-
 arch/arm/boot/dts/exynos5410-pinctrl.dtsi          |  406 +++++++
 arch/arm/boot/dts/exynos5410-smdk5410.dts          |   41 +
 arch/arm/boot/dts/exynos5410.dtsi                  |   62 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |   11 +-
 arch/arm/boot/dts/exynos5420-cpus.dtsi             |  126 ++
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |   13 +-
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |    9 +
 arch/arm/boot/dts/exynos5420.dtsi                  |  172 ++-
 arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi      |   46 +-
 arch/arm/boot/dts/exynos5422-cpus.dtsi             |  164 ++-
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |    8 +
 arch/arm/boot/dts/exynos5440.dtsi                  |    2 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |   13 +-
 arch/arm/boot/dts/exynos5800.dtsi                  |  108 ++
 arch/arm/boot/dts/hi3620.dtsi                      |    2 +-
 arch/arm/boot/dts/hip01.dtsi                       |    2 +-
 arch/arm/boot/dts/hisi-x5hd2.dtsi                  |    2 +-
 arch/arm/boot/dts/integrator.dtsi                  |    2 +-
 arch/arm/boot/dts/keystone-k2g-evm.dts             |   32 +
 arch/arm/boot/dts/keystone-k2g.dtsi                |   89 ++
 arch/arm/boot/dts/kirkwood-linkstation-6282.dtsi   |  192 +++
 .../boot/dts/kirkwood-linkstation-duo-6281.dtsi    |  186 +++
 arch/arm/boot/dts/kirkwood-linkstation-lsqvl.dts   |  135 +++
 arch/arm/boot/dts/kirkwood-linkstation-lsvl.dts    |   57 +
 arch/arm/boot/dts/kirkwood-linkstation-lswsxl.dts  |   57 +
 arch/arm/boot/dts/kirkwood-linkstation-lswvl.dts   |  112 ++
 arch/arm/boot/dts/kirkwood-linkstation-lswxl.dts   |  116 ++
 arch/arm/boot/dts/kirkwood-linkstation.dtsi        |  202 ++++
 arch/arm/boot/dts/kirkwood-lswvl.dts               |  302 -----
 arch/arm/boot/dts/kirkwood-lswxl.dts               |  302 -----
 arch/arm/boot/dts/kirkwood-openrd-client.dts       |    6 +-
 arch/arm/boot/dts/kirkwood-openrd.dtsi             |   41 +-
 arch/arm/boot/dts/kirkwood.dtsi                    |    2 +-
 arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts   |  268 +++++
 arch/arm/boot/dts/logicpd-som-lv.dtsi              |  265 +++++
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts  |  168 ++-
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi         |   43 +-
 arch/arm/boot/dts/lpc32xx.dtsi                     |  150 ++-
 arch/arm/boot/dts/mt2701.dtsi                      |   12 +
 arch/arm/boot/dts/mt7623-evb.dts                   |   33 +
 arch/arm/boot/dts/mt7623.dtsi                      |  147 +++
 arch/arm/boot/dts/mvebu-linkstation-fan.dtsi       |   72 ++
 .../boot/dts/mvebu-linkstation-gpio-simple.dtsi    |  105 ++
 arch/arm/boot/dts/omap3-beagle.dts                 |    5 +-
 arch/arm/boot/dts/omap3-cm-t3x.dtsi                |    6 +-
 arch/arm/boot/dts/omap3-devkit8000-common.dtsi     |    4 +
 arch/arm/boot/dts/omap3-evm-37xx.dts               |    8 +-
 arch/arm/boot/dts/omap3-gta04.dtsi                 |    4 +
 arch/arm/boot/dts/omap3-igep.dtsi                  |   10 +-
 arch/arm/boot/dts/omap3-igep0020-common.dtsi       |    4 +-
 arch/arm/boot/dts/omap3-igep0030-common.dtsi       |   45 +
 arch/arm/boot/dts/omap3-ldp.dts                    |   10 +-
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi            |    6 +-
 arch/arm/boot/dts/omap3-n9.dts                     |    4 +
 arch/arm/boot/dts/omap3-n900.dts                   |   44 +-
 arch/arm/boot/dts/omap3-n950-n9.dtsi               |   93 ++
 arch/arm/boot/dts/omap3-n950.dts                   |   33 +
 arch/arm/boot/dts/omap3-overo-base.dtsi            |    6 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi        |    4 +
 arch/arm/boot/dts/omap3-sniper.dts                 |  254 ++++
 arch/arm/boot/dts/omap3-tao3530.dtsi               |    6 +-
 arch/arm/boot/dts/omap3.dtsi                       |    2 +
 arch/arm/boot/dts/omap3430-sdp.dts                 |    6 +-
 arch/arm/boot/dts/omap34xx.dtsi                    |    6 +
 arch/arm/boot/dts/omap36xx.dtsi                    |    6 +
 arch/arm/boot/dts/omap5.dtsi                       |   27 +-
 arch/arm/boot/dts/orion5x-linkstation-lsgl.dts     |   87 ++
 arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts   |  243 +---
 arch/arm/boot/dts/orion5x-linkstation.dtsi         |  180 +++
 arch/arm/boot/dts/phy3250.dts                      |   32 +
 arch/arm/boot/dts/pxa3xx.dtsi                      |    2 +-
 arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts |  276 +++++
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts        |   27 +
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts         |   26 +-
 arch/arm/boot/dts/qcom-apq8064-pins.dtsi           |  208 ++++
 arch/arm/boot/dts/qcom-apq8064.dtsi                |  130 +-
 arch/arm/boot/dts/qcom-apq8084.dtsi                |   14 +
 arch/arm/boot/dts/qcom-ipq8064.dtsi                |   12 +
 arch/arm/boot/dts/qcom-msm8660.dtsi                |   22 +-
 arch/arm/boot/dts/qcom-msm8960.dtsi                |    2 +-
 arch/arm/boot/dts/qcom-msm8974.dtsi                |  135 ++-
 arch/arm/boot/dts/qcom-pm8841.dtsi                 |    4 +-
 arch/arm/boot/dts/qcom-pm8941.dtsi                 |   20 +-
 arch/arm/boot/dts/r7s72100.dtsi                    |  177 +--
 arch/arm/boot/dts/r8a73a4.dtsi                     |  241 ++--
 arch/arm/boot/dts/r8a7740.dtsi                     |  161 +--
 arch/arm/boot/dts/r8a7778-bockw.dts                |   13 +
 arch/arm/boot/dts/r8a7778.dtsi                     |  144 ++-
 arch/arm/boot/dts/r8a7779-marzen.dts               |   13 +
 arch/arm/boot/dts/r8a7779.dtsi                     |  135 ++-
 arch/arm/boot/dts/r8a7790-lager.dts                |   45 +-
 arch/arm/boot/dts/r8a7790.dtsi                     |  498 ++++----
 arch/arm/boot/dts/r8a7791-koelsch.dts              |   13 +
 arch/arm/boot/dts/r8a7791-porter.dts               |  165 +++
 arch/arm/boot/dts/r8a7791.dtsi                     |  554 +++++----
 arch/arm/boot/dts/r8a7793-gose.dts                 |  304 +++++
 arch/arm/boot/dts/r8a7793.dtsi                     |  791 ++++++++++---
 arch/arm/boot/dts/r8a7794-alt.dts                  |   59 +
 arch/arm/boot/dts/r8a7794-silk.dts                 |  122 ++
 arch/arm/boot/dts/r8a7794.dtsi                     |  393 ++++---
 arch/arm/boot/dts/rk3036-kylin.dts                 |  104 ++
 arch/arm/boot/dts/rk3036.dtsi                      |   71 +-
 arch/arm/boot/dts/rk3066a-bqcurie2.dts             |   19 +-
 arch/arm/boot/dts/rk3066a-marsboard.dts            |   16 +
 arch/arm/boot/dts/rk3066a-rayeager.dts             |   18 +-
 arch/arm/boot/dts/rk3066a.dtsi                     |   24 +-
 arch/arm/boot/dts/rk3188-radxarock.dts             |    2 +-
 arch/arm/boot/dts/rk3188.dtsi                      |    2 +
 arch/arm/boot/dts/rk3228.dtsi                      |    2 +-
 arch/arm/boot/dts/rk3288-evb.dtsi                  |    2 +-
 arch/arm/boot/dts/rk3288-firefly.dtsi              |   26 +-
 arch/arm/boot/dts/rk3288-popmetal.dts              |    2 +-
 arch/arm/boot/dts/rk3288-r89.dts                   |    2 +-
 arch/arm/boot/dts/rk3288-rock2-som.dtsi            |   26 +
 arch/arm/boot/dts/rk3288-rock2-square.dts          |   48 +-
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi    |    2 +-
 arch/arm/boot/dts/rk3288-veyron.dtsi               |    7 +-
 arch/arm/boot/dts/rk3288.dtsi                      |   50 +-
 arch/arm/boot/dts/rk3xxx.dtsi                      |    5 +-
 arch/arm/boot/dts/s5pv210-aquila.dts               |    4 +-
 arch/arm/boot/dts/s5pv210-goni.dts                 |    4 +-
 arch/arm/boot/dts/s5pv210-smdkv210.dts             |    2 +-
 arch/arm/boot/dts/s5pv210.dtsi                     |    2 +-
 arch/arm/boot/dts/sama5d2.dtsi                     |   91 +-
 arch/arm/boot/dts/sh73a0.dtsi                      |  186 +--
 arch/arm/boot/dts/socfpga.dtsi                     |    2 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi             |    2 +-
 arch/arm/boot/dts/spear1310-evb.dts                |    2 +-
 arch/arm/boot/dts/spear1340-evb.dts                |    2 +-
 arch/arm/boot/dts/spear320-hmi.dts                 |    4 +-
 arch/arm/boot/dts/ste-href-tvk1281618.dtsi         |   37 +-
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi         |    2 +-
 arch/arm/boot/dts/ste-u300.dts                     |    2 +-
 arch/arm/boot/dts/stm32429i-eval.dts               |   52 +-
 arch/arm/boot/dts/stm32f429-disco.dts              |   13 +
 arch/arm/boot/dts/stm32f429.dtsi                   |  213 ++++
 arch/arm/boot/dts/stm32f469-disco.dts              |   75 ++
 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts    |   10 +
 arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts       |   34 +
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts          |   10 +
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts       |    9 +
 .../boot/dts/sun4i-a10-itead-iteaduino-plus.dts    |   86 +-
 arch/arm/boot/dts/sun4i-a10-mk802.dts              |   33 +
 arch/arm/boot/dts/sun5i-r8-chip.dts                |    4 +
 arch/arm/boot/dts/sun6i-a31.dtsi                   |   10 +
 arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi     |    6 +-
 arch/arm/boot/dts/sun7i-a20-itead-ibox.dts         |  125 ++
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts          |  287 +++++
 arch/arm/boot/dts/sun7i-a20-mk808c.dts             |   35 +
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts     |   32 +
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               |    2 +-
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |   79 +-
 .../boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts  |   64 +
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts   |   65 +
 arch/arm/boot/dts/sun8i-a83t.dtsi                  |  228 ++++
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts       |   57 +
 arch/arm/boot/dts/sun8i-h3.dtsi                    |   64 +-
 arch/arm/boot/dts/sun8i-q8-common.dtsi             |   83 +-
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts        |    6 +
 arch/arm/boot/dts/sun9i-a80-optimus.dts            |   28 +-
 arch/arm/boot/dts/sun9i-a80.dtsi                   |   11 +-
 arch/arm/boot/dts/sunxi-itead-core-common.dtsi     |  136 +++
 arch/arm/boot/dts/versatile-ab.dts                 |    2 +-
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi            |    2 +-
 arch/arm/boot/dts/vexpress-v2m.dtsi                |    2 +-
 arch/arm/boot/dts/zynq-parallella.dts              |    2 +-
 arch/arm/boot/dts/zynq-zc702.dts                   |    2 +-
 arch/arm/boot/dts/zynq-zc706.dts                   |    2 +-
 arch/arm/boot/dts/zynq-zed.dts                     |    2 +-
 arch/arm/boot/dts/zynq-zybo.dts                    |   13 +-
 arch/arm/mach-keystone/keystone.c                  |    1 +
 arch/arm/mach-mediatek/Kconfig                     |    4 +
 arch/arm/mach-mediatek/mediatek.c                  |    1 +
 arch/arm/mach-versatile/Kconfig                    |    3 +
 arch/arm/mach-versatile/versatile_dt.c             |   15 -
 arch/arm64/boot/dts/arm/Makefile                   |    4 +-
 arch/arm64/boot/dts/arm/foundation-v8-gicv3.dts    |   30 +
 arch/arm64/boot/dts/arm/foundation-v8.dts          |  227 +---
 arch/arm64/boot/dts/arm/foundation-v8.dtsi         |  236 ++++
 arch/arm64/boot/dts/arm/juno-base.dtsi             |   74 +-
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi      |   32 +-
 arch/arm64/boot/dts/arm/juno-r1.dts                |   25 +-
 arch/arm64/boot/dts/arm/juno-r2.dts                |  183 +++
 arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts         |    2 +-
 arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi   |   16 +-
 .../boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts      |   10 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |   12 +-
 include/dt-bindings/clock/r8a7793-clock.h          |    2 +
 include/dt-bindings/clock/r8a7794-clock.h          |    1 +
 include/dt-bindings/clock/rk3188-cru-common.h      |    1 +
 include/dt-bindings/pinctrl/stm32f429-pinfunc.h    | 1239 ++++++++++++++++++++
 279 files changed, 13789 insertions(+), 3289 deletions(-)
