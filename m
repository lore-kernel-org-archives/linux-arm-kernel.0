From: olof@lixom.net (Olof Johansson)
Date: Tue, 21 Apr 2015 23:11:11 -0700
Subject: [GIT PULL 4/9] ARM: DT updates for v4.1
In-Reply-To: <1429683076-19881-1-git-send-email-olof@lixom.net>
References: <1429683076-19881-1-git-send-email-olof@lixom.net>
Message-ID: <1429683076-19881-5-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As always, this tends to be one of our bigger branches. There are lots of
updates this release, but not that many jumps out as something that needs
more detailed coverage. Some of the highlights are:

- DTs for the new Annapurna Labs Alpine platform
- More graphics DT pieces falling into place on Exynos, bridges, clocks.
- Plenty of DT updates for Qualcomm platforms for various IP blocks
- Some churn on Tegra due to switch-over to tool-generated pinctrl data
- Misc fixes and updates for Atmel at91 platforms
- Various DT updates to add IP block support on Broadcom's Cygnus platforms
- More updates for Renesas platforms as DT support is added for various IP
blocks (IPMMU, display, audio, etc).


Conflicts: None

----------------------------------------------------------------

The following changes since commit 3a6d5929b0978d35e4a6421c5cf9965a5376fcbf:

  Merge tag 'armsoc-soc' into testmerge

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt

for you to fetch changes up to 8b036556d68175caa9bea3fb98768f733fde33c6:

  ARM: dts: alpine: add internal pci

----------------------------------------------------------------

Ajay Kumar (2):
      ARM: dts: represent bridge and panel connection for exynos5250-snow
      ARM: dts: represent bridge and panel connection for exynos5420-peach-pit

Alexander Stein (1):
      DT: video: atmel_lcdc: Add example of fixed framebuffer memory

Anand Moon (1):
      ARM: dts: Fixed typo interrupt-cells for exynos5420 and exynos5250

Andrew Lunn (1):
      ARM: ARMADA XP: WRT1900AC: Add support for the Ethernet switch

Andrzej Hajda (3):
      dt-bindings: add asynchronous bridge clock for exynos
      ARM: dts: add async-bridge clocks to disp1 power domain for exynos5420
      ARM: dts: add async-bridge clocks to gsc power domain for exynos5420

Andy Gross (5):
      mfd: qcom,tcsr: Add device tree binding for TCSR
      arm: dts: qcom: Add TCSR support for APQ8064
      arm: dts: qcom: Add TCSR support for IPQ8064
      arm: dts: qcom: Add TCSR support for MSM8660
      arm: dts: qcom: Add TCSR support for MSM8960

Andy Yan (2):
      dt-bindings: add root compatible property for PopMetal board
      ARM: dts: add rk3288 PopMetal board

Arnd Bergmann (9):
      Merge tag 'renesas-dt-for-v4.1' of git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'for-v4.0-rc/meson-dts' of https://github.com/carlocaione/linux-meson into next/dt
      Merge tag 'at91-dt' of git://git.kernel.org/.../nferre/linux-at91 into next/dt
      Merge tag 'arm-soc/for-4.1/devicetree' of http://github.com/broadcom/stblinux into next/dt
      Merge tag 'mvebu-dt-4.1' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'renesas-dt2-for-v4.1' of git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'arm-soc/for-4.1/devicetree-part-2' of http://github.com/broadcom/stblinux into next/dt
      Revert "ARM: dts: mt8135: Add pinctrl/GPIO/EINT node for mt8135."
      Merge tag 'mvebu-fixes-4.0-2' of git://git.infradead.org/linux-mvebu into next/dt

Beata Michalska (1):
      ARM: dts: Add assigned clock parents to CMU node for exynos3250

Beniamino Galvani (4):
      ARM: dts: meson: add node for SPIFC
      ARM: dts: meson: enable Ethernet controller
      ARM: dts: meson8: add pinctrl node
      ARM: dts: meson: add DTS file for MINIX NEO-X8

Bo Shen (7):
      ARM: at91/dt: at91sam9n12: add udp device node
      ARM: at91/dt: at91sam9n12ek: enable udp
      ARM: at91: dt: sama5d4: add ssc nodes
      ARM: at91: dt: sama5d4ek: enable ssc0
      ARM: at91: dt: sama5d4ek: add and enable wm8904
      ARM: at91: dt: sama5d4ek: enable audio
      ARM: at91/dt: sama5d4: add pwm0 device node

Boris Brezillon (5):
      ARM: at91/dt: split sama5d3 lcd pin definitions to match RGB mode configs
      ARM: at91/dt: add alternative pin muxing for sama5d3 lcd pins
      ARM: at91/dt: define the HLCDC node available on sama5d3 SoCs
      ARM: at91/dt: sama5d4: add lcdc pin definitions
      ARM: at91/dt: sama5d4: add hlcdc node

Brian Norris (2):
      ARM: dts: brcmstb: un-hexify clock frequency
      ARM: dts: brcmstb: add IRQ0 controller

Daniel Tang (1):
      devicetree: Add TI-NSPIRE USB OTG support to device tree

Eliad Peller (4):
      dt: bindings: add TI's wilink wireless device
      wlcore: add device-tree support
      ARM: dts: add wl12xx/wl18xx bindings
      wlcore: remove wl12xx_platform_data

Ezequiel Garcia (2):
      ARM: mvebu: Enable Performance Monitor Unit on Armada 375 SoC
      ARM: mvebu: Enable Performance Monitor Unit on Armada 380/385 SoC

Felipe Balbi (1):
      ARM: dts: am437x-idk: enable i2c2

Geert Uytterhoeven (10):
      ARM: shmobile: kzm9g-reference dts: Sort i2c0 children by unit address
      ARM: shmobile: kzm9g-reference dts: Add ak8975 magnetometer node
      ARM: shmobile: kzm9g-reference dts: Add adxl345 accelerometer node
      ARM: shmobile: kzm9g-reference dts: Add r2025sd rtc node
      ARM: shmobile: sh73a0 dtsi: Add missing INTCA0 clock for irqpin module
      ARM: shmobile: kzm9g dts: Declare the full 512 MiB of RAM
      ARM: shmobile: kzm9g-reference dts: Declare the full 512 MiB of RAM
      ARM: shmobile: ape6evm dts: Fix polarity of LEDs
      ARM: shmobile: ape6evm dts: Enable pull-up for GPIO switches
      ARM: shmobile: ape6evm dts: Configure the custom switch as wake-up source

Georgi Djakov (1):
      dt-bindings: Add #defines for MSM8916 clocks and resets

Gregory CLEMENT (4):
      ARM: mvebu: Use macros for interrupt flags on Armada 38x sdhci node
      ARM: mvebu: Update the SDHCI node on Armada 38x
      ARM: mvebu: Add Device Tree description of SDHCI for Armada 388 RD
      ARM: mvebu: Conform L2CC node with ePAPR specification by adding cache-level

H. Nikolaus Schaller (3):
      ARM: dts: omap3-pandora: add common device tree
      ARM: dts: omap3-pandora: add OMAP3530 600 MHz version
      ARM: dts: omap3-pandora: add DM3730 1 GHz version

Heiko Stuebner (4):
      ARM: dts: rockchip: enable usbphy on rk3288-firefly
      ARM: dts: rockchip: enable gmac on rk3288-firefly
      ARM: dts: rockchip: add input supplies for the act8846 on Radxa Rock
      ARM: dts: rockchip: complete rk3288-evb pmic supplies

Hongzhou Yang (1):
      ARM: dts: mt8135: Add pinctrl/GPIO/EINT node for mt8135.

Imre Kaloz (1):
      ARM: mvebu: add Linksys WRT1900AC (Mamba) support

Ivan T. Ivanov (3):
      arm: dts: qcom: Add SPMI PMIC Arbiter nodes for APQ8084 and MSM8974
      arm: dts: qcom: Add 8x74 chipset SPMI PMIC's nodes
      arm: dts: qcom: Add APQ8084 chipset SPMI PMIC's nodes

Javier Martinez Canillas (7):
      ARM: dts: Enable wifi power-on for exynos5250-snow
      ARM: dts: Add cap-sdio-irq to wifi mmc node for exynos5250-snow
      ARM: dts: Mux XMMCnDATA[0] pad correctly for Exynos5420 boards
      ARM: dts: Add WiFi module support for Peach boards
      ARM: dts: Define stdout-path property for Peach boards
      ARM: dts: Define stdout-path property for exynos5250-snow
      ARM: dts: Define stdout-path property for exynos5250-spring

Jonathan Richardson (1):
      ARM: dts: Enable Broadcom Cygnus BCM958305K

Josh Wu (7):
      ARM: at91: at91sam9x5/dts: add ISI dt support, include isi node, pinctrls
      ARM: at91: at91sam9x5ek/dts: add ov2640 support
      ARM: at91: at91sam9g25ek/dts: enable ISI and ov2640
      ARM: at91/dt: sama5d4ek: add leds in DT node
      ARM: at91/dt: sama5d4: add #{address, size}_cells properties for macb0
      ARM: at91/dt: sama5d4: add dts for sama5d4 xplained board
      ARM: at91/dt: sama5d4: add ISI dt support

Kazuya Mizuguchi (2):
      ARM: shmobile: r8a7790: Fix HSUSB clock to hp_clk from mp_clk
      ARM: shmobile: r8a7791: Fix HSUSB clock to hp_clk from mp_clk

Kenneth Westfield (1):
      arm: dts: qcom: Add LPASS Audio HW to IPQ8064 device tree

Kumar Gala (2):
      arm: qcom: dts: gic: add compatible string for Qualcomm MSM GICs
      arm: dts: qcom: Add LCC nodes

Kuninori Morimoto (8):
      ARM: shmobile: r8a7790: tidyup SDHI register size on DTSI
      ARM: shmobile: r8a7791: tidyup SDHI register size on DTSI
      ARM: shmobile: r8a7790: add reg-names for sound
      ARM: shmobile: r8a7791: add reg-names for sound
      ARM: shmobile: r8a7790: enable Audio DMAC peri peri via sound driver
      ARM: shmobile: r8a7791: enable Audio DMAC peri peri via sound driver
      ARM: shmobile: r8a7790: sound enables Audio DMAC entry on DTSI
      ARM: shmobile: r8a7791: sound enables Audio DMAC entry on DTSI

Laurent Pinchart (16):
      ARM: shmobile: sh73a0 dtsi: Set control-parent for all irqpin nodes
      ARM: shmobile: kzm9g-reference dts: Add st1232 touchscreen node
      ARM: shmobile: r8a7794: Add DMAC devices to DT
      ARM: shmobile: r8a7790: Add IPMMU DT nodes
      ARM: shmobile: r8a7791: Add IPMMU DT nodes
      ARM: shmobile: r8a7794: Add IPMMU DT nodes
      ARM: shmobile: r8a7794: Add ethernet controller to device tree
      ARM: shmobile: r8a7794: alt: Enable ethernet controller
      ARM: shmobile: koelsch: Add DU HDMI output support
      ARM: shmobile: r8a7790: Reference DMA channels in SDHI DT nodes
      ARM: shmobile: r8a7791: Reference DMA channels in SDHI DT nodes
      ARM: shmobile: lager: Add DU HDMI output support
      ARM: shmobile: marzen: Add DU external pixel clock to DT
      ARM: shmobile: koelsch: Add DU external pixel clocks to DT
      ARM: shmobile: lager: Add DU external pixel clocks to DT
      ARM: shmobile: r8a7794: alt: Fix ethernet controller PHY IRQ line

Leilei Zhao (1):
      ARM: at91/dt: sama5d4: add aes, sha and tdes nodes

Lina Iyer (8):
      devicetree: bindings: Update qcom,saw2 node bindings
      devicetree: bindings: Document qcom,idle-states
      ARM: dts: qcom: Add power-controller device node for 8074 Krait CPUs
      ARM: dts: qcom: Add power-controller device node for 8084 Krait CPUs
      ARM: dts: qcom: Update power-controller device node for 8064 Krait CPUs
      ARM: dts: qcom: Add idle states device nodes for 8974/8074
      ARM: dts: qcom: Add idle states device nodes for 8084
      ARM: dts: qcom: Add idle state device nodes for 8064

Lucas Stach (1):
      ARM: tegra: Use generated pinmux for Beaver board

Luciano Coelho (2):
      wlcore: set irq_trigger in board files instead of hiding behind a quirk
      wl12xx: use frequency instead of enumerations for pdata clocks

Marek Belisko (2):
      ARM: dts: omap3: Remove all references to ti,codec property
      Documentation: omap-twl4030: Move ti,codec property to optional

Marek Szyprowski (2):
      ARM: dts: add eMMC reset line for exynos4412-odroid-common
      ARM: dts: add eMMC reset line for exynos5422-odroidxu3

Mark Jackson (1):
      ARM: dts: Update Nanobone dts file

Matt Porter (1):
      Documentation: DT: omap_serial: document missing properties and add an example

Matthias Brugger (1):
      ARM: DTS: Add watchdog to mt6589

Maxime Ripard (4):
      ARM: mvebu: Fix MPIC unit address
      ARM: mvebu: a385-db-ap: Enable the NAND
      ARM: mvebu: Enable Performance Monitor Unit on Armada XP/370 SoCs
      ARM: mvebu: armada-385-ap: Enable USB3 port

Mikko Perttunen (2):
      ARM: tegra: Add EMC to Tegra124 device tree
      ARM: tegra: Add EMC timings to Jetson TK1 device tree

Nadav Haklai (1):
      ARM: mvebu: clk: remove cpuclk resources overlapping coredivclk registers on Armada XP

Nicolas Ferre (10):
      Merge tag 'at91-fixes' into at91-4.1-dt
      ARM: at91/dt/trivial: correct file headers for SAMA5D3 SoC peripherals
      ARM: at91/dt: gpio-keys: address-cells and size-cells properties are not needed
      ARM: at91/dt: sama5d4 xplained: add i2c0
      ARM: at91/dt: at91sam9x5cm: enable RTC
      ARM: at91/dt: at91sam9n12ek: enable RTC
      ARM: at91/dt: sama5d3: add uart0
      ARM: at91/dt: sama5d3: add uart1 pinctrl definition
      ARM: at91/dt: sama5d4: fix LCD pins for RGB666 format
      ARM: at91/dt: sama5d4: add rgb777 LCD line configuration

Niklas S?derlund (2):
      ARM: shmobile: emev2 dtsi: Add PFC information
      ARM: shmobile: emev2-kzm9d dts: Add PFC information for uart1

Olof Johansson (13):
      ARM: dts: fix typo in makefile for alpine-db
      Merge tag 'v4.1-rockchip-dts1' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'renesas-dt3-for-v4.1' of git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'v4.1-dt' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'mvebu-dt-4.1-2' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'at91-dt2' of git://git.kernel.org/.../nferre/linux-at91 into next/dt
      Merge tag 'arm-soc/for-4.1/devicetree-part-3' of http://github.com/broadcom/stblinux into next/dt
      ARM: dts: fix typo in bcm7445.dtsi
      Merge tag 'omap-for-v4.1/wl12xx-dt' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'tegra-for-4.1-dt' of git://git.kernel.org/.../tegra/linux into next/dt
      Merge tag 'v4.0-next-dts' of https://github.com/mbgg/linux-mediatek into next/dt
      Merge tag 'mvebu-dt-4.1-3' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'samsung-dt' of git://git.kernel.org/.../kgene/linux-samsung into next/dt

Pali Roh?r (4):
      ARM: dts: n9/n950: Enable omap crypto support
      ARM: dts: n900: Enable omap sham and include directly omap34xx.dtsi
      ARM: dts: omap3-tao3530: Include directly omap34xx.dtsi
      ARM: dts: Remove files omap34xx-hs.dtsi and omap36xx-hs.dtsi

Peter Ujfalusi (2):
      ARM: dts: dra7xx-clocks: Add gate clock for CLKOUT2
      ARM: dts: am57xx-beagle-x15: Do not include the atl header

Philip Attfield (1):
      ARM: at91/dt: add i2c1 declaration to sama5d4

Rafa? Mi?ecki (2):
      ARM: BCM5301X: Add DT for Netgear R8000
      ARM: BCM5301X: Fix default state of power LEDs on Netgear R6250

Ray Jui (4):
      ARM: dts: enable IOMUX for Broadcom Cygnus
      ARM: dts: enable GPIO for Broadcom Cygnus
      ARM: dts: cygnus: enable GPIO based hook detection
      ARM: dts: enable PCIe support for Cygnus

Roger Quadros (2):
      ARM: dts: omap3-beagle: Add NAND device
      ARM: dts: dra7x-evm: beagle-x15: Fix USB Peripheral

Rostislav Lisovy (3):
      ARM: dts: Add vendor prefix for Grinn
      ARM: dts: am335x: Add DTS for ChiliSOM module
      ARM: dts: am335x: Add Chiliboard DTS

Ryo Kataoka (1):
      ARM: shmobile: r8a7791: Fix IPMMU-GP clock to device tree

Sakari Ailus (3):
      Documentation: DT: Add bindings for omap3isp
      ARM: dts: omap3: Add DT entries for OMAP 3 ISP
      ARM: dts: n950, n9: Add primary camera support

Sascha Hauer (1):
      dt-bindings: ARM: Mediatek: document binding for the PMIC wrapper

Sebastian Hesselbarth (4):
      ARM: dts: dove: Fix uart[23] reg property
      ARM: dts: dove: Always include gpio and interrupt-controller headers
      ARM: dts: dove: Add node labels for PCIe ports 0 and 1
      ARM: dts: dove: Add some more common pinctrl settings

Sergei Shtylyov (8):
      ARM: shmobile: r8a7790: add CAN clocks
      ARM: shmobile: r8a7790: add CAN DT support
      ARM: shmobile: r8a7791: add CAN clocks
      ARM: shmobile: r8a7791: add CAN DT support
      ARM: shmobile: henninger: add CAN0 DT support
      ARM: shmobile: r8a7791: add ADSP clocks
      ARM: shmobile: r8a7790: add ADSP clocks
      ARM: shmobile: r8a7794: add SDHI DT support

Seungwon Jeon (1):
      ARM: dts: Add HS400 support for exynos5420 and exynos5800

Simon Guinot (2):
      ARM: Kirkwood: enable GPIO fan alarm support for 2Big Network v2
      ARM: Kirkwood: add DT description for nas2big

Simon Horman (2):
      ARM: shmobile: r8a7794: Correct SDHI clock base address, labels and output-names
      ARM: shmobile: r8a7791: Correct SDHI clock labels and output-names

Stephen Warren (1):
      ARM: tegra: Import latest Jetson TK1 pinmux

Suman Anna (1):
      ARM: dts: DRA7: Remove ti,timer-dsp and ti,timer-pwm properties

Thomas Petazzoni (9):
      ARM: mvebu: fix usb@ unit address on Armada 38x to match register address
      ARM: mvebu: add missing UART labels on Armada 38x
      ARM: mvebu: add UART labels to Armada 375
      ARM: mvebu: remove aliases for Ethernet devices on Armada 370/375/38x/XP
      ARM: mvebu: add serial port aliases on Armada 370/375/38x/XP
      ARM: mvebu: use stdout-path in all armada-*.dts
      ARM: mvebu: fix unit address of MPIC nodes
      ARM: mvebu: add Device Tree files for Armada 39x SoC and board
      ARM: mvebu: use 0xf1000000 as internal registers on Armada 370 DB

Tomeu Vizoso (13):
      ARM: tegra: Change model of sound card in Nyan Big
      ARM: tegra: Move generic parts out of the nyan-big DT
      ARM: tegra: Add DTS for the nyan-blaze board
      ARM: tegra: Add node for trackpad in Nyan boards
      ARM: tegra: Use pwrseq-simple for the wifi in Nyan
      ARM: tegra: Use generated pinmux data for Nyan Big
      ARM: tegra: nyan: Set maximum frequency for SPI flash
      ARM: tegra: nyan: Add gpio-restart node
      ARM: tegra: nyan: The WiFi card is kept powered during suspend
      of: Add binding for NVIDIA Tegra ACTMON node
      ARM: tegra: Add Tegra124 ACTMON support
      ARM: tegra: Add EMC timings to Nyan Big device tree
      ARM: tegra: Add EMC timings to Nyan Blaze device tree

Tony Lindgren (3):
      ARM: dts: Fix typo for dm816x usb0_pins
      ARM: dts: Add cppi41 support for dm816x MUSB
      ARM: dts: Remove PIN_INPUT for dm816x McSPI

Tsahee Zidenberg (2):
      ARM: dts: Alpine platform devicetree
      ARM: dts: alpine: add internal pci

Tushar Behera (1):
      ARM: dts: Add mclk entry for Peach boards

Ulrich Hecht (2):
      ARM: shmobile: r8a7740 dtsi: add remaining DIV6 clocks
      ARM: shmobile: sh73a0 dtsi: Add selectable sources to DIV6 clocks

Vignesh R (1):
      ARM: dts: AM4372: update hdq compatible property

Wenyou Yang (1):
      ARM: at91/dt: at91-sama5d3_xplained: add gpio-key pinctrl property

Wolfram Sang (2):
      ARM: shmobile: r8a7790: smp: remap whole apmu region
      ARM: shmobile: r8a7791: smp: remap whole apmu region

Yunzhi Li (2):
      ARM: dts: rockchip: add rk3288 usb PHY
      ARM: dts: rockchip: Enable usb PHY on rk3288-evb board


 .../bindings/arm/exynos/power_domain.txt        |    3 +
 Documentation/devicetree/bindings/arm/gic.txt   |    2 +
 .../bindings/arm/marvell,kirkwood.txt           |    1 +
 .../bindings/arm/msm/qcom,idle-state.txt        |   84 +
 .../devicetree/bindings/arm/msm/qcom,saw2.txt   |   40 +-
 .../devicetree/bindings/arm/rockchip.txt        |    4 +
 .../arm/tegra/nvidia,tegra30-actmon.txt         |   32 +
 .../devicetree/bindings/media/ti,omap3isp.txt   |   71 +
 .../devicetree/bindings/mfd/qcom,tcsr.txt       |   22 +
 .../bindings/net/wireless/ti,wlcore.txt         |   47 +
 .../devicetree/bindings/serial/omap_serial.txt  |   20 +
 .../devicetree/bindings/soc/mediatek/pwrap.txt  |   58 +
 .../devicetree/bindings/sound/omap-twl4030.txt  |    3 +-
 .../devicetree/bindings/vendor-prefixes.txt     |    1 +
 .../devicetree/bindings/video/atmel,lcdc.txt    |   12 +-
 MAINTAINERS                                     |    1 +
 arch/arm/boot/dts/Makefile                      |   21 +-
 arch/arm/boot/dts/alpine-db.dts                 |   35 +
 arch/arm/boot/dts/alpine.dtsi                   |  160 ++
 arch/arm/boot/dts/am335x-chiliboard.dts         |  112 +
 arch/arm/boot/dts/am335x-chilisom.dtsi          |  239 ++
 arch/arm/boot/dts/am335x-evmsk.dts              |   11 +
 arch/arm/boot/dts/am335x-nano.dts               |   18 +-
 arch/arm/boot/dts/am4372.dtsi                   |    2 +-
 arch/arm/boot/dts/am437x-idk-evm.dts            |   22 +
 arch/arm/boot/dts/am57xx-beagle-x15.dts         |    9 +-
 arch/arm/boot/dts/armada-370-db.dts             |   13 +-
 arch/arm/boot/dts/armada-370-mirabox.dts        |    2 +-
 arch/arm/boot/dts/armada-370-netgear-rn102.dts  |    2 +-
 arch/arm/boot/dts/armada-370-netgear-rn104.dts  |    2 +-
 arch/arm/boot/dts/armada-370-rd.dts             |    2 +-
 .../arm/boot/dts/armada-370-synology-ds213j.dts |    3 +-
 arch/arm/boot/dts/armada-370-xp.dtsi            |   11 +-
 arch/arm/boot/dts/armada-370.dtsi               |    3 +-
 arch/arm/boot/dts/armada-375-db.dts             |    2 +-
 arch/arm/boot/dts/armada-375.dtsi               |   15 +-
 arch/arm/boot/dts/armada-385-db-ap.dts          |   44 +-
 arch/arm/boot/dts/armada-388-db.dts             |    4 +-
 arch/arm/boot/dts/armada-388-gp.dts             |    5 +-
 arch/arm/boot/dts/armada-388-rd.dts             |   12 +-
 arch/arm/boot/dts/armada-38x.dtsi               |   23 +-
 arch/arm/boot/dts/armada-390.dtsi               |   57 +
 arch/arm/boot/dts/armada-398-db.dts             |  153 ++
 arch/arm/boot/dts/armada-398.dtsi               |   60 +
 arch/arm/boot/dts/armada-39x.dtsi               |  508 ++++
 arch/arm/boot/dts/armada-xp-axpwifiap.dts       |    2 +-
 arch/arm/boot/dts/armada-xp-db.dts              |    2 +-
 arch/arm/boot/dts/armada-xp-gp.dts              |    2 +-
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts |    3 +-
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts   |  393 +++
 arch/arm/boot/dts/armada-xp-matrix.dts          |    2 +-
 arch/arm/boot/dts/armada-xp-mv78260.dtsi        |    1 -
 arch/arm/boot/dts/armada-xp-mv78460.dtsi        |    1 -
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts  |    2 +-
 .../arm/boot/dts/armada-xp-openblocks-ax3-4.dts |    2 +-
 arch/arm/boot/dts/armada-xp-synology-ds414.dts  |    3 +-
 arch/arm/boot/dts/armada-xp.dtsi                |    8 +-
 arch/arm/boot/dts/at91-sama5d3_xplained.dts     |    8 +
 arch/arm/boot/dts/at91-sama5d4_xplained.dts     |  241 ++
 arch/arm/boot/dts/at91-sama5d4ek.dts            |   55 +-
 arch/arm/boot/dts/at91sam9g25.dtsi              |    1 +
 arch/arm/boot/dts/at91sam9g25ek.dts             |   18 +
 arch/arm/boot/dts/at91sam9n12.dtsi              |    9 +
 arch/arm/boot/dts/at91sam9n12ek.dts             |   18 +
 arch/arm/boot/dts/at91sam9x5_isi.dtsi           |   46 +
 arch/arm/boot/dts/at91sam9x5cm.dtsi             |    4 +
 arch/arm/boot/dts/at91sam9x5ek.dtsi             |   48 +
 arch/arm/boot/dts/bcm-cygnus.dtsi               |   78 +
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts     |    4 +-
 arch/arm/boot/dts/bcm4709-netgear-r8000.dts     |   77 +
 arch/arm/boot/dts/bcm7445.dtsi                  |   14 +-
 arch/arm/boot/dts/bcm911360_entphn.dts          |   13 +
 arch/arm/boot/dts/bcm958300k.dts                |    8 +
 arch/arm/boot/dts/bcm958305k.dts                |   53 +
 arch/arm/boot/dts/dm8168-evm.dts                |   14 +-
 arch/arm/boot/dts/dm816x.dtsi                   |   60 +
 arch/arm/boot/dts/dove.dtsi                     |   63 +-
 arch/arm/boot/dts/dra7-evm.dts                  |    8 +
 arch/arm/boot/dts/dra7.dtsi                     |    7 -
 arch/arm/boot/dts/dra72-evm.dts                 |    8 +
 arch/arm/boot/dts/dra7xx-clocks.dtsi            |    8 +
 arch/arm/boot/dts/emev2-kzm9d.dts               |   13 +
 arch/arm/boot/dts/emev2.dtsi                    |   10 +
 arch/arm/boot/dts/exynos3250.dtsi               |    4 +
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |   14 +
 arch/arm/boot/dts/exynos5250-snow.dts           |   57 +-
 arch/arm/boot/dts/exynos5250-spring.dts         |    1 +
 arch/arm/boot/dts/exynos5250.dtsi               |    2 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts   |    4 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts      |   99 +-
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi       |    7 +
 arch/arm/boot/dts/exynos5420-smdk5420.dts       |    7 +-
 arch/arm/boot/dts/exynos5420.dtsi               |   10 +-
 arch/arm/boot/dts/exynos5422-odroidxu3.dts      |   21 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts       |   71 +-
 arch/arm/boot/dts/kirkwood-nas2big.dts          |  143 ++
 arch/arm/boot/dts/kirkwood-net2big.dts          |    5 +
 arch/arm/boot/dts/meson.dtsi                    |   20 +
 arch/arm/boot/dts/meson6-atv1200.dts            |    4 +
 arch/arm/boot/dts/meson8-minix-neo-x8.dts       |  128 +
 arch/arm/boot/dts/meson8.dtsi                   |   68 +
 arch/arm/boot/dts/mt6589.dtsi                   |    5 +
 arch/arm/boot/dts/nspire-classic.dtsi           |    5 +
 arch/arm/boot/dts/nspire-cx.dts                 |    4 +
 arch/arm/boot/dts/nspire.dtsi                   |   21 +
 arch/arm/boot/dts/omap3-beagle-xm.dts           |    1 -
 arch/arm/boot/dts/omap3-beagle.dts              |   53 +-
 arch/arm/boot/dts/omap3-cm-t3517.dts            |   10 +
 arch/arm/boot/dts/omap3-cm-t3730.dts            |   10 +
 arch/arm/boot/dts/omap3-cm-t3x30.dtsi           |    1 -
 arch/arm/boot/dts/omap3-devkit8000.dts          |    1 -
 arch/arm/boot/dts/omap3-evm-common.dtsi         |   10 +
 arch/arm/boot/dts/omap3-gta04.dtsi              |    1 -
 arch/arm/boot/dts/omap3-igep.dtsi               |    1 -
 arch/arm/boot/dts/omap3-igep0020-rev-f.dts      |    9 +
 arch/arm/boot/dts/omap3-igep0030-rev-g.dts      |    9 +
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi         |    1 -
 arch/arm/boot/dts/omap3-n9.dts                  |   37 +
 arch/arm/boot/dts/omap3-n900.dts                |   16 +-
 arch/arm/boot/dts/omap3-n950-n9.dtsi            |    2 +-
 arch/arm/boot/dts/omap3-n950.dts                |   37 +
 arch/arm/boot/dts/omap3-overo-base.dtsi         |    1 -
 arch/arm/boot/dts/omap3-pandora-1ghz.dts        |   70 +
 arch/arm/boot/dts/omap3-pandora-600mhz.dts      |   65 +
 arch/arm/boot/dts/omap3-pandora-common.dtsi     |  640 +++++
 arch/arm/boot/dts/omap3-tao3530.dtsi            |   12 +-
 arch/arm/boot/dts/omap3-zoom3.dts               |   10 +
 arch/arm/boot/dts/omap34xx-hs.dtsi              |   16 -
 arch/arm/boot/dts/omap34xx.dtsi                 |   17 +
 arch/arm/boot/dts/omap36xx-hs.dtsi              |   16 -
 arch/arm/boot/dts/omap36xx.dtsi                 |   17 +
 arch/arm/boot/dts/omap4-panda-common.dtsi       |   10 +
 arch/arm/boot/dts/omap4-sdp.dts                 |   11 +
 arch/arm/boot/dts/omap4-var-som-om44-wlan.dtsi  |   10 +
 arch/arm/boot/dts/qcom-apq8064.dtsi             |   51 +-
 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts  |    2 +
 arch/arm/boot/dts/qcom-apq8084-ifc6540.dts      |    1 +
 arch/arm/boot/dts/qcom-apq8084-mtp.dts          |    1 +
 arch/arm/boot/dts/qcom-apq8084.dtsi             |   56 +-
 arch/arm/boot/dts/qcom-ipq8064.dtsi             |   38 +
 arch/arm/boot/dts/qcom-msm8660.dtsi             |    8 +
 arch/arm/boot/dts/qcom-msm8960.dtsi             |   15 +
 .../dts/qcom-msm8974-sony-xperia-honami.dts     |    2 +
 arch/arm/boot/dts/qcom-msm8974.dtsi             |   56 +-
 arch/arm/boot/dts/qcom-pm8841.dtsi              |   18 +
 arch/arm/boot/dts/qcom-pm8941.dtsi              |   18 +
 arch/arm/boot/dts/qcom-pma8084.dtsi             |   18 +
 arch/arm/boot/dts/r8a73a4-ape6evm.dts           |   22 +-
 arch/arm/boot/dts/r8a7740.dtsi                  |   79 +-
 arch/arm/boot/dts/r8a7779-marzen.dts            |    9 +
 arch/arm/boot/dts/r8a7790-lager.dts             |   69 +
 arch/arm/boot/dts/r8a7790.dtsi                  |  259 +-
 arch/arm/boot/dts/r8a7791-henninger.dts         |   11 +
 arch/arm/boot/dts/r8a7791-koelsch.dts           |   69 +-
 arch/arm/boot/dts/r8a7791.dtsi                  |  278 +-
 arch/arm/boot/dts/r8a7794-alt.dts               |   13 +
 arch/arm/boot/dts/r8a7794.dtsi                  |  157 +-
 arch/arm/boot/dts/rk3188-radxarock.dts          |   16 +
 arch/arm/boot/dts/rk3288-evb-act8846.dts        |   10 +
 arch/arm/boot/dts/rk3288-evb-rk808.dts          |    7 +
 arch/arm/boot/dts/rk3288-evb.dtsi               |   13 +
 arch/arm/boot/dts/rk3288-firefly.dtsi           |   20 +
 arch/arm/boot/dts/rk3288-popmetal.dts           |  447 ++++
 arch/arm/boot/dts/rk3288.dtsi                   |   35 +
 arch/arm/boot/dts/sama5d3.dtsi                  |   34 +
 arch/arm/boot/dts/sama5d35ek.dts                |    2 -
 arch/arm/boot/dts/sama5d3_can.dtsi              |    2 +-
 arch/arm/boot/dts/sama5d3_emac.dtsi             |    2 +-
 arch/arm/boot/dts/sama5d3_gmac.dtsi             |    2 +-
 arch/arm/boot/dts/sama5d3_lcd.dtsi              |  207 +-
 arch/arm/boot/dts/sama5d3_mci2.dtsi             |    2 +-
 arch/arm/boot/dts/sama5d3_tcb1.dtsi             |    2 +-
 arch/arm/boot/dts/sama5d3_uart.dtsi             |    2 +-
 arch/arm/boot/dts/sama5d4.dtsi                  |  342 +++
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts    |   42 +-
 arch/arm/boot/dts/sh73a0-kzm9g.dts              |    2 +-
 arch/arm/boot/dts/sh73a0.dtsi                   |   82 +-
 arch/arm/boot/dts/tegra124-jetson-tk1-emc.dtsi  | 2421 ++++++++++++++++++
 arch/arm/boot/dts/tegra124-jetson-tk1.dts       |  559 ++--
 arch/arm/boot/dts/tegra124-nyan-big-emc.dtsi    | 2023 +++++++++++++++
 arch/arm/boot/dts/tegra124-nyan-big.dts         | 2121 ++++++++-------
 arch/arm/boot/dts/tegra124-nyan-blaze-emc.dtsi  | 2049 +++++++++++++++
 arch/arm/boot/dts/tegra124-nyan-blaze.dts       | 1334 ++++++++++
 arch/arm/boot/dts/tegra124-nyan.dtsi            |  695 +++++
 arch/arm/boot/dts/tegra124.dtsi                 |   19 +
 arch/arm/boot/dts/tegra30-beaver.dts            | 1653 +++++++++++-
 arch/arm/mach-davinci/Kconfig                   |   11 -
 arch/arm/mach-davinci/board-da850-evm.c         |  112 -
 arch/arm/mach-omap2/pdata-quirks.c              |   74 -
 arch/arm/mach-shmobile/smp-r8a7790.c            |    4 +-
 arch/arm/mach-shmobile/smp-r8a7791.c            |    2 +-
 drivers/net/wireless/ti/wilink_platform_data.c  |   25 -
 drivers/net/wireless/ti/wl12xx/main.c           |   63 +-
 drivers/net/wireless/ti/wl12xx/wl12xx.h         |   28 +
 drivers/net/wireless/ti/wlcore/boot.c           |    1 -
 drivers/net/wireless/ti/wlcore/debugfs.c        |    2 +-
 drivers/net/wireless/ti/wlcore/main.c           |   31 +-
 drivers/net/wireless/ti/wlcore/sdio.c           |   63 +-
 drivers/net/wireless/ti/wlcore/spi.c            |    6 +-
 drivers/net/wireless/ti/wlcore/wlcore.h         |    5 +-
 drivers/net/wireless/ti/wlcore/wlcore_i.h       |    6 +-
 include/dt-bindings/clock/r8a7790-clock.h       |    3 +
 include/dt-bindings/clock/r8a7791-clock.h       |    3 +
 include/dt-bindings/clock/sh73a0-clock.h        |    3 +
 include/dt-bindings/media/omap3-isp.h           |   22 +
 include/linux/wl12xx.h                          |   49 -
 206 files changed, 19014 insertions(+), 1946 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-actmon.txt
 create mode 100644 Documentation/devicetree/bindings/media/ti,omap3isp.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/qcom,tcsr.txt
 create mode 100644 Documentation/devicetree/bindings/net/wireless/ti,wlcore.txt
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
 create mode 100644 arch/arm/boot/dts/alpine-db.dts
 create mode 100644 arch/arm/boot/dts/alpine.dtsi
 create mode 100644 arch/arm/boot/dts/am335x-chiliboard.dts
 create mode 100644 arch/arm/boot/dts/am335x-chilisom.dtsi
 create mode 100644 arch/arm/boot/dts/armada-390.dtsi
 create mode 100644 arch/arm/boot/dts/armada-398-db.dts
 create mode 100644 arch/arm/boot/dts/armada-398.dtsi
 create mode 100644 arch/arm/boot/dts/armada-39x.dtsi
 create mode 100644 arch/arm/boot/dts/armada-xp-linksys-mamba.dts
 create mode 100644 arch/arm/boot/dts/at91-sama5d4_xplained.dts
 create mode 100644 arch/arm/boot/dts/bcm4709-netgear-r8000.dts
 create mode 100644 arch/arm/boot/dts/bcm958305k.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-nas2big.dts
 create mode 100644 arch/arm/boot/dts/meson8-minix-neo-x8.dts
 create mode 100644 arch/arm/boot/dts/omap3-pandora-1ghz.dts
 create mode 100644 arch/arm/boot/dts/omap3-pandora-600mhz.dts
 create mode 100644 arch/arm/boot/dts/omap3-pandora-common.dtsi
 delete mode 100644 arch/arm/boot/dts/omap34xx-hs.dtsi
 delete mode 100644 arch/arm/boot/dts/omap36xx-hs.dtsi
 create mode 100644 arch/arm/boot/dts/qcom-pm8841.dtsi
 create mode 100644 arch/arm/boot/dts/qcom-pm8941.dtsi
 create mode 100644 arch/arm/boot/dts/qcom-pma8084.dtsi
 create mode 100644 arch/arm/boot/dts/rk3288-popmetal.dts
 create mode 100644 arch/arm/boot/dts/tegra124-jetson-tk1-emc.dtsi
 create mode 100644 arch/arm/boot/dts/tegra124-nyan-big-emc.dtsi
 create mode 100644 arch/arm/boot/dts/tegra124-nyan-blaze-emc.dtsi
 create mode 100644 arch/arm/boot/dts/tegra124-nyan-blaze.dts
 create mode 100644 arch/arm/boot/dts/tegra124-nyan.dtsi
 create mode 100644 include/dt-bindings/media/omap3-isp.h
