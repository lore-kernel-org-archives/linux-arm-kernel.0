From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 08 Oct 2016 02:33:15 +0200
Subject: [GIT PULL 6/8] ARM: DT updates for v4.9
In-Reply-To: <3637015.LRn5VyhPVM@wuerfel>
References: <3637015.LRn5VyhPVM@wuerfel>
Message-ID: <1521057.0X8YESdiKH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 3eab887a55424fc2c27553b7bfe32330df83f7b8:

  Linux 4.8-rc4 (2016-08-28 15:04:33 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt

for you to fetch changes up to adff807988f92d4646c50b601936e340a92d5455:

  Merge tag 'berlin-dt-for-v4.9-1' of git://git.infradead.org/users/hesselba/linux-berlin into next/dt (2016-10-02 22:20:39 -0700)

----------------------------------------------------------------
ARM: DT updates for v4.9

These are as usual a very large number of mostly boring updates to
enable devices in existing machines, or to fix minor bugs.  Notably,
an ongoing treewide effort to fix warnings caused by an update to the
device tree compiler. These are enabled with "make W=1" at the moment
but can hopefully become the default once all issues have been addressed.

No new SoC platform is added this time around (Armada 395 and Orion
mv88f5181 are slight variations of existing ones), but a significant
number of new dts files are added, which I list by platform:

- Allwinner: Empire Electronix M712 and iNet d978 Rev2 tablets;
	Orange Pi PC Plus, Orange Pi 2, Orange Pi Plus 2E,
	Orange Pi Lite, Olimex A33-Olinuxino, and Nano Pi Neo
	single-board computers

- ARM Realview: all supported machines (ported from board files)

- Broadcom: BCM958525er, BCM958522er, BCM988312hr, BCM958623hr and
	BCM958622hr reference boards for Northstar platform;
	Raspberry Pi Zero single-board computer

- Marvell EBU: Netgear WNR854T router (ported from board file);
	Armada 395 SoC platform and GP board
	Armada 390 DB development board

- NXP i.MX: imx7s Warp7 reference board;
	Gateworks Ventana GW553x single-board computer,
	Technologic Systems TS-4900 and
	Engicam IMX6UL GEA M6UL computer-on-module,
	Inverse Path USB armory board

- Qualcomm: LG Nexus 5 Phone

- Renesas: r8a7792/wheat and r7s72100/rskrza1 development boards

- Rockchip: Rockchip RK3288 Fennec reference board;
	Firefly RK3288 Reload platform

- ST Microelectronics STi: B2260 (96boards) single-board computer

- TI Davinci: OMAP-L138 LCDK Development kit

- TI OMAP: beagleboard-x15 rev B1 single-board computer

Conflicts: vendor-prefixes.txt has conflicting additions, keep all of
them in alphabetical order.

----------------------------------------------------------------
Adam Ford (1):
      ARM: dts: Add LogicPD DM37/AM37 Torpedo and SOM-LV

Andrej Rosano (2):
      devicetree: Add vendor prefix for Inverse Path
      ARM: dts: imx53: add support for USB armory board

Andrew F. Davis (3):
      ARM: dts: keystone-k2g: Add device state controller node
      ARM: dts: keystone-k2g: Add keystone IRQ controller node
      ARM: dts: keystone-k2g: Add DSP GPIO controller node

Andy Yan (5):
      soc: rockchip: add reboot-mode header
      ARM: dts: rockchip: add syscon-reboot-mode DT node
      ARM: dts: rockchip: enable usbotg for Popemtal-rk3288 board
      ARM: dts: rockchip: fix L3G4200D i2c address on PopMetal-RK3288 board
      ARM: dts: rockchip: Add sensor-supplies on PopMetal-RK3288 board

Anson Huang (1):
      ARM: dts: imx6ul iomuxc syscon is compatible to imx6q

Arnd Bergmann (30):
      ARM: dts: mvebu: fix reference to a390 spi controller
      Merge tag 'renesas-dt-for-v4.9' of git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'lpc18xx_dts_for_4.9' of https://github.com/manabian/linux-lpc into next/dt
      Merge tag 'samsung-dt-4.9' of git://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'uniphier-dt-v4.9' of git://git.kernel.org/.../masahiroy/linux-uniphier into next/dt
      Merge tag 'keystone_dts_for_4.9' of git://git.kernel.org/.../ssantosh/linux-keystone into next/dt
      Merge tag 'omap-for-v4.9/dt-pt1-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'sti-dt-for-v4.9-1' of git://git.kernel.org/.../pchotard/sti into next/dt
      Merge tag 'qcom-dts-for-4.9' of git://git.kernel.org/.../agross/linux into next/dt
      Merge tag 'mvebu-dt-4.9-1' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'lpc18xx_dts_for_4.9_part2' of https://github.com/manabian/linux-lpc into next/dt
      Merge tag 'renesas-dt2-for-v4.9' of git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'sunxi-dt-for-4.9' of https://git.kernel.org/.../mripard/linux into next/dt
      Merge tag 'v4.9-rockchip-dts32-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'tegra-for-4.9-arm-dt' of git://git.kernel.org/.../tegra/linux into next/dt
      Merge tag 'realview-dts-split' of git://git.kernel.org/.../linusw/linux-integrator into next/dt
      Merge tag 'imx-dt-4.9' of git://git.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'clcd-nomadik' of git://git.kernel.org/.../linusw/linux-nomadik into next/dt
      Merge tag 'arm-soc/for-4.9/devicetree' of http://github.com/Broadcom/stblinux into next/dt
      Merge tag 'davinci-for-v4.9/dts' of git://git.kernel.org/.../nsekhar/linux-davinci into next/dt
      Merge tag 'at91-ab-4.9-dt1' of git://git.kernel.org/.../abelloni/linux into next/dt
      Merge tag 'mvebu-dt-4.9-2' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'amlogic-dt' of git://git.kernel.org/.../khilman/linux-amlogic into next/dt
      Merge tag 'sti-dt-for-v4.9-2' of git://git.kernel.org/.../pchotard/sti into next/dt
      Merge tag 'sti-dt-for-v4.9-3' of git://git.kernel.org/.../pchotard/sti into next/dt
      Merge tag 'davinci-for-v4.9/dts-p2' of git://git.kernel.org/.../nsekhar/linux-davinci into next/dt
      Merge tag 'omap-for-v4.9/dt-pt2-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'samsung-dt-4.9-2' of git://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'samsung-dt-pinctrl-4.9' of git://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'omap-for-v4.9/dt-pt3-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/dt

Baruch Siach (1):
      dt-binding: mrvl-gpio: remove orion-gpio description

Bhushan Shah (6):
      ARM: dts: msm8974: Add nodes for blsp1_uart1 serial port
      ARM: dts: qcom: Add initial DTS for LG Nexus 5 Phone
      ARM: dts: msm8974-hammerhead: Add regulator nodes for hammerhead
      ARM: dts: msm8974-hammerhead: Introduce gpio-keys nodes
      ARM: dts: qcom: msm8974: Add fixed regulator node for vph-pwr-reg
      ARM: dts: msm8974: Move vreg_boost node from the honami to msm8974

Bjorn Andersson (1):
      ARM: dts: msm8974: honami: Add touchscreen

Breno Lima (1):
      ARM: dts: imx7s-warp: Add MPL3115 sensor support

Chen-Yu Tsai (4):
      ARM: dts: sun9i: a80-optimus: Add device node for AC100
      ARM: dts: sun9i: cubieboard4: Add device node for AC100
      ARM: dts: sun9i: Switch to the AC100 RTC clock outputs for osc32k
      ARM: dts: sun9i: Add missing #interrupt-cells to R_PIO pinctrl device node

Chris Brandt (5):
      ARM: dts: Add RSKRZA1 DT bindings documentation
      ARM: dts: rskrza1: initial device tree
      ARM: dts: r7s72100: add ethernet clock to device tree
      ARM: dts: r7s72100: add ethernet to device tree
      ARM: dts: rskrza1: add ethernet DT support

Chris Packham (1):
      ARM: dts: armada-38x: Add NAND pinctrl information

Christoph Fritz (1):
      ARM: dts: imx6sx: document SION necessity of ENET1_REF_CLK1

Cooper Jr., Franklin (1):
      ARM: dts: da850: Add new ECAP and EPWM bindings

Dave Gerlach (3):
      Revert "ARM: dts: am335x-boneblack: Enable 1GHz OPP for cpu"
      Revert "ARM: dts: am33xx: Move to operating-points-v2 table and ti-cpufreq driver"
      Revert "ARM: dts: dra7: Move to operating-points-v2 table"

Fabien Lahoudere (2):
      ARM: dts: imx53: Add DMA configuration for UART
      ARM: dts: imx53: Add IPU nodes for csi

Fabio Estevam (8):
      ARM: dts: imx7s-warp: Add initial support
      ARM: dts: imx7s: Add SDMA node
      ARM: dts: imx7s: Add SAI nodes
      ARM: dts: imx7s-warp: Add audio support
      ARM: dts: imx7s-warp: Add Wifi support
      ARM: dts: imx7s-warp: Use WDOG_B pin reset
      ARM: dts: imx6ul-pico-hobbit: Use WDOG_B pin reset
      ARM: dts: imx7s-warp: Let the codec control MCLK pinctrl

Florian Fainelli (3):
      ARM: dts: NSP: Add Switch Register Access Block node
      ARM: dts: NSP: Add BCM958625HR switch ports
      Merge tag 'bcm2835-dt-next-2016-08-29' into devicetree/next

Gabriel Fernandez (9):
      ARM: dts: STiH4xx: Simplify clock binding of STiH4xx platforms
      ARM: dts: STiH407: Enable clock propagation for audio clocks
      ARM: dts: STiH410: Enable clock propagation for audio clocks
      ARM: dts: STiH418: Enable clock propagation for audio clocks
      ARM: dts: STiH407: Enable synchronous clock mode for video clocks
      ARM: dts: STiH410: Enable synchronous clock mode for video clocks
      ARM: dts: STiH418: Enable synchronous clock mode for video clocks
      ARM: dts: STi: STiH407: clock configuration to address 720p and 1080p
      ARM: dts: STiH410: clock configuration to address 720p and 1080p

Geert Uytterhoeven (2):
      ARM: dts: r8a7790: Remove obsolete vsp1 properties
      ARM: dts: r8a7791: Remove obsolete vsp1 properties

Grygorii Strashko (2):
      ARM: dts: dra7: cpsw: fix clocks tree
      ARM: dts: keystone: specify usb mode explicitly

Grzegorz Jaszczyk (14):
      ARM: dts: mvebu: a385-db-ap: enable USB (orion-ehci) port
      ARM: dts: mvebu: a385-db-ap: add default partition description for NAND
      ARM: dts: mvebu: armada-390: add missing compatibility string and bracket
      ARM: dts: mvebu: armada-39x: update the SDHCI node on Armada 39x
      ARM: dts: mvebu: armada-39x: enable PMU, CA9 SoC Controller and Coherency fabric
      ARM: dts: mvebu: armada-39x: enable the thermal sensor in Armada-39x SoCs
      ARM: dts: mvebu: armada-39x: enable watchdog for all Armada-39x SoCs
      ARM: dts: mvebu: armada-39x: add missing nodes describing GPIO's
      ARM: dts: mvebu: armada-39x: enable rtc for all Armada-39x SoCs
      ARM: dts: mvebu: armada-395: add support for the Armada 395 SoC family
      ARM: dts: mvebu: armada-398: update the dtsi about missing interfaces
      ARM: dts: mvebu: armada-398-db: enable supported usb interfaces
      ARM: dts: mvebu: armada-390-db: add support for the Armada 390 DB board
      ARM: dts: mvebu: armada-395-gp: add support for the Armada 395 GP Board

Guenter Roeck (1):
      ARM: dts: lpc4350-hitex-eval: fix binding for SE97 i2c device

H. Nikolaus Schaller (1):
      ARM: dts: omap3-gta04: reduce panel backlight PWM frequency to 83Hz

Hans de Goede (19):
      ARM: dts: sun6i-a31s-colorfly-e708-q1: Add full otg support
      ARM: dts: sun8i: Add dts file for the Orange Pi PC Plus SBC
      ARM: dts: sun8i: Add ethernet1 alias to Orange Pi 2 dts
      ARM: dts: sun8i: Add dts file for the Orange Pi Lite SBC
      ARM: dts: sun8i: Use sun8i-reference-design-tablet for gt90h dts
      ARM: dts: sun8i: Add dt node for rtl8703as wifi chip on ga10h
      ARM: dts: sun8i: reference-design-tablet: Add gsl1680 touchscreen node
      ARM: dts: sun6i: colorfly-e708-q1: Remove unused mma8452_int_e708_q1 node
      ARM: dts: sun6i: Add sun6i-reference-design-tablet.dtsi
      ARM: dts: sun6i: Add new dts file for tablets using the inet-q972 PCB
      ARM: dts: sun8i: Add dt node for esp8089 wifi chip on polaroid-mid2407
      ARM: dts: sun8i: Add dt node for esp8089 wifi chip on polaroid-mid2809
      ARM: dts: sun4i: Disable ohci1 on ba10-tv-box
      ARM: dts: sun5i: Convert inet-98v-rev2 dts to use reference-design-tablet.dtsi
      ARM: dts: sun5i: Add dts file for the Empire Electronix M712 tablet
      ARM: dts: sun8i: Rename reference-design-tablet touchscreen node
      ARM: dts: sun8i: Orange Pi Plus dts is for the Plus and Plus 2
      ARM: dts: sun8i: Add dts file for the Orange Pi Plus2E SBC
      ARM: dts: sun8i-q8-common: Add support for SDIO wifi controllers

Heiko Stuebner (2):
      ARM: dts: rockchip: move rk3288 usbphy under the GRF node
      Merge branch 'v4.9-shared/soc-hdr' into v4.9-armsoc/dts32

Icenowy Zheng (2):
      ARM: dts: sun8i: add NAND controller node for A23/A33
      ARM: dts: sun8i: Add dts file for inet-d978_rev2 tablets

J.D. Schroeder (1):
      ARM: dts: dra7: Fix clock data for gmac_gmii_ref_clk_div

James Pettigrew (2):
      ARM: dts: sun8i: Add dts file for the NanoPi NEO SBC
      devicetree: Add vendor prefix for FriendlyARM

Jamie Lentin (5):
      ARM: dts: orion5x: Add required properties for orion-wdt to DT node
      dt-bindings: arm: add DT binding for Marvell Orion5x SoC family
      ARM: dts: arm: orion5x: Add DT include for mv88f5181
      ARM: dts: orion5x: Add description for Netgear WNR854T
      ARM: dts: orion5x: Configure WNR854T ethernet PHY LEDs

Jason Cooper (1):
      ARM: dts: kirkwood: Fix Openblock A6 external GPIO pins

Javier Martinez Canillas (42):
      ARM: dts: omap3/am4372: add missing unit name to ocp node
      ARM: dts: omap3: overo: add missing unit name for lcd35 display
      ARM: dts: am335x/am437x: remove unneeded unit name for gpio-matrix-keypad
      ARM: dts: am335x/am437x: remove unneeded unit name for fixed regulators
      ARM: dts: da850/dm81x: remove unneeded unit name for fixed regulators
      ARM: dts: omap3/dra62x: remove unneeded unit name for fixed regulators
      ARM: dts: am335x/am437x: remove unneeded unit name for gpio-keys nodes
      ARM: dts: omap3/4: remove unneeded unit name for gpio-keys nodes
      ARM: dts: am335x/437x/57xx: remove unneeded unit name for gpio-leds nodes
      ARM: dts: omap3/4/5/dra7: remove unneeded unit name for gpio-leds nodes
      ARM: am335x: Add missing memory node in sl50 board
      ARM: omap3: Add missing memory node in overo and torpedo boards
      ARM: dts: omap2: Remove skeleton.dtsi usage
      ARM: dts: omap3: Remove skeleton.dtsi usage
      ARM: dts: omap4: Remove skeleton.dtsi usage
      ARM: dts: omap5: Remove skeleton.dtsi usage
      ARM: dts: am33xx: Remove skeleton.dtsi usage
      ARM: dts: dm814x: Remove skeleton.dtsi usage
      ARM: dts: dm816x: Remove skeleton.dtsi usage
      ARM: dts: dra7: Remove skeleton.dtsi usage
      ARM: dts: am4372: Remove skeleton.dtsi usage
      ARM: dts: omap2: Add missing unit name to memory nodes
      ARM: dts: omap3: Add missing unit name to memory nodes
      ARM: dts: omap4: Add missing unit name to memory nodes
      ARM: dts: omap5: Add missing unit name to memory nodes
      ARM: dts: am335x: Add missing unit name to memory nodes
      ARM: dts: am3517: Add missing unit name to memory nodes
      ARM: dts: am4372: Add missing unit name to memory nodes
      ARM: dts: am572x: Add missing unit name to memory nodes
      ARM: dts: dm8148: Add missing unit name to memory nodes
      ARM: dts: dm8168: Add missing unit name to memory nodes
      ARM: dts: dra62x: Add missing unit name to memory nodes
      ARM: dts: dra7: Add missing unit name to memory nodes
      ARM: dts: exynos: Add missing memory node for Exynos5440 boards
      ARM: dts: exynos: Remove skeleton.dtsi usage for Exynos3
      ARM: dts: exynos: Remove skeleton.dtsi usage for Exynos4
      ARM: dts: exynos: Remove skeleton.dtsi usage for Exynos5
      ARM: dts: exynos: Add missing unit name to memory nodes in Exynos3 DTS
      ARM: dts: exynos: Add missing unit name to memory nodes in Exynos4 DTS
      ARM: dts: exynos: Add missing unit name to memory nodes in Exynos5 DTS
      ARM: dts: s5p: Remove skeleton.dtsi inclusion for S5PV210
      ARM: dts: s5p: Add missing unit name to memory nodes for S5PV210 boards

Jean-Christophe Trotin (1):
      ARM: dts: STiH410: Add hva dt nodes

Jisheng Zhang (11):
      arm: dts: berlin2: enable all wdt nodes unconditionally
      arm: dts: berlin2q: enable all wdt nodes unconditionally
      ARM: dts: berlin2q: Remove skeleton.dtsi inclusion
      ARM: dts: berlin2cd: Remove skeleton.dtsi inclusion
      ARM: dts: berlin2: Remove skeleton.dtsi inclusion
      ARM: dts: berlin2q: Add missing unit name to /soc node
      ARM: dts: berlin2cd: Add missing unit name to /soc node
      ARM: dts: berlin2: Add missing unit name to /soc node
      ARM: dts: berlin2q-marvell-dmp: add missing unit name to /memory node
      ARM: dts: chromecast: add missing unit name to /memory node
      ARM: dts: sony-nsz-gs7: add missing unit name to /memory node

Joachim Eastwood (4):
      ARM: dts: lpc18xx: configure dwmac properly
      ARM: dts: armv7-m: remove skeleton.dtsi include
      ARM: dts: lpc18xx: remove skeleton.dtsi include and fix unit address warnings
      ARM: dts: efm32: remove skeleton.dtsi include and fix unit address warnings

John Stultz (3):
      device-tree: nexus7: Set phy mode to otg instead of host
      device-tree: aqp8064.dtsi: Remove usb phy dr_mode = "host"
      device-tree: nexus7: Add IMEM syscon and reboot reason support

Jon Hunter (1):
      ARM: tegra: Correct polarity for Tegra114 PMIC interrupt

Jon Mason (14):
      dt-bindings: net: bgmac: add bindings documentation for bgmac
      ARM: dts: NSP: Add AMAC entries
      ARM: dts: NSP: Correct RAM amount for BCM958625HR board
      ARM: dts: NSP: Enable SATA on bcm958625hr
      ARM: dts: NSP: Enable SATA and add i2c devices on XMC
      ARM: dts: NSP: Specify RAM amount for BCM958625K board
      ARM: dts: NSP: Specify RAM amount for BCM958525XMC board
      ARM: dts: NSP: Add GPIO reboot method to bcm958625hr DTS file
      ARM: dts: NSP: Add GPIO reboot method to bcm958625xmc DTS file
      ARM: dts: NSP: Add new DT file for bcm958525er
      ARM: dts: NSP: Add new DT file for bcm958522er
      ARM: dts: NSP: Add new DT file for bcm988312hr
      ARM: dts: NSP: Add new DT file for bcm958623hr
      ARM: dts: NSP: Add new DT file for bcm958622hr

Joshua Clayton (1):
      ARM: dts: imx6q-evi: Use GPIO_6 for fec irq

Jyri Sarha (3):
      ARM: dts: am335x-evm: Add blue-and-red-wiring -property to lcdc node
      ARM: dts: am335x-evmsk: Whitespace cleanup of lcdc related nodes
      ARM: dts: am335x-evmsk: Add blue-and-red-wiring -property to lcdc node

Karl Beldan (5):
      ARM: dts: da850: Add missing pin muxing for the UARTs
      ARM: dts: da850: Add basic DTS for the LCDK
      ARM: dts: da850,da850-evm: Add an aemif node and use it for the NAND
      ARM: dts: da850-lcdk: Audio support via simple-card
      ARM: dts: da850-lcdk: Add NAND to DT

Keerthy (5):
      ARM: dts: AM437X-GP-EVM: AM437X-SK-EVM: Make dcdc3 dcdc5 and dcdc6 enable during suspend
      ARM: dts: AM437X-GP-EVM: Remove redundant regulator compatibles
      ARM: dts: AM437X-SK-EVM: Remove redundant regulator compatibles
      ARM: dts: AM437X-CM-T43: Remove redundant regulator compatibles
      ARM: dts: AM43X-EPOS-EVM: Remove redundant regulator compatibles

Ken Lin (1):
      ARM: dts: imx6q-bx50v3: configure unused pca953x pins

Kishon Vijay Abraham I (1):
      ARM: dts: DRA7: Add "linux,pci-domain" property for pci dt nodes

Krzysztof Kozlowski (18):
      ARM: dts: exynos: Use stdout non-deprecated property and add serial options to Odroid XU/XU3/XU4
      pinctrl: dt-bindings: samsung: Add header with values used for configuration
      pinctrl: dt-bindings: samsung: Update documentation with new macros
      ARM: dts: exynos: Use common macros for pinctrl configuration
      ARM: dts: exynos: Use macros for pinctrl configuration on exynos3250
      ARM: dts: exynos: Use macros for pinctrl configuration on exynos4210
      ARM: dts: exynos: Use macros for pinctrl configuration on exynos4x12
      ARM: dts: exynos: Use macros for pinctrl configuration on exynos4415
      ARM: dts: exynos: Use macros for pinctrl configuration on exynos5250
      ARM: dts: exynos: Use macros for pinctrl configuration on exynos5260
      ARM: dts: exynos: Use macros for pinctrl configuration on exynos5410
      ARM: dts: exynos: Use macros for pinctrl configuration on exynos542x/exynos5800
      ARM: dts: exynos: Fix mismatched value for SD4 pull up/down configuration on exynos4210
      ARM: dts: exynos: Fix mismatched values of SD drive strengh configuration on exynos4415
      ARM: dts: s3c64xx: Use common macros for pinctrl configuration
      ARM: dts: s5pv210: Use macros for pinctrl configuration
      ARM: dts: s3c2416: Use macros for pinctrl configuration
      ARM: dts: s3c64xx: Use macros for pinctrl configuration

Ladislav Michl (1):
      ARM: dts: omap5-igep0050.dts: Use tabs for indentation

Lars Persson (3):
      ARM: dts: artpec: use clock binding header
      ARM: dts: artpec: use optimized pl310 settings
      ARM: dts: artpec: set irq affinity on pmu interrupts

Lee Jones (6):
      ARM: dts: STiH407: Supply PWM Capture IRQ
      ARM: dts: STiH407: Declare PWM Capture data lines via Pinctrl
      ARM: dts: STiH416: Supply PWM Capture IRQs
      ARM: dts: STiH416: Declare PWM Capture data lines via Pinctrl
      ARM: dts: STiH416: Define PWM Capture clock
      ARM: dts: STiH416: Define the number of PWM Capture channels

Linus Walleij (13):
      ARM: dts: MSM8064 remove flags from SPMI/MPP IRQs
      ARM: dts: MSM8660 remove flags from SPMI/MPP IRQs
      ARM: dts: add PM8058 LEDs to the APQ8060 Dragonboard
      ARM: dts: fix RealView EB SMSC ethernet version
      ARM: dts: add device tree for the RealView EB Rev D
      ARM: dts: split RealView EB 11MPCore variants
      ARM: dts: add RealView EB rev D A9 MPCore variant
      ARM: dts: add STMPE PWM to the NHK15 device tree
      dt-bindings: add vendor TPO
      dt-bindings: Add TPO TPG110 binding
      ARM: nomadik: select MFD_SYSCON
      ARM: dts: add PMU to the NHK15 device tree
      ARM: dts: add the CLCD LCD display to the NHK15

Lucile Quirion (2):
      of: documentation: add bindings documentation for TS-4900
      ARM: dts: TS-4900: add basic device tree

Marek Szyprowski (1):
      ARM: dts: exynos: Add all required FIMC-IS clocks to exynos4x12

Marek Vasut (1):
      ARM: dts: imx6sx: Add GPU bindings

Mark Rutland (1):
      ARM: dts: explicitly mark skeleton.dtsi as deprecated

Masahiro Yamada (5):
      ARM: dts: uniphier: remove a whitespace after tabs
      ARM: dts: uniphier: match DT names to other projects and documents
      ARM: dts: uniphier: switch over to PSCI
      ARM: dts: uniphier: use clock/reset controllers
      ARM: dts: uniphier: add specific compatible to SoC-Glue node

Maxime Ripard (2):
      ARM: dt: axp209: Add AXP209 GPIO driver
      ARM: sun5i: chip: Add status LED

Meng Yi (1):
      ARM: dts: ls1021a: Add of_graph dt nodes to describe the panel

Michael Trimarchi (1):
      ARM: dts: imx6ul-geam: Add Engicam IMX6UL GEA M6UL initial support

Milo Kim (3):
      ARM: dts: exynos: Use 'hpd-gpios' instead of 'hpd-gpio'
      ARM: dts: exynos: Enable HDMI for Arndale Octa board
      ARM: dts: sun8i: Add PWM controller node in H3

Neil Armstrong (1):
      ARM: dts: meson8b: Add Meson8b PWM Controller nodes

Nishanth Menon (4):
      ARM: dts: keystone-k2g: Add Message Manager node
      ARM: dts: am57xx-beagle-x15: Remove pinmux configurations for erratum i869
      ARM: dts: am57xx-beagle-x15: Add support for rev B1
      ARM: dts: am57xx-beagle-x15-common: Fix wrong pinctrl selection for mmc2

Olivier Schonken (1):
      ARM: dts: at91: sama5d2: add ETM and ETB nodes

Olof Johansson (1):
      Merge tag 'berlin-dt-for-v4.9-1' of git://git.infradead.org/users/hesselba/linux-berlin into next/dt

Patrice Chotard (17):
      ARM: dts: STiH407: Move pio20 node to fix kernel warning
      ARM: dts: STiH410: Add thermal node
      ARM: dts: STiH407-pinctrl: Add i2c2_alt2_1 node
      ARM: dts: STiH407: Move non-removable property to board file
      ARM: dts: STiH407-pinctrl: Add pinctrl_rgmii1_mdio_1 node
      ARM: dts: STiH407-family: Add ports-implemented property in sata nodes
      ARM: dts: STi: Introduce B2260 board
      ARM: dts: STiH407-pinctrl: Update gpio-cells to 2
      ARM: dts: STiH418-B2199: Update gpio specifier
      ARM: dts: STiH41x-b2020: Update gpio specifier
      ARM: dts: STiH415-pinctrl: update gpio-cells to 2
      ARM: dts: STiH416-pinctrl: update gpio-cells to 2
      ARM: dts: STiHxxx-b2120: update gpio specifier
      ARM: dts: STiH41x-b2000: update gpio specifier
      ARM: dts: STiH416-b2020e: update gpio specifier
      ARM: dts: STiH410-b2260: add USB3 node
      ARM: dts: STiH410-b2260: add clk_ignore_unused in bootargs

Peter Griffin (8):
      ARM: STi: DT: STiH407: Add FDMA driver dt nodes.
      ARM: DT: STiH407: Add i2s_out pinctrl configuration
      ARM: DT: STiH407: Add i2s_in pinctrl configuration
      ARM: DT: STiH407: Add spdif_out pinctrl config
      ARM: STi: DT: STiH407: Add sti-sasg-codec dt node
      ARM: STi: DT: STiH407: Add uniperif player dt nodes
      ARM: STi: DT: STiH407: Add uniperif reader dt nodes
      ARM: DT: STi: stihxxx-b2120: Add DT nodes for STi audio card

Rafa? Mi?ecki (1):
      ARM: BCM5301X: Specify PHY of USB 2.0 in DT

Rajendra Nayak (3):
      arm: dts: msm8974: Add thermal zones, tsens and qfprom nodes
      arm: dts: apq8064: Add thermal zones, tsens and qfprom nodes
      arm: dts: apq8084: Add thermal zones, tsens and qfprom nodes

Randy Li (3):
      ARM: dts: rockchip: add rk3288-firefly-reload
      ARM: dts: rockchip: remove excess sd properties from firefly reload
      ARM: dts: rockchip: add missing regulators for firefly reload board

Sascha Hauer (1):
      ARM: i.MX6 Phytec PFLA02: Add supplies for the SoC internal regulators

Sekhar Nori (1):
      ARM: dts: dra7: workaround silicon limitation i845

Sergei Shtylyov (42):
      ARM: dts: r8a7792: add PFC support
      ARM: dts: blanche: add SCIF0/3 pins
      ARM: dts: blanche: add Ethernet pins
      ARM: dts: r8a7792: add GPIO clocks
      ARM: dts: r8a7792: add GPIO support
      ARM: dts: r8a7792: add EtherAVB clocks
      ARM: dts: r8a7792: add EtherAVB support
      ARM: dts: r8a7792: add CAN clocks
      ARM: dts: r8a7792: add CAN support
      ARM: dts: blanche: add CAN0 support
      ARM: dts: r8a7792: add SD clocks
      ARM: dts: r8a7792: add SDHI support
      ARM: dts: r8a7792: add I2C clocks
      ARM: dts: r8a7792: add I2C support
      ARM: dts: r8a7792: add VIN clocks
      ARM: dts: r8a7792: add VIN support
      ARM: dts: r8a7794: add audio clocks
      ARM: dts: r8a7794: add MSTP5 clocks
      ARM: dts: r8a7794: add MSTP10 clocks
      ARM: dts: r8a7794: add Audio-DMAC support
      ARM: dts: r8a7794: add sound support
      ARM: dts: silk: add sound support
      ARM: dts: r8a7792: fix misindented line
      ARM: dts: r8a7792: add DU clocks
      ARM: dts: r8a7792: add DU support
      ARM: dts: r8a7794: add VSP1 support
      ARM: dts: blanche: add support for general purpose switches
      ARM: dts: blanche: add SDHI0 support
      ARM: dts: blanche: add DU support
      ARM: dts: r8a7792: add VSP1V clocks
      ARM: dts: r8a7792: add VSP1V support
      ARM: dts: blanche: add support for general purpose LEDs
      ARM: dts: document Wheat board
      ARM: dts: wheat: initial device tree
      ARM: dts: wheat: add Ethernet support
      ARM: dts: r8a7794: fix PWM clock parent
      ARM: dts: wheat: add CAN support
      ARM: dts: wheat: add SDHI0 support
      ARM: dts: r8a7792: add QSPI clock
      ARM: dts: r8a7792: add QSPI support
      ARM: dts: wheat: add QSPI support
      ARM: dts: wheat: add support for tactile switches

Simon Horman (3):
      ARM: dts: r8a7794: Correct SDHI register size
      ARM: dts: alt: add SDHI0 and 1 support
      ARM: dts: alt: add MMCIF support

Stefan Agner (8):
      ARM: dts: imx7d: move ARM platform peripherals inside soc node
      ARM: dts: imx7d: fix GIC nodes interrupt and register specification
      ARM: dts: imx7d: move CPU operating points to imx7d.dtsi
      ARM: dts: imx7d: add clock-frequency to CPU nodes
      ARM: dts: imx7-colibri: move SD-card to module level
      ARM: dts: imx7-colibri: add basic supply regulators
      ARM: dts: imx7-colibri: add Audio support
      ARM: dts: vf610-colibri: use of_graph dt nodes to describe the panel

Stefan Mavrodiev (1):
      ARM: dts: sun8i: Add dts file for Olimex A33-OLinuXino

Stefan M?ller-Klieser (1):
      ARM: dts: am335x-wega: Add audio support

Stefan Roese (3):
      ARM: dts: mvebu: Add SPI1 pinctrl defines for Armada XP
      ARM: dts: mvebu: A37x/XP/38x/39x: Move SPI controller nodes into 'soc' node
      ARM: dts: mvebu: armada-370-xp: Add MBus mappings for all SPI devices

Stefan Wahren (4):
      ARM: dts: bcm283x: Add missing USB clock
      ARM: dts: bcm283x: Add dtsi for USB host mode
      DT: bindings: bcm: Add Raspberry Pi Zero
      ARM: dts: bcm2835: Add Raspberry Pi Zero

Stephen Warren (1):
      ARM: tegra: Fix Tegra114 USB compatible values

Tero Kristo (2):
      ARM: dts: am437x-gp-evm: disable DDR regulator in rtc-only/poweroff mode
      ARM: dts: am437x-sk-evm: disable DDR regulator in rtc-only/poweroff mode

Tim Harvey (3):
      ARM: dts: imx: ventana: Add ext watchdog reset
      ARM: dts: imx: add Gateworks Ventana GW553x support
      ARM: dts: imx: ventana: add RS485 txen gpio support

Tony Lindgren (8):
      ARM: dts: Configure panda SDIO WLAN wakeirq
      ARM: dts: ARM: dts: Fix omap5 SDIO dat1 interrupt
      ARM: dts: Configure omap5 OTG ID pin
      ARM: dts: Add power button support for igepv5
      ARM: dts: Fix LEDs for igepv5
      ARM: dts: Add support for more than 2GB of memory for omap5
      Merge branch 'am335x-cpufreq-regression' into omap-for-v4.9/dt-v2
      ARM: dts: Fix igepv5 power button GPIO direction

Uwe Kleine-K?nig (2):
      ARM: dts: imx6qdl: don't configure reserved pad settings
      ARM: dts: imx35: add iim module to imx35.dtsi

Vanessa Maegima (4):
      ARM: dts: imx6ul-pico-hobbit: Add Wifi support
      ARM: dts: imx7s-warp: Enable I2C2 device support
      ARM: dts: imx7s-warp: Add User Button support
      ARM: dts: imx7s-warp: Add Bluetooth support

Vignesh R (3):
      ARM: dts: dra7xx: Increase spi-max-frequency to 76.8MHz for QSPI
      ARM: dts: am57xx-idk-common: Enable support for QSPI
      ARM: dts: am335x-icev2: Add nodes for gpio-decoder

Vladimir Zapolskiy (1):
      ARM: dts: add gpio-ranges property to iMX GPIO controllers

Xing Zheng (1):
      ARM: dts: rockchip: add dts for RK3288-Fennec boards

Yakir Yang (3):
      ARM: dts: rockchip: add eDP/panel display device nodes for rk3288-evb
      ARM: dts: rockchip: add the panel power supply for rk3288-evb board with act8846 pmu
      ARM: dts: rockchip: add the panel power supply for rk3288-evb board with rk808 pmu

Yendapally Reddy Dhananjaya Reddy (1):
      ARM: dts: NSP: Add PWM Support to DT

twp at codeaurora.org (1):
      ipq8064: dts: force AP148 SATA port mapping

 .../devicetree/bindings/arm/bcm/brcm,bcm2835.txt   |   4 +
 Documentation/devicetree/bindings/arm/davinci.txt  |   4 +
 .../devicetree/bindings/arm/marvell/armada-39x.txt |  15 +-
 .../bindings/arm/marvell/marvell,orion5x.txt       |  25 +
 .../devicetree/bindings/arm/omap/omap.txt          |   6 +
 Documentation/devicetree/bindings/arm/rockchip.txt |   8 +
 Documentation/devicetree/bindings/arm/shmobile.txt |   4 +
 .../devicetree/bindings/arm/technologic.txt        |   6 +
 .../devicetree/bindings/clock/qcom,gcc.txt         |  16 +
 .../bindings/display/exynos/exynos_hdmi.txt        |   4 +-
 .../bindings/display/panel/tpo,tpg110.txt          |  47 ++
 .../devicetree/bindings/gpio/mrvl-gpio.txt         |  23 -
 .../devicetree/bindings/net/brcm,amac.txt          |  24 +
 .../devicetree/bindings/net/brcm,bgmac-nsp.txt     |  24 +
 .../bindings/pinctrl/samsung-pinctrl.txt           |  44 +-
 .../devicetree/bindings/vendor-prefixes.txt        |   3 +
 MAINTAINERS                                        |   2 +
 arch/arm/boot/dts/Makefile                         |  58 +-
 arch/arm/boot/dts/am335x-baltos.dtsi               |   8 +-
 arch/arm/boot/dts/am335x-base0033.dts              |   4 +-
 arch/arm/boot/dts/am335x-bone-common.dtsi          |  12 +-
 arch/arm/boot/dts/am335x-boneblack.dts             |  11 -
 arch/arm/boot/dts/am335x-chilisom.dtsi             |   2 +-
 arch/arm/boot/dts/am335x-cm-t335.dts               |   8 +-
 arch/arm/boot/dts/am335x-evm.dts                   |  18 +-
 arch/arm/boot/dts/am335x-evmsk.dts                 |  70 +-
 arch/arm/boot/dts/am335x-icev2.dts                 |  47 +-
 arch/arm/boot/dts/am335x-igep0033.dtsi             |  10 +-
 arch/arm/boot/dts/am335x-lxm.dts                   |   6 +-
 arch/arm/boot/dts/am335x-nano.dts                  |   4 +-
 arch/arm/boot/dts/am335x-pepper.dts                |  18 +-
 arch/arm/boot/dts/am335x-phycore-som.dtsi          |   6 +-
 arch/arm/boot/dts/am335x-shc.dts                   |  16 +-
 arch/arm/boot/dts/am335x-sl50.dts                  |  15 +-
 arch/arm/boot/dts/am335x-wega.dtsi                 |  64 +-
 arch/arm/boot/dts/am33xx.dtsi                      |  92 +--
 arch/arm/boot/dts/am3517-craneboard.dts            |   2 +-
 arch/arm/boot/dts/am3517-evm.dts                   |   2 +-
 arch/arm/boot/dts/am3517.dtsi                      |   2 +-
 arch/arm/boot/dts/am3517_mt_ventoux.dts            |   2 +-
 arch/arm/boot/dts/am4372.dtsi                      |  10 +-
 arch/arm/boot/dts/am437x-cm-t43.dts                |   6 -
 arch/arm/boot/dts/am437x-gp-evm.dts                |  21 +-
 arch/arm/boot/dts/am437x-idk-evm.dts               |   2 +-
 arch/arm/boot/dts/am437x-sk-evm.dts                |  45 +-
 arch/arm/boot/dts/am43x-epos-evm.dts               |  11 +-
 arch/arm/boot/dts/am572x-idk.dts                   |   2 +-
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi    | 596 +++++++++++++++
 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts      |  24 +
 arch/arm/boot/dts/am57xx-beagle-x15.dts            | 812 +--------------------
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts          |   4 +-
 arch/arm/boot/dts/am57xx-idk-common.dtsi           |  49 ++
 .../dts/arm-realview-eb-11mp-bbrevd-ctrevb.dts     |  32 +
 arch/arm/boot/dts/arm-realview-eb-11mp-bbrevd.dts  |  28 +
 ...mp-revb.dts => arm-realview-eb-11mp-ctrevb.dts} |   0
 arch/arm/boot/dts/arm-realview-eb-11mp.dts         |   2 +-
 arch/arm/boot/dts/arm-realview-eb-a9mp-bbrevd.dts  |  28 +
 arch/arm/boot/dts/arm-realview-eb-bbrevd.dts       |  29 +
 arch/arm/boot/dts/arm-realview-eb-bbrevd.dtsi      |  45 ++
 arch/arm/boot/dts/arm-realview-eb.dtsi             |  23 +-
 arch/arm/boot/dts/armada-370-db.dts                |  29 +-
 .../dts/armada-370-seagate-personal-cloud.dtsi     |  40 +-
 arch/arm/boot/dts/armada-370-synology-ds213j.dts   | 112 +--
 arch/arm/boot/dts/armada-370-xp.dtsi               |  56 +-
 arch/arm/boot/dts/armada-370.dtsi                  |  34 +-
 arch/arm/boot/dts/armada-385-db-ap.dts             |  58 +-
 arch/arm/boot/dts/armada-385-linksys.dtsi          |   9 +-
 arch/arm/boot/dts/armada-388-clearfog.dts          |  48 +-
 arch/arm/boot/dts/armada-388-db.dts                |  25 +-
 arch/arm/boot/dts/armada-388-gp.dts                |  30 +-
 arch/arm/boot/dts/armada-388-rd.dts                |  25 +-
 arch/arm/boot/dts/armada-38x.dtsi                  |  57 +-
 arch/arm/boot/dts/armada-390-db.dts                | 175 +++++
 arch/arm/boot/dts/armada-390.dtsi                  |   3 +
 arch/arm/boot/dts/armada-395-gp.dts                | 163 +++++
 arch/arm/boot/dts/armada-395.dtsi                  |  76 ++
 arch/arm/boot/dts/armada-398-db.dts                |  56 +-
 arch/arm/boot/dts/armada-398.dtsi                  |  10 +-
 arch/arm/boot/dts/armada-39x.dtsi                  | 126 +++-
 arch/arm/boot/dts/armada-xp-axpwifiap.dts          |  24 +-
 arch/arm/boot/dts/armada-xp-db.dts                 |  24 +-
 arch/arm/boot/dts/armada-xp-gp.dts                 |  24 +-
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts      |  24 +-
 arch/arm/boot/dts/armada-xp-synology-ds414.dts     | 112 +--
 arch/arm/boot/dts/armada-xp.dtsi                   |  31 +-
 arch/arm/boot/dts/armv7-m.dtsi                     |   2 -
 arch/arm/boot/dts/artpec6.dtsi                     |  31 +-
 arch/arm/boot/dts/axp209.dtsi                      |   6 +
 arch/arm/boot/dts/bcm-nsp.dtsi                     |  37 +
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts           |   1 +
 arch/arm/boot/dts/bcm2835-rpi-a.dts                |   1 +
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts           |   1 +
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts           |   1 +
 arch/arm/boot/dts/bcm2835-rpi-b.dts                |   1 +
 arch/arm/boot/dts/bcm2835-rpi-zero.dts             |  40 +
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts              |   1 +
 arch/arm/boot/dts/bcm283x-rpi-usb-host.dtsi        |   3 +
 arch/arm/boot/dts/bcm283x.dtsi                     |   9 +
 arch/arm/boot/dts/bcm5301x.dtsi                    |  11 +
 arch/arm/boot/dts/bcm958522er.dts                  | 130 ++++
 arch/arm/boot/dts/bcm958525er.dts                  | 142 ++++
 arch/arm/boot/dts/bcm958525xmc.dts                 |  44 +-
 arch/arm/boot/dts/bcm958622hr.dts                  | 170 +++++
 arch/arm/boot/dts/bcm958623hr.dts                  | 178 +++++
 arch/arm/boot/dts/bcm958625hr.dts                  |  71 +-
 arch/arm/boot/dts/bcm958625k.dts                   |  13 +
 arch/arm/boot/dts/bcm988312hr.dts                  | 182 +++++
 arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts         |   2 +-
 arch/arm/boot/dts/berlin2.dtsi                     |   7 +-
 arch/arm/boot/dts/berlin2cd-google-chromecast.dts  |   2 +-
 arch/arm/boot/dts/berlin2cd.dtsi                   |   5 +-
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts         |   2 +-
 arch/arm/boot/dts/berlin2q.dtsi                    |   8 +-
 arch/arm/boot/dts/da850-evm.dts                    |  51 +-
 arch/arm/boot/dts/da850-lcdk.dts                   | 221 ++++++
 arch/arm/boot/dts/da850.dtsi                       |  80 +-
 arch/arm/boot/dts/dm8148-evm.dts                   |   4 +-
 arch/arm/boot/dts/dm8148-t410.dts                  |   4 +-
 arch/arm/boot/dts/dm814x.dtsi                      |   4 +-
 arch/arm/boot/dts/dm8168-evm.dts                   |   4 +-
 arch/arm/boot/dts/dm816x.dtsi                      |   4 +-
 arch/arm/boot/dts/dra62x-j5eco-evm.dts             |   4 +-
 arch/arm/boot/dts/dra7-evm.dts                     |  14 +-
 arch/arm/boot/dts/dra7.dtsi                        |  36 +-
 arch/arm/boot/dts/dra72-evm-common.dtsi            |   4 +-
 arch/arm/boot/dts/dra72-evm-revc.dts               |   2 +-
 arch/arm/boot/dts/dra72-evm.dts                    |   2 +-
 arch/arm/boot/dts/dra74x.dtsi                      |   1 -
 arch/arm/boot/dts/dra7xx-clocks.dtsi               |  15 +-
 arch/arm/boot/dts/efm32gg-dk3750.dts               |   5 +-
 arch/arm/boot/dts/efm32gg.dtsi                     |   4 +
 arch/arm/boot/dts/exynos3250-artik5.dtsi           |   3 +-
 arch/arm/boot/dts/exynos3250-monk.dts              |   3 +-
 arch/arm/boot/dts/exynos3250-pinctrl.dtsi          | 346 +++++----
 arch/arm/boot/dts/exynos3250-rinato.dts            |   3 +-
 arch/arm/boot/dts/exynos3250.dtsi                  |   3 +-
 arch/arm/boot/dts/exynos4.dtsi                     |   3 +-
 arch/arm/boot/dts/exynos4210-origen.dts            |   3 +-
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi          | 458 ++++++------
 arch/arm/boot/dts/exynos4210-smdkv310.dts          |  15 +-
 arch/arm/boot/dts/exynos4210-trats.dts             |   3 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |  13 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |  16 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts          |   3 +-
 arch/arm/boot/dts/exynos4412-odroidx.dts           |   5 +-
 arch/arm/boot/dts/exynos4412-odroidx2.dts          |   3 +-
 arch/arm/boot/dts/exynos4412-origen.dts            |  15 +-
 arch/arm/boot/dts/exynos4412-smdk4412.dts          |  15 +-
 arch/arm/boot/dts/exynos4412-tiny4412.dts          |   3 +-
 arch/arm/boot/dts/exynos4412-trats2.dts            |   3 +-
 arch/arm/boot/dts/exynos4415-pinctrl.dtsi          | 296 ++++----
 arch/arm/boot/dts/exynos4415.dtsi                  |   3 +-
 arch/arm/boot/dts/exynos4x12-pinctrl.dtsi          | 525 +++++++------
 arch/arm/boot/dts/exynos4x12.dtsi                  |   5 +-
 arch/arm/boot/dts/exynos5.dtsi                     |   3 +-
 arch/arm/boot/dts/exynos5250-arndale.dts           |   5 +-
 arch/arm/boot/dts/exynos5250-pinctrl.dtsi          | 404 +++++-----
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |  11 +-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi      |  81 +-
 arch/arm/boot/dts/exynos5250-snow-rev5.dts         |   6 +-
 arch/arm/boot/dts/exynos5250-snow.dts              |   6 +-
 arch/arm/boot/dts/exynos5250-spring.dts            |  77 +-
 arch/arm/boot/dts/exynos5260-pinctrl.dtsi          | 280 ++++---
 arch/arm/boot/dts/exynos5260-xyref5260.dts         |   9 +-
 arch/arm/boot/dts/exynos5260.dtsi                  |   4 +-
 arch/arm/boot/dts/exynos5410-odroidxu.dts          |  35 +-
 arch/arm/boot/dts/exynos5410-pinctrl.dtsi          | 182 ++---
 arch/arm/boot/dts/exynos5410-smdk5410.dts          |  13 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |  22 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts         | 131 ++--
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          | 356 ++++-----
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |  23 +-
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  25 +-
 arch/arm/boot/dts/exynos5440-sd5v1.dts             |   6 +
 arch/arm/boot/dts/exynos5440-ssdk5440.dts          |   6 +
 arch/arm/boot/dts/exynos5440.dtsi                  |   3 +-
 arch/arm/boot/dts/exynos54xx.dtsi                  |   1 -
 arch/arm/boot/dts/exynos5800-peach-pi.dts          | 131 ++--
 arch/arm/boot/dts/imx35.dtsi                       |   7 +
 arch/arm/boot/dts/imx50.dtsi                       |  10 +
 arch/arm/boot/dts/imx53-usbarmory.dts              | 224 ++++++
 arch/arm/boot/dts/imx53.dtsi                       |  18 +
 arch/arm/boot/dts/imx6dl-gw553x.dts                |  55 ++
 arch/arm/boot/dts/imx6dl-riotboard.dts             |  22 +-
 arch/arm/boot/dts/imx6dl-ts4900.dts                |  49 ++
 arch/arm/boot/dts/imx6dl.dtsi                      |  53 ++
 arch/arm/boot/dts/imx6q-arm2.dts                   |  24 +-
 arch/arm/boot/dts/imx6q-b450v3.dts                 |  16 +
 arch/arm/boot/dts/imx6q-b650v3.dts                 |   9 +
 arch/arm/boot/dts/imx6q-ba16.dtsi                  |  24 +-
 arch/arm/boot/dts/imx6q-bx50v3.dtsi                |  70 ++
 arch/arm/boot/dts/imx6q-cm-fx6.dts                 |  24 +-
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts            |  24 +-
 arch/arm/boot/dts/imx6q-evi.dts                    |  28 +-
 arch/arm/boot/dts/imx6q-gw5400-a.dts               |  24 +-
 arch/arm/boot/dts/imx6q-gw553x.dts                 |  55 ++
 arch/arm/boot/dts/imx6q-marsboard.dts              |  24 +-
 arch/arm/boot/dts/imx6q-novena.dts                 |  12 +-
 arch/arm/boot/dts/imx6q-sbc6x.dts                  |  24 +-
 arch/arm/boot/dts/imx6q-tbs2910.dts                |  24 +-
 arch/arm/boot/dts/imx6q-ts4900.dts                 |  53 ++
 arch/arm/boot/dts/imx6q.dtsi                       |  37 +
 arch/arm/boot/dts/imx6qdl-apalis.dtsi              |  24 +-
 arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi       |  24 +-
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi              |  36 +-
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi              |  39 +-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi              |  39 +-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              |  44 +-
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi              |  12 +
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi              |  12 +
 arch/arm/boot/dts/imx6qdl-gw553x.dtsi              | 433 +++++++++++
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi           |  24 +-
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi           |  12 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi       |  24 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |  24 +-
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi       |  36 +-
 arch/arm/boot/dts/imx6qdl-rex.dtsi                 |  24 +-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |  24 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi           |  24 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |  24 +-
 arch/arm/boot/dts/imx6qdl-ts4900.dtsi              | 481 ++++++++++++
 arch/arm/boot/dts/imx6qdl-udoo.dtsi                |  24 +-
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi           |  24 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |  47 ++
 arch/arm/boot/dts/imx6sx-pinfunc.h                 |  14 +
 arch/arm/boot/dts/imx6sx.dtsi                      |  22 +
 arch/arm/boot/dts/imx6ul-geam-kit.dts              | 101 +++
 arch/arm/boot/dts/imx6ul-geam.dtsi                 | 361 +++++++++
 arch/arm/boot/dts/imx6ul-pico-hobbit.dts           |  33 +
 arch/arm/boot/dts/imx6ul.dtsi                      |   9 +-
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi        |   4 -
 arch/arm/boot/dts/imx7-colibri.dtsi                |  61 +-
 arch/arm/boot/dts/imx7d.dtsi                       |  42 +-
 arch/arm/boot/dts/imx7s-warp.dts                   | 446 +++++++++++
 arch/arm/boot/dts/imx7s.dtsi                       | 371 ++++++----
 arch/arm/boot/dts/keystone-k2e-evm.dts             |  12 +-
 arch/arm/boot/dts/keystone-k2e.dtsi                |   4 +-
 arch/arm/boot/dts/keystone-k2g.dtsi                |  32 +
 arch/arm/boot/dts/keystone-k2hk-evm.dts            |   6 +-
 arch/arm/boot/dts/keystone-k2l-evm.dts             |   6 +-
 arch/arm/boot/dts/keystone.dtsi                    |   4 +-
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts       |   9 +-
 arch/arm/boot/dts/logicpd-som-lv.dtsi              |  11 +-
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi         |   6 +
 arch/arm/boot/dts/lpc18xx.dtsi                     |   7 +
 arch/arm/boot/dts/lpc4337-ciaa.dts                 |   2 +-
 arch/arm/boot/dts/lpc4350-hitex-eval.dts           |   4 +-
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts        |   2 +-
 arch/arm/boot/dts/ls1021a-twr.dts                  |  13 +-
 arch/arm/boot/dts/meson8b.dtsi                     |  21 +
 arch/arm/boot/dts/mps2.dtsi                        |   1 +
 arch/arm/boot/dts/omap2.dtsi                       |   4 +-
 arch/arm/boot/dts/omap2420-h4.dts                  |   2 +-
 arch/arm/boot/dts/omap2420-n8x0-common.dtsi        |   2 +-
 arch/arm/boot/dts/omap2430-sdp.dts                 |   2 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts              |   2 +-
 arch/arm/boot/dts/omap3-beagle.dts                 |   2 +-
 arch/arm/boot/dts/omap3-cm-t3x.dtsi                |   2 +-
 arch/arm/boot/dts/omap3-devkit8000-common.dtsi     |   2 +-
 arch/arm/boot/dts/omap3-evm-37xx.dts               |   2 +-
 arch/arm/boot/dts/omap3-evm.dts                    |   2 +-
 arch/arm/boot/dts/omap3-gta04.dtsi                 |   4 +-
 arch/arm/boot/dts/omap3-igep.dtsi                  |   2 +-
 arch/arm/boot/dts/omap3-ldp.dts                    |   2 +-
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi            |   2 +-
 arch/arm/boot/dts/omap3-n900.dts                   |   2 +-
 arch/arm/boot/dts/omap3-n950-n9.dtsi               |   6 +-
 arch/arm/boot/dts/omap3-overo-alto35-common.dtsi   |   2 +-
 arch/arm/boot/dts/omap3-overo-base.dtsi            |  10 +-
 .../boot/dts/omap3-overo-chestnut43-common.dtsi    |   6 +-
 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi    |   2 +-
 arch/arm/boot/dts/omap3-overo-gallop43-common.dtsi |   4 +-
 arch/arm/boot/dts/omap3-overo-palo35-common.dtsi   |   4 +-
 arch/arm/boot/dts/omap3-overo-palo43-common.dtsi   |   4 +-
 arch/arm/boot/dts/omap3-overo-tobi-common.dtsi     |   2 -
 arch/arm/boot/dts/omap3-overo-tobiduo-common.dtsi  |   3 -
 arch/arm/boot/dts/omap3-pandora-common.dtsi        |  10 +-
 arch/arm/boot/dts/omap3-sniper.dts                 |   2 +-
 arch/arm/boot/dts/omap3-tao3530.dtsi               |   2 +-
 arch/arm/boot/dts/omap3-zoom3.dts                  |   2 +-
 arch/arm/boot/dts/omap3.dtsi                       |   6 +-
 arch/arm/boot/dts/omap3430-sdp.dts                 |   2 +-
 arch/arm/boot/dts/omap34xx.dtsi                    |   2 +-
 arch/arm/boot/dts/omap36xx.dtsi                    |   2 +-
 arch/arm/boot/dts/omap4-duovero-parlor.dts         |   2 +-
 arch/arm/boot/dts/omap4-duovero.dtsi               |   2 +-
 arch/arm/boot/dts/omap4-kc1.dts                    |   2 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi          |   4 +-
 arch/arm/boot/dts/omap4-sdp.dts                    |   2 +-
 arch/arm/boot/dts/omap4-var-som-om44.dtsi          |   2 +-
 arch/arm/boot/dts/omap4.dtsi                       |   4 +-
 arch/arm/boot/dts/omap5-board-common.dtsi          |  29 +-
 arch/arm/boot/dts/omap5-cm-t54.dts                 |   6 +-
 arch/arm/boot/dts/omap5-igep0050.dts               |  42 +-
 arch/arm/boot/dts/omap5-uevm.dts                   |  18 +-
 arch/arm/boot/dts/omap5.dtsi                       |  26 +-
 arch/arm/boot/dts/orion5x-mv88f5181.dtsi           |  49 ++
 arch/arm/boot/dts/orion5x-netgear-wnr854t.dts      | 251 +++++++
 arch/arm/boot/dts/orion5x.dtsi                     |   3 +-
 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts     |  39 +
 arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts |  15 +
 arch/arm/boot/dts/qcom-apq8064.dtsi                | 180 ++++-
 arch/arm/boot/dts/qcom-apq8084.dtsi                | 103 +++
 arch/arm/boot/dts/qcom-ipq8064-ap148.dts           |   1 +
 arch/arm/boot/dts/qcom-msm8660.dtsi                |  75 +-
 .../dts/qcom-msm8974-lge-nexus5-hammerhead.dts     | 262 +++++++
 .../boot/dts/qcom-msm8974-sony-xperia-honami.dts   |  81 +-
 arch/arm/boot/dts/qcom-msm8974.dtsi                | 139 ++++
 arch/arm/boot/dts/qcom-pm8941.dtsi                 |   5 +
 arch/arm/boot/dts/r7s72100-rskrza1.dts             |  61 ++
 arch/arm/boot/dts/r7s72100.dtsi                    |  22 +
 arch/arm/boot/dts/r8a7790.dtsi                     |  23 -
 arch/arm/boot/dts/r8a7791.dtsi                     |  18 -
 arch/arm/boot/dts/r8a7792-blanche.dts              | 264 +++++++
 arch/arm/boot/dts/r8a7792-wheat.dts                | 199 +++++
 arch/arm/boot/dts/r8a7792.dtsi                     | 554 +++++++++++++-
 arch/arm/boot/dts/r8a7794-alt.dts                  | 106 +++
 arch/arm/boot/dts/r8a7794-silk.dts                 |  70 ++
 arch/arm/boot/dts/r8a7794.dtsi                     | 309 +++++++-
 arch/arm/boot/dts/rk3036.dtsi                      |  12 +-
 arch/arm/boot/dts/rk3288-evb-act8846.dts           |   4 +
 arch/arm/boot/dts/rk3288-evb-rk808.dts             |   4 +
 arch/arm/boot/dts/rk3288-evb.dtsi                  |  45 +-
 arch/arm/boot/dts/rk3288-fennec.dts                | 382 ++++++++++
 arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi  | 310 ++++++++
 arch/arm/boot/dts/rk3288-firefly-reload.dts        | 403 ++++++++++
 arch/arm/boot/dts/rk3288-popmetal.dts              |  12 +-
 arch/arm/boot/dts/rk3288.dtsi                      |  73 +-
 arch/arm/boot/dts/rk3xxx.dtsi                      |  12 +-
 arch/arm/boot/dts/s3c2416-pinctrl.dtsi             |  38 +-
 arch/arm/boot/dts/s3c6410-mini6410.dts             |   4 +-
 arch/arm/boot/dts/s3c64xx-pinctrl.dtsi             | 356 +++++----
 arch/arm/boot/dts/s5pv210-aquila.dts               |   6 +-
 arch/arm/boot/dts/s5pv210-goni.dts                 |   2 +-
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi             | 476 ++++++------
 arch/arm/boot/dts/s5pv210-smdkc110.dts             |   2 +-
 arch/arm/boot/dts/s5pv210-smdkv210.dts             |   2 +-
 arch/arm/boot/dts/s5pv210-torbreck.dts             |   2 +-
 arch/arm/boot/dts/s5pv210.dtsi                     |   4 +-
 arch/arm/boot/dts/sama5d2.dtsi                     |  29 +
 arch/arm/boot/dts/skeleton.dtsi                    |   4 +
 arch/arm/boot/dts/ste-nomadik-nhk15.dts            |  68 ++
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi         |  28 +
 arch/arm/boot/dts/stih407-clock.dtsi               |  22 +-
 arch/arm/boot/dts/stih407-family.dtsi              | 173 ++++-
 arch/arm/boot/dts/stih407-pinctrl.dtsi             | 140 +++-
 arch/arm/boot/dts/stih407.dtsi                     |  16 +-
 arch/arm/boot/dts/stih410-b2260.dts                | 194 +++++
 arch/arm/boot/dts/stih410-clock.dtsi               |  20 +-
 arch/arm/boot/dts/stih410.dtsi                     |  34 +-
 arch/arm/boot/dts/stih415-pinctrl.dtsi             |  54 +-
 arch/arm/boot/dts/stih416-b2020e.dts               |   6 +-
 arch/arm/boot/dts/stih416-pinctrl.dtsi             |  65 +-
 arch/arm/boot/dts/stih416.dtsi                     |   8 +-
 arch/arm/boot/dts/stih418-b2199.dts                |   8 +-
 arch/arm/boot/dts/stih418-clock.dtsi               |  20 +-
 arch/arm/boot/dts/stih41x-b2000.dtsi               |   5 +-
 arch/arm/boot/dts/stih41x-b2020.dtsi               |   6 +-
 arch/arm/boot/dts/stihxxx-b2120.dtsi               |  52 +-
 arch/arm/boot/dts/stm32f429.dtsi                   |   1 +
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts         |   4 -
 .../boot/dts/sun5i-a13-empire-electronix-m712.dts  |  51 ++
 arch/arm/boot/dts/sun5i-a13-inet-98v-rev2.dts      | 164 +----
 arch/arm/boot/dts/sun5i-r8-chip.dts                |  10 +
 arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts  | 138 +---
 arch/arm/boot/dts/sun6i-a31s-inet-q972.dts         | 100 +++
 .../boot/dts/sun6i-reference-design-tablet.dtsi    | 193 +++++
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               |  21 +
 arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts           | 192 +----
 .../boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts   |  42 ++
 .../boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts   |  42 ++
 arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts         |  18 +
 arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts     |  88 +++
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts          | 226 ++++++
 arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts          | 125 ++++
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts          |  10 +
 arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts       | 178 +++++
 arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts    |  88 +++
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts       |   2 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-plus2e.dts     |  53 ++
 arch/arm/boot/dts/sun8i-h3.dtsi                    |   8 +
 arch/arm/boot/dts/sun8i-q8-common.dtsi             |  49 ++
 .../boot/dts/sun8i-reference-design-tablet.dtsi    |  26 +
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts        |  29 +
 arch/arm/boot/dts/sun9i-a80-optimus.dts            |  29 +
 arch/arm/boot/dts/sun9i-a80.dtsi                   |  14 +-
 arch/arm/boot/dts/tegra114-dalmore.dts             |   2 +-
 arch/arm/boot/dts/tegra114-roth.dts                |   2 +-
 arch/arm/boot/dts/tegra114-tn7.dts                 |   2 +-
 arch/arm/boot/dts/tegra114.dtsi                    |   8 +-
 arch/arm/boot/dts/uniphier-common32.dtsi           |  63 +-
 ...iphier-ph1-ld4-ref.dts => uniphier-ld4-ref.dts} |  11 +-
 .../{uniphier-ph1-ld4.dtsi => uniphier-ld4.dtsi}   |  59 +-
 ...hier-ph1-ld6b-ref.dts => uniphier-ld6b-ref.dts} |  11 +-
 .../{uniphier-ph1-ld6b.dtsi => uniphier-ld6b.dtsi} |  17 +-
 ...hier-ph1-pro4-ace.dts => uniphier-pro4-ace.dts} |  11 +-
 ...hier-ph1-pro4-ref.dts => uniphier-pro4-ref.dts} |  11 +-
 ...-ph1-pro4-sanji.dts => uniphier-pro4-sanji.dts} |  11 +-
 .../{uniphier-ph1-pro4.dtsi => uniphier-pro4.dtsi} |  63 +-
 .../{uniphier-ph1-pro5.dtsi => uniphier-pro5.dtsi} |  58 +-
 ...stream2-gentil.dts => uniphier-pxs2-gentil.dts} |  12 +-
 ...oxstream2-vodka.dts => uniphier-pxs2-vodka.dts} |  11 +-
 ...niphier-proxstream2.dtsi => uniphier-pxs2.dtsi} |  62 +-
 ...hier-ph1-sld3-ref.dts => uniphier-sld3-ref.dts} |  11 +-
 .../{uniphier-ph1-sld3.dtsi => uniphier-sld3.dtsi} |  75 +-
 ...hier-ph1-sld8-ref.dts => uniphier-sld8-ref.dts} |  11 +-
 .../{uniphier-ph1-sld8.dtsi => uniphier-sld8.dtsi} |  59 +-
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi          |  13 +-
 arch/arm/boot/dts/vf610m4.dtsi                     |   1 +
 arch/arm/mach-davinci/da8xx-dt.c                   |   1 +
 arch/arm/mach-nomadik/Kconfig                      |   1 +
 include/dt-bindings/clock/r7s72100-clock.h         |   3 +
 include/dt-bindings/clock/r8a7794-clock.h          |  25 +
 include/dt-bindings/pinctrl/samsung.h              |  57 ++
 include/dt-bindings/soc/rockchip,boot-mode.h       |  15 +
 415 files changed, 16267 insertions(+), 5464 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/tpo,tpg110.txt
 create mode 100644 Documentation/devicetree/bindings/net/brcm,amac.txt
 create mode 100644 Documentation/devicetree/bindings/net/brcm,bgmac-nsp.txt
 create mode 100644 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
 create mode 100644 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
 create mode 100644 arch/arm/boot/dts/arm-realview-eb-11mp-bbrevd-ctrevb.dts
 create mode 100644 arch/arm/boot/dts/arm-realview-eb-11mp-bbrevd.dts
 rename arch/arm/boot/dts/{arm-realview-eb-11mp-revb.dts => arm-realview-eb-11mp-ctrevb.dts} (100%)
 create mode 100644 arch/arm/boot/dts/arm-realview-eb-a9mp-bbrevd.dts
 create mode 100644 arch/arm/boot/dts/arm-realview-eb-bbrevd.dts
 create mode 100644 arch/arm/boot/dts/arm-realview-eb-bbrevd.dtsi
 create mode 100644 arch/arm/boot/dts/armada-390-db.dts
 create mode 100644 arch/arm/boot/dts/armada-395-gp.dts
 create mode 100644 arch/arm/boot/dts/armada-395.dtsi
 create mode 100644 arch/arm/boot/dts/bcm2835-rpi-zero.dts
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-usb-host.dtsi
 create mode 100644 arch/arm/boot/dts/bcm958522er.dts
 create mode 100644 arch/arm/boot/dts/bcm958525er.dts
 create mode 100644 arch/arm/boot/dts/bcm958622hr.dts
 create mode 100644 arch/arm/boot/dts/bcm958623hr.dts
 create mode 100644 arch/arm/boot/dts/bcm988312hr.dts
 create mode 100644 arch/arm/boot/dts/da850-lcdk.dts
 create mode 100644 arch/arm/boot/dts/imx53-usbarmory.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-gw553x.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-ts4900.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw553x.dts
 create mode 100644 arch/arm/boot/dts/imx6q-ts4900.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw553x.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-ts4900.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-geam-kit.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-geam.dtsi
 create mode 100644 arch/arm/boot/dts/imx7s-warp.dts
 create mode 100644 arch/arm/boot/dts/orion5x-mv88f5181.dtsi
 create mode 100644 arch/arm/boot/dts/orion5x-netgear-wnr854t.dts
 create mode 100644 arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
 create mode 100644 arch/arm/boot/dts/r7s72100-rskrza1.dts
 create mode 100644 arch/arm/boot/dts/r8a7792-wheat.dts
 create mode 100644 arch/arm/boot/dts/rk3288-fennec.dts
 create mode 100644 arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
 create mode 100644 arch/arm/boot/dts/rk3288-firefly-reload.dts
 create mode 100644 arch/arm/boot/dts/stih410-b2260.dts
 create mode 100644 arch/arm/boot/dts/sun5i-a13-empire-electronix-m712.dts
 create mode 100644 arch/arm/boot/dts/sun6i-a31s-inet-q972.dts
 create mode 100644 arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi
 create mode 100644 arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a33-olinuxino.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3-orangepi-plus2e.dts
 rename arch/arm/boot/dts/{uniphier-ph1-ld4-ref.dts => uniphier-ld4-ref.dts} (89%)
 rename arch/arm/boot/dts/{uniphier-ph1-ld4.dtsi => uniphier-ld4.dtsi} (80%)
 rename arch/arm/boot/dts/{uniphier-ph1-ld6b-ref.dts => uniphier-ld6b-ref.dts} (89%)
 rename arch/arm/boot/dts/{uniphier-ph1-ld6b.dtsi => uniphier-ld6b.dtsi} (82%)
 rename arch/arm/boot/dts/{uniphier-ph1-pro4-ace.dts => uniphier-pro4-ace.dts} (90%)
 rename arch/arm/boot/dts/{uniphier-ph1-pro4-ref.dts => uniphier-pro4-ref.dts} (89%)
 rename arch/arm/boot/dts/{uniphier-ph1-pro4-sanji.dts => uniphier-pro4-sanji.dts} (89%)
 rename arch/arm/boot/dts/{uniphier-ph1-pro4.dtsi => uniphier-pro4.dtsi} (82%)
 rename arch/arm/boot/dts/{uniphier-ph1-pro5.dtsi => uniphier-pro5.dtsi} (85%)
 rename arch/arm/boot/dts/{uniphier-proxstream2-gentil.dts => uniphier-pxs2-gentil.dts} (88%)
 rename arch/arm/boot/dts/{uniphier-proxstream2-vodka.dts => uniphier-pxs2-vodka.dts} (88%)
 rename arch/arm/boot/dts/{uniphier-proxstream2.dtsi => uniphier-pxs2.dtsi} (84%)
 rename arch/arm/boot/dts/{uniphier-ph1-sld3-ref.dts => uniphier-sld3-ref.dts} (89%)
 rename arch/arm/boot/dts/{uniphier-ph1-sld3.dtsi => uniphier-sld3.dtsi} (83%)
 rename arch/arm/boot/dts/{uniphier-ph1-sld8-ref.dts => uniphier-sld8-ref.dts} (89%)
 rename arch/arm/boot/dts/{uniphier-ph1-sld8.dtsi => uniphier-sld8.dtsi} (80%)
 create mode 100644 include/dt-bindings/pinctrl/samsung.h
 create mode 100644 include/dt-bindings/soc/rockchip,boot-mode.h
