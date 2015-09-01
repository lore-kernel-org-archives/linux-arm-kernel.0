From: olof@lixom.net (Olof Johansson)
Date: Mon, 31 Aug 2015 17:07:08 -0700
Subject: [GIT PULL 5/7] ARM: DT updates for v4.3
In-Reply-To: <1441066030-23225-1-git-send-email-olof@lixom.net>
References: <1441066030-23225-1-git-send-email-olof@lixom.net>
Message-ID: <1441066030-23225-6-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ladies and gentlemen, we proudly announce to you the latest branch of ARM
device tree contents for the mainline kernel. Come and see, come and see!

No less than twentythree thousand lines of additions! Just imagine the
joy you will have of using your mainline kernel on newly supported
hardware such as Rockchip Chromebooks, Freescale i.MX6UL boards or
UniPhier hardware!

For those of you feeling less adventurous, added hardware support on
platforms such as TI DM814x and Gumstix Overo platforms might be more
of your liking.

We've got something for everyone here!

Ahem. Cough. So, anyway...

This is the usual large batch of DT updates. Lots and lots of smaller
changes, some of the larger ones to point out are:

- Rockchip veyron (Chromebook) support, as well as several other new boards
- DRM support on Atmel AT91SAM9N12EK
- USB additions on some Allwinner platforms
- Freescale i.MX6UL support
- Cleanups for Renesas shmobile platforms
- Lots of added devices on LPC18xx
- Lots of added devices and boards on UniPhier

There's also some dependent code added here, in particular some branches
that are primarily merged through the clock tree.


Conflicts:

arch/arm/boot/dts/imx6qdl-gw5*xx.dtsi:

Change/add conflict with DT fix merged through MMC tree.
Keep the GPIO piece from HEAD, pinctrl pieces from branch.

----------------------------------------------------------------

The following changes since commit df782b553c2914d98f86b1a54eb51fcb7c208a4d:

  Merge branch 'next/drivers' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt

for you to fetch changes up to 4c80a00388dd7b9d9e7ebf31e62b96c7b74178b8:

  Merge tag 'v4.3-rockchip32-dts3' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into next/dt

----------------------------------------------------------------

Adam YH Lee (2):
      ARM: dts: overo: Enable McBSP2 for all Overo COMs
      ARM: dts: overo: Add device tree for Palo35 board

Alex Wilson (1):
      ARM: zynq: DT: Add missing interrupt for L2 pl310

Alexandre Belloni (17):
      ARM: at91/dt: sama5d4: fix external trigger property
      ARM: at91/dt: sama5d4: move ADC pinctrl to board device trees
      Documentation: dt: atmel-at91: add clocks to system timer, rstc and shdwc
      Documentation: watchdog: at91sam9_wdt: add clocks property
      Documentation: dt: rtc: at91rm9200: add clocks property
      ARM: at91/dt: at91rm9200: use slow clock where necessary
      ARM: at91/dt: at91sam9260: use slow clock where necessary
      ARM: at91/dt: at91sam9261: use slow clock where necessary
      ARM: at91/dt: at91sam9263: use slow clock where necessary
      ARM: at91/dt: at91sam9g45: use slow clock where necessary
      ARM: at91/dt: at91sam9n12: use slow clock where necessary
      ARM: at91/dt: at91sam9rl: use slow clock where necessary
      ARM: at91/dt: at91sam9x5: use slow clock where necessary
      ARM: at91/dt: sama5d3: use slow clock where necessary
      ARM: at91/dt: sama5d4: use slow clock where necessary
      ARM: at91/dt: at91sam9x5dm: add support for the touschscreen
      ARM: at91/dt: sama5d2: use slow clock where necessary

Alexandre Courbot (2):
      ARM: tegra: Add IOMMU node to GK20A
      ARM: tegra: jetson-tk1: Add GK20A GPU DT node

Alexandru M Stan (3):
      ARM: dts: rockchip: add shared rk3288-veyron files
      ARM: dts: rockchip: add veyron-jerry board
      ARM: dts: rockchip: add veyron-minnie board

Alison Wang (1):
      ARM: dts: ls1021a: Add dts nodes for audio on LS1021A

Anand Moon (5):
      ARM: dts: Enable USB3 regulators for exynos5422-odroidxu3
      ARM: dts: Add pwm-fan node for exynos5422-odroidxu3
      ARM: dts: Enable TMU for exynos5422-odroidxu3
      ARM: dts: Define default thermal-zones for exynos5422
      ARM: dts: Enable thermal-zones for exynos5422-odroidxu3

Andreas Faerber (1):
      ARM: dts: Clean up indentation for exynos5410-smdk5410

Andy Sun (1):
      ARM: dts: atlas7: add a GPIO key for rearview button

Anson Huang (4):
      ARM: dts: imx6sx: correct property name for wakeup source
      ARM: dts: imx6ul: enable GPC as extended interrupt controller
      ARM: dts: imx6ul: add RTC support
      ARM: dts: imx6ul: add snvs power key support

Anthoine Bourgeois (7):
      ARM: dts: omap3-devkit8000: Add user button support
      ARM: dts: omap3-devkit8000: Add PMU stat support
      ARM: dts: omap3-devkit8000: Add keymap support
      ARM: dts: omap3-devkit8000: Add S-video output support
      ARM: dts: omap3-devkit8000: Add DSS' DVI support
      ARM: dts: omap3-devkit8000: add LCD panels
      ARM: dts: omap3-devkit8000: Add ADS7846 Touchscreen support

Aparna Balasubramanian (1):
      ARM: dts: omap5-uevm: Add Palmas power button support

Ariel D'Alessandro (2):
      ARM: dts: lpc4350-hitex-eval: add pinctrl and uart0 muxing
      ARM: dts: lpc4350-hitex-eval: add ethernet

Ash Charles (2):
      ARM: dts: Add DTS for Gumstix TobiDuo expansion board
      ARM: dts: overo: Support PoP NAND

Balaji T K (1):
      ARM: dts: dra7-evm: add evm_3v3_sd regulator

Baruch Siach (2):
      ARM: digicolor: enable watchdog device
      ARM: digicolor: dts: use stdout-path for console configuration

Benjamin Cama (1):
      ARM: dts: Convert Linkstation Mini to Device Tree

Bjorn Andersson (3):
      ARM: dts: qcom: Replace gpio node with pinctrl node
      ARM: dts: msm8974: Add tcsr mutex node
      ARM: dts: msm8974: Add smem reservation and node

Bo Shen (1):
      ARM: at91/dt: add drm support for at91sam9n12ek

Boris Brezillon (5):
      Documentation: dt: atmel-at91: add slow clock to tcb
      ARM: at91/dt: define hlcdc node in at91sam9x5_lcd.dtsi
      ARM: at91/dt: include lcd dtsi in at91sam9x5 dtsis
      ARM: at91/dt: add at91sam9x5-ek Display Module dtsi
      ARM: at91/dt: enable lcd support for at91sam9x5 SoCs

Brian Norris (2):
      ARM: dts: rockchip: correct regulator PM properties
      ARM: dts: rockchip: correct regulator power states for suspend

Chen-Yu Tsai (4):
      ARM: dts: sun8i: Add support for USB controllers on A23/A33
      ARM: dts: sun8i: sina33: Enable USB hosts
      ARM: dts: sun5i: hsg-h702: Enable side volume buttons with LRADC
      ARM: dts: sun5i: hsg-h702: Enable USB OTG controller

Chris Zhong (1):
      ARM: dts: Add sbs-battery dts fragment used by chromebooks

Claudiu Manoil (2):
      ARM: dts: ls1021a: Add the eTSEC controller nodes
      ARM: dts: ls1021a: Enable the eTSEC ports on QDS and TWR

Cory Tusar (4):
      ARM: dts: vf610: Extend I2C support to all available buses.
      ARM: dts: vf610: Add missing QuadSPI register mapping and names.
      ARM: dts: vfxxx: Include support for qspi1 functionality.
      ARM: dts: vfxxx: Include support for esdhc0 functionality.

Dalon Westergreen (1):
      ARM: dts: socfpga: Add support of Terasic DE0 Atlas board

Daniel Thompson (1):
      ARM: dts: stm32f429: Adopt STM32F4 clock driver

Dave Gerlach (3):
      ARM: OMAP2+: Use pdata-quirks for wkup_m3 reset management
      ARM: dts: am43xx: Introduce MUX_MODE9 for pinctrl
      ARM: dts: am437x-gp-evm: Add regulator-always-on and regulator-boot-on for RTC DCDCs

Dinh Nguyen (8):
      ARM: dts: socfpga: enable the data and instruction prefetch for the l2 cache
      ARM: dts: socfpga: use stdout-path for chosen node
      ARM: socfpga: dts: Correct the parent clock for l3_sp_clk and dbg_clk
      ARM: socfpga: dts: Fix gpio dts entry for the correct clock
      ARM: socfpga: dts: add osc1 as a possible parent for dbg_base_clk
      dt-bindings: Add reset manager offsets for Arria10
      ARM: socfpga: dts: add "altr,modrst-offset" property
      ARM: socfpga: dts: Add resets for EMACs on Arria10

Dongli Li (1):
      ARM: dts: atlas7: add lost G2D node

Eric Anholt (2):
      ARM: bcm2835: Add the firmware driver information to the RPi DT
      dt/bindings: Add binding for the Raspberry Pi firmware driver

Ezequiel Garcia (2):
      of: add vendor prefix for CIAA project
      ARM: dts: add DT for CIAA LPC4337 industrial computer

Ezra Savard (1):
      ARM: zynq: DT: Add zc702 pushbuttons to DT as gpio-keys

Fabien Dessenne (1):
      ARM: DT: STiH410: Add bdisp dt nodes

Fabio Estevam (8):
      clk: imx: clk-imx6q: Provide initial IPU clock settings for mx6dl
      ARM: dts: imx6sl-warp: Add the SD2_RESET pin
      ARM: dts: imx6qdl-sabreauto: Add HDMI support
      ARM: dts: imx6qdl-sabresd: Allow HDMI and LVDS to work simultaneously
      ARM: dts: imx6sl-warp: Add changes for rev1.12
      ARM: dts: imx6qdl-sabrelite: Allow HDMI and LVDS to work simultaneously
      ARM: dts: imx6qdl-nitrogen6x: Allow HDMI and LVDS to work simultaneously
      ARM: dts: imx6qdl-sabreauto: Allow HDMI and LVDS to work simultaneously

Felipe Balbi (2):
      ARM: dts: am4372: Add named interrupt property for dwc3
      arm: boot: dts: am4372: add ARM timers and SCU nodes

Felix Fietkau (1):
      ARM: BCM5301X: Add profiling support

Frank Li (12):
      clk: imx: add imx6ul clk tree support
      ARM: dts: imx7d: add watch dog support
      ARM: dts: imx6sx: enable snvs power key
      ARM: dts: imx7d: add cortex-a7 coresight component
      Document: dt: binding: imx: update document for imx6ul support
      ARM: dts: add i.mx6ul pin function include file
      ARM: dts: imx: add imx6ul and imx6ul evk board support
      ARM: dts: imx: update snvs to use syscon access register
      ARM: dts: imx6ul: add usb host and function support
      ARM: dts: imx6ul: fix low case define in imx6ul-pinfunc.h
      ARM: dts: imx6ul: add qspi support
      ARM: dts: imx7d: enable snvs rtc, onoffkey and power off

Fugang Duan (3):
      ARM: dts: omap3: correct the format of u16 values for tsc2046 node
      ARM: dts: imx: add fec1 and fec2 nodes for SOC i.MX6UL
      ARM: dts: imx6ul-14x14-evk: add fec1 and fec2 support

Gabriel Fernandez (1):
      ARM: STi: DT: Rename st_pll3200c32_407_c0_x into st_pll3200c32_cx_x

Geert Uytterhoeven (16):
      ARM: shmobile: armadillo800eva dts: Add pinctrl and gpio-hog for lcdc0
      ARM: shmobile: r8a73a4 dtsi: Use "arm,gic-400" for GIC
      ARM: shmobile: r8a7790 dtsi: Use "arm,gic-400" for GIC
      ARM: shmobile: r8a7791 dtsi: Use "arm,gic-400" for GIC
      ARM: shmobile: r8a7793 dtsi: Use "arm,gic-400" for GIC
      ARM: shmobile: r8a7794 dtsi: Use "arm,gic-400" for GIC
      ARM: shmobile: r8a73a4 dtsi: Add missing "gpio-ranges" to gpio node
      ARM: shmobile: r8a7740 dtsi: Add missing "gpio-ranges" to gpio node
      ARM: shmobile: sh73a0 dtsi: Add missing "gpio-ranges" to gpio node
      ARM: shmobile: r7s72100 dtsi: Add CPG/MSTP Clock Domain
      ARM: shmobile: r8a7778 dtsi: Add CPG/MSTP Clock Domain
      ARM: shmobile: r8a7779 dtsi: Add CPG/MSTP Clock Domain
      ARM: shmobile: r8a7790 dtsi: Add CPG/MSTP Clock Domain
      ARM: shmobile: r8a7791 dtsi: Add CPG/MSTP Clock Domain
      ARM: shmobile: r8a7793 dtsi: Add CPG/MSTP Clock Domain
      ARM: shmobile: r8a7794 dtsi: Add CPG/MSTP Clock Domain

Grazvydas Ignotas (4):
      ARM: dts: omap3-pandora: miscellaneous corrections
      ARM: dts: omap3-pandora: add support for usb host and 32k buffer
      ARM: OMAP2+: omap3-pandora: add backlight support
      ARM: OMAP2+: omap3-pandora: add wifi support

Gregory Fong (1):
      ARM: dts: brcmstb: add BCM7445 GPIO nodes

Guo Zeng (1):
      ARM: dts: atlas7: add lost PWM node

Haikun Wang (1):
      ARM: dts: ls1021a: Update 'dspi' device node compatible string

Hans de Goede (22):
      ARM: dts: sun4i: Add USB Dual Role Controller
      ARM: dts: sun5i: Add USB Dual Role Controller
      ARM: dts: sun6i: Add USB Dual Role Controller
      ARM: dts: sun8i: Add A23 usb-phy and otg nodes
      ARM: dts: sun8i: Add A33 usb-phy and otg nodes
      ARM: dts: sun4i: Enable USB DRC on Chuwi V7 CW0825
      ARM: dts: sun4i: Enable USB DRC on the Cubieboard
      ARM: dts: sun5i: Enable USB DRC on UTOO P66
      ARM: dts: sun6i: Enable USB DRC on the Mele A1000G quad
      ARM: dts: sun7i: Enable USB DRC on A20-OLinuxIno-Lime
      ARM: dts: sun7i: Enable USB DRC on A20-OLinuxIno-Micro
      ARM: dts: sun8i: Enable USB DRC on Ippo Q8H-A23 tablets
      ARM: dts: sun8i: Enable USB DRC on GA10H-A33 tablets
      ARM: dts: sun8i: Enable USB host on GA10H-A33 tablets
      ARM: sun8i: dts: Add Ippo-q8h v1.2 with A33
      ARM: dts: sunxi: Add regulator-boot-on to usb host port regulator nodes
      ARM: dts: sun4i: Enable otg controller on the ba10-tvbox
      ARM: dts: sun4i: Enable otg controller on the mini-x
      ARM: dts: sun6i: Enable otg controller on the cs908
      ARM: dts: sun5i: Enable USB DRC on A10s OLinuxIno Micro
      ARM: dts: sun8i: Enable USB DRC on Ippo Q8H-A33 tablet
      ARM: dts: sun7i: Change cubietruck wifi enable pin to use mmc-pwrseq

Hauke Mehrtens (1):
      ARM: BCM5301X: activate some additional options in pl310 cache controller

Heiko Stuebner (11):
      ARM: dts: rockchip: fix rk3288 watchdog irq
      dt-bindings: add vendor prefix for Netxeon Technology
      ARM: dts: rockchip: add Netxeon R89 board
      ARM: dts: rockchip: add veyron-pinky board
      ARM: dts: rockchip: add missing device_type = "memory" to boards
      dt-bindings: document rk3368 R88 board from Rockchip
      ARM: dts: rockchip: add rk3288 arm-pmu irq affinity
      ARM: dts: rockchip: set correct dwc2 params for cortex-a9 socs
      ARM: dts: rockchip: add usb phys to Cortex-A9 socs
      ARM: dts: rockchip: enable usb controller on marsboard
      ARM: dts: rockchip: reserve unusable memory region on rk3288

Huayi Li (1):
      ARM: dts: atlas7: put pinctl property to get pinmux for NAND

James Liao (1):
      ARM: dts: mediatek: Enable clock support for Mediatek MT8135.

Javier Martinez Canillas (4):
      ARM: dts: Include exynos5250-pinctrl after the nodes were defined for exynos5250
      ARM: dts: Extend exynos5250-pinctrl nodes using labels instead of paths
      ARM: dts: Include exynos5420-pinctrl after the nodes were defined for exynos5420
      ARM: dts: Extend exynos5420-pinctrl nodes using labels instead of paths

Joachim Eastwood (22):
      ARM: dts: lpc18xx: add cgu and ccu clock-controller nodes
      ARM: dts: lpc18xx: add uart new compat string and clk names
      ARM: dts: lpc18xx: add pinctrl node
      ARM: dts: lpc18xx: add gpio node
      ARM: dts: lpc18xx: add ssp nodes
      ARM: dts: lpc18xx: add can nodes
      ARM: dts: lpc18xx: add mmcsd node
      ARM: dts: lpc18xx: add creg (syscon) node
      ARM: dts: lpc18xx: add ethernet node
      ARM: dts: lpc18xx: add usb nodes
      ARM: dts: lpc4357-ea4357: add pinctrl and uart0 muxing
      ARM: dts: lpc4357-ea4357: add mmcsd
      ARM: dts: lpc4357-ea4357: add gpio joystick
      ARM: dts: lpc4357-ea4357: add ethernet
      ARM: dts: lpc4357-ea4357: add uart3
      ARM: dts: lpc18xx: add usb otg phy node
      ARM: dts: lpc18xx: add pl111 lcd controller node
      ARM: dts: lpc18xx: add pl172 memory-controller node
      ARM: dts: lpc4357-ea4357: add usb0
      ARM: dts: lpc4357-ea4357: add emc pins and static memory devices
      ARM: dts: lpc4357-ea4357: add mmio-gpio leds
      ARM: dts: lpc4350-hitex-eval: add emc pins and static memory devices

Josef Gajdusek (1):
      ARM: dts: sun4i: Add Iteaduino Plus A10

Josh Wu (2):
      ARM: at91/dt: add isi & ov2640 dt nodes for at91sam9m10g45ek board
      ARM: at91/dt: sama5: update rstc to correct compatible string

Jyri Sarha (1):
      ARM: dts: am335x-boneblack: Use new binding for HDMI

Karsten Merker (1):
      devicetree: Add msi to the vendor-prefix list

Keerthy (4):
      ARM: dts: AM437X: add dpll_clksel_mac_clk node
      ARM: dts: am4372: Set the default clock rate for dpll_clksel_mac_clk clock
      ARM: dts: AM4372: Reorder the rtc compatible string
      ARM: dts: AM4372: Add the am4372-rtc compatible string

Kishon Vijay Abraham I (5):
      ARM: dts: dra72-evm: add evm_3v3_sd regulator
      ARM: dts: dra72-evm: Set max clock frequency of MMC1 and MMC2
      ARM: dts: am57xx-beagle-x15: mmc1: remove redundant pbias-supply property
      ARM: dts: dra7-evm: Fix spurious card insert/removal interrupt
      ARM: dts: dra72-evm: Fix spurious card insert/removal interrupt

Krzysztof Kozlowski (2):
      ARM: dts: Set max17047 over heat and voltage thresholds for exynos4412-trats2
      ARM: dts: Use labels for overriding nodes for exynos4210-universal_c210

Kuninori Morimoto (6):
      ARM: shmobile: lager: add sound label on DTS
      ARM: shmobile: koelsch: add sound label on DTS
      ARM: shmobile: r8a7790: Add Audio CTU support on DTSI
      ARM: shmobile: r8a7790: Add Audio MIX support on DTSI
      ARM: shmobile: r8a7791: Add Audio CTU support on DTSI
      ARM: shmobile: r8a7791: Add Audio MIX support on DTSI

Kyle Huey (1):
      ARM: tegra: Add Tegra124 PMU support

Laurent Pinchart (1):
      ARM: shmobile: lager: Fix adv7511 IRQ sensing

Lee Jones (2):
      ARM: STi: STiH407: Move PWM nodes STiH407 => STiH407-family
      ARM: STi: STiH407: Add PWM Regulator node

Lily.Li (1):
      ARM: dts: atlas7: add lost jpeg node

Lucas Stach (1):
      ARM: dts: imx53-qsb: select open-drain mode for i2c1 pads

Ludovic Desroches (1):
      ARM: at91/dt: add basic dtsi for sama5d2 SoC

Magnus Damm (1):
      ARM: shmobile: r8a7779: Configure IRLM mode via DT

Mark Janssen (1):
      ARM: dts: sun5i: Enable USB DRC on A13 OLinuxIno

Mars Cheng (2):
      Document: DT: Add bindings for mediatek MT6580 SoC Platform
      ARM: dts: mediatek: add mt6580 basic support

Masahiro Yamada (9):
      ARM: dts: UniPhier: add on-chip UART device nodes
      ARM: dts: UniPhier: add USB EHCI device nodes
      ARM: dts: UniPhier: add pinctrl device nodes
      ARM: dts: UniPhier: add UART and USB pinmux nodes
      ARM: dts: uniphier: add I2C controller device nodes
      ARM: dts: uniphier: add PH1-Pro5 SoC support
      ARM: dts: uniphier: add ProXstream2 and PH1-LD6b SoC/board support
      ARM: dts: UniPhier: add reference daughter board
      ARM: dts: UniPhier: fix PPI interrupt CPU mask of timer nodes

Matthew Gerlach (1):
      ARM: socfpga: dts: add missing clock gates to socfpga.dtsi

Maxime Coquelin (2):
      ARM: dts: Add STM32429i-EVAL board support
      ARM: dts: Use stdout-path in STM32F429 Discovery board

Maxime Ripard (1):
      ARM: sunxi: dt: Convert users to the PIO interrupts binding

Michal Simek (1):
      ARM: dts: zynq: Add OCM node

Michal Suchanek (2):
      ARM: dts: axp152: Add a dtsi file for the axp152 pmic
      ARM: dts: A10s-OLinuxIno: Add a node for axp152 pmic

Mikhail Ulyanov (2):
      ARM: shmobile: r8a7790: Add JPU device node.
      ARM: shmobile: r8a7791: Add JPU device node.

Mikko Perttunen (2):
      clk: tegra: Introduce ability for SoC-specific reset control callbacks
      ARM: tegra: Add CPU regulator to the Jetson TK1 device tree

Moritz Fischer (1):
      ARM: dts: zynq: Add devicetree entry for Xilinx Zynq reset controller.

Nicolas Chauvet (1):
      ARM: tegra: Fix AHB base address on Tegra20, Tegra30 and Tegra114

Nicolas Ferre (2):
      ARM: at91/dt: add minimal sama5d2 Xplained board
      ARM: at91/dt: at91sam9x5dm: add QT1070 touch button controller

Nishanth Menon (2):
      pinctrl: dra: dt-bindings: Add virtual mode configuration option
      ARM: dts: dra7-evm: Add MMCSD card removal GPIO

Olof Johansson (33):
      Merge tag 'renesas-dt-for-v4.3' of git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'omap-for-v4.3/dt-pt1' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge branch 'lpc18xx_43xx_dts_4.3' of https://github.com/manabian/linux-lpc into next/dt
      Merge tag 'mvebu-dt-4.3-1' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'arm-soc/for-4.3/dts' of http://github.com/broadcom/stblinux into next/dt
      Merge tag 'v4.3-rockchip32-dts1' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'tags/pxa-dt-4.3' of https://github.com/rjarzmik/linux into next/dt
      Merge tag 'omap-for-v4.3/dt-pt2' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'sti-dt-for-v4.3-1' of https://git.kernel.org/.../mcoquelin/sti into next/dt
      Merge tag 'stm32-dt-for-v4.3-1b' of https://git.kernel.org/.../mcoquelin/stm32 into next/dt
      Merge tag 'renesas-dt2-for-v4.3' of git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'omap-for-v4.3/dt-dm814x' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'v4.2-next-dts' of https://github.com/mbgg/linux-mediatek into next/dt
      Merge tag 'socfpga_dts_for_v4.3' of git://git.kernel.org/.../dinguyen/linux into next/dt
      Merge tag 'at91-dt' of git://git.kernel.org/.../nferre/linux-at91 into next/dt
      Merge tag 'qcom-dt-for-4.3' of git://codeaurora.org/quic/kernel/agross-msm into next/dt
      Merge tag 'zynq-dt-for-4.3' of https://github.com/Xilinx/linux-xlnx into next/dt
      Merge tag 'mvebu-dt-4.3-2' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'sunxi-dt-for-4.3' of https://git.kernel.org/.../mripard/linux into next/dt
      Merge tag 'samsung-dt-1' of git://git.kernel.org/.../kgene/linux-samsung into next/dt
      Merge tag 'sirf-dts-for-4.3' of git://git.kernel.org/.../baohua/linux into next/dt
      Merge tag 'omap-for-v4.3/dt-pt3' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'renesas-dt3-for-v4.3' of git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'at91-ab-dt2' of git://git.kernel.org/.../abelloni/linux into next/dt
      Merge tag 'mvebu-dt-4.3-3' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'v4.3-rockchip32-dts2' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'socfpga_dts_for_v4.3_part_2' of git://git.kernel.org/.../dinguyen/linux into next/dt
      Merge tag 'rpi-dt-for-armsoc-4.3' of git://git.kernel.org/.../rpi/linux-rpi into next/dt
      Merge tag 'imx-dt-4.3' of git://git.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'renesas-dt4-for-v4.3' of git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'omap-for-v4.3/dt-pt4-v2' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'tegra-for-4.3-dt' of git://git.kernel.org/.../tegra/linux into next/dt
      Merge tag 'v4.3-rockchip32-dts3' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt

Paul Walmsley (1):
      clk: tegra: Add DFLL DVCO reset control for Tegra124

Peter Chen (1):
      ARM: imx6qdl-sabreauto.dtsi: enable USB support

Peter Griffin (11):
      ARM: STi: DT: Add STiH407 family tsin0 pinctrl configuration
      ARM: STi: DT: Add STiH407 family tsin1 pinctrl configuration
      ARM: STi: DT: Add STiH407 family tsin2 pinctrl configuration
      ARM: STi: DT: Add STiH407 family tsin3 pinctrl configuration
      ARM: STi: DT: Add STiH407 family tsin4 pinctrl configuration
      ARM: STi: DT: Add STiH407 family tsin5 pinctrl configuration
      ARM: STi: DT: Add STiH407 family tsout0 pinctrl configuration
      ARM: STi: DT: Add STiH407 family tsout1 pinctrl configuration
      ARM: STi: DT: Add STiH407 family mtsin0 pinctrl configuration
      ARM: STi: DT: STiH407: Add cpu-release-addr dt property.
      ARM: STi: DT: STiH418: Add cpu-release-addr dt property.

Peter Seiderer (2):
      ARM: dts: nitrogen6x: add CAN support
      ARM: dts: sabrelite: add CAN support

Peter Ujfalusi (21):
      ARM: dts: dra7x: Integrate sDMA crossbar
      ARM: omap2plus_defconfig: Enable audio related config options
      ARM: dts: am437x-sk-evm: Add sleep pin settings for mcasp1
      ARM: dts: am437x-sk-evm: Switch using simple-audio-card for audio support
      ARM: dts: am43xx-epos-evm: Add gpio-hog for configuring the display/audio mux
      ARM: dts: am43xx-epos-evm: Add regulator for VBAT and DCDC4 of tps65218
      ARM: dts: am43xx-epos-evm: McASP1 node for audio support
      ARM: dts: am43xx-epos-evm: Add node for tlv320aic3111 audio codec
      ARM: dts: am43xx-epos-evm: Enable analog audio via simple-card
      ARM: dts: am437x-gp-evm: Add gpio-hog for configuring the display/audio mux
      ARM: dts: am437x-gp-evm: Rename fixed regulator vmmcsd_fixed to evm_v3_3d
      ARM: dts: am437x-gp-evm: Add node for tlv320aic3106 audio codec
      ARM: dts: am437x-gp-evm: McASP1 node for audio support
      ARM: dts: am437x-gp-evm: Enable analog audio via simple-card
      ARM: dts: am335x-evmsk: Fix mcasp1 node's indentation
      ARM: dts: am335x-evmsk: Add sleep pin settings for mcasp1
      ARM: dts: am335x-evmsk: Switch using simple-audio-card for audio support
      ARM: dts: am335x-evm: Fix mcasp1 node's indentation
      ARM: dts: am335x-evm: Rename pinctrl section for McASP1
      ARM: dts: am335x-evm: Add sleep pin settings for mcasp1
      ARM: dts: am335x-evm: Switch using simple-audio-card for audio support

Philippe Reynes (1):
      ARM: dts: imx27: add support of internal rtc

Pramod Gurav (1):
      ARM: dts: apq8064: Add DT support for GSBI6 and for UART pin mux

Punnaiah Choudary Kalluri (1):
      Documentation: devicetree: Add ECC information to synopsys ddr controller

Qipan Li (1):
      ARM: dts: atlas7: add alias name for spi device

Rafa? Mi?ecki (1):
      ARM: BCM5301X: Enable UART0 on tested devices

Ray Jui (1):
      ARM: dts: enable clock support for Broadcom Cygnus

Remy van Elst (1):
      ARM: dts: sun4i: Enable USB DRC on A10 OLinuxIno Lime

Robert Jarzmik (6):
      ARM: dts: pxa: add dma controller
      ARM: dts: pxa: add dma engine node to pxa3xx-nand
      ARM: dts: pxa: add dma pxamci nodes to pxa3xx
      ARM: dts: pxa: add embedded pxa camera capture interface
      ARM: dts: pxa: add the usb host controller
      ARM: dts: pxa: fix power i2c definition

Roger Quadros (7):
      ARM: dts: omap5: Add named interrupt property for dwc3
      ARM: dts: dra7: Add named interrupt property for dwc3
      ARM: dts: dra7: Remove ctrl_core and ctrl_general nodes
      ARM: dts: dra7: fix pinmux at 1400 resource length
      ARM: dts: dra7: Add scm_conf at 1c04 node
      ARM: dts: am437x-gp-evm: Add gpio-hog for configuring eMMC/NAND driver
      ARM: dts: am437x-gp-evm: Add eMMC support

Roger Shimizu (3):
      ARM: dts: add buffalo linkstation ls-wxl/wsxl
      ARM: dts: add buffalo linkstation ls-wvl/vl
      ARM: dts: orion5x: add buffalo linkstation ls-wtgl

Romain Perier (4):
      ARM: dts: rockchip: Add STMMAC reset signal in GMAC interface for rk3288
      ARM: dts: rockchip: Add ramp delay for vdd_cpu in firefly board dts
      ARM: dts: rockchip: Use correct dts properties for tsadc node on veyron
      ARM: dts: rockchip: Add veyron-speedy board

Roman Byshko (2):
      ARM: dts: sun7i: Add USB Dual Role Controller
      ARM: dts: sun7i: Enable USB DRC on Cubietruck

Russell King (4):
      ARM: dt: Add PMU node, making PMU child devices childs of this node
      ARM: dt: dove: wire up RTC interrupt
      ARM: dt: dove: add video decoder power domain description
      ARM: dt: dove: add GPU power domain description

Sanchayan Maity (1):
      ARM: dts: vfxxx: Add io-channel-cells property for ADC node

Sascha Hauer (3):
      ARM: dts: mt8135: Add pmic wrapper nodes
      ARM: dts: mt8135-evbp1: Add PMIC support
      ARM: dts: mediatek mt8135: Use real UART clocks

Sekhar Nori (1):
      ARM: dts: am437x: add aliases for all UART instances

Sergei Shtylyov (7):
      ARM: shmobile: r8a7790: add EtherAVB clocks
      ARM: shmobile: r8a7790: add EtherAVB DT support
      ARM: shmobile: r8a7794: add PFC DT support
      ARM: shmobile: silk: initial device tree
      ARM: shmobile: silk: add Ether DT support
      ARM: shmobile: r8a7794: add MMCIF DT support
      ARM: shmobile: silk: add eMMC DT support

Shengjiu Wang (1):
      ARM: dts: imx6qdl-sabreauto: Add audio support

Simon Horman (1):
      Merge branch 'clk-for-v4.3' into dt-for-v4.3

Srinivas Kandagatla (6):
      ARM: dts: apq8064: Add pm8921 mfd and its gpio node
      ARM: dts: apq8064: add pm8921 mpp support
      ARM: dts: apq8064: fix missing gsbi cell-index
      ARM: dts: apq8064: remove temporary fixed regulator for mmc
      ARM: dts: ifc6410: add real regulators for sdcc nodes.
      ARM: dts: qs600: Add real regulators to sdcc

Stefan Agner (2):
      ARM: dts: vf-colibri: define stdout-path property
      ARM: dts: add property for maximum ADC clock frequencies

Stephen Boyd (5):
      ARM: dts: qcom: Replace gpio node with pinctrl node
      ARM: dts: qcom: Add MSM8960 RPM and RPM regulator nodes
      ARM: dts: qcom: Add MSM8960 CDP RPM regulators
      ARM: dts: qcom: Add ks8851 node for wired ethernet
      ARM: dts: vexpress: Use assigned-clock-parents for sp810

Suman Anna (4):
      ARM: dts: AM33xx: Update and move wkup_m3 node to l4 node
      ARM: dts: AM4372: Add the wkupm3 rproc node
      ARM: dts: AM33xx: Add the wkup_m3_ipc node
      ARM: dts: AM4372: Add the wkup_m3_ipc node

Teresa Remmet (2):
      ARM: dts: Add support for phyCORE-AM335x SoM
      ARM: dts: Add phyBOARD-WEGA-AM335x rdk

Thierry Reding (3):
      Merge branch 'for-4.3/pinctrl' into for-4.3/dt
      Merge branch 'for-4.3/clk' into for-4.3/dt
      ARM: tegra: venice2: Add GK20A GPU DT node

Thomas Petazzoni (4):
      ARM: mvebu: use armada-380-xor on Armada 38x and 39x
      ARM: mvebu: use DT properties to fine-tune the L2 configuration
      ARM: mvebu: fix description of pwr-sata0 regulator on Armada 388 GP
      ARM: mvebu: update EEPROM description of Armada 388 GP

Tim Harvey (1):
      ARM: dts: ventana: add UHS-I support for Ventana boards

Tomeu Vizoso (2):
      pinctrl: tegra: Only set the gpio range if needed
      ARM: tegra: Add gpio-ranges property

Tony Lindgren (7):
      ARM: dts: Remove L3 compatible value for dm816x
      ARM: dts: Add minimal dm814x support
      ARM: dts: Add minimal clocks for dm814x
      ARM: dts: Add minimal dts support for dm8148-evm
      ARM: dts: Add minimal support for HP T410
      ARM: OMAP2+: Add custom abort handler for t410
      Merge branch 'for-4.3/ti-clk-dt' of https://github.com/t-kristo/linux-pm into omap-for-v4.3/dt-v2

Tuomas Tynkkynen (10):
      clk: tegra: Add binding for the Tegra124 DFLL clocksource
      clk: tegra: Add library for the DFLL clock source (open-loop mode)
      clk: tegra: Add closed loop support for the DFLL
      clk: tegra: Add functions for parsing CVB tables
      clk: tegra: Add Tegra124 DFLL clocksource platform driver
      clk: tegra: Save/restore CCLKG_BURST_POLICY on suspend
      clk: tegra: Add the DFLL as a possible parent of the cclk_g clock
      ARM: tegra: Add the DFLL to Tegra124 device tree
      ARM: tegra: Enable the DFLL on the Jetson TK1
      ARM: tegra: Add entries for cpufreq on Tegra124

Ulrich Hecht (2):
      ARM: shmobile: add r8a7793 minimal SoC device tree
      ARM: shmobile: r8a7793: add minimal Gose board device tree

Vignesh R (1):
      ARM: dts: DRA72: switch to cpsw slave0 for ethernet

Wolfram Sang (2):
      ARM: shmobile: emev2: add IIC cores to dtsi
      ARM: shmobile: emev2: kzm9d: enable IIC busses

Xiaofeng Fei (1):
      ARM: dts: atlas7: add multimedia codec node

Ye He (2):
      ARM: dts: atlas7: add performance monitor unit node
      ARM: dts: atlas7: add lost gmac node

Yonghui Zhang (1):
      ARM: dts: atlas7: add software digital radio nodes and its DMA channels


 .../devicetree/bindings/arm/atmel-at91.txt      |   13 +-
 .../arm/bcm/raspberrypi,bcm2835-firmware.txt    |   14 +
 .../bindings/arm/marvell,kirkwood.txt           |    2 +
 .../devicetree/bindings/arm/mediatek.txt        |    4 +
 .../bindings/arm/mediatek/mediatek,sysirq.txt   |    1 +
 .../devicetree/bindings/arm/omap/omap.txt       |    3 +
 .../devicetree/bindings/arm/rockchip.txt        |   35 +
 .../devicetree/bindings/clock/imx6ul-clock.txt  |   13 +
 .../bindings/clock/nvidia,tegra124-dfll.txt     |   79 +
 .../bindings/clock/st/st,clkgen-pll.txt         |    4 +-
 .../bindings/memory-controllers/synopsys.txt    |    4 +
 .../bindings/pinctrl/fsl,imx6ul-pinctrl.txt     |   36 +
 .../devicetree/bindings/reset/socfpga-reset.txt |    2 +
 .../bindings/rtc/atmel,at91rm9200-rtc.txt       |    2 +
 .../devicetree/bindings/rtc/rtc-omap.txt        |    1 +
 .../devicetree/bindings/serial/mtk-uart.txt     |    3 +-
 .../bindings/timer/mediatek,mtk-timer.txt       |    6 +-
 .../devicetree/bindings/vendor-prefixes.txt     |    3 +
 .../devicetree/bindings/watchdog/atmel-wdt.txt  |    2 +
 arch/arm/boot/dts/Makefile                      |   41 +-
 arch/arm/boot/dts/am335x-boneblack.dts          |   20 +-
 arch/arm/boot/dts/am335x-evm.dts                |   69 +-
 arch/arm/boot/dts/am335x-evmsk.dts              |   62 +-
 arch/arm/boot/dts/am335x-phycore-som.dtsi       |  368 ++++
 arch/arm/boot/dts/am335x-wega-rdk.dts           |   22 +
 arch/arm/boot/dts/am335x-wega.dtsi              |  151 ++
 arch/arm/boot/dts/am33xx.dtsi                   |   25 +-
 arch/arm/boot/dts/am4372.dtsi                   |   67 +-
 arch/arm/boot/dts/am437x-gp-evm.dts             |  185 +-
 arch/arm/boot/dts/am437x-sk-evm.dts             |   45 +-
 arch/arm/boot/dts/am43x-epos-evm.dts            |  130 +-
 arch/arm/boot/dts/am43xx-clocks.dtsi            |    9 +
 arch/arm/boot/dts/am57xx-beagle-x15.dts         |    1 -
 arch/arm/boot/dts/armada-375.dtsi               |    4 +
 arch/arm/boot/dts/armada-388-gp.dts             |   12 +-
 arch/arm/boot/dts/armada-38x.dtsi               |    8 +-
 arch/arm/boot/dts/armada-39x.dtsi               |    8 +-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts     |  134 ++
 arch/arm/boot/dts/at91-sama5d4_xplained.dts     |    9 +
 arch/arm/boot/dts/at91-sama5d4ek.dts            |    9 +
 arch/arm/boot/dts/at91rm9200.dtsi               |   10 +-
 arch/arm/boot/dts/at91sam9260.dtsi              |   11 +-
 arch/arm/boot/dts/at91sam9261.dtsi              |    7 +-
 arch/arm/boot/dts/at91sam9263.dtsi              |    7 +-
 arch/arm/boot/dts/at91sam9g15.dtsi              |    1 +
 arch/arm/boot/dts/at91sam9g15ek.dts             |   25 +
 arch/arm/boot/dts/at91sam9g35.dtsi              |    1 +
 arch/arm/boot/dts/at91sam9g35ek.dts             |   21 +
 arch/arm/boot/dts/at91sam9g45.dtsi              |   60 +-
 arch/arm/boot/dts/at91sam9m10g45ek.dts          |   47 +
 arch/arm/boot/dts/at91sam9n12.dtsi              |   83 +-
 arch/arm/boot/dts/at91sam9n12ek.dts             |   61 +
 arch/arm/boot/dts/at91sam9rl.dtsi               |    8 +-
 arch/arm/boot/dts/at91sam9x35.dtsi              |    1 +
 arch/arm/boot/dts/at91sam9x35ek.dts             |   20 +
 arch/arm/boot/dts/at91sam9x5.dtsi               |   12 +-
 arch/arm/boot/dts/at91sam9x5_lcd.dtsi           |  139 ++
 arch/arm/boot/dts/at91sam9x5dm.dtsi             |  101 +
 arch/arm/boot/dts/atlas7-evb.dts                |   18 +
 arch/arm/boot/dts/atlas7.dtsi                   |   97 +-
 arch/arm/boot/dts/axp152.dtsi                   |   49 +
 arch/arm/boot/dts/bcm-cygnus-clock.dtsi         |   89 +-
 arch/arm/boot/dts/bcm2835-rpi.dtsi              |    7 +
 .../boot/dts/bcm4708-buffalo-wzr-1750dhp.dts    |    4 +
 arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts    |    4 +
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts     |   14 +-
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts   |    4 +
 .../boot/dts/bcm47081-buffalo-wzr-600dhp2.dts   |    4 +
 arch/arm/boot/dts/bcm5301x.dtsi                 |   10 +
 arch/arm/boot/dts/bcm7445.dtsi                  |   50 +
 arch/arm/boot/dts/cros-ec-sbs.dtsi              |   52 +
 arch/arm/boot/dts/cx92755.dtsi                  |    7 +
 arch/arm/boot/dts/cx92755_equinox.dts           |    3 +-
 arch/arm/boot/dts/dm8148-evm.dts                |   28 +
 arch/arm/boot/dts/dm8148-t410.dts               |   28 +
 arch/arm/boot/dts/dm814x-clocks.dtsi            |  109 ++
 arch/arm/boot/dts/dm814x.dtsi                   |  333 ++++
 arch/arm/boot/dts/dm816x.dtsi                   |    2 +-
 arch/arm/boot/dts/dove.dtsi                     |  604 +++---
 arch/arm/boot/dts/dra7-evm.dts                  |   18 +-
 arch/arm/boot/dts/dra7.dtsi                     |   95 +-
 arch/arm/boot/dts/dra72-evm.dts                 |   26 +-
 arch/arm/boot/dts/dra74x.dtsi                   |    7 +-
 arch/arm/boot/dts/emev2-kzm9d.dts               |    8 +
 arch/arm/boot/dts/emev2.dtsi                    |   48 +
 arch/arm/boot/dts/exynos4210-universal_c210.dts |  620 +++----
 arch/arm/boot/dts/exynos4412-trats2.dts         |    3 +
 arch/arm/boot/dts/exynos5250-pinctrl.dtsi       | 1600 ++++++++--------
 arch/arm/boot/dts/exynos5250.dtsi               |    3 +-
 arch/arm/boot/dts/exynos5410-smdk5410.dts       |    6 +-
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi       | 1411 +++++++-------
 arch/arm/boot/dts/exynos5420.dtsi               |    3 +-
 arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi   |   59 +
 .../boot/dts/exynos5422-odroidxu3-common.dtsi   |   46 +
 arch/arm/boot/dts/imx27.dtsi                    |    9 +
 arch/arm/boot/dts/imx53-qsb-common.dtsi         |    5 +-
 arch/arm/boot/dts/imx53-qsrb.dts                |   14 +-
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi           |    1 -
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi           |   35 +-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi           |   35 +-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi           |   34 +-
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi           |    1 -
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi           |    1 -
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi       |   39 +
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi        |  137 ++
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi        |   39 +
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi          |    7 +
 arch/arm/boot/dts/imx6qdl.dtsi                  |   52 +-
 arch/arm/boot/dts/imx6sl-warp.dts               |   32 +-
 arch/arm/boot/dts/imx6sl.dtsi                   |   21 +-
 arch/arm/boot/dts/imx6sx.dtsi                   |   28 +-
 arch/arm/boot/dts/imx6ul-14x14-evk.dts          |  343 ++++
 arch/arm/boot/dts/imx6ul-pinfunc.h              |  938 ++++++++++
 arch/arm/boot/dts/imx6ul.dtsi                   |  707 +++++++
 arch/arm/boot/dts/imx7d.dtsi                    |  260 ++-
 arch/arm/boot/dts/kirkwood-lswvl.dts            |  301 +++
 arch/arm/boot/dts/kirkwood-lswxl.dts            |  301 +++
 arch/arm/boot/dts/lpc18xx.dtsi                  |  267 ++-
 arch/arm/boot/dts/lpc4337-ciaa.dts              |  187 ++
 arch/arm/boot/dts/lpc4350-hitex-eval.dts        |  244 ++-
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts     |  467 +++++
 arch/arm/boot/dts/ls1021a-qds.dts               |   89 +
 arch/arm/boot/dts/ls1021a-twr.dts               |   81 +
 arch/arm/boot/dts/ls1021a.dtsi                  |  106 +-
 arch/arm/boot/dts/mt6580-evbp1.dts              |   38 +
 arch/arm/boot/dts/mt6580.dtsi                   |  116 ++
 arch/arm/boot/dts/mt8135-evbp1.dts              |  193 ++
 arch/arm/boot/dts/mt8135.dtsi                   |   58 +-
 arch/arm/boot/dts/omap3-devkit8000-common.dtsi  |  369 ++++
 .../boot/dts/omap3-devkit8000-lcd-common.dtsi   |   73 +
 arch/arm/boot/dts/omap3-devkit8000-lcd43.dts    |   37 +
 arch/arm/boot/dts/omap3-devkit8000-lcd70.dts    |   37 +
 arch/arm/boot/dts/omap3-devkit8000.dts          |  191 +-
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi         |   12 +-
 arch/arm/boot/dts/omap3-overo-base.dtsi         |   55 +
 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi |    3 +-
 .../arm/boot/dts/omap3-overo-palo35-common.dtsi |   53 +
 arch/arm/boot/dts/omap3-overo-palo35.dts        |   37 +
 arch/arm/boot/dts/omap3-overo-storm-palo35.dts  |   37 +
 arch/arm/boot/dts/omap3-overo-storm-tobiduo.dts |   21 +
 .../boot/dts/omap3-overo-tobiduo-common.dtsi    |   65 +
 arch/arm/boot/dts/omap3-overo-tobiduo.dts       |   21 +
 arch/arm/boot/dts/omap3-overo.dtsi              |    4 -
 arch/arm/boot/dts/omap3-pandora-1ghz.dts        |    2 +-
 arch/arm/boot/dts/omap3-pandora-600mhz.dts      |    2 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi     |   54 +-
 arch/arm/boot/dts/omap5-uevm.dts                |    7 +
 arch/arm/boot/dts/omap5.dtsi                    |    7 +-
 .../arm/boot/dts/orion5x-linkstation-lswtgl.dts |  273 +++
 arch/arm/boot/dts/orion5x-lswsgl.dts            |  276 +++
 arch/arm/boot/dts/pxa27x.dtsi                   |   36 +
 arch/arm/boot/dts/pxa2xx.dtsi                   |    4 +
 arch/arm/boot/dts/pxa3xx.dtsi                   |   52 +
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts     |   20 +
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts      |   40 +
 arch/arm/boot/dts/qcom-apq8064.dtsi             |   91 +-
 arch/arm/boot/dts/qcom-msm8660.dtsi             |   11 +-
 arch/arm/boot/dts/qcom-msm8960-cdp.dts          |  302 +++
 arch/arm/boot/dts/qcom-msm8960.dtsi             |   49 +-
 arch/arm/boot/dts/qcom-msm8974.dtsi             |   32 +
 arch/arm/boot/dts/r7s72100.dtsi                 |   19 +
 arch/arm/boot/dts/r8a73a4.dtsi                  |    9 +-
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts   |   13 +
 arch/arm/boot/dts/r8a7740.dtsi                  |    1 +
 arch/arm/boot/dts/r8a7778.dtsi                  |   22 +
 arch/arm/boot/dts/r8a7779.dtsi                  |   28 +-
 arch/arm/boot/dts/r8a7790-lager.dts             |    4 +-
 arch/arm/boot/dts/r8a7790.dtsi                  |  138 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts           |    2 +-
 arch/arm/boot/dts/r8a7791.dtsi                  |  120 +-
 arch/arm/boot/dts/r8a7793-gose.dts              |   63 +
 arch/arm/boot/dts/r8a7793.dtsi                  |  374 ++++
 arch/arm/boot/dts/r8a7794-silk.dts              |  102 +
 arch/arm/boot/dts/r8a7794.dtsi                  |   48 +-
 arch/arm/boot/dts/rk3066a-bqcurie2.dts          |    1 +
 arch/arm/boot/dts/rk3066a-marsboard.dts         |   13 +
 arch/arm/boot/dts/rk3066a-rayeager.dts          |    5 +
 arch/arm/boot/dts/rk3066a.dtsi                  |   22 +
 arch/arm/boot/dts/rk3188-radxarock.dts          |    5 +
 arch/arm/boot/dts/rk3188.dtsi                   |   22 +
 arch/arm/boot/dts/rk3288-evb.dtsi               |    1 +
 arch/arm/boot/dts/rk3288-firefly.dtsi           |    3 +
 arch/arm/boot/dts/rk3288-popmetal.dts           |    1 +
 arch/arm/boot/dts/rk3288-r89.dts                |  413 +++++
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi |  232 +++
 arch/arm/boot/dts/rk3288-veyron-jerry.dts       |  197 ++
 arch/arm/boot/dts/rk3288-veyron-minnie.dts      |  230 +++
 arch/arm/boot/dts/rk3288-veyron-pinky.dts       |  128 ++
 arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi      |  122 ++
 arch/arm/boot/dts/rk3288-veyron-speedy.dts      |  155 ++
 arch/arm/boot/dts/rk3288-veyron.dtsi            |  563 ++++++
 arch/arm/boot/dts/rk3288.dtsi                   |   31 +-
 arch/arm/boot/dts/rk3xxx.dtsi                   |   10 +
 arch/arm/boot/dts/sama5d2.dtsi                  |  926 +++++++++
 arch/arm/boot/dts/sama5d3.dtsi                  |   10 +-
 arch/arm/boot/dts/sama5d3_tcb1.dtsi             |    4 +-
 arch/arm/boot/dts/sama5d4.dtsi                  |   25 +-
 arch/arm/boot/dts/sh73a0.dtsi                   |    3 +
 arch/arm/boot/dts/socfpga.dtsi                  |   46 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi          |   11 +
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi    |    3 +-
 arch/arm/boot/dts/socfpga_arria5_socdk.dts      |    3 +-
 .../boot/dts/socfpga_cyclone5_de0_sockit.dts    |  111 ++
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts    |    3 +-
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts   |    3 +-
 arch/arm/boot/dts/stih407-clock.dtsi            |    4 +-
 arch/arm/boot/dts/stih407-family.dtsi           |   45 +
 arch/arm/boot/dts/stih407-pinctrl.dtsi          |  200 ++
 arch/arm/boot/dts/stih407.dtsi                  |   28 -
 arch/arm/boot/dts/stih410-clock.dtsi            |    4 +-
 arch/arm/boot/dts/stih410.dtsi                  |   12 +
 arch/arm/boot/dts/stih418-clock.dtsi            |    4 +-
 arch/arm/boot/dts/stih418.dtsi                  |    4 +
 arch/arm/boot/dts/stm32429i-eval.dts            |   75 +
 arch/arm/boot/dts/stm32f429-disco.dts           |    8 +-
 arch/arm/boot/dts/stm32f429.dtsi                |   79 +-
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts      |   15 +
 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts |   34 +
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts      |   19 +
 .../boot/dts/sun4i-a10-itead-iteaduino-plus.dts |  202 ++
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts      |   15 +
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts  |   32 +
 arch/arm/boot/dts/sun4i-a10.dtsi                |   16 +-
 .../arm/boot/dts/sun5i-a10s-olinuxino-micro.dts |   37 +-
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts        |   58 +
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts       |   37 +
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts        |   29 +-
 arch/arm/boot/dts/sun5i.dtsi                    |   16 +-
 .../arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts |    5 +
 arch/arm/boot/dts/sun6i-a31.dtsi                |   16 +-
 arch/arm/boot/dts/sun6i-a31s-cs908.dts          |    5 +
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts      |   56 +-
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts       |    2 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts  |   32 +
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts |   32 +
 arch/arm/boot/dts/sun7i-a20.dtsi                |   16 +-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi            |   25 +-
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts     |    9 +
 arch/arm/boot/dts/sun8i-a23.dtsi                |   33 +
 arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts      |   17 +
 arch/arm/boot/dts/sun8i-a33-ippo-q8h-v1.2.dts   |  133 ++
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts  |   13 +
 arch/arm/boot/dts/sun8i-a33.dtsi                |   33 +
 arch/arm/boot/dts/sunxi-common-regulators.dtsi  |    2 +
 arch/arm/boot/dts/tegra114.dtsi                 |    5 +-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts       |   25 +-
 arch/arm/boot/dts/tegra124-venice2.dts          |   10 +-
 arch/arm/boot/dts/tegra124.dtsi                 |   50 +
 arch/arm/boot/dts/tegra20.dtsi                  |    5 +-
 arch/arm/boot/dts/tegra30.dtsi                  |    5 +-
 arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts      |   38 +-
 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi         |  143 ++
 arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts     |  105 ++
 arch/arm/boot/dts/uniphier-ph1-ld6b.dtsi        |   67 +
 arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts     |   40 +-
 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi        |  158 ++
 arch/arm/boot/dts/uniphier-ph1-pro5.dtsi        |  252 +++
 arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts     |   46 +-
 arch/arm/boot/dts/uniphier-ph1-sld3.dtsi        |  122 ++
 arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts     |   42 +-
 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi        |  143 ++
 arch/arm/boot/dts/uniphier-pinctrl.dtsi         |  105 ++
 arch/arm/boot/dts/uniphier-proxstream2.dtsi     |  273 +++
 arch/arm/boot/dts/uniphier-ref-daughter.dtsi    |   50 +
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi         |    2 +
 arch/arm/boot/dts/vexpress-v2m.dtsi             |    2 +
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi       |    2 +-
 arch/arm/boot/dts/vfxxx.dtsi                    |   85 +-
 arch/arm/boot/dts/zynq-7000.dtsi                |   10 +-
 arch/arm/boot/dts/zynq-zc702.dts                |   28 +
 arch/arm/configs/omap2plus_defconfig            |    3 +
 arch/arm/mach-omap2/pdata-quirks.c              |  157 ++
 arch/arm/mach-orion5x/Kconfig                   |    6 +-
 arch/arm/mach-orion5x/Makefile                  |    1 -
 arch/arm/mach-orion5x/lsmini-setup.c            |  280 ---
 arch/arm/mach-tegra/Kconfig                     |    1 +
 drivers/clk/imx/Makefile                        |    1 +
 drivers/clk/imx/clk-imx6q.c                     |    4 +
 drivers/clk/imx/clk-imx6ul.c                    |  432 +++++
 drivers/clk/tegra/Makefile                      |    3 +
 drivers/clk/tegra/clk-dfll.c                    | 1755 ++++++++++++++++++
 drivers/clk/tegra/clk-dfll.h                    |   54 +
 drivers/clk/tegra/clk-tegra-super-gen4.c        |    4 +-
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c      |  166 ++
 drivers/clk/tegra/clk-tegra124.c                |   82 +
 drivers/clk/tegra/clk.c                         |   39 +-
 drivers/clk/tegra/clk.h                         |    3 +
 drivers/clk/tegra/cvb.c                         |  140 ++
 drivers/clk/tegra/cvb.h                         |   67 +
 drivers/clk/ti/clk-43xx.c                       |    1 +
 drivers/pinctrl/pinctrl-tegra.c                 |   19 +-
 include/dt-bindings/clock/imx6ul-clock.h        |  240 +++
 include/dt-bindings/clock/r8a7790-clock.h       |    3 +
 include/dt-bindings/clock/r8a7791-clock.h       |    2 +
 include/dt-bindings/clock/r8a7793-clock.h       |  164 ++
 include/dt-bindings/pinctrl/am43xx.h            |    1 +
 include/dt-bindings/pinctrl/dra.h               |   20 +
 include/dt-bindings/reset/altr,rst-mgr-a10.h    |  110 ++
 include/dt-bindings/reset/tegra124-car.h        |   12 +
 299 files changed, 23173 insertions(+), 3206 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx6ul-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx6ul-pinctrl.txt
 create mode 100644 arch/arm/boot/dts/am335x-phycore-som.dtsi
 create mode 100644 arch/arm/boot/dts/am335x-wega-rdk.dts
 create mode 100644 arch/arm/boot/dts/am335x-wega.dtsi
 create mode 100644 arch/arm/boot/dts/at91-sama5d2_xplained.dts
 create mode 100644 arch/arm/boot/dts/at91sam9x5dm.dtsi
 create mode 100644 arch/arm/boot/dts/axp152.dtsi
 create mode 100644 arch/arm/boot/dts/cros-ec-sbs.dtsi
 create mode 100644 arch/arm/boot/dts/dm8148-evm.dts
 create mode 100644 arch/arm/boot/dts/dm8148-t410.dts
 create mode 100644 arch/arm/boot/dts/dm814x-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/dm814x.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-14x14-evk.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-pinfunc.h
 create mode 100644 arch/arm/boot/dts/imx6ul.dtsi
 create mode 100644 arch/arm/boot/dts/kirkwood-lswvl.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-lswxl.dts
 create mode 100644 arch/arm/boot/dts/lpc4337-ciaa.dts
 create mode 100644 arch/arm/boot/dts/mt6580-evbp1.dts
 create mode 100644 arch/arm/boot/dts/mt6580.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-devkit8000-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-devkit8000-lcd43.dts
 create mode 100644 arch/arm/boot/dts/omap3-devkit8000-lcd70.dts
 create mode 100644 arch/arm/boot/dts/omap3-overo-palo35-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-overo-palo35.dts
 create mode 100644 arch/arm/boot/dts/omap3-overo-storm-palo35.dts
 create mode 100644 arch/arm/boot/dts/omap3-overo-storm-tobiduo.dts
 create mode 100644 arch/arm/boot/dts/omap3-overo-tobiduo-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-overo-tobiduo.dts
 create mode 100644 arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts
 create mode 100644 arch/arm/boot/dts/orion5x-lswsgl.dts
 create mode 100644 arch/arm/boot/dts/r8a7793-gose.dts
 create mode 100644 arch/arm/boot/dts/r8a7793.dtsi
 create mode 100644 arch/arm/boot/dts/r8a7794-silk.dts
 create mode 100644 arch/arm/boot/dts/rk3288-r89.dts
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-jerry.dts
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-minnie.dts
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-pinky.dts
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-speedy.dts
 create mode 100644 arch/arm/boot/dts/rk3288-veyron.dtsi
 create mode 100644 arch/arm/boot/dts/sama5d2.dtsi
 create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
 create mode 100644 arch/arm/boot/dts/stm32429i-eval.dts
 create mode 100644 arch/arm/boot/dts/sun4i-a10-itead-iteaduino-plus.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a33-ippo-q8h-v1.2.dts
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-ld6b.dtsi
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-pro5.dtsi
 create mode 100644 arch/arm/boot/dts/uniphier-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/uniphier-proxstream2.dtsi
 create mode 100644 arch/arm/boot/dts/uniphier-ref-daughter.dtsi
 delete mode 100644 arch/arm/mach-orion5x/lsmini-setup.c
 create mode 100644 drivers/clk/imx/clk-imx6ul.c
 create mode 100644 drivers/clk/tegra/clk-dfll.c
 create mode 100644 drivers/clk/tegra/clk-dfll.h
 create mode 100644 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
 create mode 100644 drivers/clk/tegra/cvb.c
 create mode 100644 drivers/clk/tegra/cvb.h
 create mode 100644 include/dt-bindings/clock/imx6ul-clock.h
 create mode 100644 include/dt-bindings/clock/r8a7793-clock.h
 create mode 100644 include/dt-bindings/reset/altr,rst-mgr-a10.h
 create mode 100644 include/dt-bindings/reset/tegra124-car.h
