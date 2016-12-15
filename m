From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Dec 2016 00:07:59 +0100
Subject: [GIT PULL 5/7] ARM: DT updates for v4.10
In-Reply-To: <2664636.Hf0nvRznEK@wuerfel>
References: <2664636.Hf0nvRznEK@wuerfel>
Message-ID: <2609617.qBv0NtFQyQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit e5cd7ff7058dc6f2133455636809a09b691ee419:

  ARM: gr8: Rename the DTSI and relevant DTS (2016-11-22 15:06:04 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt

for you to fetch changes up to 8237c0b9570c09d513296ef0fde26ce0784e5179:

  Merge tag 'zynq-dt-for-4.10' of https://github.com/Xilinx/linux-xlnx into next/dt (2016-12-07 12:38:43 -0800)

----------------------------------------------------------------
ARM: DT updates for v4.10

Lots of changes as usual, so I'm trying to be brief here. Most of the
new hardware support has the respective driver changes merged through
other trees or has had it available for a while, so this is where things
come together.

We get a DT descriptions for a couple of new SoCs, all of them variants
of other chips we already support, and usually coming with a new
evaluation board:

- Oxford semiconductor (now Broadcom) OX820 SoC for NAS devices
- Qualcomm MDM9615 LTE baseband
- NXP imx6ull, the latest and smallest i.MX6 application processor variant
- Renesas RZ/G (r8a7743 and r8a7745) application processors
- Rockchip PX3, a variant of the rk3188 chip used in Android tablets
- Rockchip rk1108 single-core application processor
- ST stm32f746 Cortex-M7 based microcontroller
- TI DRA71x automotive processors

These are commercially available consumer platforms we now support:
- Motorola Droid 4 (xt894) mobile phone
- Rikomagic MK808 Android TV stick based on Rockchips rx3066
- Cloud Engines PogoPlug v3 based on OX820
- Various Broadcom based wireless devices:
  - Netgear R8500 router
  - Tenda AC9 router
  - TP-LINK Archer C9 V1
  - Luxul XAP-1510 Access point
- Turris Omnia open hardware router based on Armada 385

And a couple of new boards targeted at developers, makers
or industrial integration:
- Macnica Sodia development platform for Altera socfpga (Cyclone V)
- MicroZed board based on Xilinx Zynq FPGA platforms
- TOPEET itop/elite based on exynos4412
- WP8548 MangOH Open Hardware platform for IOT, based on
  Qualcomm MDM9615
- NextThing CHIP Pro gadget
- NanoPi M1 development board
- AM571x-IDK industrial board based on TI AM5718
- i.MX6SX UDOO Neo
- Boundary Devices Nitrogen6_SOM2 (i.MX6)
- Engicam i.CoreM6
- Grinn i.MX6UL liteSOM/liteBoard
- Toradex Colibri iMX6 module

Other changes:
- added peripherals on renesas, davinci, stm32f429, uniphier, sti,
  mediatek, integrator, at91, imx, vybrid, ls1021a, omap, qualcomm,
  mvebu, allwinner, broadcom, exynos, zynq

- Continued fixes for W=1 dtc warnings

- The old STiH415/416 SoC support gets removed, these never made it into
  products and have served their purpose in the kernel as a template
  for teh newer chips from ST

- The exynos4415 dtsi file is removed as nothing uses it.

- Intel PXA25x can now be booted using devicetree

Conflicts:
arch/arm/boot/dts/r8a*.dtsi: a node was added
the clk tree, keep both sides and watch out for git
dropping the required '};' at the end of each side.

----------------------------------------------------------------
Alexandre Bailon (2):
      ARM: dts: da850: Add the usb otg device node
      ARM: dts: da850-lcdk: Enable the usb otg device node

Alexandre Belloni (4):
      ARM: dts: at91: sama5d4: use proper sckc compatible
      ARM: dts: at91: sama5d2: use correct sckc compatible
      ARM: dts: at91: sama5d2: Add secumod node
      ARM: dts: at91: sama5d2: Add securam node

Alexandre TORGUE (6):
      ARM: DT: STM32: add dma for usart3 on F429
      ARM: DT: stm32: move dma translation to board files
      ARM: dts: stm32f429: Align Ethernet node with new bindings properties
      ARM: dts: stm32f429: Fix Ethernet node on Eval Board
      ARM: dts: stm32f429: remove Ethernet wake on Lan support
      ARM: dts: Add STM32F746 MCU and STM32746g-EVAL board

Andreas F?rber (1):
      ARM: dts: imx6sx: Add UDOO Neo support

Andrew F. Davis (7):
      ARM: dts: am335x-icev2: Add Industrial input support
      ARM: dts: am335x-icev2: Disable Industrial I/O LEDs and fix naming
      ARM: dts: am335x-icev2: Add ADC support
      ARM: dts: am437x-idk: Add Industrial input support
      ARM: dts: am437x-idk: Add Industrial output support
      ARM: dts: am57xx-idk: Add Industrial input support
      ARM: dts: am57xx-idk: Add Industrial output support

Andrey Smirnov (2):
      ARM: dts: vf610-zii-dev-rev-b: Remove I2C3
      ARM: dts: vfxxx: Add node corresponding to OCOTP

Andy Gross (1):
      Merge tag 'qcom-dts-for-4.10-1' into dts-for-4.10-2

Andy Yan (5):
      ARM: dts: rockchip: add rockchip PX3 Evaluation board
      include: dt-bindings: Add GPIO pin index definition for rockchip pinctrl
      ARM: dts: rockchip: use pin constants to describe gpios on Popmetal-RK3288
      ARM: dts: rockchip: add basic support for RK1108 SOC
      ARM: dts: rockchip: add rockchip RK1108 Evaluation board

Antoine Tenart (1):
      ARM: sun5i: chip: add a node for the w1 gpio controller

Archit Taneja (2):
      arm: dts: qcom: apq8064: Add display DT nodes
      arm: dts: qcom: apq8064-ifc6410: Add HDMI support

Arnaud Pouliquen (7):
      ARM: dts: STiH407-family: sti sound card field cleaning
      ARM: dts: STiH407: Add label for sti-hdmi node
      ARM: dts: STiH410: Add label for sti-hdmi node
      ARM: dts: STiHxxx-b2120: Add support of HDMI audio
      ARM: dts: STiH410-B2260: clean unnecessary hdmi node overlay
      ARM: dts: STiH410-B2260: enable sound card
      ARM: dts: STiHxxx-b2120: change sound card name

Arnd Bergmann (17):
      Merge tag 'oxnas-arm-soc-dt-for-4.10' of https://github.com/OXNAS/linux into next/dt
      Merge tag 'pxa-dt-4.10' of https://github.com/rjarzmik/linux into next/dt
      Merge tag 'qcom-dts-for-4.10-1' of git://git.kernel.org/.../agross/linux into next/dt
      Merge tag 'mvebu-dt-4.10-1' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'sunxi-dt-for-4.10-bis' of https://git.kernel.org/.../mripard/linux into next/dt
      Merge tag 'davinci-for-v4.10/dt-2' of git://git.kernel.org/.../nsekhar/linux-davinci into next/dt
      Merge tag 'davinci-for-v4.10/dt-3' of git://git.kernel.org/.../nsekhar/linux-davinci into next/dt
      Merge tag 'rzg-clock-defs-tag1' of git://git.kernel.org/.../geert/renesas-drivers into next/dt
      Merge tag 'renesas-dt2-for-v4.10' of git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'socfpga_dts_for_v4.10_part_3' of git://git.kernel.org/.../dinguyen/linux into next/dt
      Merge tag 'arm-soc/for-4.10/devicetree' of http://github.com/Broadcom/stblinux into next/dt
      Merge tag 'samsung-dt-4.10-2' of git://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'qcom-dts-for-4.10-2' of git://git.kernel.org/.../agross/linux into next/dt
      Merge tag 'v4.10-rockchip-dts32-2' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'berlin-dt-for-v4.10-1' of git://git.kernel.org/.../jszhang/linux-berlin into next/dt
      Merge tag 'mvebu-dt-4.10-2' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'omap-for-v4.10/dt-late-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/dt

Ashley Hughes (1):
      ARM: dts: orion5x: convert ls-chl to FDT

Axel Haslam (2):
      ARM: dts: da850-lcdk: fix mmc card detect polarity
      ARM: dts: da850: enable high speed for mmc

Bartosz Golaszewski (2):
      ARM: dts: da850: add the mstpri and ddrctl nodes
      ARM: dts: da850: enable memctrl and mstpri nodes per board

Bhushan Shah (1):
      ARM: dts: qcom: msm8974-hammerhead: Add sdhci1 node

Chen-Yu Tsai (13):
      ARM: dts: sun6i: Sort pinmux setting nodes
      ARM: dts: sun6i: Add device nodes for first display pipeline
      ARM: dts: sun6i: Add A31 LCD0 RGB888 pins
      ARM: dts: sun9i: Add mmc1 pinmux setting
      ARM: dts: sun9i: a80-optimus: Enable AP6330 WiFi
      ARM: dts: sun9i: cubieboard4: Enable AP6330 WiFi
      ARM: dts: sun6i: Add audio codec device node
      ARM: dts: sun6i: hummingbird: Enable internal audio codec
      ARM: dts: sun6i: sina31s: Enable internal audio codec
      ARM: dts: sun7i: bananapi-m1-plus: Enable USB PHY for USB host support
      ARM: dts: sun7i: bananapi-m1-plus: Add PMIC regulators
      ARM: dts: sun7i: bananapi-m1-plus: Enable USB OTG
      ARM: dts: sun6i: hummingbird-a31: Enable display output through VGA bridge

Chris Brandt (5):
      ARM: dts: r7s72100: add mmcif clock to device tree
      ARM: dts: r7s72100: add mmcif to device tree
      ARM: dts: r7s72100: add sdhi clock to device tree
      ARM: dts: r7s72100: add sdhi to device tree
      ARM: dts: rskrza1: add sdhi1 DT support

Chris Packham (1):
      ARM: dts: mvebu: Update comment for main PLL frequency

Christopher Spinrath (1):
      ARM: dts: imx6q-utilite-pro: i2c1 is muxed

Cyrille Pitchen (1):
      ARM: dts: at91: sama5d2: enable FIFOs for high-speed i2c controllers

Dan Haab (2):
      ARM: BCM5301X: Add DT for Luxul XAP-1510
      ARM: BCM5301X: Add DT for Luxul XWR-3100

David Lechner (3):
      ARM: dts: da850: Add DMA to SPI0
      ARM: dts: da850: Add cfgchip syscon node
      ARM: dts: da850: Add node for pullup/pulldown pinconf

Dinh Nguyen (7):
      ARM: dts: socfpga: enable arm,shared-override in the pl310
      ARM: dts: socfpga: add specific compatible strings for boards
      ARM: dts: socfpga: enable qspi on the Cyclone5 devkit
      ARM: dts: socfpga: Add QSPI node for the Arria10
      ARM: dts: socfpga: Enable QSPI in Arria10 devkit
      ARM: dts: socfpga: Enable QSPI on the Cyclone5 sockit
      ARM: dts: socfpga: Enable QSPI on the Arria5 devkit

Emmanuel Vadot (1):
      ARM: dts: sunxi: Add cpu-supply for Olimex A20 EVB

Eric Anholt (1):
      ARM: dts: bcm283x: Define standard pinctrl groups in the gpio node.

Erin Lo (1):
      arm: dts: mt2701: Use real clock for UARTs

Fabien Parent (1):
      ARM: dts: da850-lcdk: Add ethernet0 alias to DT

Fabio Estevam (2):
      ARM: dts: imx6sx-udoo: Add board specific compatible strings
      ARM: dts: imx: Remove skeleton.dtsi

Finley Xiao (1):
      ARM: dts: rockchip: update compatible strings for Rockchip efuse

Florian Fainelli (1):
      Merge tag 'bcm2835-dt-next-2016-11-18' into devicetree/next

Frank Li (1):
      ARM: dts: add new compatible string for i.MX6QP mmdc

Gabriel Fernandez (2):
      ARM: dts: stm32f429: add LSI and LSE clocks
      ARM: dts: stm32f429: Add QSPI clock

Gary Bisson (5):
      ARM: dts: imx: add Boundary Devices Nitrogen6_SOM2 support
      ARM: dts: imx6qdl-sabrelite: use hyphens for nodes name
      ARM: dts: imx6qdl-nitrogen6x: use hyphens for nodes name
      ARM: dts: imx6qdl-nit6xlite: use hyphens for nodes name
      ARM: dts: imx6qdl-nitrogen6_max: use hyphens for nodes name

Geert Uytterhoeven (20):
      ARM: dts: STiH407: DT fix s/interrupts-names/interrupt-names/
      ARM: dts: r8a7790: Correct SCIFB reg properties to cover all registers
      ARM: dts: r8a7791: Correct SCIFB reg properties to cover all registers
      ARM: dts: r8a7793: Correct SCIFB reg properties to cover all registers
      ARM: dts: r8a7794: Correct SCIFB reg properties to cover all registers
      ARM: dts: r8a7794: Fix W=1 dtc warnings
      ARM: dts: emev2: Remove skeleton.dtsi inclusion
      ARM: dts: r8a7778: Remove skeleton.dtsi inclusion
      ARM: dts: r8a7779: Remove skeleton.dtsi inclusion
      ARM: dts: r8a7740: Remove skeleton.dtsi inclusion
      ARM: dts: sh73a0: Remove skeleton.dtsi inclusion
      ARM: dts: r8a7794: Correct hsusb parent clock
      ARM: dts: r8a7794: Use SYSC "always-on" PM Domain for sound
      ARM: dts: r8a73a4: Add device node for PRR
      ARM: dts: r8a7779: Add device node for PRR
      ARM: dts: r8a7790: Add device node for PRR
      ARM: dts: r8a7791: Add device node for PRR
      ARM: dts: r8a7792: Add device node for PRR
      ARM: dts: r8a7793: Add device node for PRR
      ARM: dts: r8a7794: Add device node for PRR

Gerald Baeza (1):
      ARM: DT: STM32: add dma for usart1 on F429

Gerd Hoffmann (6):
      pinctrl: bcm2835: add pull defines to dt bindings
      ARM: dts: bcm283x: add pinctrl group to &pwm, drop pins from &gpio
      ARM: dts: bcm283x: add pinctrl group to &i2c0, drop pins from &gpio
      ARM: dts: bcm283x: add pinctrl group to &i2c1, drop pins from &gpio
      ARM: dts: bcm283x: add pinctrl group to &sdhci, drop pins from &gpio
      ARM: dts: bcm283x: drop alt3 from &gpio

Gregory CLEMENT (21):
      ARM: dts: armada-xp-matrix: Fix the location of the pcie-controller node
      ARM: dts: armada-370-xp: move the cpurst node in the common file
      ARM: dts: armada-370-xp: add node labels
      ARM: dts: armada-370-xp: Use the node labels
      ARM: dts: armada-370-xp: Fixup mdio DT warning
      ARM: dts: armada-xp: Fixup pcie DT warnings
      ARM: dts: armada-370: Fixup pcie DT warnings
      ARM: dts: armada-370-xp: Remove skeleton.dtsi
      ARM: dts: armada-370-xp: Fixup l2-cache DT warning
      ARM: dts: armada-370-xp: Fixup memory DT warning
      ARM: dts: armada-370-xp: Remove address from dsa unit name
      ARM: dts: armada-370-xp: Remove button address and fixup names
      ARM: dts: armada-370-xp: Fixup regulator DT warning
      ARM: dts: armada-375: Add node labels
      ARM: dts: armada-375: Use the node labels
      ARM: dts: armada-375: Fixup mdio DT warning
      ARM: dts: armada-375: Fixup pcie DT warnings
      ARM: dts: armada-375: Fixup pinctrl DT warnings
      ARM: dts: armada-375: Remove skeleton.dtsi
      ARM: dts: armada-375: Fixup memory DT warning
      ARM: dts: armada-375: Fixup ethernet child DT warning

H. Nikolaus Schaller (3):
      ARM: dts: omap5 uevm: add EEPROM
      ARM: dts: omap5 uevm: add LEDs
      ARM: dts: omap5 uevm: add USR1 button

Hans Verkuil (1):
      ARM: dts: koelsch: add HDMI input

Hans de Goede (2):
      ARM: dts: sun8i: reference-design-tablet: ldo_io1 is vcc-touchscreen
      ARM: dts: sun5i: Add touchscreen node to reference-design-tablet.dtsi

Heiko Stuebner (3):
      Merge branch 'v4.10-shared/clkids' into v4.10-armsoc/dts32
      Merge branch 'v4.10-shared/pinctrl' into v4.10-armsoc/dts32
      Merge branch 'v4.10-shared/clkids' into v4.10-armsoc/dts32

Hongtao Jia (1):
      ARM: dts: ls1021a: Add TMU device tree support for LS1021A

Jacob Chen (1):
      ARM: dts: rockchip: add the sdmmc pinctrl for rk1108

Jacopo Mondi (1):
      ARM: dts: alt: Fix PFC names for DU

Jaehoon Chung (3):
      ARM: dts: rockchip: replace to "max-frequency" instead of "clock-freq-min-max"
      ARM: dts: exynos: Replace "clock-freq-min-max" with "max-frequency"
      ARM: dts: exynos: Remove the cd-gpios property for eMMC of Odroid XU3/4

Jagan Teki (8):
      ARM: dts: imx6qdl: Fix "WARNING: please, no space before tabs"
      ARM: dts: imx6qdl: Fix "ERROR: code indent should use tabs where possible"
      ARM: dts: imx6qdl-wandboard-revb: Fix "ERROR: trailing whitespace"
      ARM: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual initial support
      ARM: dts: imx6q: Add Engicam i.CoreM6 DualLite/Solo initial support
      ARM: dts: imx6qdl-icore: Add FEC support
      ARM: dts: imx: Fix "ERROR: code indent should use tabs where possible"
      arm: dts: zynq: Add MicroZed board support

James Liao (1):
      arm: dts: mt2701: Add clock controller device nodes

Jaret Cantu (1):
      ARM: dts: imx: b650v3: Calibrate USB PHY to pass eye diagram test

Javier Martinez Canillas (9):
      ARM: dts: rockchip: Remove skeleton.dtsi inclusion in rk3036.dtsi
      ARM: dts: rockchip: Remove skeleton.dtsi inclusion in rk322x.dtsi
      ARM: dts: rockchip: Remove skeleton.dtsi inclusion in rk3288.dtsi
      ARM: dts: rockchip: Remove skeleton.dtsi inclusion in rk3xxx.dtsi
      ARM: dts: rockchip: Add missing unit name to memory nodes in rk3036 boards
      ARM: dts: rockchip: Add missing unit name to memory nodes in rk322x boards
      ARM: dts: rockchip: Add missing unit name to memory nodes in rk3288 boards
      ARM: dts: rockchip: Add missing unit name to memory nodes in rk3xxx boards
      ARM: dts: exynos: Document eMMC/SD/SDIO devices in Snow and Peach boards

Jisheng Zhang (1):
      ARM: dts: berlin2q-marvell-dmp: fix regulators' name

John Stultz (3):
      arm: dts: qcom: apq8064: Add dsi, gpu and iommu nodes
      arm: dts: qcom: apq8064-nexus7: Add DSI and panel nodes
      arm: dts: qcom: apq8064-nexus7: Add pstore support to nexus7

Jonathan Richardson (3):
      ARM: dts: Enable Broadcom iProc mailbox controller
      ARM: dts: Enable interrupt support for cygnus crmu gpio driver
      ARM: dts: Add node for Broadcom OTP controller driver

Joshua Clayton (1):
      ARM: dts: imx6: Add imx-weim parameters to dtsi's

Juri Lelli (1):
      ARM: dts: vexpress: add TC2 cpu capacity-dmips-mhz information

Jyri Sarha (1):
      ARM: dts: am335x-boneblack: Add blue-and-red-wiring -property to LCDC node

Kamal Dasu (1):
      ARM: dts: NSP: Add QSPI nodes to NSPI and bcm958625k DTSes

Karl Beldan (1):
      ARM: dts: da850: add a node for the LCD controller

Keerthy (5):
      ARM: dts: AM335X-bone-common: Add the internal and external clock nodes for rtc
      ARM: dts: AM335X-evm: Add the internal and external clock nodes for rtc
      ARM: dts: AM335X-evmsk: Add the internal and external clock nodes for rtc
      ARM: dts: am57xx-beagle-x15-common: Add overide powerhold property
      ARM: dts: am57xx-idk-common: Add overide powerhold property

Kefeng Wang (3):
      ARM: dts: hip01: Remove skeleton.dtsi inclusion
      ARM: dts: hi3620: Remove skeleton.dtsi inclusion
      ARM: dts: hisi-x5hd2: Remove skeleton.dtsi inclusion

Krzysztof Kozlowski (16):
      ARM: dts: exynos: Remove exynos4415.dtsi
      ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos4
      ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos4210
      ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos4x12
      ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos3250
      ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos5
      ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos5250
      ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos5410/exynos542x
      ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos5260
      ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos5440
      ARM: dts: exynos: Use human-friendly symbols for interrupt properties in exynos3250
      ARM: dts: exynos: Use human-friendly symbols for interrupt properties in exynos4
      ARM: dts: exynos: Use human-friendly symbols for interrupt properties in exynos5
      ARM: dts: exynos: Use human-friendly symbols for interrupt properties in exynos5260
      ARM: dts: exynos: Use human-friendly symbols for interrupt properties in exynos5440
      ARM: dts: exynos: Fix invalid GIC interrupt flags in audio block of Exynos5410

Laurent Pinchart (2):
      ARM: dts: r8a7779: Fix DU reg property
      ARM: dts: r8a7779: marzen: Configure pinmuxing for the DU0 input clock

Linus Walleij (5):
      ARM: bcm2835: Add names for the Raspberry Pi GPIO lines
      ARM: dts: Add Integrator/CP cpus node and operating points
      ARM: dts: Add Integrator/AP cpus node and operating points
      ARM: dts: add EBI2 to the Qualcomm MSM8660 DTSI
      ARM: dts: add SMSC ethernet on the APQ8060 Dragonboard

Lokesh Vutla (3):
      ARM: dts: dra72-evm: Remove pinmux configurations for erratum i869
      ARM: dts: dra72-evm: Fix modelling of regulators
      ARM: dts: dra72: Add separate dtsi for tps65917

Marcel Ziswiler (1):
      ARM: tegra: apalis/colibri t30: Integrate audio

Marcin Niestroj (2):
      ARM: dts: imx6ul: Add DTS for liteSOM module
      ARM: dts: imx6ul: Add DTS for liteBoard

Marek Vasut (7):
      ARM: dts: socfpga: Add new MCVEVK manufacturer compat
      ARM: dts: at91: sama5d4: Add new MA5D4EVK manufacturer compat
      ARM: dts: imx6sx: Fix LCDIF interrupt type
      ARM: dts: novena: Enable PWM1
      ARM: dts: mxs: Add new M28EVK manufacturer compat
      ARM: dts: mx5: Add new M53EVK manufacturer compat
      ARM: dts: socfpga: fine-tune L2 cache configuration

Markus Reichl (1):
      ARM: dts: exynos: Add ADCs on 4412 and 5422 based odroid boards.

Martin Sperl (2):
      dt: bindings: add thermal device driver for bcm2835
      ARM: bcm2835: dts: add thermal node to device-tree of bcm283x

Masahiro Yamada (8):
      ARM: dts: uniphier: increase register region size of sysctrl node
      ARM: dts: uniphier: add CPU clocks and OPP table for Pro5 SoC
      ARM: dts: uniphier: add CPU clocks and OPP table for PXs2 SoC
      ARM: dts: uniphier: make 32bit SoC DTSI linear
      ARM: dts: uniphier: remove redundant serial fifo-size properties
      ARM: dts: uniphier: add clocks/resets to EHCI nodes of sLD3 SoC
      ARM: dts: uniphier: make compatible of syscon nodes SoC-specific
      ARM: dts: berlin2q-marvell-dmp: fix typo in chosen node

Matthias Brugger (1):
      arm64: dts: mt8173: Fix auxadc node

Maxime Coquelin (2):
      ARM: dts: Add GPIO irq support to STM32F429
      ARM: dts: Declare push button as GPIO key on stm32f429 boards

Maxime Ripard (16):
      ARM: sun5i: a13-olinuxino: Enable VGA bridge
      ARM: gr8: Add the UART3
      ARM: gr8: Fix typo in the i2s mclk pin group
      ARM: gr8: Add missing pwm channel 1 pin
      ARM: gr8: Add UART2 pins
      ARM: gr8: Add UART3 pins
      ARM: gr8: Add CHIP Pro support
      ARM: sun5i: chip: Enable Wi-Fi SDIO chip
      ARM: sun5i: Rename A10s pins
      ARM: sun5i: Add SPI2 pins
      ARM: sun5i: Add RGB 565 LCD pins
      ARM: sun5i: chip: Add optional buses
      ARM: gr8: evb: Enable SPDIF
      ARM: gr8: evb: Add i2s codec
      ARM: sun8i: sina33: Enable USB gadget
      ARM: sunxi: Add the missing clocks to the pinctrl nodes

Michal Simek (3):
      ARM: zynq: Remove skeleton.dtsi
      ARM: zynq: Fix W=1 dtc 1.4 warnings
      ARM: zynq: Fix pmu register description coding style

Milo Kim (12):
      ARM: dts: tps65217: Specify the interrupt controller
      ARM: dts: tps65217: Add the charger device
      ARM: dts: tps65217: Add the power button device
      ARM: dts: am335x: Support the PMIC interrupt
      dt-bindings: mfd: Provide human readable defines for TPS65217 interrupts
      ARM: dts: am335x: Add the charger interrupt
      ARM: dts: am335x: Add the power button interrupt
      ARM: dts: sun8i: Add common dtsi file for NanoPi SBCs
      ARM: dts: sun8i: Use the common file in NanoPi NEO SBC
      ARM: dts: sun8i: Add dts file for NanoPi M1 SBC
      ARM: dts: sun8i: Add SPI pinctrl node in H3
      ARM: dts: sun8i: Add SPI controller node in H3

Mirza Krak (3):
      ARM: tegra: Add Tegra20 GMI support
      ARM: tegra: Add Tegra30 GMI support
      serial: tegra20-hsuart: Fix typo in dmas DT binding description

Mugunthan V N (2):
      ARM: dts: am33xx: add DMA properties for tscadc
      ARM: dts: am4372: add DMA properties for tscadc

Neil Armstrong (7):
      ARM: dts: Add MDM9615 dtsi
      dt-bindings: qcom: Add MDM9615 bindings
      ARM: dts: Add support for OX820 and Pogoplug V3
      MAINTAINERS: oxnas: Add new files definitions
      ARM: dts: Add Sierra Wireless WP8548 dtsi
      ARM: dts: Add WP8548 based MangOH Green board DTS
      dt-bindings: arm: Add Sierra Wireless modules bindings

Niklas Cassel (2):
      ARM: dts: exynos: Specify snps, dwmac in compatible string for gmac
      ARM: dts: artpec: add pcie support

Nishanth Menon (1):
      ARM: dts: Add support for dra718-evm

Nobuhiro Iwamatsu (1):
      ARM: dts: socfpga: Add Macnica sodia board

Olof Johansson (25):
      Merge tag 'sti-dt-for-4.10' of git://git.kernel.org/.../pchotard/sti into next/dt
      Merge tag 'socfpga_dts_for_v4.10_part_1' of git://git.kernel.org/.../dinguyen/linux into next/dt
      Merge tag 'vexpress-dt-4.10' of git://git.kernel.org/.../sudeep.holla/linux into next/dt
      Merge tag 'davinci-for-v4.10/dt' of git://git.kernel.org/.../nsekhar/linux-davinci into next/dt
      Merge tag 'renesas-dt-for-v4.10' of git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'stm32-dt-for-v4.10-1' of git://git.kernel.org/.../atorgue/stm32 into next/dt
      Merge tag 'v4.9-rc3' into next/dt
      Merge tag 'uniphier-dt-v4.10' of git://git.kernel.org/.../masahiroy/linux-uniphier into next/dt
      Merge tag 'lpc32xx-dt-v4.10' of https://github.com/sylemieux/linux-lpc32xx into next/dt
      Merge tag 'samsung-dt-4.10' of git://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'sti-dt-for-4.10-round2' of git://git.kernel.org/.../pchotard/sti into next/dt
      Merge tag 'socfpga_dts_for_v4.10_part_2' of git://git.kernel.org/.../dinguyen/linux into next/dt
      Merge tag 'v4.10-rockchip-dts32-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'v4.9-next-dts' of https://github.com/mbgg/linux-mediatek into next/dt
      Merge tag 'at91-ab-4.10-dt1' of git://git.kernel.org/.../abelloni/linux into next/dt
      Merge tag 'omap-for-v4.10/pinctrl-cells-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'imx-dt-4.10' of git://git.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'stm32-dt-for-v4.10-2' of git://git.kernel.org/.../atorgue/stm32 into next/dt
      Merge tag 'hisi-armv7-soc-dt-for-4.10' of git://github.com/hisilicon/linux-hisi into next/dt
      Merge tag 'omap-for-v4.10/dt-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'samsung-dt-gic-flags-4.10' of git://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'tegra-for-4.10-dt-bindings' of git://git.kernel.org/.../tegra/linux into next/dt
      Merge tag 'tegra-for-4.10-arm-dt' of git://git.kernel.org/.../tegra/linux into next/dt
      Merge tag 'davinci-for-v4.10/dt-4' of git://git.kernel.org/.../nsekhar/linux-davinci into next/dt
      Merge tag 'zynq-dt-for-4.10' of https://github.com/Xilinx/linux-xlnx into next/dt

Pankaj Dubey (1):
      ARM: dts: exynos: Add SCU device node to exynos4.dtsi

Patrice Chotard (16):
      ARM: dts: remove STiH416-b2020e.dts
      ARM: dts: remove STiH416-b2020.dts
      ARM: dts: remove STiH416-b2000.dts
      ARM: dts: remove STiH416-clock.dtsi
      ARM: dts: remove STiH416-pinctrl.dtsi
      ARM: dts: remove STiH415-b2020.dts
      ARM: dts: remove STiH415-b2000.dts
      ARM: dts: remove STiH415-clock.dtsi
      ARM: dts: remove STiH415-pinctrl.dtsi
      ARM: dts: remove STiH415.dtsi
      ARM: dts: remove STiH416.dtsi
      ARM: dts: remove STiH41x.dtsi
      ARM: dts: remove STiH41x-b2020.dtsi
      ARM: dts: remove STiH41x-b2000.dtsi
      ARM: dts: remove STiH41x-b2020.dtsi
      ARM: dts: remove stih415-clks.h

Paul Kocialkowski (1):
      ARM: tegra: nyan: Enable GPU node and related supply

Paul Wassi (1):
      ARM: dts: kirkwood: fix spelling mistake

Pawe? Jarosz (6):
      ARM: dts: rockchip: initialize rk3066 PLL clock rate
      devicetree: Add vendor prefix for Rikomagic
      ARM: dts: rockchip: Add rk3066 MK808 board
      ARM: dts: rockchip: Set sdmmc frequency at boot time for rk3066a
      ARM: dts: rockchip: fix TSADC reset node for rk3066a
      ARM: dts: rockchip: enable dma for uart and mmc on rk3066a

Peter Chen (4):
      ARM: dts: imx6ul-14x14-evk: add USB dual-role support
      ARM: dts: imx6sx-sdb: update TX D_CAL for USBPHY
      ARM: dts: imx6ul-14x14-evk: update TX D_CAL for USBPHY
      ARM: dts: imx6ull: add imx6ull support

Peter Griffin (8):
      MAINTAINERS: Remove phy-miphy365x.c entry from STi arch
      MAINTAINERS: Remove phy-stih41x-usb.c entry from STi arch
      ahci: st: Remove STiH416 dt example
      thermal: sti: Remove obsolete platforms from the DT doc.
      reset: sti: Remove obsolete platforms from dt binding doc.
      reset: sti: softreset: Remove obsolete platforms from dt binding doc.
      ARM: dts: stih410-clocks: Add PROC_STFE as a critical clock
      ARM: dts: stih407-clocks: Identify critical clocks

Peter Rosin (1):
      dt-bindings: usb: atmel: fix a couple of copy-paste style typos

Rafa? Mi?ecki (7):
      ARM: BCM5301X: Add DT for Netgear R8500
      ARM: BCM5301X: Add basic dts for BCM53573 based Tenda AC9
      ARM: BCM5301X: Add separated DTS include file for BCM47094
      ARM: BCM5301X: Enable UART on Netgear R8000
      ARM: BCM5301X: Specify USB 3.0 PHY in DT
      ARM: BCM53573: Specify PMU and its ILP clock in the DT
      ARM: BCM5301X: Add DT for TP-LINK Archer C9 V1

Randy Li (2):
      ARM: dts: exynos: Add TOPEET itop core board SCP package version
      ARM: dts: exynos: Add TOPEET itop elite based board

Ritesh Harjani (1):
      ARM: dts: Add xo to sdhc clock node on qcom platforms

Robert Jarzmik (4):
      ARM: dts: pxa: add pxa25x .dtsi file
      ARM: dts: pxa: fix gpio0 and gpio1 interrupts
      ARM: dts: pxa: add pxa25x cpu operating points
      ARM: dts: pxa: add pxa27x cpu operating points

Sanchayan Maity (5):
      ARM: dts: imx6: Add support for Toradex Colibri iMX6 module
      ARM: dts: imx6q-apalis-ixora: Remove use of pwm-leds
      ARM: dts: imx6qdl-apalis: Use enable-gpios property for backlight
      ARM: dts: vfxxx: Enable DMA for DSPI on Vybrid
      ARM: dts: vfxxx: Enable DMA for DSPI2 and DSPI3

Schuyler Patton (1):
      ARM: dts: AM571x-IDK Initial Support

Scott Branden (1):
      ARM: dts: cygnus: fix naming of pinctrl node

Sergei Shtylyov (20):
      ARM: shmobile: r8a7743: add power domain index macros
      ARM: dts: wheat: add DU support
      ARM: dts: r8a7792: add MSIOF clocks
      ARM: dts: r8a7792: add MSIOF support
      ARM: dts: r8a7794: remove Z clock
      ARM: shmobile: r8a7745: add power domain index macros
      ARM: dts: r8a7743: initial SoC device tree
      ARM: dts: r8a7743: add SYS-DMAC support
      ARM: dts: r8a7743: add [H]SCIF{A|B} support
      ARM: dts: r8a7743: add Ether support
      ARM: dts: r8a7743: add IRQC support
      ARM: dts: sk-rzg1m: initial device tree
      ARM: dts: sk-rzg1m: add Ether support
      ARM: dts: r8a7745: initial SoC device tree
      ARM: dts: r8a7745: add SYS-DMAC support
      ARM: dts: r8a7745: add [H]SCIF{|A|B} support
      ARM: dts: r8a7745: add Ether support
      ARM: dts: r8a7745: add IRQC support
      ARM: dts: sk-rzg1e: initial device tree
      ARM: dts: sk-rzg1e: add Ether support

Shawn Lin (4):
      ARM: dts: rockchip: remove always-on and boot-on from vcc_sd for px3-evb
      ARM: dts: rockchip: Support UHS mode for SD card on PopMetal-RK3288 board
      ARM: dts: rockchip: enable HS200/DDR52 mode for emmc on rk3288-popmetal
      dt-bindings: rockchip-dw-mshc: add RK1108 dw-mshc description

Shunli Wang (1):
      soc: mediatek: Add MT2701 power dt-bindings

Simon Horman (13):
      ARM: dts: r8a7791: set maximum frequency for SDHI clocks
      ARM: dts: koelsch: enable UHS for SDHI 0, 1 & 3
      ARM: dts: r8a7794: set maximum frequency for SDHI clocks
      ARM: dts: alt: enable UHS for SDHI 0 & 1
      ARM: dts: gose: use generic pinctrl properties in SDHI nodes
      Merge tag 'rzg-clock-defs-tag1'; commit '538321bd9718'; commit '97ca8402997c' into dt-for-v4.10
      ARM: dts: lager: rename and reindex i2cexio
      ARM: dts: lager: use demuxer for IIC1/I2C1
      ARM: dts: koelsch: use demuxer for I2C1
      ARM: dts: alt: use demuxer for I2C4
      ARM: dts: lager: Enable UHS-I SDR-104
      ARM: dts: koelsch: Enable UHS-I SDR-104
      ARM: dts: alt: Enable UHS-I SDR-104

Stefan Wahren (4):
      DT: binding: bcm2835-mbox: fix address typo in example
      ARM: dts: bcm283x: fix typo in mailbox address
      ARM: bcm2835: Fix names for the Raspberry Pi GPIO lines
      ARM: bcm2835: Add names for the RPi Zero GPIO lines

Steffen Trumtrar (3):
      ARM: dts: socfpga: add qspi node
      ARM: dts: socfpga: socrates: enable qspi
      ARM: dts: socfpga: add nand controller nodes

Sudeep Holla (4):
      ARM: dts: at91: replace gpio-key,wakeup with wakeup-source for sam9260ek
      ARM: dts: imx6q: replace gpio-key,wakeup with wakeup-source for Utilite Pro
      ARM: dts: omap5: replace gpio-key,wakeup with wakeup-source property
      ARM: dts: sun8i: replace enable-sdio-wakeup with wakeup-source for BananaPi M1+

Sylvain Lemieux (1):
      ARM: dts: lpc32xx: set default parent clock for pwm1 & pwm2

Sylvain Rochet (1):
      ARM: dts: at91: fixes dbgu pinctrl, set pullup on rx, clear pullup on tx

Sylwester Nawrocki (2):
      ARM: dts: exynos: Remove "simple-bus" compatible from fimc-is node
      ARM: dts: exynos: Add entries for sound support on Odroid-XU board

Thierry Reding (2):
      ARM: tegra: apalis-tk1: Drop leading 0 from unit-address
      dt-bindings: Add documentation for Tegra186 Denver

Thor Thayer (4):
      ARM: dts: socfpga: Add SPI Master1 for Arria10 SR chip
      ARM: dts: socfpga: Add Devkit A10-SR fields for Arria10
      ARM: dts: socfpga: Enable GPIO parent for Arria10 SR chip
      ARM: dts: socfpga: Add LED framework to A10-SR GPIO

Tony Lindgren (2):
      ARM: dts: Add #pinctrl-cells for pinctrl-single instances
      ARM: dts: Add minimal support for motorola droid 4 xt894

Ulrich Hecht (1):
      ARM: dts: r8a7793: Enable VIN0-VIN2

Uwe Kleine-K?nig (8):
      ARM: dts: armada-370-rn104: add pinmuxing for i2c0
      ARM: dts: armada-370-rn104: drop specification of compatible for i2c0
      ARM: dts: armada-xp-rn2120: drop wrong compatible for i2c0
      ARM: dts: armada-xp-rn2120: add pinmuxing for ethernet
      ARM: dts: armada-370-rn102: drop specification of compatible for i2c0
      ARM: dts: armada-370-rn102: add pinmuxing for i2c0
      devicetree: Add vendor prefix for CZ.NIC
      ARM: dts: add support for Turris Omnia

Vijay Kumar (1):
      ARM: dts: pxa: fix no. of gpio cells in the pxa gpio binding documentation

Vladimir Murzin (1):
      ARM: dts: mps2: remove skeleton.dtsi include and fix unit address warnings

William Towle (1):
      ARM: dts: lager: Add entries for VIN HDMI input support

Yegor Yefremov (3):
      ARM: dts: am335x-baltos-ir5221: use both musb channels in host mode
      ARM: dts: am335x-baltos: don't reset gpio3 block
      ARM: dts: am335x-baltos: use phy-phandle declarations

Yendapally Reddy Dhananjaya Reddy (1):
      ARM: dts: enable GPIO-b for Broadcom NSP


 Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
 .../devicetree/bindings/arm/omap/omap.txt          |   3 +
 Documentation/devicetree/bindings/arm/oxnas.txt    |   5 +
 Documentation/devicetree/bindings/arm/qcom.txt     |   1 +
 Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
 .../bindings/arm/samsung/samsung-boards.txt        |   3 +
 Documentation/devicetree/bindings/arm/swir.txt     |  12 +
 Documentation/devicetree/bindings/ata/ahci-st.txt  |  15 -
 .../devicetree/bindings/gpio/mrvl-gpio.txt         |   6 +-
 .../bindings/mailbox/brcm,bcm2835-mbox.txt         |   2 +-
 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |   1 +
 .../devicetree/bindings/pinctrl/pinctrl-single.txt |   3 +
 .../devicetree/bindings/reset/st,sti-powerdown.txt |  12 +-
 .../devicetree/bindings/reset/st,sti-softreset.txt |   8 +-
 .../bindings/serial/nvidia,tegra20-hsuart.txt      |   2 +-
 .../devicetree/bindings/soc/mediatek/scpsys.txt    |  13 +-
 .../bindings/thermal/brcm,bcm2835-thermal.txt      |  17 +
 .../devicetree/bindings/thermal/st-thermal.txt     |  28 +-
 .../devicetree/bindings/usb/atmel-usb.txt          |  10 +-
 .../devicetree/bindings/vendor-prefixes.txt        |   2 +
 MAINTAINERS                                        |   5 +-
 arch/arm/boot/dts/Makefile                         |  50 +-
 arch/arm/boot/dts/am335x-baltos-ir2110.dts         |  10 +-
 arch/arm/boot/dts/am335x-baltos-ir3220.dts         |   2 +-
 arch/arm/boot/dts/am335x-baltos-ir5221.dts         |   4 +-
 arch/arm/boot/dts/am335x-baltos.dtsi               |   9 +-
 arch/arm/boot/dts/am335x-bone-common.dtsi          |  22 +
 arch/arm/boot/dts/am335x-boneblack.dts             |  11 +
 arch/arm/boot/dts/am335x-evm.dts                   |   5 +
 arch/arm/boot/dts/am335x-evmsk.dts                 |   5 +
 arch/arm/boot/dts/am335x-icev2.dts                 |  47 +-
 arch/arm/boot/dts/am33xx.dtsi                      |   6 +
 arch/arm/boot/dts/am3517.dtsi                      |   1 +
 arch/arm/boot/dts/am4372.dtsi                      |   3 +
 arch/arm/boot/dts/am437x-idk-evm.dts               | 101 +++
 arch/arm/boot/dts/am571x-idk.dts                   |  81 ++
 arch/arm/boot/dts/am572x-idk.dts                   |   4 +
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi    |   1 +
 arch/arm/boot/dts/am57xx-idk-common.dtsi           |  75 ++
 arch/arm/boot/dts/armada-370-db.dts                |  63 +-
 arch/arm/boot/dts/armada-370-dlink-dns327l.dts     |  30 +-
 arch/arm/boot/dts/armada-370-mirabox.dts           |  57 +-
 arch/arm/boot/dts/armada-370-netgear-rn102.dts     |  55 +-
 arch/arm/boot/dts/armada-370-netgear-rn104.dts     |  63 +-
 arch/arm/boot/dts/armada-370-rd.dts                |  57 +-
 arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts  |  27 +-
 arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi |  45 +-
 .../dts/armada-370-seagate-personal-cloud.dtsi     |  44 +-
 arch/arm/boot/dts/armada-370-synology-ds213j.dts   |  18 +-
 arch/arm/boot/dts/armada-370-xp.dtsi               |  39 +-
 arch/arm/boot/dts/armada-370.dtsi                  | 136 ++--
 arch/arm/boot/dts/armada-375-db.dts                | 271 +++----
 arch/arm/boot/dts/armada-375.dtsi                  |  72 +-
 arch/arm/boot/dts/armada-385-turris-omnia.dts      | 340 ++++++++
 arch/arm/boot/dts/armada-38x.dtsi                  |   2 +-
 arch/arm/boot/dts/armada-39x.dtsi                  |   2 +-
 arch/arm/boot/dts/armada-xp-axpwifiap.dts          |  68 +-
 arch/arm/boot/dts/armada-xp-db.dts                 | 104 +--
 arch/arm/boot/dts/armada-xp-gp.dts                 |  80 +-
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts    |  53 +-
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts      |  52 +-
 arch/arm/boot/dts/armada-xp-matrix.dts             |  20 +-
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |  12 +-
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |  20 +-
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |  22 +-
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts     |  74 +-
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   |  58 +-
 arch/arm/boot/dts/armada-xp-synology-ds414.dts     |  75 +-
 arch/arm/boot/dts/armada-xp.dtsi                   |  94 +--
 arch/arm/boot/dts/artpec6-devboard.dts             |   4 +
 arch/arm/boot/dts/artpec6.dtsi                     |  29 +-
 arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi          |   4 +-
 arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts        |   4 +-
 arch/arm/boot/dts/at91rm9200.dtsi                  |   4 +-
 arch/arm/boot/dts/at91sam9260.dtsi                 |   4 +-
 arch/arm/boot/dts/at91sam9260ek.dts                |   4 +-
 arch/arm/boot/dts/at91sam9261.dtsi                 |   4 +-
 arch/arm/boot/dts/at91sam9263.dtsi                 |   4 +-
 arch/arm/boot/dts/at91sam9g45.dtsi                 |   4 +-
 arch/arm/boot/dts/at91sam9n12.dtsi                 |   4 +-
 arch/arm/boot/dts/at91sam9rl.dtsi                  |   4 +-
 arch/arm/boot/dts/at91sam9x5.dtsi                  |   4 +-
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |  21 +-
 arch/arm/boot/dts/bcm-nsp.dtsi                     |  41 +-
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts           |  67 +-
 arch/arm/boot/dts/bcm2835-rpi-a.dts                |  69 +-
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts           |  68 +-
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts           |  68 +-
 arch/arm/boot/dts/bcm2835-rpi-b.dts                |  69 +-
 arch/arm/boot/dts/bcm2835-rpi-zero.dts             |  67 +-
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |  15 +-
 arch/arm/boot/dts/bcm2835.dtsi                     |   6 +
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts              |   2 +-
 arch/arm/boot/dts/bcm2836.dtsi                     |   6 +
 arch/arm/boot/dts/bcm283x.dtsi                     | 212 ++++-
 arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts       |  64 ++
 arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts        |   2 +-
 arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts  |   2 +-
 arch/arm/boot/dts/bcm4709-netgear-r7000.dts        |   2 +-
 arch/arm/boot/dts/bcm4709-netgear-r8000.dts        |   6 +-
 arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts  | 114 +++
 arch/arm/boot/dts/bcm4709.dtsi                     |  11 +
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts      |   3 +-
 arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts      | 111 +++
 arch/arm/boot/dts/bcm47094-netgear-r8500.dts       | 103 +++
 arch/arm/boot/dts/bcm47094.dtsi                    |  17 +
 arch/arm/boot/dts/bcm47189-tenda-ac9.dts           |  74 ++
 arch/arm/boot/dts/bcm5301x-nand-cs0-bch4.dtsi      |  13 +
 arch/arm/boot/dts/bcm5301x.dtsi                    |   7 +
 arch/arm/boot/dts/bcm53573.dtsi                    | 159 ++++
 arch/arm/boot/dts/bcm958625k.dts                   |  34 +
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts         |  12 +-
 .../boot/dts/cloudengines-pogoplug-series-3.dts    |  94 +++
 arch/arm/boot/dts/da850-lcdk.dts                   |  19 +-
 arch/arm/boot/dts/da850.dtsi                       |  70 ++
 arch/arm/boot/dts/dm814x.dtsi                      |   1 +
 arch/arm/boot/dts/dm816x.dtsi                      |   2 +
 arch/arm/boot/dts/dra7.dtsi                        |   1 +
 arch/arm/boot/dts/dra71-evm.dts                    | 230 ++++++
 arch/arm/boot/dts/dra72-evm-common.dtsi            | 348 +-------
 arch/arm/boot/dts/dra72-evm-revc.dts               |  21 +-
 arch/arm/boot/dts/dra72-evm-tps65917.dtsi          | 134 ++++
 arch/arm/boot/dts/dra72-evm.dts                    |  14 +-
 arch/arm/boot/dts/emev2.dtsi                       |   3 +-
 arch/arm/boot/dts/exynos3250-artik5-eval.dts       |   2 +-
 arch/arm/boot/dts/exynos3250-artik5.dtsi           |   2 +-
 arch/arm/boot/dts/exynos3250-monk.dts              |   2 +-
 arch/arm/boot/dts/exynos3250-pinctrl.dtsi          |  20 +-
 arch/arm/boot/dts/exynos3250-rinato.dts            |   2 +-
 arch/arm/boot/dts/exynos3250.dtsi                  |  97 ++-
 arch/arm/boot/dts/exynos4.dtsi                     | 100 ++-
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi          |  20 +-
 arch/arm/boot/dts/exynos4210.dtsi                  |  36 +-
 arch/arm/boot/dts/exynos4412-itop-elite.dts        | 240 ++++++
 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi    | 501 ++++++++++++
 arch/arm/boot/dts/exynos4412-odroidx.dts           |   5 +
 arch/arm/boot/dts/exynos4415-pinctrl.dtsi          | 575 -------------
 arch/arm/boot/dts/exynos4415.dtsi                  | 650 ---------------
 arch/arm/boot/dts/exynos4x12-pinctrl.dtsi          |  20 +-
 arch/arm/boot/dts/exynos4x12.dtsi                  |  50 +-
 arch/arm/boot/dts/exynos5.dtsi                     |  64 +-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi      |   4 +
 arch/arm/boot/dts/exynos5250.dtsi                  |  80 +-
 arch/arm/boot/dts/exynos5260.dtsi                  |  43 +-
 arch/arm/boot/dts/exynos5410-odroidxu.dts          |  69 ++
 arch/arm/boot/dts/exynos5410-pinctrl.dtsi          |   9 +
 arch/arm/boot/dts/exynos5410.dtsi                  |  85 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |   3 +
 arch/arm/boot/dts/exynos5420.dtsi                  |  78 +-
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  12 +-
 arch/arm/boot/dts/exynos5440.dtsi                  |  72 +-
 arch/arm/boot/dts/exynos54xx.dtsi                  |  34 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |   3 +
 arch/arm/boot/dts/hi3620.dtsi                      |   6 +-
 arch/arm/boot/dts/hip01.dtsi                       |   2 -
 arch/arm/boot/dts/hisi-x5hd2.dtsi                  |   4 +-
 arch/arm/boot/dts/imx1.dtsi                        |   4 +-
 arch/arm/boot/dts/imx23.dtsi                       |   6 +-
 arch/arm/boot/dts/imx25.dtsi                       |   4 +-
 arch/arm/boot/dts/imx27.dtsi                       |   4 +-
 arch/arm/boot/dts/imx28-m28.dtsi                   |   4 +-
 arch/arm/boot/dts/imx28-m28evk.dts                 |   4 +-
 arch/arm/boot/dts/imx28.dtsi                       |   4 +-
 arch/arm/boot/dts/imx31.dtsi                       |   5 +-
 arch/arm/boot/dts/imx35.dtsi                       |   4 +-
 arch/arm/boot/dts/imx50.dtsi                       |  48 +-
 arch/arm/boot/dts/imx51.dtsi                       |  48 +-
 arch/arm/boot/dts/imx53-m53.dtsi                   |   4 +-
 arch/arm/boot/dts/imx53-m53evk.dts                 |   4 +-
 arch/arm/boot/dts/imx53.dtsi                       |  72 +-
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts       | 253 ++++++
 arch/arm/boot/dts/imx6dl-icore.dts                 |  59 ++
 arch/arm/boot/dts/imx6dl-riotboard.dts             |   2 +-
 arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts          |   2 +-
 arch/arm/boot/dts/imx6dl-tx6u-801x.dts             |   2 +-
 arch/arm/boot/dts/imx6q-apalis-ixora.dts           |  22 -
 arch/arm/boot/dts/imx6q-b650v3.dts                 |   6 +
 arch/arm/boot/dts/imx6q-evi.dts                    |   3 -
 arch/arm/boot/dts/imx6q-icore.dts                  |  59 ++
 arch/arm/boot/dts/imx6q-nitrogen6_som2.dts         |  53 ++
 arch/arm/boot/dts/imx6q-novena.dts                 |   4 +
 arch/arm/boot/dts/imx6q-phytec-pbab01.dts          |   2 +-
 arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts       |   2 +-
 arch/arm/boot/dts/imx6q-tx6q-1010.dts              |   2 +-
 arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts       |   2 +-
 arch/arm/boot/dts/imx6q-tx6q-1020.dts              |   2 +-
 arch/arm/boot/dts/imx6q-utilite-pro.dts            |  53 +-
 arch/arm/boot/dts/imx6qdl-apalis.dtsi              |   9 +
 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi             |  14 +-
 arch/arm/boot/dts/imx6qdl-colibri.dtsi             | 890 +++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi              |   4 +-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi              |   4 +-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              |   4 +-
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi              |   2 +-
 arch/arm/boot/dts/imx6qdl-icore.dtsi               | 265 ++++++
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi           |  32 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi       |  18 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi      | 770 ++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |  12 +-
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi       |   6 +-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |   4 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi           |  10 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |   4 +-
 arch/arm/boot/dts/imx6qdl-tx6.dtsi                 |  32 +-
 arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi     |   2 +-
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi           |   4 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |  14 +-
 arch/arm/boot/dts/imx6qp.dtsi                      |   7 +
 arch/arm/boot/dts/imx6sl.dtsi                      |   7 +-
 arch/arm/boot/dts/imx6sx-sdb.dtsi                  |  16 +-
 arch/arm/boot/dts/imx6sx-udoo-neo-basic.dts        |  69 ++
 arch/arm/boot/dts/imx6sx-udoo-neo-extended.dts     |  54 ++
 arch/arm/boot/dts/imx6sx-udoo-neo-full.dts         |  69 ++
 arch/arm/boot/dts/imx6sx-udoo-neo.dtsi             | 293 +++++++
 arch/arm/boot/dts/imx6sx.dtsi                      |  17 +-
 arch/arm/boot/dts/imx6ul-14x14-evk.dts             |  10 +-
 arch/arm/boot/dts/imx6ul-liteboard.dts             | 147 ++++
 arch/arm/boot/dts/imx6ul-litesom.dtsi              |  82 ++
 arch/arm/boot/dts/imx6ul.dtsi                      |   4 +-
 arch/arm/boot/dts/imx6ull-14x14-evk.dts            |  52 ++
 arch/arm/boot/dts/imx6ull-pinfunc.h                |  56 ++
 arch/arm/boot/dts/imx6ull.dtsi                     |  43 +
 arch/arm/boot/dts/imx7s.dtsi                       |   4 +-
 arch/arm/boot/dts/integratorap.dts                 |  35 +
 arch/arm/boot/dts/integratorcp.dts                 |  26 +
 arch/arm/boot/dts/keystone-k2g.dtsi                |   1 +
 arch/arm/boot/dts/keystone-k2l.dtsi                |   1 +
 arch/arm/boot/dts/kirkwood-topkick.dts             |   2 +-
 arch/arm/boot/dts/lpc32xx.dtsi                     |   4 +
 arch/arm/boot/dts/ls1021a.dtsi                     |  84 +-
 arch/arm/boot/dts/mps2-an385.dts                   |   2 +-
 arch/arm/boot/dts/mps2-an399.dts                   |   2 +-
 arch/arm/boot/dts/mps2.dtsi                        |   4 +-
 arch/arm/boot/dts/mt2701.dtsi                      |  50 +-
 arch/arm/boot/dts/omap2420.dtsi                    |   2 +
 arch/arm/boot/dts/omap2430.dtsi                    |   2 +
 arch/arm/boot/dts/omap3.dtsi                       |   2 +
 arch/arm/boot/dts/omap34xx.dtsi                    |   1 +
 arch/arm/boot/dts/omap36xx.dtsi                    |   1 +
 arch/arm/boot/dts/omap4-droid4-xt894.dts           | 188 +++++
 arch/arm/boot/dts/omap4.dtsi                       |   2 +
 arch/arm/boot/dts/omap5-uevm.dts                   |  92 +++
 arch/arm/boot/dts/omap5.dtsi                       |   2 +
 arch/arm/boot/dts/orion5x-lschl.dts                | 171 ++++
 arch/arm/boot/dts/ox820.dtsi                       | 296 +++++++
 arch/arm/boot/dts/pxa25x.dtsi                      | 117 +++
 arch/arm/boot/dts/pxa27x.dtsi                      |  40 +
 arch/arm/boot/dts/pxa2xx.dtsi                      |   4 +-
 arch/arm/boot/dts/pxa3xx.dtsi                      |   1 +
 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts     | 119 +++
 arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts |  77 +-
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts         |  74 ++
 arch/arm/boot/dts/qcom-apq8064.dtsi                | 321 ++++++++
 arch/arm/boot/dts/qcom-apq8084.dtsi                |  16 +-
 .../boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts  | 281 +++++++
 arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi         | 170 ++++
 arch/arm/boot/dts/qcom-mdm9615.dtsi                | 557 +++++++++++++
 arch/arm/boot/dts/qcom-msm8660.dtsi                |  17 +
 .../dts/qcom-msm8974-lge-nexus5-hammerhead.dts     |  29 +
 arch/arm/boot/dts/qcom-msm8974.dtsi                |  16 +-
 arch/arm/boot/dts/r7s72100-rskrza1.dts             |   5 +
 arch/arm/boot/dts/r7s72100.dtsi                    |  55 ++
 arch/arm/boot/dts/r8a73a4.dtsi                     |   5 +
 arch/arm/boot/dts/r8a7740.dtsi                     |   4 +-
 arch/arm/boot/dts/r8a7743-sk-rzg1m.dts             |  57 ++
 arch/arm/boot/dts/r8a7743.dtsi                     | 476 +++++++++++
 arch/arm/boot/dts/r8a7745-sk-rzg1e.dts             |  52 ++
 arch/arm/boot/dts/r8a7745.dtsi                     | 476 +++++++++++
 arch/arm/boot/dts/r8a7778.dtsi                     |   4 +-
 arch/arm/boot/dts/r8a7779-marzen.dts               |   2 +-
 arch/arm/boot/dts/r8a7779.dtsi                     |  11 +-
 arch/arm/boot/dts/r8a7790-lager.dts                | 118 ++-
 arch/arm/boot/dts/r8a7790.dtsi                     |  11 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts              | 137 +++-
 arch/arm/boot/dts/r8a7791.dtsi                     |  14 +-
 arch/arm/boot/dts/r8a7792-wheat.dts                | 126 +++
 arch/arm/boot/dts/r8a7792.dtsi                     |  56 +-
 arch/arm/boot/dts/r8a7793-gose.dts                 |  12 +-
 arch/arm/boot/dts/r8a7793.dtsi                     |  38 +-
 arch/arm/boot/dts/r8a7794-alt.dts                  |  62 +-
 arch/arm/boot/dts/r8a7794.dtsi                     |  81 +-
 arch/arm/boot/dts/rk1108-evb.dts                   |  69 ++
 arch/arm/boot/dts/rk1108.dtsi                      | 452 +++++++++++
 arch/arm/boot/dts/rk3036-evb.dts                   |   2 +-
 arch/arm/boot/dts/rk3036-kylin.dts                 |   2 +-
 arch/arm/boot/dts/rk3036.dtsi                      |  10 +-
 arch/arm/boot/dts/rk3066a-bqcurie2.dts             |   2 +-
 arch/arm/boot/dts/rk3066a-marsboard.dts            |   2 +-
 arch/arm/boot/dts/rk3066a-mk808.dts                | 195 +++++
 arch/arm/boot/dts/rk3066a-rayeager.dts             |   2 +-
 arch/arm/boot/dts/rk3066a.dtsi                     |  31 +-
 arch/arm/boot/dts/rk3188-px3-evb.dts               | 328 ++++++++
 arch/arm/boot/dts/rk3188-radxarock.dts             |   2 +-
 arch/arm/boot/dts/rk3188.dtsi                      |   2 +-
 arch/arm/boot/dts/rk3228-evb.dts                   |   2 +-
 arch/arm/boot/dts/rk3229-evb.dts                   |   2 +-
 arch/arm/boot/dts/rk322x.dtsi                      |   6 +-
 arch/arm/boot/dts/rk3288-evb.dtsi                  |   2 +-
 arch/arm/boot/dts/rk3288-fennec.dts                |   2 +-
 arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi  |   2 +-
 arch/arm/boot/dts/rk3288-firefly.dtsi              |   2 +-
 arch/arm/boot/dts/rk3288-miqi.dts                  |   2 +-
 arch/arm/boot/dts/rk3288-popmetal.dts              |  34 +-
 arch/arm/boot/dts/rk3288-r89.dts                   |   2 +-
 arch/arm/boot/dts/rk3288-rock2-som.dtsi            |   2 +-
 arch/arm/boot/dts/rk3288-veyron.dtsi               |   2 +-
 arch/arm/boot/dts/rk3288.dtsi                      |  14 +-
 arch/arm/boot/dts/rk3xxx.dtsi                      |   4 +-
 arch/arm/boot/dts/sama5d2.dtsi                     |  47 +-
 arch/arm/boot/dts/sama5d3.dtsi                     |   4 +-
 arch/arm/boot/dts/sama5d4.dtsi                     |  31 +-
 arch/arm/boot/dts/sh73a0.dtsi                      |   4 +-
 arch/arm/boot/dts/socfpga.dtsi                     |  33 +
 arch/arm/boot/dts/socfpga_arria10.dtsi             |  32 +
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi       |  49 ++
 arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dts   |  49 ++
 arch/arm/boot/dts/socfpga_arria5_socdk.dts         |  33 +
 arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts  |   2 +-
 arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi        |   2 +-
 arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts      |   4 +-
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts       |  35 +-
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts      |  23 +-
 arch/arm/boot/dts/socfpga_cyclone5_socrates.dts    |  19 +
 arch/arm/boot/dts/socfpga_cyclone5_sodia.dts       | 123 +++
 arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts |   2 +-
 arch/arm/boot/dts/stih407-clock.dtsi               |  10 +
 arch/arm/boot/dts/stih407-family.dtsi              |  32 +-
 arch/arm/boot/dts/stih407-pinctrl.dtsi             |   2 +-
 arch/arm/boot/dts/stih407.dtsi                     |   2 +-
 arch/arm/boot/dts/stih410-b2260.dts                |  22 +-
 arch/arm/boot/dts/stih410-clock.dtsi               |   3 +-
 arch/arm/boot/dts/stih410.dtsi                     |   2 +-
 arch/arm/boot/dts/stih415-b2000.dts                |  15 -
 arch/arm/boot/dts/stih415-b2020.dts                |  15 -
 arch/arm/boot/dts/stih415-clock.dtsi               | 533 ------------
 arch/arm/boot/dts/stih415-pinctrl.dtsi             | 545 -------------
 arch/arm/boot/dts/stih415.dtsi                     | 234 ------
 arch/arm/boot/dts/stih416-b2000.dts                |  15 -
 arch/arm/boot/dts/stih416-b2020.dts                |  37 -
 arch/arm/boot/dts/stih416-b2020e.dts               |  65 --
 arch/arm/boot/dts/stih416-clock.dtsi               | 756 -----------------
 arch/arm/boot/dts/stih416-pinctrl.dtsi             | 692 ----------------
 arch/arm/boot/dts/stih416.dtsi                     | 517 ------------
 arch/arm/boot/dts/stih41x-b2000.dtsi               |  96 ---
 arch/arm/boot/dts/stih41x-b2020.dtsi               |  82 --
 arch/arm/boot/dts/stih41x-b2020x.dtsi              |  32 -
 arch/arm/boot/dts/stih41x.dtsi                     |  47 --
 arch/arm/boot/dts/stihxxx-b2120.dtsi               |  21 +-
 arch/arm/boot/dts/stm32429i-eval.dts               |  29 +-
 arch/arm/boot/dts/stm32746g-eval.dts               |  96 +++
 arch/arm/boot/dts/stm32f429-disco.dts              |  13 +
 arch/arm/boot/dts/stm32f429.dtsi                   |  40 +-
 arch/arm/boot/dts/stm32f469-disco.dts              |   8 +
 arch/arm/boot/dts/stm32f746.dtsi                   | 304 +++++++
 arch/arm/boot/dts/sun4i-a10.dtsi                   |   3 +-
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts   |   4 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi                  |   4 +-
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts          |  54 ++
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts           |  38 +-
 arch/arm/boot/dts/sun5i-gr8-chip-pro.dts           | 266 ++++++
 arch/arm/boot/dts/sun5i-gr8-evb.dts                |  33 +
 arch/arm/boot/dts/sun5i-gr8.dtsi                   |  47 +-
 arch/arm/boot/dts/sun5i-r8-chip.dts                |  69 ++
 .../boot/dts/sun5i-reference-design-tablet.dtsi    |  25 +
 arch/arm/boot/dts/sun5i.dtsi                       |  27 +-
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts        |  80 ++
 arch/arm/boot/dts/sun6i-a31.dtsi                   | 266 +++++-
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts           |   8 +
 arch/arm/boot/dts/sun6i-a31s.dtsi                  |   8 +
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts   |  62 +-
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts     |   4 +
 arch/arm/boot/dts/sun7i-a20.dtsi                   |   3 +-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               |   6 +-
 .../boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts   |   7 -
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |   5 +
 arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts           |  64 ++
 arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts          |  79 +-
 arch/arm/boot/dts/sun8i-h3-nanopi.dtsi             | 144 ++++
 arch/arm/boot/dts/sun8i-h3.dtsi                    |  52 +-
 .../boot/dts/sun8i-reference-design-tablet.dtsi    |   7 +
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts        |  32 +
 arch/arm/boot/dts/sun9i-a80-optimus.dts            |  30 +
 arch/arm/boot/dts/sun9i-a80.dtsi                   |  14 +-
 arch/arm/boot/dts/tegra124-apalis.dtsi             |   2 +-
 arch/arm/boot/dts/tegra124-nyan.dtsi               |   8 +-
 arch/arm/boot/dts/tegra20.dtsi                     |  13 +
 arch/arm/boot/dts/tegra30-apalis.dtsi              |  49 ++
 arch/arm/boot/dts/tegra30-colibri.dtsi             |  49 ++
 arch/arm/boot/dts/tegra30.dtsi                     |  13 +
 arch/arm/boot/dts/tps65217.dtsi                    |  12 +
 arch/arm/boot/dts/uniphier-common32.dtsi           | 199 -----
 arch/arm/boot/dts/uniphier-ld4.dtsi                | 358 ++++++---
 arch/arm/boot/dts/uniphier-pro4.dtsi               | 378 ++++++---
 arch/arm/boot/dts/uniphier-pro5.dtsi               | 432 +++++++---
 arch/arm/boot/dts/uniphier-pxs2.dtsi               | 399 ++++++---
 arch/arm/boot/dts/uniphier-sld3.dtsi               |  21 +-
 arch/arm/boot/dts/uniphier-sld8.dtsi               | 359 ++++++---
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         |   5 +
 arch/arm/boot/dts/vf-colibri.dtsi                  |   4 +
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts          |  14 -
 arch/arm/boot/dts/vfxxx.dtsi                       |  18 +
 arch/arm/boot/dts/zynq-7000.dtsi                   |  10 +-
 arch/arm/boot/dts/zynq-microzed.dts                |  96 +++
 arch/arm/boot/dts/zynq-parallella.dts              |   2 +-
 arch/arm/boot/dts/zynq-zc702.dts                   |   2 +-
 arch/arm/boot/dts/zynq-zc706.dts                   |   2 +-
 arch/arm/boot/dts/zynq-zed.dts                     |   2 +-
 arch/arm/boot/dts/zynq-zybo.dts                    |   2 +-
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |   3 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |   3 +
 drivers/pinctrl/bcm/pinctrl-bcm2835.c              |   6 -
 include/dt-bindings/clock/r7s72100-clock.h         |   7 +
 include/dt-bindings/clock/r8a7794-clock.h          |   3 +-
 include/dt-bindings/clock/stih415-clks.h           |  16 -
 include/dt-bindings/mfd/tps65217.h                 |  26 +
 include/dt-bindings/pinctrl/bcm2835.h              |   5 +
 include/dt-bindings/pinctrl/rockchip.h             |  33 +
 include/dt-bindings/power/mt2701-power.h           |  27 +
 include/dt-bindings/power/r8a7743-sysc.h           |  25 +
 include/dt-bindings/power/r8a7745-sysc.h           |  25 +
 420 files changed, 18327 insertions(+), 8052 deletions(-)
