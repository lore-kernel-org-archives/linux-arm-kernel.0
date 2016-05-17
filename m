From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 May 2016 00:23:15 +0200
Subject: [GIT PULL 4/7] ARM: DT updates for v4.7
In-Reply-To: <8749147.ztcb6kVhye@wuerfel>
References: <8749147.ztcb6kVhye@wuerfel>
Message-ID: <4897774.QfBWDn1tQ5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit bf16200689118d19de1b8d2a3c314fc21f5dc7bb:

  Linux 4.6-rc3 (2016-04-10 17:58:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt

for you to fetch changes up to ec42083b98bc7a85c736a8ae1b4c045901ed259e:

  ARM: dts: tango4: Import watchdog node (2016-05-10 16:12:00 +0200)

----------------------------------------------------------------
ARM: DT updates for v4.7

These are all the updates to device tree files for 32-bit platforms,
which as usual makes up the bulk of the ARM SoC changes: 462 non-merge
changesets, 450 files changed, 23340 insertions, 5216 deletions.

The three platforms that are added with the "soc" branch are here as well,
and we add some related machine files:

- For Aspeed AST2400/AST2500, we get the evaluation platform and
  the Tyan Palmetto POWER8 mainboard that uses the AST2400 BMC
- For Oxnas 810SE, the Western Digital "My Book World Edition"
  is added as the only platform at the moment.
- For ARM MPS2, the AN385 (Cortex-M3) and AN399 (Cortex-M7)
  are supported

On the ARM Realview development platform, we now support all machines
with device tree, previously only the board files were supported, which
in turn will likely be removed soon.

Qualcomm IPQ4019 is the second generation ARM based "Internet Processor",
following the IPQ806x that is used in many high-end WiFi routers. This one
integrates two ath10k wifi radios that were previously on separate chips.

Other boards that got added for existing chips are:

- On Ti OMAP family:
  - Amazon Kindle Fire, first generation, tablet and ebook reader
  - OnRISC Baltos iR 2110 and 3220 embedded industrial PCs
  - TI AM5728 IDK, TI AM3359 ICE-V2, and TI DRA722 Rev C EVM
    development systems

- On Samsung EXYNOS platform:
  - Samsung ARTIK5 evaluation board, see
    https://www.artik.io/modules/overview/artik-5/

- On NXP i.MX platforms:
  - Ka-Ro electronics TX6S-8034, TX6S-8035, TX6U-8033, TX6U-81xx,
    TX6Q-1036, TX6Q-1110/-1130, TXUL-0010 and TXUL-0011 industrial
    SoM modules
  - Embest MarS Board i.MX6Dual DIY platform
  - Boundary Devices i.MX6 Quad Plus Nitrogen6_MAX and
    SoloX Nitrogen6sx embedded boards
  - Technexion Pico i.MX6UL compute module
  - ZII VF610 Development Board

- On Marvell embedded (mvebu, orion, kirkwood) platforms:
  - Linksys Viper (E4200v2 / EA4500) WiFi router
  - Buffalo Kurobox Pro NAS

- On Qualcomm Snapdragon:
  - Arrow DragonBoard 600c (96boards) with APQ8064 Snapdragon 600

- On Rockchips platform:
  - mqmaker MiQi single-board computer

- On Altera SoCFPGA:
  - samtec VIN|ING 1000 vehicle communication interface

- On Allwinner Sunxi platforms:
  - Dserve DSRV9703C tablet
  - Difrnce DIT4350 tablet
  - Colorfly E708 Q1 tablet
  - Polaroid MID2809PXE04 tablet
  - Olimex A20 OLinuXino LIME2 single board computer
  - Xunlong Orange Pi 2, Orange Pi One, and Orange Pi PC
    single board computers

Across many platforms, bug fixes went in to address warnings that
dtc now emits with 'make dtbs W=1'. Further changes for device enablement
went into Ti OMAP, bcm283x (Raspberry Pi), bcm47xx (wifi router),
Ti Davinci, Samsung EXYNOS, Marvell mvebu/kirkwood/orion, NXP i.MX/Vybrid
NXP LPC18xx, NXP LPC32xx, Renesas shmobile/r-mobile/r-car, Rockchips
rk3xxx, ST Ux500, ST STi, Atmel AT91/SAMA5, Altera SoCFPGA, Allwinner
Sunxi, Sigma Designs Tango, NVIDIA Tegra, Socionext Uniphier and ARM
Versatile Express.

----------------------------------------------------------------
Adam Baker (1):
      ARM: dts: kirkwood: Add the hardware monitor to the NSA320 device tree

Akshay Bhat (5):
      ARM: dts: imx6q-ba16: Remove unused vqmmc-supply
      ARM: dts: imx6q-b850v3: Remove ldb panel
      ARM: dts: imx6q-b850v3: Update display clock source
      ARM: dts: imx: b450/b650v3: Move ldb_di clk assignment
      ARM: dts: imx6q-ba16: use wdog external reset

Alexander Kurz (1):
      ARM: dts: i.MX3x: add keypad port devicetree nodes

Alexander Stein (1):
      ARM: dts: ls1021a: DSPI has 6 chip-selects

Andrew Lunn (8):
      ARM: dts: kirkwood: Remove button address and fixup names
      ARM: dts: kirkwood: Remove node address from leds
      ARM: dts: kirkwood: Remove address from dsa unit name
      ARM: dts: kirkwood: Add address to ethernet-phy unit name
      ARM: dts: kirkwood: Fixup pcie DT warnings
      ARM: dts: kirkwood: Remove address from gpio-i2c unit name
      ARM: dts: kirkwood: Add address to mbus unit name
      ARM: dts: kirkwood: Add address go regulator unit name

Arnd Bergmann (34):
      Merge tag 'samsung-dt-exynos3250-artik5-4.7' of git://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'samsung-dt-4.7' of git://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'mvebu-dt-4.7-1' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'nomadik-dts-v4.7' of git://git.kernel.org/.../linusw/linux-nomadik into next/dt
      Merge tag 'davinci-for-v4.7/dt' of git://git.kernel.org/.../nsekhar/linux-davinci into next/dt
      Merge tag 'tegra-for-4.7-arm' of git://git.kernel.org/.../tegra/linux into next/dt
      Merge tag 'imx-dt-4.7' of git://git.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'renesas-rcar-sysc-for-v4.7' of git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'omap-for-v4.7/dt-part1' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'arm-soc/for-4.7/devicetree' of http://github.com/Broadcom/stblinux into next/dt
      Merge tag 'qcom-dt-for-4.7' of git://git.kernel.org/.../agross/linux into next/dt
      Merge tag 'renesas-dt-for-v4.7' of git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'vexpress-for-v4.7/updates' of git://git.kernel.org/.../sudeep.holla/linux into next/dt
      Merge tag 'keystone_dts_for_4.7' of git://git.kernel.org/.../ssantosh/linux-keystone into next/dt
      Merge tag 'omap-for-v4.6/dt-ti81xx-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'renesas-fixes-for-v4.6' of git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'ox810se-arm-dt-v4.6-rc3' of https://github.com/superna9999/linux into next/dt
      Merge tag 'sti-dt-for-v4.7b-1' of git://git.kernel.org/.../mcoquelin/sti into next/dt
      Merge tag 'at91-dt2' of git://git.kernel.org/.../nferre/linux-at91 into next/dt
      Merge tag 'lpc32xx-dt-4.7' of git://github.com/vzapolskiy/linux-lpc32xx into next/dt
      Merge tag 'renesas-dt2-for-v4.7' of git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'samsung-dt-4.7-2' of git://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'socfpga_dts_for_v4.7_part_2' of git://git.kernel.org/.../dinguyen/linux into next/dt
      Merge tag 'samsung-dt-exynos-srom-fixup-4.7' of git://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'omap-for-v4.7/dt-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'v4.7-rockchip-dts32-2' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'davinci-for-v4.7/dt-part2' of git://git.kernel.org/.../nsekhar/linux-davinci into next/dt
      Merge tag 'sunxi-dt-for-4.7' of https://git.kernel.org/.../mripard/linux into next/dt
      Merge tag 'v4.6-next-dts' of https://github.com/mbgg/linux-mediatek into next/dt
      Merge tag 'imx-dt-4.7-2' of git://git.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'ux500-armsoc-v4.7' of git://git.kernel.org/.../linusw/linux-stericsson into next/dt
      Merge tag 'at91-dt3' of git://git.kernel.org/.../nferre/linux-at91 into next/dt
      Merge tag 'aspeed-for-4.7-dts' of https://github.com/shenki/linux into next/dt
      Merge tag 'sunxi-dt-for-4.7-2' of https://git.kernel.org/.../mripard/linux into next/dt

Ben Hutchings (2):
      ARM: dts: dra7xx: Fix compatible string for PCF8575 chip
      ARM: dts: r8a7790: Set maximum frequencies for SDHI clocks

Bert Vermeulen (1):
      ARM: dts: kirkwood: Add DTS for Linksys EA4200v2/EA4500

Biao Huang (1):
      arm: dts: Add pinctrl/GPIO/EINT node for mt2701

Bjorn Andersson (6):
      ARM: dts: msm8974: Split efs in rfsa and rmtfs
      ARM: dts: msm8974: Add node for second i2c from blsp1
      ARM: dts: msm8974: Add modem smp2p and smd nodes
      ARM: dts: qcom: apq8064: Add syscon for sic-non-secure
      ARM: dts: qcom: apq8064: Add complete smsm node
      ARM: dts: qcom: apq8064: Add smd node and all edges

Brian Starkey (1):
      ARM: dts: vexpress: Add external expansion bus to DT

Caesar Wang (7):
      ARM: dts: rockchip: add vop device node for rk3036
      ARM: dts: rockchip: add hdmi device node for rk3036
      ARM: dts: rockchip: enable graphics support on rk3036-kylin
      ARM: dts: rockchip: add the thermal main info found on rk3228
      ARM: dts: rockchip: enable the tsadc for rk3228 evb
      ARM: dts: rockchip: add rk3288-veyron-jaq backlight and panel overrides
      ARM: dts: rockchip: move the rk3288 thermal data into rk3288.dtsi

Chanho Park (1):
      ARM: dts: exynos: Add exynos5420-fimd compatible

Chanwoo Choi (6):
      dt-bindings: Add the clock id of UART2 and MMC2 for Exynos3250
      clk: samsung: exynos3250: Add MMC2 clock
      ARM: dts: exynos: Add initial pin configuration for exynos3250-rinato
      ARM: dts: exynos: Add initial gpio setting of MMC2 device for exynos3250-monk
      ARM: dts: exynos: Add MSHC2 DT node for Exynos3250 SoC
      ARM: dts: exynos: Add exynos3250-artik5 dtsi file for ARTIK5 module

Chen-Yu Tsai (1):
      ARM: dts: sun8i: Add Orange Pi PC support

Christopher Spinrath (1):
      ARM: dts: sun7i: Enable S/PDIF on the Cubietruck

Cory Tusar (1):
      ARM: dts: vf610-zii-dev: Add ZII development board.

Cyrille Pitchen (1):
      ARM: dts: at91: sama5d2: add SFR node

David Lechner (5):
      ARM: dts: davinci: use proper address after @
      ARM: dts: da850: add spi0 to device tree
      ARM: davinci: da8xx-dt: Add spi0 lookup for clock matching
      ARM: dts: da850: disable mdio and eth0 in da850.dtsi
      ARM: dts: da850: There are 101 interrupts.

Dinh Nguyen (3):
      ARM: dts: socfpga: add cap-sd-highspeed for SD/MMC node
      ARM: dts: socfpga: add the clk-phase property for sd/mmc clock
      ARM: dts: socfpga: add reset control for USB

Eric Anholt (2):
      drm/vc4: Kick out the simplefb framebuffer before we set up KMS.
      ARM: bcm2835: Add VC4 to the device tree.

Fabio Estevam (14):
      ARM: dts: imx6qdl-sabresd: Pass the hannstar panel compatible string
      ARM: dts: imx6sx: Fix SAI DMA index
      ARM: dts: imx6sx: Remove unused property
      bindings: fsl-imx-sdma: Document 'fsl,sdma-event-remap' property
      ARM: dts: imx6sx-sdb: Add SAI support
      ARM: dts: imx6ul: Fix operating points
      ARM: dts: imx6sx: Add 198MHz operating point
      ARM: dts: imx6dl: Fix the VDD_ARM_CAP voltage for 396MHz operation
      ARM: dts: imx6: Do not hardcode the CLKO clock
      ARM: dts: imx6ul-pico-hobbit: Add initial support
      ARM: dts: imx28-m28: Remove unneeded partition nodes
      ARM: dts: imx6sx-sdb: Add 198MHz operational point
      ARM: dts: imx6qdl: Remove unneeded unit-addresses
      ARM: dts: imx6ul-14x14-evk: Add audio support

Filip Matijevi? (2):
      ARM: dts: N9/N950: Add support for 1GHz CPU clock
      ARM: dts: N9/N950: Add support for accelerometer

Florian Fainelli (1):
      Merge tag 'bcm2835-dt-next-2016-04-20' into devicetree/next

Florian Vallee (1):
      ARM: dts: at91: fix typo in sama5d2 PIN_PD24 description

Franklin S Cooper Jr (1):
      ARM: dts: da850/am4372/am33xx: Use generic node name for ehrpwm

Gary Bisson (2):
      ARM: dts: imx: add Boundary Devices Nitrogen6_MAX QP board
      ARM: dts: imx: add Boundary Devices Nitrogen6_SoloX board

Geert Uytterhoeven (21):
      PM / Domains: Add DT bindings for the R-Car System Controller
      soc: renesas: Add r8a7779 SYSC PM Domain Binding Definitions
      soc: renesas: Add r8a7790 SYSC PM Domain Binding Definitions
      soc: renesas: Add r8a7791 SYSC PM Domain Binding Definitions
      soc: renesas: Add r8a7793 SYSC PM Domain Binding Definitions
      soc: renesas: Add r8a7794 SYSC PM Domain Binding Definitions
      soc: renesas: Add r8a7795 SYSC PM Domain Binding Definitions
      ARM: shmobile: timer: Fix preset_lpj leading to too short delays
      ARM: dts: r8a7790: Add SCIF2 clock
      ARM: dts: r8a7790: Add SCIF2 device node
      ARM: dts: sh73a0: Correct interrupt type for ARM TWD
      ARM: dts: r8a7779: Correct interrupt type for ARM TWD
      ARM: dts: kzm9g: Configure NMI key as wake-up source
      ARM: dts: omap5-board-common: DT spelling s/interrupt-name/interrupt-names/
      ARM: dts: omap5-cm-t54: DT spelling s/interrupt-name/interrupt-names/
      ARM: dts: OMAP36xx: : DT spelling s/#address-cell/#address-cells/
      ARM: dts: r8a7778: Don't disable referenced optional clocks
      ARM: dts: r8a7779: Don't disable referenced optional clocks
      ARM: dts: r8a7790: Don't disable referenced optional clocks
      ARM: dts: r8a7793: Don't disable referenced optional clocks
      ARM: dts: r8a7794: Don't disable referenced optional clocks

Graham Moore (1):
      ARM: dts: socfpga: Add missing clock and interrupt fields for Arria10 DMA

H. Nikolaus Schaller (2):
      ARM: dts: twl6030: describe gpadc
      ARM: dts: omap5-board-common: describe gpadc for Palmas

Hans de Goede (19):
      ARM: dts: sun5i-a13-inet98v-rev2: Remove mmc2 node
      ARM: dts: sun5i-a13-empire-electronix-d709: Remove mmc2 node
      ARM: dts: sun5i: Add dts for Difrence DIT4350 tablet
      ARM: dts: sun6i: Add dts for colorfly e708 q1 tablet
      ARM: dts: sun8i: Add pmic nodes to sun8i-a23-gt90h-v4
      ARM: dts: sun8i: Add backlight / pwm nodes to sun8i-a23-gt90h-v4
      ARM: dts: sun8i: Fix wrong Quad core / a33 compat for sun8i-a23-gt90h-v4
      ARM: dts: sun8i: Fix regulator for mmc0 for sun8i-a23-gt90h-v4
      ARM: dts: sun8i: Add dts file for the Polaroid MID2809PXE4 tablet
      ARM: dts: sun4i: Add dts file for Dserve DSRV9703C tablet
      ARM: dts: sun8i: Add mmc2_8bit_pins to sun8i-h3.dtsi
      ARM: dts: sun8i: Enable IR receiver on Orangepi Plus boards
      ARM: dts: sun8i: Add wifi dt node on Orangepi Plus boards
      ARM: dts: sun8i: Add eMMC dt node on Orangepi Plus boards
      ARM: dts: sun8i: Fix pio nodes Orangepi Plus dts
      ARM: dts: sun8i: Add dts for Orange Pi 2 SBC
      ARM: dts: sun8i: Orangepi plus gpio keys fixes and improvements
      ARM: dts: sun8i: Base Orange Pi Plus dts on the Orange Pi 2 dts
      ARM: dts: sun8i: Add dts file for the Orange Pi One SBC

Heiko Stuebner (20):
      ARM: dts: rockchip: update rk3288-veyron cpu operating points
      ARM: dts: rockchip: fix rk3288 power-domain unit names
      ARM: dts: rockchip: fix missing usbphy unit-names
      ARM: dts: rockchip: clean up gpio-keys nodes
      ARM: dts: rockchip: drop unneeded properties from mipi node
      ARM: dts: rockchip: add missing unitname to cpu_leakage efuse
      ARM: dts: rockchip: add rk3288 edp-phy node
      ARM: dts: rockchip: add rk3288 displayport controller node
      ARM: dts: rockchip: move edp-hpd pin definition into common location
      ARM: dts: rockchip: add startup delay to rk3288-veyron panel-regulators
      ARM: dts: rockchip: add core rk3288-veyron backlight and panel nodes
      ARM: dts: rockchip: add rk3288-veyron-minnie backlight and panel settings
      ARM: dts: rockchip: override edp hpd handling on veyron-pinky and speedy
      ARM: dts: rockchip: simple panel and backlight supplies on veyron boards
      ARM: dts: rockchip: enable the eDP on rk3288 veyron devices
      ARM: dts: rockchip: move rk3036 memory definition to board files
      ARM: dts: rockchip: make rk3288-grf a simple-mfd
      ARM: dts: rockchip: move rk3288 edp phy under the GRF
      dt-bindings: add vendor-prefix for mqmaker
      ARM: dts: rockchip: add MiQi board from mqmaker

Heinrich Schuchardt (2):
      ARM: dts: kirkwood: add kirkwood-ds112.dtb to Makefile
      ARM: dts: kirkwood: add kirkwood-nsa320.dtb to Makefile

Imre Kaloz (1):
      ARM: mvebu: fix GPIO config on the Linksys boards

JM Friedt (1):
      ARM: dts: sun5i-a13-olinuxino-micro: enable USB DRC

Jaehoon Chung (1):
      ARM: dts: exynos: Add MSHC2 DT node for SD card for exynos3250-artik5-eval board

Javier Martinez Canillas (5):
      ARM: dts: omap: add missing unit name to pbias regulator nodes
      ARM: dts: n8x0: remove unneeded unit name for i2c node
      ARM: dts: omap3: add missing unit name to PMU node
      ARM: dts: omap: remove unneeded unit name for sound nodes
      ARM: dts: omap: add missing unit names to bandgap nodes

Jens Kuske (1):
      ARM: dts: sun8i: Enable USB host controllers on Orangepi Plus boards

Jianqun Xu (1):
      dt-bindings: add bindings for Rockchip grf

Joachim Eastwood (12):
      ARM: dts: lpc18xx: add creg-clk node
      ARM: dts: lpc18xx: add rtc node
      ARM: dts: lpc18xx: add adc nodes
      ARM: dts: lpc18xx: add dac node
      ARM: dts: lpc4357-ea4357: add adc0
      ARM: dts: lpc4357-ea4357: add dac
      ARM: dts: lpc4350-hitex-eval: add adc1
      ARM: dts: armv7-m: add unit name to interrupt-controller
      ARM: dts: lpc18xx: remove unit addresses from creg childs
      ARM: dts: lpc4357-ea4357: fix unit name warnings from dtc
      ARM: dts: lpc4350-hitex-eval: fix unit name warnings from dtc
      dt-bindings: phy-lpc18xx-usb-otg: remove unit address from binding

Joel Stanley (3):
      doc/devicetree: Add Aspeed and Tyan to vendor-prefixes
      arm/dts: Add Aspeed ast2400 device tree
      arm/dst: Add Aspeed ast2500 device tree

John Crispin (1):
      dt-bindings: ARM: Mediatek: add MT2701/7623 string to the PMIC wrapper doc

John Keeping (3):
      ARM: dts: rockchip: fix MIPI interrupt on rk3288
      ARM: dts: rockchip: fix audio interrupts on rk3288
      ARM: dts: rockchip: add mipi_dsi to VIO power domain on rk3288

John Stultz (1):
      device-tree: nexus7: Add bq27541 battery interface to dts

Jon Hunter (2):
      ARM: tegra: Add stdout-path for various boards
      ARM: tegra: Correct interrupt type for ARM TWD

Joshua Clayton (1):
      ARM: dts: imx6: fix dtc warnings for ipu endpoints

Justin Waters (2):
      ARM: dts: imx: ba16: Add correct PCIe Tx Values
      ARM: dts: imx6q-ba16: Disable pwm2 by default

Kamil Debski (2):
      ARM: dts: exynos: Add HDMI CEC pin definition to exynos4 pinctrl
      ARM: dts: exynos: Add node for the HDMI CEC device to exynos4

Keerthy (4):
      ARM: dts: am57xx: Introduce commercial grade thermal thresholds
      ARM: dts: am57xx: Introduce industrial grade thermal thresholds
      ARM: dts: am57xx-beagle-x15: Include the commercial grade thresholds
      ARM: dts: am57xx-idk: Include Industrial grade  thermal thresholds

Krzysztof Kozlowski (18):
      ARM: dts: exynos: Add Security SubSystem node to Exynos4
      ARM: dts: exynos: Enable SSS on Trats2
      ARM: dts: exynos: Enable SSS on Odroid X/X2/U3 family
      Merge tag 'clk-v4.7-exynos3250' of git://linuxtv.org/snawrocki/samsung into for-v4.7/dt-exynos3250-artik5
      Merge tag 'samsung-dt-exynos3250-artik5-4.7' into next/dt
      ARM: dts: exynos: Fix DTC unit name warnings in cros-adc-thermistors
      ARM: dts: exynos: Fix DTC unit name warnings in Exynos3250
      ARM: dts: exynos: Fix DTC unit name warnings in Exynos4
      ARM: dts: exynos: Fix DTC unit name warnings in Trats2 board
      ARM: dts: exynos: Fix DTC unit name warnings in Exynos4x12
      ARM: dts: exynos: Fix DTC unit name warnings in Exynos5250
      ARM: dts: exynos: Fix DTC unit name warnings in Exynos542x
      ARM: dts: exynos: Fix DTC unit name warnings in Peach Pit
      ARM: dts: exynos: Fix DTC unit name warnings in SMDK5420
      ARM: dts: exynos: Fix DTC unit name warnings in Exynos5440
      ARM: dts: s5p: Fix DTC unit name warnings in SMDKv210 board
      ARM: dts: exynos: Remove unsupported s2mps11 regulator bindings from Exynos5420 boards
      ARM: dts: exynos: Enable PRNG and SSS for all Exynos4 devices

Lars Persson (1):
      ARM: dts: artpec: update clock bindings in artpec6.dtsi

Lee Jones (8):
      ARM: dts: STi: STiH407: Provide generic (safe) DVFS configuration
      ARM: dts: STi: STiH407: Provide CPU with clocking information
      ARM: dts: STi: STiH407: Link CPU with its voltage supply
      ARM: dts: STi: STiH407: Provide CPU with a means to look-up Major number
      ARM: dts: STi: stih407-family: Add nodes for Mailbox
      ARM: dts: STiH407: Add nodes for RemoteProc
      ARM: dts: STiH407: Move over to using the 'reserved-memory' API for obtaining DMA memory
      ARM: dts: STi: STih407: Switch LPC mode from RTC to Clocksource

Linus Walleij (10):
      ARM: dts: ux500: use the GPIO DT header
      ARM: dts: ux500: use the GIC include header
      Documentation/DT: add blurb for IB2 syscon to Versatile
      ARM: dts: realview: PB11MPCore: define a standard VGA panel
      ARM: dts: realview: PB1176: define a standard VGA panel
      ARM: dts: realview: support all the RealView EB board variants
      ARM: dts: realview: DT support for the PBA8 and PBX-A9
      ARM: dts: nomadik: add accelerometer IRQ and pin setting
      ARM: dts: nomadik: add DMA engine and some channels
      ARM: dts: ux500: configure the accelerometers open drain

Liu Gang (1):
      ARM: dts: ls1021a: Add gpio support for ls1021a platform

Lokesh Vutla (1):
      ARM: dts: am335x: Add initial support for ICEv2 board

Lothar Wa?mann (12):
      ARM: dts: imx6ul: add support for Ka-Ro electronics TXUL modules
      ARM: dts: imx6ul: add support for Ka-Ro electronics TXUL mainboard
      ARM: dts: imx6-tx6: Relicense the Ka-Ro DT files under GPLv2/X11
      ARM: dts: imx6-tx6: cleanup; no functional change
      ARM: dts: imx6-tx6: disable the spi node by default
      ARM: dts: imx6-tx6: remove container node around pinctrl nodes
      ARM: dts: imx6qdl-tx6: add mdio node for ethernet phy
      ARM: dts: imx6-tx6: remove regulator bus
      ARM: dts: imx6-tx6: remove LED pinctrl setting from hoggrp
      ARM: dts: imx6-tx6: enable support for rtscts on UARTs
      ARM: dts: imx6: add support for more Ka-Ro electronics modules
      ARM: dts: imx6: add support for the Ka-Ro electronics 'MB7' baseboard

Ludovic Desroches (1):
      ARM: dts: at91: sama5d2: add chipid node

Maarten Lankhorst (1):
      ARM: tegra: Enable watchdog support for Tegra114 and Tegra124

Maciej S. Szmigiero (1):
      ARM: dts: imx6qdl-udoo: add 7 inch LCD touchscreen panel support

Marc Gonzalez (4):
      ARM: dts: tango4: Initial thermal support
      ARM: dts: tango4: Update DT to match clk driver
      ARM: dts: tango4: Update cpus node for cpufreq
      ARM: dts: tango4: Import watchdog node

Marcel Ziswiler (1):
      ARM: dts: imx6: apalis: parallel lcd display support on ixora

Marcin Niestroj (3):
      ARM: dts: am335x-chili*: Move uart0 description from SOM to board
      ARM: dts: am335x-chili*: Move Ethernet MAC description from SOM to board
      ARM: dts: am335x-chilisom: Enable poweroff PMIC sequence using RTC signal

Marcus Cooper (8):
      ARM: dts: sun4i: Add SPDIF TX pin to the A10
      ARM: dts: sun7i: Add SPDIF TX pin to the A20
      ARM: dts: sun4i: Add the SPDIF clk to the A10
      ARM: dts: sun7i: Add the SPDIF clk to the A20
      ARM: dts: sun4i: Add the SPDIF block to the A10
      ARM: dts: sun7i: Add the SPDIF block to the A20
      ARM: dts: sun4i: Add SPDIF to the Mele A1000
      ARM: dts: sun7i: Add SPDIF to the Itead Ibox

Marek Szyprowski (1):
      ARM: dts: exynos: Enable the HDMI CEC device on Exynos4412 Odroid boards

Marek Vasut (6):
      ARM: dts: socfpga: Drop phy-addr OF property from CV dtsi
      ARM: dts: socfpga: Drop gmac0 from CV dtsi
      ARM: dts: socfpga: Add support for HPS LEDs on SoCKit
      ARM: dts: socfpga: Add support for HPS KEYs/SWs on SoCKit
      ARM: dts: socfpga: Add samtec VIN|ING board
      ARM: mx5: dts: Enable USB OTG on M53EVK

Markus Reichl (1):
      ARM: dts: exynos: Add eMMC and SD regulator supplies to Odroid XU3/XU4

Martin Sperl (1):
      dt/bindings: bcm2835: correct description for DMA-int

Masahiro Yamada (2):
      ARM: tegra: Remove redundant ARM_L1_CACHE_SHIFT_6 select
      ARM: dts: uniphier: add NAND pinmux node

Matthew McClintock (10):
      qcom: ipq4019: Add basic board/dts support for IPQ4019 SoC
      dts: ipq4019: Add support for IPQ4019 DK01 board
      qcom: ipq4019: add acc and saw nodes to bring up secondary cores
      qcom: ipq4019: add watchdog node to ipq4019 SoC and DK01 device tree
      qcom: ipq4019: add support for reset via qcom,ps-hold
      qcom: ipq4019: add spi node to ipq4019 SoC and DK01 device tree
      qcom: ipq4019: add i2c node to ipq4019 SoC and DK01 device tree
      qcom: ipq4019: add cpu operating points for cpufreq support
      qcom: ipq4019: add crypto nodes to ipq4019 SoC and DK01 device tree
      qcom: ipq4019: add DMA nodes to ipq4019 SoC and DK01 device tree

Maxime Ripard (6):
      ARM: sun5i: dt: Add pll3 and pll7 clocks
      ARM: sun5i: Add TV encoder gate to the DTSI
      ARM: sun5i: Add DRAM gates
      ARM: sun5i: a13: Add display and TCON clocks
      ARM: sun5i: r8: Add display blocks to the DTSI
      ARM: sun5i: chip: Enable the TV Encoder

Mike Williams (3):
      ARM: dts: at91: sama5d2: add trng node
      ARM: dts: at91: sama5d3: add trng node
      ARM: dts: at91: sama5d4: add trng node

Minghuan Lian (1):
      ARM: dts: ls1021a: add SCFG MSI dts node

Misael Lopez Cruz (1):
      ARM: dts: dra7: Use eDMA and add DAT port address for McASP3

Neil Armstrong (6):
      dt-bindings: irq: arm,versatile-fpga: add compatible string for OX810SE SoC
      dt-bindings: Add Oxford Semiconductor to vendor prefixes
      ARM: boot: dts: Add Oxford Semiconductor OX810SE dtsi
      dt-bindings: Add OXNAS bindings
      dt-bindings: Add Western Digital to vendor prefixes
      ARM: boot: dts: Add Western Digital My Book World Edition device tree

Nicolas Ferre (6):
      ARM: dts: at91: sama5d2: add LCD controller
      ARM: dts: at91: sama5d4: add watchdog interrupt property
      ARM: dts: at91: sama5d2: add shutdown controller node
      ARM: dts: at91: sama5d2: add slow clock to watchdog node
      ARM: dts: at91: VInCo: fix phy reset gpio flag
      ARM: dts: at91: at91sam9g45 family: reduce the trng register map size

Nishanth Menon (4):
      ARM: dts: dra7-evm: Add missing regulators
      ARM: dts: k2*: Rename the k2* files to keystone-k2* files
      ARM: dts: Add support for dra72-evm rev C (SR2.0)
      ARM: dts: AM57xx/DRA7: Update SoC voltage rail limits to match data sheet

Olliver Schinagl (1):
      ARM: dts: sunxi: Add a olinuxino-lime2-emmc

Olof Johansson (7):
      Merge tag 'at91-dt' of git://git.kernel.org/.../nferre/linux-at91 into next/dt
      Merge tag 'renesas-arm64-dt-for-v4.7' of git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'renesas-cleanup-for-v4.7' of git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'versatile-dts-1' of git://git.kernel.org/.../linusw/linux-integrator into next/dt
      Merge tag 'lpc18xx_dts_for_4.7' of https://github.com/manabian/linux-lpc into next/dt
      Merge tag 'socfpga_dts_for_v4.7' of git://git.kernel.org/.../dinguyen/linux into next/dt
      Merge tag 'v4.7-rockchip-dts32-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt

Pankaj Dubey (3):
      clk: samsung: exynos3250: Add UART2 clock
      ARM: dts: exynos: Add UART2 DT node for Exynos3250 SoC
      ARM: dts: change SROM node compatible from generic to model specific

Paul Kocialkowski (5):
      devicetree: bindings: Add vendor prefix for Amazon.com, Inc.
      ARM: dts: Amazon Kindle Fire (first generation) codename kc1 basic support
      ARM: dts: omap4-kc1: USB OTG support
      ARM: dts: omap4-kc1: LEDs support
      ARM: dts: omap4-kc1: Power off support

Peter Ujfalusi (8):
      ARM: dts: dra7: Move the sDMA crossbar node under l4_cfg/scm
      ARM: dts: dra7: Enable eDMA
      ARM: dts: dra7-evm: Enable AFIFO use for McASP3
      ARM: dts: dra72-evm: Enable AFIFO use for McASP3
      ARM: dts: am57xx-beagle-x15: Move clkout2 source selection to codec node
      ARM: dts: am57xx-beagle-x15: Enable AFIFO use for McASP3
      ARM: dts: dra7xx: Correct mcasp8_ahclkx_mux name
      ARM: dts: dra7: Add nodes for McASP1/2/4/5/6/7/8

Petr Kulhavy (3):
      ARM: DTS: da850: fix missing #gpio-cells in gpio node
      ARM: DTS: da850: add node for i2c1
      ARM: davinci: da8xx-dt: add OF_DEV_AUXDATA entry for i2c1

Priit Laes (4):
      ARM: sun4i: dt: Enable dram gate 5 (tve0 clock) for simplefb TV output
      ARM: sun7i: dt: Enable dram gate 5 (tve0 clock) for simplefb TV output
      ARM: sun4i: dt: Add pll3 and pll7 clocks
      ARM: sun7i: dt: Add pll3 and pll7 clocks

Rafa? Mi?ecki (3):
      ARM: BCM5301X: Set vcc-gpio for USB controllers of few devices
      ARM: BCM5301X: Enable earlycon on tested devices
      ARM: BCM5301X: Add DT entry for SPI controller and NOR flash

Ralf Ramsauer (2):
      ARM: tegra: Fix copy/paste typo in several DTS includes
      ARM: tegra: Add high speed UARTs to Jetson TK1 device tree

Ramesh Shanmugasundaram (2):
      arm64: dts: r8a7795: Add CAN external clock support
      arm64: dts: r8a7795: Add CAN support

Reinder de Haan (2):
      ARM: dts: sun8i: Add support for H3 usb clocks
      ARM: dts: sun8i: Add usbphy and usb host controller nodes

Roger Quadros (15):
      ARM: dts: dra7-evm: Fix comment about NAND configuration
      ARM: dts: omap24xx: Enable gpio and interrupt controller for GPMC
      ARM: dts: omap4: Enable gpio and interrupt controller for GPMC
      ARM: dts: omap5: Enable gpio and interrupt controller for GPMC
      ARM: dts: dra7: Enable gpio controller for GPMC
      ARM: dts: am335x: Enable gpio controller for GPMC
      ARM: dts: am4372: Enable gpio controller for GPMC
      ARM: dts: omap3: Enable gpio controller for GPMC
      ARM: dts: dm814x: Enable gpio controller for GPMC
      ARM: dts: dm816x: Enable gpio controller for GPMC
      ARM: dts: dra7x-evm: Provide NAND ready pin
      ARM: dts: am437x: Provide NAND ready pin
      ARM: dts: am335x: Provide NAND ready pin
      ARM: dts: omap3-beagle: Provide NAND ready pin
      ARM: dts: dra7xx: Fix compatible string for PCF8575 chip

Roger Shimizu (1):
      ARM: dts: orion5x: add device tree for kurobox-pro

Sascha Hauer (1):
      dt-bindings: MediaTek: Add binding document for the AUXADC

Schuyler Patton (1):
      ARM: dts: AM572x-IDK Initial Support

Sebastian Reichel (5):
      ARM: dts: n9/n950: regulator configuration
      ARM: dts: OMAP3-N950: Add Keypad Matrix
      ARM: dts: OMAP3-N950: Add Vibrator
      ARM: dts: Enable N950 keyboard sleep leds by default
      ARM: dts: OMAP3-N950: Add Keypad Slide Switch

Sergio Prado (1):
      ARM: dts: imx6: Add dts for Embest MarS Board

Shawn Lin (1):
      ARM: dts: rockchip: remove broken-cd from emmc and sdio

Simon Horman (39):
      arm64: dts: r8a7795: Use USB3.0 fallback compatibility string
      ARM: dts: lager: use generic pinctrl properties
      ARM: dts: ape6evm: use generic pinctrl properties
      ARM: dts: armadillo800eva: use generic pinctrl properties
      ARM: dts: bockw: use generic pinctrl properties
      ARM: dts: marzen: use generic pinctrl properties
      ARM: dts: koelsch: use generic pinctrl properties
      ARM: dts: porter: use generic pinctrl properties
      ARM: dts: gose: use generic pinctrl properties
      ARM: dts: alt: use generic pinctrl properties
      ARM: dts: silk: use generic pinctrl properties
      ARM: dts: kzm9g: use generic pinctrl properties
      ARM: dts: kzm9d: use generic pinctrl properties
      ARM: dts: r8a7790: Remove unnecessary clock-output-names properties
      ARM: dts: r7s72100: Remove unnecessary clock-output-names properties
      ARM: dts: r8a7740: Remove unnecessary clock-output-names properties
      ARM: dts: r8a7778: Remove unnecessary clock-output-names properties
      ARM: dts: r8a7779: Remove unnecessary clock-output-names properties
      ARM: dts: r8a7791: Remove unnecessary clock-output-names properties
      ARM: dts: r8a7793: Remove unnecessary clock-output-names properties
      ARM: dts: r8a7794: Remove unnecessary clock-output-names properties
      ARM: dts: gose: Remove unnecessary clock-output-names properties
      ARM: dts: koelsch: Remove unnecessary clock-output-names properties
      ARM: dts: porter: Remove unnecessary clock-output-names properties
      ARM: dts: lager: Remove unnecessary clock-output-names properties
      ARM: dts: r8a73a4: Remove unnecessary clock-output-names properties
      ARM: dts: sh73a0: Remove unnecessary clock-output-names properties
      ARM: dts: r8a7790: use fallback jpu compatibility string
      ARM: dts: r8a7791: use fallback jpu compatibility string
      ARM: dts: r8a7791: use fallback can compatibility string
      ARM: dts: r8a7790: use fallback can compatibility string
      ARM: dts: r8a7794: add CAN clocks to device tree
      ARM: dts: r8a7794: add CAN nodes to device tree
      ARM: dts: r8a7793: add CAN clocks to device tree
      ARM: dts: r8a7793: add CAN nodes to device tree
      ARM: dts: r8a7794: add IIC clocks
      ARM: dts: r8a7794: Add IIC nodes
      ARM: dts: r8a7790: Use USB3.0 fallback compatibility string
      ARM: dts: r8a7791: Use USB3.0 fallback compatibility string

Sjoerd Simons (2):
      ARM: dts: r8a7791: Don't disable referenced optional clocks
      Revert "ARM: dts: porter: Enable SCIF_CLK frequency and pins"

Soeren Moch (1):
      ARM: dts: imx6q-tbs2910: fix fec reset polarity

Srinivas Kandagatla (13):
      ARM: dts: apq8064: fix the pinctrls for i2c and spi
      ARM: dts: apq8064: add support to gsbi1 uart
      ARM: dts: apq8064: add gsbi7 i2c support
      ARM: dts: db600c: add board support with serial
      ARM: dts: db600c: add pmic regulator supplies
      ARM: dts: db600c: Add eMMC and SD card support
      ARM: dts: db600c: add usb support
      ARM: dts: db600c: add pcie support
      ARM: dts: db600c: add on board sata support.
      ARM: dts: db600c: Add on board leds support
      ARM: dts: db600c: add i2c support
      ARM: dts: db600c: add spi support
      ARM: dts: db600c: add support to magnetometer

Stefan Agner (4):
      ARM: dts: vf-colibri: alias the primary FEC as ethernet0
      ARM: dts: vf-colibri: increase NAND clock speed
      ARM: dts: vfxxx: add missing reg properties
      ARM: dts: ls1021a: add pix clock to DCU dts node

Stefan Wahren (1):
      ARM: bcm2835: add CPU node for ARM core

Sudeep Holla (2):
      ARM: tegra: Replace legacy *,wakeup property with wakeup-source
      ARM: dts: vexpress: fix node name unit-address presence warnings

Suman Anna (2):
      ARM: dts: DRA7: Enable Timers 13 through 16
      ARM: dts: DRA7: Add timer12 node

Sylvain Lemieux (3):
      ARM: dts: lpc32xx: add clock properties to spi nodes
      ARM: dts: phy3250: enable ssp0
      ARM: dts: lpc32xx: disabled ssp0/spi1 & ssp1/spi2 by default

Tero Kristo (9):
      ARM: dts: omap3: fix clock node definitions to avoid build warnings
      ARM: dts: omap2: fix clock node definitions to avoid build warnings
      ARM: dts: omap4: fix clock node definitions to avoid build warnings
      ARM: dts: am33xx: fix clock node definitions to avoid build warnings
      ARM: dts: am43xx: fix clock node definitions to avoid build warnings
      ARM: dts: dm81x: fix clock node definitions to avoid build warnings
      ARM: dts: dra7: fix clock node definitions to avoid build warnings
      ARM: dts: omap5: fix clock node definitions to avoid build warnings
      ARM: dts: am43xx: add support for clkout1 clock

Thor Thayer (2):
      ARM: dts: socfpga: Add Altera Arria10 L2 Cache EDAC devicetree entry
      ARM: dts: socfpga: Add Altera Arria10 OCRAM EDAC devicetree entry

Tony Lindgren (1):
      ARM: dts: Add clocks for dm814x ADPLL

Ulrich Hecht (2):
      ARM: dts: r8a7793: Add SDHI controllers
      ARM: dts: gose: Enable SDHI controllers

Uwe Kleine-K?nig (3):
      ARM: dts: imx25-pinfunc: add all UART mux modes
      ARM: dts: imx25-pinfunc: remove SION for pins with an UART handshaking input mode
      ARM: dts: imx28: add alternative pinmuxing for mac0

Vignesh R (3):
      ARM: dts: keystone: Add aliases for SPI nodes
      ARM: dts: dra7x: Remove QSPI pinmux
      ARM: dts: dra7x: Support QSPI MODE-0 operation at 64MHz

Vitaly Andrianov (1):
      ARM: keystone: dts: add psci command definition

Vladimir Murzin (2):
      ARM: dts: introduce MPS2 AN385/AN386
      ARM: dts: introduce MPS2 AN399/AN400

Vladimir Zapolskiy (10):
      ARM: dts: lpc32xx: set default clock rate of HCLK PLL
      dt-bindings: interrupt-controllers: add description of SIC1 and SIC2
      ARM: dts: lpc32xx: reparent SIC1 and SIC2 interrupts from MIC
      ARM: dts: lpc32xx: ea3250: avoid extension of device nodes by absolute path
      ARM: dts: lpc32xx: ea3250: add NAND partitions device node
      ARM: dts: lpc32xx: ea3250: fix Atmel at24 eeprom vendor
      ARM: dts: lpc32xx: ea3250: add SoC name prefix to board dts file
      ARM: dts: lpc32xx: phy3250: avoid extension of device nodes by absolute path
      ARM: dts: lpc32xx: phy3250: add NAND partitions device node
      ARM: dts: lpc32xx: phy3250: add SoC name prefix to board dts file

Wolfram Sang (2):
      ARM: dts: r8a7790: lager: Enable UHS-I SDR-50
      ARM: dts: r8a7790: fix max-frequency for SDHI

Yakir Yang (1):
      ARM: dts: rockchip: add i2c nodes for RK3228 SoCs

Yegor Yefremov (4):
      ARM: dts: am335x-baltos-ir5221: use dedicated RTS/CTS signals
      ARM: dts: split am335x-baltos-ir5221 into dts and dtsi files
      ARM: dts: add DTS for Baltos IR3220
      ARM: dts: add DTS for Baltos IR2110

 Documentation/devicetree/bindings/arm/arm-boards   |   8 +
 .../devicetree/bindings/arm/atmel-at91.txt         |   2 +-
 .../devicetree/bindings/arm/omap/omap.txt          |   6 +
 Documentation/devicetree/bindings/arm/oxnas.txt    |   9 +
 Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
 .../bindings/arm/samsung/samsung-boards.txt        |   2 +
 .../devicetree/bindings/dma/fsl-imx-sdma.txt       |  27 +
 .../arm,versatile-fpga-irq.txt                     |   2 +-
 .../brcm,bcm2835-armctrl-ic.txt                    |   4 +-
 .../interrupt-controller/nxp,lpc3220-mic.txt       |  70 +-
 .../bindings/phy/phy-lpc18xx-usb-otg.txt           |   2 +-
 .../bindings/power/renesas,rcar-sysc.txt           |  48 +
 .../devicetree/bindings/soc/mediatek/auxadc.txt    |  21 +
 .../devicetree/bindings/soc/mediatek/pwrap.txt     |   1 +
 .../devicetree/bindings/soc/rockchip/grf.txt       |  35 +
 Documentation/devicetree/bindings/spi/ti_qspi.txt  |   7 +
 .../devicetree/bindings/vendor-prefixes.txt        |   6 +
 MAINTAINERS                                        |   2 +-
 arch/arm/boot/dts/Makefile                         |  67 +-
 arch/arm/boot/dts/am335x-baltos-ir2110.dts         |  71 ++
 arch/arm/boot/dts/am335x-baltos-ir3220.dts         | 119 +++
 arch/arm/boot/dts/am335x-baltos-ir5221.dts         | 398 +--------
 arch/arm/boot/dts/am335x-baltos.dtsi               | 408 +++++++++
 arch/arm/boot/dts/am335x-chiliboard.dts            |  75 ++
 arch/arm/boot/dts/am335x-chilisom.dtsi             |  77 +-
 arch/arm/boot/dts/am335x-cm-t335.dts               |   1 +
 arch/arm/boot/dts/am335x-evm.dts                   |   1 +
 arch/arm/boot/dts/am335x-icev2.dts                 | 306 +++++++
 arch/arm/boot/dts/am335x-igep0033.dtsi             |   1 +
 arch/arm/boot/dts/am335x-phycore-som.dtsi          |   1 +
 arch/arm/boot/dts/am335x-shc.dts                   |   2 +-
 arch/arm/boot/dts/am33xx-clocks.dtsi               |  90 +-
 arch/arm/boot/dts/am33xx.dtsi                      |   8 +-
 arch/arm/boot/dts/am35xx-clocks.dtsi               |  20 +-
 arch/arm/boot/dts/am4372.dtsi                      |  14 +-
 arch/arm/boot/dts/am437x-gp-evm.dts                |   3 +-
 arch/arm/boot/dts/am43x-epos-evm.dts               |   3 +-
 arch/arm/boot/dts/am43xx-clocks.dtsi               | 170 ++--
 arch/arm/boot/dts/am572x-idk.dts                   |  85 ++
 arch/arm/boot/dts/am57xx-beagle-x15.dts            |  14 +-
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts          |   2 +-
 arch/arm/boot/dts/am57xx-commercial-grade.dtsi     |  23 +
 arch/arm/boot/dts/am57xx-idk-common.dtsi           | 304 +++++++
 arch/arm/boot/dts/am57xx-industrial-grade.dtsi     |  23 +
 arch/arm/boot/dts/arm-realview-eb-11mp-revb.dts    |  93 ++
 arch/arm/boot/dts/arm-realview-eb-11mp.dts         |  74 ++
 arch/arm/boot/dts/arm-realview-eb-a9mp.dts         |  70 ++
 arch/arm/boot/dts/arm-realview-eb-mp.dtsi          | 225 +++++
 arch/arm/boot/dts/arm-realview-eb.dts              | 166 ++++
 arch/arm/boot/dts/arm-realview-eb.dtsi             | 453 ++++++++++
 arch/arm/boot/dts/arm-realview-pb1176.dts          |  40 +
 arch/arm/boot/dts/arm-realview-pb11mp.dts          |  19 +-
 arch/arm/boot/dts/arm-realview-pba8.dts            | 178 ++++
 arch/arm/boot/dts/arm-realview-pbx-a9.dts          | 229 +++++
 arch/arm/boot/dts/arm-realview-pbx.dtsi            | 542 ++++++++++++
 arch/arm/boot/dts/armada-385-linksys.dtsi          |   6 +-
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts      |   4 +-
 arch/arm/boot/dts/armv7-m.dtsi                     |   2 +-
 arch/arm/boot/dts/artpec6.dtsi                     |  99 +--
 arch/arm/boot/dts/aspeed-ast2500-evb.dts           |  25 +
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts      |  25 +
 arch/arm/boot/dts/aspeed-g4.dtsi                   | 161 ++++
 arch/arm/boot/dts/aspeed-g5.dtsi                   | 170 ++++
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |   9 +
 arch/arm/boot/dts/at91-vinco.dts                   |   4 +-
 arch/arm/boot/dts/at91sam9g45.dtsi                 |   2 +-
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts           |   4 +
 arch/arm/boot/dts/bcm2835-rpi-a.dts                |   4 +
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts           |   4 +
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts           |   4 +
 arch/arm/boot/dts/bcm2835-rpi-b.dts                |   4 +
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |   9 +
 arch/arm/boot/dts/bcm2835.dtsi                     |  11 +
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts              |   4 +
 arch/arm/boot/dts/bcm283x.dtsi                     |  47 +
 arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts  |  10 +-
 arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts       |   6 +-
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts        |  17 +-
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts      |   6 +-
 arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts |   2 +-
 arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts  |   5 +
 arch/arm/boot/dts/bcm4709-netgear-r8000.dts        |   8 +
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts      |   6 +-
 arch/arm/boot/dts/bcm5301x.dtsi                    |  32 +
 arch/arm/boot/dts/cros-adc-thermistors.dtsi        |   8 +-
 arch/arm/boot/dts/da850-enbw-cmc.dts               |  14 +-
 arch/arm/boot/dts/da850-evm.dts                    |  26 +-
 arch/arm/boot/dts/da850.dtsi                       |  95 +-
 arch/arm/boot/dts/dm814x-clocks.dtsi               | 253 +++++-
 arch/arm/boot/dts/dm814x.dtsi                      |   2 +
 arch/arm/boot/dts/dm816x-clocks.dtsi               |  42 +-
 arch/arm/boot/dts/dm816x.dtsi                      |   2 +
 arch/arm/boot/dts/dra62x-clocks.dtsi               |  26 +
 arch/arm/boot/dts/dra7-evm.dts                     |  70 +-
 arch/arm/boot/dts/dra7.dtsi                        | 200 ++++-
 arch/arm/boot/dts/dra72-evm-common.dtsi            | 817 +++++++++++++++++
 arch/arm/boot/dts/dra72-evm-revc.dts               |  73 ++
 arch/arm/boot/dts/dra72-evm.dts                    | 835 +-----------------
 arch/arm/boot/dts/dra7xx-clocks.dtsi               | 376 ++++----
 arch/arm/boot/dts/emev2-kzm9d.dts                  |   4 +-
 arch/arm/boot/dts/exynos3250-artik5-eval.dts       |  43 +
 arch/arm/boot/dts/exynos3250-artik5.dtsi           | 334 +++++++
 arch/arm/boot/dts/exynos3250-monk.dts              |  12 +-
 arch/arm/boot/dts/exynos3250-pinctrl.dtsi          |  80 ++
 arch/arm/boot/dts/exynos3250-rinato.dts            |  71 +-
 arch/arm/boot/dts/exynos3250.dtsi                  |  27 +-
 arch/arm/boot/dts/exynos4.dtsi                     |  27 +-
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi          |   7 +
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |   4 +
 arch/arm/boot/dts/exynos4412-trats2.dts            |  16 +-
 arch/arm/boot/dts/exynos4x12-pinctrl.dtsi          |   7 +
 arch/arm/boot/dts/exynos4x12.dtsi                  |   2 +-
 arch/arm/boot/dts/exynos5.dtsi                     |   4 +-
 arch/arm/boot/dts/exynos5250-arndale.dts           |   2 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   8 +-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi      |  12 +-
 arch/arm/boot/dts/exynos5250-spring.dts            |   2 +-
 arch/arm/boot/dts/exynos5250.dtsi                  |  10 +-
 arch/arm/boot/dts/exynos5410-smdk5410.dts          |   2 +-
 arch/arm/boot/dts/exynos5410.dtsi                  |   4 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |   7 -
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |   6 +-
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |   9 +-
 arch/arm/boot/dts/exynos5420.dtsi                  |  13 +-
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  24 +-
 arch/arm/boot/dts/exynos5440.dtsi                  |   4 +-
 arch/arm/boot/dts/imx25-pinfunc.h                  | 124 +--
 arch/arm/boot/dts/imx28-m28.dtsi                   |  26 -
 arch/arm/boot/dts/imx28.dtsi                       |  26 +
 arch/arm/boot/dts/imx31.dtsi                       |   8 +
 arch/arm/boot/dts/imx35.dtsi                       |   8 +
 arch/arm/boot/dts/imx53-m53evk.dts                 |  21 +-
 arch/arm/boot/dts/imx6dl-riotboard.dts             |   2 +-
 arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts          |  42 +-
 arch/arm/boot/dts/imx6dl-tx6s-8034.dts             | 237 +++++
 arch/arm/boot/dts/imx6dl-tx6s-8035.dts             | 253 ++++++
 arch/arm/boot/dts/imx6dl-tx6u-801x.dts             |  42 +-
 arch/arm/boot/dts/imx6dl-tx6u-8033.dts             | 248 ++++++
 arch/arm/boot/dts/imx6dl-tx6u-811x.dts             |  60 +-
 arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dts         | 255 ++++++
 arch/arm/boot/dts/imx6dl.dtsi                      |   2 +-
 arch/arm/boot/dts/imx6q-apalis-ixora.dts           |  45 +
 arch/arm/boot/dts/imx6q-b450v3.dts                 |   5 +-
 arch/arm/boot/dts/imx6q-b650v3.dts                 |   5 +-
 arch/arm/boot/dts/imx6q-b850v3.dts                 |  33 +-
 arch/arm/boot/dts/imx6q-ba16.dtsi                  |   6 +-
 arch/arm/boot/dts/imx6q-gw5400-a.dts               |   2 +-
 arch/arm/boot/dts/imx6q-marsboard.dts              | 403 +++++++++
 arch/arm/boot/dts/imx6q-tbs2910.dts                |   4 +-
 arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts       |  42 +-
 arch/arm/boot/dts/imx6q-tx6q-1010.dts              |  42 +-
 arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts       |  72 +-
 arch/arm/boot/dts/imx6q-tx6q-1020.dts              |  72 +-
 arch/arm/boot/dts/imx6q-tx6q-1036.dts              | 252 ++++++
 arch/arm/boot/dts/imx6q-tx6q-1110.dts              |  60 +-
 arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dts          | 264 ++++++
 arch/arm/boot/dts/imx6q.dtsi                       |  18 +-
 arch/arm/boot/dts/imx6qdl-apalis.dtsi              |   2 +-
 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi             |   2 +-
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi              |   2 +-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi              |   2 +-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              |   2 +-
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi           |   2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi       |   2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |   2 +-
 arch/arm/boot/dts/imx6qdl-rex.dtsi                 |   2 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi           |   2 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |  30 +-
 arch/arm/boot/dts/imx6qdl-tx6.dtsi                 | 788 +++++++++--------
 arch/arm/boot/dts/imx6qdl-udoo.dtsi                |  98 ++-
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi           |   2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |  32 +-
 arch/arm/boot/dts/imx6qp-nitrogen6_max.dts         |  59 ++
 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts           | 709 +++++++++++++++
 arch/arm/boot/dts/imx6sx-sdb-sai.dts               |  67 ++
 arch/arm/boot/dts/imx6sx-sdb.dts                   |   2 +
 arch/arm/boot/dts/imx6sx-sdb.dtsi                  |  16 +
 arch/arm/boot/dts/imx6sx.dtsi                      |   8 +-
 arch/arm/boot/dts/imx6ul-14x14-evk.dts             |  74 ++
 arch/arm/boot/dts/imx6ul-pico-hobbit.dts           | 516 +++++++++++
 arch/arm/boot/dts/imx6ul-tx6ul-0010.dts            |  53 ++
 arch/arm/boot/dts/imx6ul-tx6ul-0011.dts            |  68 ++
 arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dts       | 271 ++++++
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi                | 973 +++++++++++++++++++++
 arch/arm/boot/dts/imx6ul.dtsi                      |  12 +-
 .../{k2e-clocks.dtsi => keystone-k2e-clocks.dtsi}  |   0
 .../boot/dts/{k2e-evm.dts => keystone-k2e-evm.dts} |   2 +-
 .../{k2e-netcp.dtsi => keystone-k2e-netcp.dtsi}    |   0
 arch/arm/boot/dts/{k2e.dtsi => keystone-k2e.dtsi}  |   4 +-
 ...{k2hk-clocks.dtsi => keystone-k2hk-clocks.dtsi} |   0
 .../dts/{k2hk-evm.dts => keystone-k2hk-evm.dts}    |   2 +-
 .../{k2hk-netcp.dtsi => keystone-k2hk-netcp.dtsi}  |   0
 .../arm/boot/dts/{k2hk.dtsi => keystone-k2hk.dtsi} |   4 +-
 .../{k2l-clocks.dtsi => keystone-k2l-clocks.dtsi}  |   0
 .../boot/dts/{k2l-evm.dts => keystone-k2l-evm.dts} |   2 +-
 .../{k2l-netcp.dtsi => keystone-k2l-netcp.dtsi}    |   0
 arch/arm/boot/dts/{k2l.dtsi => keystone-k2l.dtsi}  |   4 +-
 arch/arm/boot/dts/keystone.dtsi                    |  11 +
 arch/arm/boot/dts/kirkwood-6192.dtsi               |   4 +-
 arch/arm/boot/dts/kirkwood-6281.dtsi               |   4 +-
 arch/arm/boot/dts/kirkwood-6282.dtsi               |   4 +-
 arch/arm/boot/dts/kirkwood-98dx4122.dtsi           |   4 +-
 arch/arm/boot/dts/kirkwood-b3.dts                  |  19 +-
 arch/arm/boot/dts/kirkwood-blackarmor-nas220.dts   |   4 +-
 arch/arm/boot/dts/kirkwood-cloudbox.dts            |   2 +-
 arch/arm/boot/dts/kirkwood-db-88f6281.dts          |  14 +-
 arch/arm/boot/dts/kirkwood-db-88f6282.dts          |  20 +-
 arch/arm/boot/dts/kirkwood-dir665.dts              |  20 +-
 arch/arm/boot/dts/kirkwood-dnskw.dtsi              |   6 +-
 arch/arm/boot/dts/kirkwood-ds111.dts               |   2 +-
 arch/arm/boot/dts/kirkwood-ds112.dts               |   6 +-
 arch/arm/boot/dts/kirkwood-ds212.dts               |   2 +-
 arch/arm/boot/dts/kirkwood-ds411.dts               |   6 +-
 arch/arm/boot/dts/kirkwood-ds411slim.dts           |   2 +-
 arch/arm/boot/dts/kirkwood-ib62x0.dts              |   4 +-
 arch/arm/boot/dts/kirkwood-iconnect.dts            |  22 +-
 arch/arm/boot/dts/kirkwood-km_common.dtsi          |  20 +-
 arch/arm/boot/dts/kirkwood-laplug.dts              |  19 +-
 arch/arm/boot/dts/kirkwood-linkstation.dtsi        |  17 +-
 arch/arm/boot/dts/kirkwood-linksys-viper.dts       | 240 +++++
 arch/arm/boot/dts/kirkwood-lsxl.dtsi               |  16 +-
 arch/arm/boot/dts/kirkwood-mplcec4.dts             |  18 +-
 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts     |  24 +-
 arch/arm/boot/dts/kirkwood-nas2big.dts             |  18 +-
 .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  |  20 +-
 .../boot/dts/kirkwood-netgear_readynas_nv+_v2.dts  |  23 +-
 arch/arm/boot/dts/kirkwood-netxbig.dtsi            |   8 +-
 arch/arm/boot/dts/kirkwood-ns2-common.dtsi         |   4 +-
 arch/arm/boot/dts/kirkwood-nsa310.dts              |  18 +-
 arch/arm/boot/dts/kirkwood-nsa320.dts              |  31 +-
 arch/arm/boot/dts/kirkwood-nsa325.dts              |  17 +-
 arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi      |  24 +-
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts       |   2 +-
 arch/arm/boot/dts/kirkwood-openblocks_a7.dts       |   2 +-
 arch/arm/boot/dts/kirkwood-openrd.dtsi             |  14 +-
 arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts   |   2 +-
 arch/arm/boot/dts/kirkwood-rd88f6192.dts           |  20 +-
 arch/arm/boot/dts/kirkwood-rd88f6281-a.dts         |   2 +-
 arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts        |   2 +-
 arch/arm/boot/dts/kirkwood-rd88f6281.dtsi          |  20 +-
 arch/arm/boot/dts/kirkwood-rs212.dts               |   6 +-
 arch/arm/boot/dts/kirkwood-synology.dtsi           |  22 +-
 arch/arm/boot/dts/kirkwood-t5325.dts               |  22 +-
 arch/arm/boot/dts/kirkwood-ts219-6281.dts          |   4 +-
 arch/arm/boot/dts/kirkwood-ts219-6282.dts          |  16 +-
 arch/arm/boot/dts/kirkwood-ts219.dtsi              |  20 +-
 arch/arm/boot/dts/kirkwood-ts419-6282.dts          |  15 +-
 arch/arm/boot/dts/kirkwood-ts419.dtsi              |   4 +-
 arch/arm/boot/dts/kirkwood.dtsi                    |   2 +-
 arch/arm/boot/dts/lpc18xx.dtsi                     |  47 +-
 .../boot/dts/{ea3250.dts => lpc3250-ea3250.dts}    | 230 +++--
 arch/arm/boot/dts/lpc3250-phy3250.dts              | 226 +++++
 arch/arm/boot/dts/lpc32xx.dtsi                     |  77 +-
 arch/arm/boot/dts/lpc4350-hitex-eval.dts           |  41 +-
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts        |  29 +-
 arch/arm/boot/dts/ls1021a.dtsi                     |  65 +-
 .../dts/{rk3288-thermal.dtsi => mps2-an385.dts}    |  96 +-
 arch/arm/boot/dts/mps2-an399.dts                   |  92 ++
 arch/arm/boot/dts/mps2.dtsi                        | 241 +++++
 arch/arm/boot/dts/mt2701.dtsi                      |  19 +
 arch/arm/boot/dts/omap2420-clocks.dtsi             |  38 +-
 arch/arm/boot/dts/omap2420-n8x0-common.dtsi        |   2 +-
 arch/arm/boot/dts/omap2420.dtsi                    |   4 +
 arch/arm/boot/dts/omap2430-clocks.dtsi             |  58 +-
 arch/arm/boot/dts/omap2430.dtsi                    |   6 +-
 arch/arm/boot/dts/omap24xx-clocks.dtsi             | 228 ++---
 arch/arm/boot/dts/omap3-beagle.dts                 |   1 +
 arch/arm/boot/dts/omap3-n9.dts                     |  14 +
 arch/arm/boot/dts/omap3-n950-n9.dtsi               | 151 ++++
 arch/arm/boot/dts/omap3-n950.dts                   |  99 +++
 arch/arm/boot/dts/omap3.dtsi                       |   6 +-
 arch/arm/boot/dts/omap3430es1-clocks.dtsi          |  30 +-
 arch/arm/boot/dts/omap34xx-omap36xx-clocks.dtsi    |  44 +-
 arch/arm/boot/dts/omap34xx.dtsi                    |   2 +-
 .../omap36xx-am35xx-omap3430es2plus-clocks.dtsi    |  32 +-
 arch/arm/boot/dts/omap36xx-clocks.dtsi             |  14 +-
 .../boot/dts/omap36xx-omap3430es2plus-clocks.dtsi  |  14 +-
 arch/arm/boot/dts/omap36xx.dtsi                    |   4 +-
 arch/arm/boot/dts/omap3xxx-clocks.dtsi             | 276 +++---
 arch/arm/boot/dts/omap4-kc1.dts                    | 182 ++++
 arch/arm/boot/dts/omap4-var-som-om44.dtsi          |   2 +-
 arch/arm/boot/dts/omap4.dtsi                       |   6 +-
 arch/arm/boot/dts/omap443x-clocks.dtsi             |   2 +-
 arch/arm/boot/dts/omap443x.dtsi                    |   2 +-
 arch/arm/boot/dts/omap4460.dtsi                    |   2 +-
 arch/arm/boot/dts/omap446x-clocks.dtsi             |   4 +-
 arch/arm/boot/dts/omap44xx-clocks.dtsi             | 316 +++----
 arch/arm/boot/dts/omap5-board-common.dtsi          |  12 +-
 arch/arm/boot/dts/omap5-cm-t54.dts                 |   2 +-
 arch/arm/boot/dts/omap5.dtsi                       |   6 +-
 arch/arm/boot/dts/omap54xx-clocks.dtsi             | 260 +++---
 arch/arm/boot/dts/orion5x-kuroboxpro.dts           | 127 +++
 arch/arm/boot/dts/ox810se.dtsi                     | 336 +++++++
 arch/arm/boot/dts/phy3250.dts                      | 227 -----
 .../boot/dts/qcom-apq8064-arrow-db600c-pins.dtsi   |  52 ++
 arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts    | 349 ++++++++
 arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts |   6 +
 arch/arm/boot/dts/qcom-apq8064-pins.dtsi           |  39 +
 arch/arm/boot/dts/qcom-apq8064.dtsi                | 135 ++-
 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c1.dts    |  22 +
 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi      | 112 +++
 arch/arm/boot/dts/qcom-ipq4019.dtsi                | 267 ++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi                |  52 +-
 arch/arm/boot/dts/r7s72100.dtsi                    |  15 +-
 arch/arm/boot/dts/r8a73a4-ape6evm.dts              |  20 +-
 arch/arm/boot/dts/r8a73a4.dtsi                     |  75 +-
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts      |  34 +-
 arch/arm/boot/dts/r8a7740.dtsi                     |  57 +-
 arch/arm/boot/dts/r8a7778-bockw.dts                |  40 +-
 arch/arm/boot/dts/r8a7778.dtsi                     |  22 +-
 arch/arm/boot/dts/r8a7779-marzen.dts               |  36 +-
 arch/arm/boot/dts/r8a7779.dtsi                     |  18 +-
 arch/arm/boot/dts/r8a7790-lager.dts                | 117 +--
 arch/arm/boot/dts/r8a7790.dtsi                     | 125 ++-
 arch/arm/boot/dts/r8a7791-koelsch.dts              |  72 +-
 arch/arm/boot/dts/r8a7791-porter.dts               |  73 +-
 arch/arm/boot/dts/r8a7791.dtsi                     |  92 +-
 arch/arm/boot/dts/r8a7793-gose.dts                 | 162 +++-
 arch/arm/boot/dts/r8a7793.dtsi                     | 127 ++-
 arch/arm/boot/dts/r8a7794-alt.dts                  |  32 +-
 arch/arm/boot/dts/r8a7794-silk.dts                 |  44 +-
 arch/arm/boot/dts/r8a7794.dtsi                     | 158 ++--
 arch/arm/boot/dts/rk3036-evb.dts                   |   5 +
 arch/arm/boot/dts/rk3036-kylin.dts                 |  18 +-
 arch/arm/boot/dts/rk3036.dtsi                      |  71 +-
 arch/arm/boot/dts/rk3066a-bqcurie2.dts             |  11 +-
 arch/arm/boot/dts/rk3066a-rayeager.dts             |   9 +-
 arch/arm/boot/dts/rk3066a.dtsi                     |   6 +-
 arch/arm/boot/dts/rk3188-radxarock.dts             |   7 +-
 arch/arm/boot/dts/rk3188.dtsi                      |   6 +-
 arch/arm/boot/dts/rk3228-evb.dts                   |   8 +-
 arch/arm/boot/dts/rk3228.dtsi                      | 149 ++++
 arch/arm/boot/dts/rk3288-evb.dtsi                  |   8 +-
 arch/arm/boot/dts/rk3288-firefly.dtsi              |   9 +-
 arch/arm/boot/dts/rk3288-miqi.dts                  | 472 ++++++++++
 arch/arm/boot/dts/rk3288-popmetal.dts              |   9 +-
 arch/arm/boot/dts/rk3288-r89.dts                   |   7 +-
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi    | 100 +++
 arch/arm/boot/dts/rk3288-veyron-jaq.dts            |  49 +-
 arch/arm/boot/dts/rk3288-veyron-jerry.dts          |   9 +
 arch/arm/boot/dts/rk3288-veyron-minnie.dts         |  44 +
 arch/arm/boot/dts/rk3288-veyron-pinky.dts          |   7 +
 arch/arm/boot/dts/rk3288-veyron-speedy.dts         |  16 +
 arch/arm/boot/dts/rk3288-veyron.dtsi               |  18 +-
 arch/arm/boot/dts/rk3288.dtsi                      | 158 +++-
 arch/arm/boot/dts/s5pv210-smdkv210.dts             |   2 +-
 arch/arm/boot/dts/sama5d2-pinfunc.h                |   4 +-
 arch/arm/boot/dts/sama5d2.dtsi                     |  53 ++
 arch/arm/boot/dts/sama5d3.dtsi                     |   7 +
 arch/arm/boot/dts/sama5d4.dtsi                     |   8 +
 arch/arm/boot/dts/sh73a0-kzm9g.dts                 |  37 +-
 arch/arm/boot/dts/sh73a0.dtsi                      |  89 +-
 arch/arm/boot/dts/socfpga.dtsi                     |   4 +
 arch/arm/boot/dts/socfpga_arria10.dtsi             |  32 +-
 arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts  |   1 +
 arch/arm/boot/dts/socfpga_cyclone5.dtsi            |   6 -
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts      |  94 +-
 arch/arm/boot/dts/socfpga_cyclone5_socrates.dts    |   1 +
 arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts | 310 +++++++
 arch/arm/boot/dts/ste-ccu9540.dts                  |   2 +-
 arch/arm/boot/dts/ste-dbx5x0.dtsi                  |  92 +-
 arch/arm/boot/dts/ste-href-stuib.dtsi              |   4 +-
 arch/arm/boot/dts/ste-href-tvk1281618.dtsi         |  16 +-
 arch/arm/boot/dts/ste-hrefprev60.dtsi              |   8 +-
 arch/arm/boot/dts/ste-hrefv60plus.dtsi             |   6 +-
 arch/arm/boot/dts/ste-nomadik-nhk15.dts            |  13 +-
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi         |  38 +
 arch/arm/boot/dts/ste-snowball.dts                 |  19 +-
 arch/arm/boot/dts/stih407-family.dtsi              | 126 ++-
 arch/arm/boot/dts/sun4i-a10-a1000.dts              |  24 +
 arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts   | 281 ++++++
 arch/arm/boot/dts/sun4i-a10.dtsi                   |  76 +-
 arch/arm/boot/dts/sun5i-a13-difrnce-dit4350.dts    | 226 +++++
 .../boot/dts/sun5i-a13-empire-electronix-d709.dts  |  19 +-
 arch/arm/boot/dts/sun5i-a13-inet-98v-rev2.dts      |  15 -
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts    |  41 +
 arch/arm/boot/dts/sun5i-a13.dtsi                   |  66 +-
 arch/arm/boot/dts/sun5i-r8-chip.dts                |  12 +
 arch/arm/boot/dts/sun5i-r8.dtsi                    | 142 ++-
 arch/arm/boot/dts/sun5i.dtsi                       |  43 +
 arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts  | 208 +++++
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         |  24 +
 arch/arm/boot/dts/sun7i-a20-itead-ibox.dts         |  24 +
 .../boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts    |  82 ++
 arch/arm/boot/dts/sun7i-a20.dtsi                   |  77 +-
 arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts           | 120 ++-
 .../boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts   | 243 +++++
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts          | 186 ++++
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts        | 145 +++
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         | 167 ++++
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts       | 105 +--
 arch/arm/boot/dts/sun8i-h3.dtsi                    | 123 +++
 arch/arm/boot/dts/tango4-common.dtsi               |  16 +-
 arch/arm/boot/dts/tango4-smp8758.dtsi              |  28 +-
 arch/arm/boot/dts/tango4-vantage-1172.dts          |   1 -
 arch/arm/boot/dts/tegra114-dalmore.dts             |   6 +-
 arch/arm/boot/dts/tegra114-roth.dts                |   2 +-
 arch/arm/boot/dts/tegra114-tn7.dts                 |   2 +-
 arch/arm/boot/dts/tegra114.dtsi                    |   4 +-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts          |  32 +-
 arch/arm/boot/dts/tegra124-nyan.dtsi               |   8 +-
 arch/arm/boot/dts/tegra124-venice2.dts             |   6 +-
 arch/arm/boot/dts/tegra124.dtsi                    |   4 +-
 arch/arm/boot/dts/tegra20-harmony.dts              |   6 +-
 arch/arm/boot/dts/tegra20-iris-512.dts             |   4 +
 arch/arm/boot/dts/tegra20-medcom-wide.dts          |   4 +
 arch/arm/boot/dts/tegra20-paz00.dts                |   6 +-
 arch/arm/boot/dts/tegra20-seaboard.dts             |   8 +-
 arch/arm/boot/dts/tegra20-tamonten.dtsi            |   4 +
 arch/arm/boot/dts/tegra20-trimslice.dts            |   6 +-
 arch/arm/boot/dts/tegra20-ventana.dts              |   6 +-
 arch/arm/boot/dts/tegra20-whistler.dts             |   6 +-
 arch/arm/boot/dts/tegra20.dtsi                     |   4 +-
 arch/arm/boot/dts/tegra30-apalis-eval.dts          |   6 +-
 arch/arm/boot/dts/tegra30-beaver.dts               |   4 +
 arch/arm/boot/dts/tegra30-cardhu.dtsi              |   6 +-
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts      |   6 +-
 arch/arm/boot/dts/tegra30.dtsi                     |   4 +-
 arch/arm/boot/dts/twl6030.dtsi                     |   6 +
 arch/arm/boot/dts/uniphier-pinctrl.dtsi            |  10 +
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi            |  44 +-
 arch/arm/boot/dts/vexpress-v2m.dtsi                |  44 +-
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts        |  47 +-
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         |  57 +-
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts            |  37 +-
 arch/arm/boot/dts/vexpress-v2p-ca9.dts             |  41 +-
 arch/arm/boot/dts/vf-colibri.dtsi                  |   7 +-
 arch/arm/boot/dts/vf500-colibri.dtsi               |   5 +
 arch/arm/boot/dts/vf500.dtsi                       |   1 +
 arch/arm/boot/dts/vf610-colibri.dtsi               |   5 +
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts          | 734 ++++++++++++++++
 arch/arm/boot/dts/vfxxx.dtsi                       |   2 +
 arch/arm/boot/dts/wd-mbwe.dts                      | 112 +++
 arch/arm/mach-davinci/da8xx-dt.c                   |   2 +
 arch/arm/mach-shmobile/timer.c                     |  28 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  42 +-
 drivers/clk/samsung/clk-exynos3250.c               |  15 +
 drivers/clk/ti/clk-7xx.c                           |   2 +-
 drivers/gpu/drm/vc4/vc4_drv.c                      |  20 +
 drivers/soc/tegra/Kconfig                          |   2 -
 include/dt-bindings/clock/exynos3250.h             |  11 +-
 include/dt-bindings/clock/r8a7790-clock.h          |   1 +
 include/dt-bindings/clock/r8a7794-clock.h          |   5 +
 include/dt-bindings/power/r8a7779-sysc.h           |  27 +
 include/dt-bindings/power/r8a7790-sysc.h           |  34 +
 include/dt-bindings/power/r8a7791-sysc.h           |  26 +
 include/dt-bindings/power/r8a7793-sysc.h           |  28 +
 include/dt-bindings/power/r8a7794-sysc.h           |  26 +
 include/dt-bindings/power/r8a7795-sysc.h           |  42 +
 include/soc/at91/atmel-sfr.h                       |  18 +
 450 files changed, 23340 insertions(+), 5216 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/oxnas.txt
 create mode 100644 Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/auxadc.txt
 create mode 100644 Documentation/devicetree/bindings/soc/rockchip/grf.txt
 create mode 100644 arch/arm/boot/dts/am335x-baltos-ir2110.dts
 create mode 100644 arch/arm/boot/dts/am335x-baltos-ir3220.dts
 create mode 100644 arch/arm/boot/dts/am335x-baltos.dtsi
 create mode 100644 arch/arm/boot/dts/am335x-icev2.dts
 create mode 100644 arch/arm/boot/dts/am572x-idk.dts
 create mode 100644 arch/arm/boot/dts/am57xx-commercial-grade.dtsi
 create mode 100644 arch/arm/boot/dts/am57xx-idk-common.dtsi
 create mode 100644 arch/arm/boot/dts/am57xx-industrial-grade.dtsi
 create mode 100644 arch/arm/boot/dts/arm-realview-eb-11mp-revb.dts
 create mode 100644 arch/arm/boot/dts/arm-realview-eb-11mp.dts
 create mode 100644 arch/arm/boot/dts/arm-realview-eb-a9mp.dts
 create mode 100644 arch/arm/boot/dts/arm-realview-eb-mp.dtsi
 create mode 100644 arch/arm/boot/dts/arm-realview-eb.dts
 create mode 100644 arch/arm/boot/dts/arm-realview-eb.dtsi
 create mode 100644 arch/arm/boot/dts/arm-realview-pba8.dts
 create mode 100644 arch/arm/boot/dts/arm-realview-pbx-a9.dts
 create mode 100644 arch/arm/boot/dts/arm-realview-pbx.dtsi
 create mode 100644 arch/arm/boot/dts/aspeed-ast2500-evb.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
 create mode 100644 arch/arm/boot/dts/aspeed-g4.dtsi
 create mode 100644 arch/arm/boot/dts/aspeed-g5.dtsi
 create mode 100644 arch/arm/boot/dts/dra72-evm-common.dtsi
 create mode 100644 arch/arm/boot/dts/dra72-evm-revc.dts
 create mode 100644 arch/arm/boot/dts/exynos3250-artik5-eval.dts
 create mode 100644 arch/arm/boot/dts/exynos3250-artik5.dtsi
 create mode 100644 arch/arm/boot/dts/imx6dl-tx6s-8034.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-tx6s-8035.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-tx6u-8033.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dts
 create mode 100644 arch/arm/boot/dts/imx6q-marsboard.dts
 create mode 100644 arch/arm/boot/dts/imx6q-tx6q-1036.dts
 create mode 100644 arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dts
 create mode 100644 arch/arm/boot/dts/imx6qp-nitrogen6_max.dts
 create mode 100644 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
 create mode 100644 arch/arm/boot/dts/imx6sx-sdb-sai.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-pico-hobbit.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-tx6ul-0010.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-tx6ul-0011.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-tx6ul.dtsi
 rename arch/arm/boot/dts/{k2e-clocks.dtsi => keystone-k2e-clocks.dtsi} (100%)
 rename arch/arm/boot/dts/{k2e-evm.dts => keystone-k2e-evm.dts} (98%)
 rename arch/arm/boot/dts/{k2e-netcp.dtsi => keystone-k2e-netcp.dtsi} (100%)
 rename arch/arm/boot/dts/{k2e.dtsi => keystone-k2e.dtsi} (97%)
 rename arch/arm/boot/dts/{k2hk-clocks.dtsi => keystone-k2hk-clocks.dtsi} (100%)
 rename arch/arm/boot/dts/{k2hk-evm.dts => keystone-k2hk-evm.dts} (99%)
 rename arch/arm/boot/dts/{k2hk-netcp.dtsi => keystone-k2hk-netcp.dtsi} (100%)
 rename arch/arm/boot/dts/{k2hk.dtsi => keystone-k2hk.dtsi} (96%)
 rename arch/arm/boot/dts/{k2l-clocks.dtsi => keystone-k2l-clocks.dtsi} (100%)
 rename arch/arm/boot/dts/{k2l-evm.dts => keystone-k2l-evm.dts} (98%)
 rename arch/arm/boot/dts/{k2l-netcp.dtsi => keystone-k2l-netcp.dtsi} (100%)
 rename arch/arm/boot/dts/{k2l.dtsi => keystone-k2l.dtsi} (96%)
 create mode 100644 arch/arm/boot/dts/kirkwood-linksys-viper.dts
 rename arch/arm/boot/dts/{ea3250.dts => lpc3250-ea3250.dts} (61%)
 create mode 100644 arch/arm/boot/dts/lpc3250-phy3250.dts
 rename arch/arm/boot/dts/{rk3288-thermal.dtsi => mps2-an385.dts} (54%)
 create mode 100644 arch/arm/boot/dts/mps2-an399.dts
 create mode 100644 arch/arm/boot/dts/mps2.dtsi
 create mode 100644 arch/arm/boot/dts/omap4-kc1.dts
 create mode 100644 arch/arm/boot/dts/orion5x-kuroboxpro.dts
 create mode 100644 arch/arm/boot/dts/ox810se.dtsi
 delete mode 100644 arch/arm/boot/dts/phy3250.dts
 create mode 100644 arch/arm/boot/dts/qcom-apq8064-arrow-db600c-pins.dtsi
 create mode 100644 arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c1.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019.dtsi
 create mode 100644 arch/arm/boot/dts/rk3288-miqi.dts
 create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
 create mode 100644 arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
 create mode 100644 arch/arm/boot/dts/sun5i-a13-difrnce-dit4350.dts
 create mode 100644 arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts
 create mode 100644 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
 create mode 100644 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
 create mode 100644 arch/arm/boot/dts/wd-mbwe.dts
 create mode 100644 include/dt-bindings/power/r8a7779-sysc.h
 create mode 100644 include/dt-bindings/power/r8a7790-sysc.h
 create mode 100644 include/dt-bindings/power/r8a7791-sysc.h
 create mode 100644 include/dt-bindings/power/r8a7793-sysc.h
 create mode 100644 include/dt-bindings/power/r8a7794-sysc.h
 create mode 100644 include/dt-bindings/power/r8a7795-sysc.h
 create mode 100644 include/soc/at91/atmel-sfr.h
