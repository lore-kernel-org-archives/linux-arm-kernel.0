From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Feb 2017 00:10:16 +0100
Subject: [GIT PULL 5/7] ARM: DT updates for v4.11
In-Reply-To: <8729461.VkrRdW7LzJ@wuerfel>
References: <8729461.VkrRdW7LzJ@wuerfel>
Message-ID: <10249250.AYuvEdWT4h@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit a121103c922847ba5010819a3f250f1f7fc84ab8:

  Linux 4.10-rc3 (2017-01-08 14:18:17 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt

for you to fetch changes up to a25996e733db057a27a5f90c5636c3e1e01ad33e:

  Merge tag 'mvebu-dt-4.11-4' of git://git.infradead.org/linux-mvebu into next/dt (2017-02-17 17:28:29 +0100)

----------------------------------------------------------------
ARM: DT updates for v4.11

A total of 380 patches this time, mostly adding support for more hardware
in the device tree descriptions. There is not much exciting here for 4.11,
but I've tried my best to condense the information from the pull requests
I got into a readable summary.

Noteworthy changes to existing platforms include:
  - The GIC memory map was a bit wrong almost everywhere and now
    gets fixed up
  - The Allwinner platforms convert to the generic pinmux properties
  - The Marvell EBU platforms now use the new DSA binding
  - Samsung Exynos4212 was unused and gets removed
  - The Renesas power management got improved

New production machines:
  - Lego Mindstorms EV3
    https://www.lego.com/en-us/mindstorms/about-ev3
  - Beelink X2 Android media box
    http://linux-sunxi.org/Beelink_X2
  - "Romulus" baseboard management controller for OpenPower
  - Axentia TSE-850 Data Radio Channel (DARC) encoder
    http://www.axentia.se/db/equipment.html
  - Luxul XAP-1410 and XWR-1200 wireless access points
    https://luxul.com/xap-1410

New SoCs:
  - Allwinner H2+ and V3s, both minor variations of already
    supported chips
    http://www.allwinnertech.com/index.php?c=product&a=index&id=38
  - Marvell Prestera DX packet processors based on Armada XP architecture
    http://www.marvell.com/switching/prestera-dx/
  - Samsung Exynos4412 Prime gets added, a minor variation of Exynos4412

New developer and reference boards:
  - Lichee Pi One, Lichee Pi Zero and Orange Pi Zero,
    all based on Allwinner SoCs
    http://linux-sunxi.org/LicheePi_One
    http://www.orangepi.org/orangepizero/
  - SAMA5d36ek Reference platform
    http://www.atmel.com/tools/sama5d36-ek.aspx
  - Beaglebone Green Wireless and Black Wireless
    https://beagleboard.org/black-wireless
    https://beagleboard.org/green-wireless
  - phyCORE-AM335x System on Module
    http://phytec.com/products/system-on-modules/phycore/am335x/
  - New revision of "vf610-zii" Zodiac Inflight Innovations board
  - Various i.MX System-on-Module: Is.IoT MX6UL, SavageBoard, Engicam i.Core
    http://www.opossom.com/english/index.html
    http://www.savageboard.org/
    http://www.engicam.com/en/products/embedded/som/sodimm/is-iot-mx6ul
    http://www.engicam.com/en/products/embedded/som/sodimm/i-core-m6s-dl-d-q
  - Liebherr (LWN) monitor 6 based on i.MX6 Quad, no idea what this is

Cleanups and bugfixes on at91, bcm53xx, i.MX, mvebu, omap, oxnas, qcom,
    rockchip, sti, stm32 and tegra

New device supports added to some boards and SoCs, briefly by platform:
  - Allwinner: SPDIF, A33 cpufreq, A33 Mali GPU
  - Aspeed: network, ipmi bt, gpio, pinmux
  - Broadcom: video encoder for raspberry pi, qspi, ethernet, sd/mmc
  - TI DaVinci: gpio, lcdc, usb, video-in, uart
  - TI Keystone 2: MSM RAM, power/reset, uart
  - Mediatek MT2701: clocks, iommu, spi, nand, adc, thermal
  - Marvell EBU: ethernet switch on Turris Omnia
  - NXP i.MX: otp ram, USB, wifi, bluetooth, spdif, spi, pmic,
    eeprom, mmc, nand
  - TI OMAP:
  - Qualcomm: coresight, gyro/accelerometer, hdmi
  - Renesas: pmic, soc-id
  - Rockchip: qos
  - Samsung: audio on Odroid-X
  - Socfpga: FPGA manager, i2c, led, can, watchdog, nand, power monitor
  - STi: video in/out
  - STM32: timer, pwm, i2c, rtc, add, i2s
  - NVIDIA Tegra: tpm
  - Uniphier: mmc/sd pinmux

----------------------------------------------------------------
Alan Tull (1):
      ARM: dts: socfpga: add base fpga region and fpga bridges

Alex (1):
      ARM: dts: at91: sama5d2: add ssc0 definition

Alexandre Belloni (4):
      ARM: dts: mvebu: Correct license text
      ARM: dts: imx/vf: Correct license text
      ARM: dts: at91: Enable DMA on sama5d4_xplained console
      ARM: dts: at91: Enable DMA on sama5d2_xplained console

Alexandre TORGUE (1):
      Merge commit 'f8b5036361412a27c07a4ac9c3a4b80678cbd1e1' into stm32-dt-for-v4.11

Amelie Delaunay (10):
      ARM: dts: stm32: set HSE_RTC clock frequency to 1 MHz on stm32f429
      ARM: dts: stm32: Add RTC support for STM32F429 MCU
      ARM: dts: stm32: enable RTC on stm32f429-disco
      ARM: dts: stm32: enable RTC on stm32f469-disco
      ARM: dts: stm32: enable RTC on stm32429i-eval
      ARM: dts: stm32: set HSE_RTC clock frequency to 1 MHz on stm32f429
      ARM: dts: stm32: Add RTC support for STM32F429 MCU
      ARM: dts: stm32: enable RTC on stm32f429-disco
      ARM: dts: stm32: enable RTC on stm32f469-disco
      ARM: dts: stm32: enable RTC on stm32429i-eval

Andrew Jeffery (6):
      ARM: dts: aspeed-g4: Add syscon and pin controller nodes
      ARM: dts: aspeed-g4: Add gpio controller to devicetree
      ARM: dts: aspeed-g5: Add SoC Display Controller node
      ARM: dts: aspeed-g5: Add LPC Controller node
      ARM: dts: aspeed-g5: Add syscon and pin controller nodes
      ARM: dts: aspeed-g5: Add gpio controller to devicetree

Andrey Smirnov (2):
      ARM: dts: vf610-zii-dev-rev-b: Remove leftover PWM pingroup
      ARM: dts: vf610-zii-dev: Add .dts file for rev. C

Andy Yan (1):
      ARM: dts: rockchip: use pin constants to describe gpios

Arnd Bergmann (10):
      Merge tag 'mvebu-dt-4.11-3' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'stm32-dt-for-v4.11-2' of git://git.kernel.org/.../atorgue/stm32 into next/dt
      Merge tag 'ux500-dt-1' of git://git.kernel.org/.../linusw/linux-stericsson into next/dt
      Merge tag 'samsung-dt-4.11-3' of git://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'socfpga_dts_for_v4.11_part_2' of git://git.kernel.org/.../dinguyen/linux into next/dt
      Merge tag 'sunxi-dt-for-4.11' of https://git.kernel.org/.../mripard/linux into next/dt
      Merge tag 'sunxi-dt-for-4.11-2' of https://git.kernel.org/.../mripard/linux into next/dt
      Merge tag 'davinci-for-v4.11/dt-2' of git://git.kernel.org/.../nsekhar/linux-davinci into next/dt
      Merge tag 'omap-for-v4.11/dt-late' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'mvebu-dt-4.11-4' of git://git.infradead.org/linux-mvebu into next/dt

Axel Haslam (2):
      ARM: dts: da850: Add usb device node
      ARM: dts: da850-lcdk: Enable ohci for omapl138 lcdk

Bai Ping (1):
      ARM: dts: imx: Add ocotp node for imx6ul

Bartlomiej Zolnierkiewicz (2):
      clk: samsung: Add CPU clk configuration data for Exynos4412 Prime
      ARM: dts: exynos: Add CPU OPPs for Exynos4412 Prime

Bartosz Golaszewski (7):
      ARM: dts: da850-lcdk: add gpio-keys
      ARM: dts: da850: rename the display node label
      ARM: dts: da850-lcdk: add the vga-bridge node
      ARM: dts: da850: specify the maximum pixel clock rate for tilcdc
      devicetree: bindings: add bindings for ahci-da850
      ARM: dts: da850: add the SATA node
      ARM: dts: da850-lcdk: enable the SATA node

Benjamin Gaignard (2):
      ARM: dts: stm32: add Timers driver for stm32f429 MCU
      ARM: dts: stm32: Enable pwm1 and pwm3 for stm32f469-disco

Bjorn Andersson (7):
      ARM: dts: qcom: msm8974: Add USB gadget nodes
      ARM: dts: msm8974: Add ADSP smp2p and smd nodes
      ARM: dts: msm8974: Add ADSP PIL node
      ARM: dts: qcom: apq8064: Add riva-pil node
      ARM: dts: qcom: apq8064-sony-yuga: Enable riva-pil
      ARM: dts: qcom: sd600-eval: pm8921_s2 regulator properties
      ARM: dts: qcom: sd600eval: Enable riva-pil

Boris Brezillon (2):
      ARM: dts: bcm283x: Add VEC node in bcm283x.dtsi
      ARM: dts: bcm283x: Enable the VEC IP on all RaspberryPi boards

Breno Lima (3):
      ARM: dts: udoo_neo: Add UDOO Neo USB OTG1 and OTG2 support
      ARM: dts: udoo_neo: Add Wifi support
      ARM: dts: udoo_neo: Add Bluetooth support

Bruno Herrera (2):
      ARM: dts: stm32: Fix memory size from 8MB to 16MB on stm32f469-disco board
      ARM: dts: stm32: Fix memory size from 8MB to 16MB on stm32f469-disco board

Bruno Meirelles Herrera (2):
      ARM: dts: stm32: Add missing USART3 pin config to stm32f469-disco board
      ARM: dts: stm32: Add missing USART3 pin config to stm32f469-disco board

Chen-Yu Tsai (8):
      ARM: dts: sunxi: Explicitly enable pull-ups for MMC pins
      ARM: dts: sun6i: hummingbird: Enable USB OTG
      ARM: dts: sun8i: Add codec analog path controls node in PRCM for A23/A33
      ARM: dts: sun8i-a23: Add device node for internal audio codec
      ARM: dts: sun8i-a23: q8-tablet: Enable internal audio codec
      ARM: dts: sun8i-h3: Add device nodes for audio codec and its analog controls
      ARM: dts: sun8i-h3: orange-pi-pc: Enable audio codec
      ARM: dts: sun6i: sina31s: Enable USB OTG controller in peripheral mode

Chris Brandt (4):
      ARM: dts: r7s72100: add ostm clock to device tree
      ARM: dts: r7s72100: add ostm to device tree
      ARM: dts: rskrza1: add ostm DT support
      ARM: dts: r7s72100: add power-domains to mmcif

Chris Packham (3):
      ARM: dts: mvebu: Add device tree for 98DX3236 SoCs
      ARM: dts: mvebu: Add device tree for db-dxbc2 and db-xc3-24g4xg boards
      ARM: dts: Fix typo in armada-xp-98dx4251

Christopher Spinrath (2):
      ARM: dts: imx6q-cm-fx6: enable S/PDIF support
      ARM: dts: imx6q-utilite-pro: enable 2nd display pipeline

Cyril Bur (2):
      ARM: dts: aspeed: Reserve framebuffer memory
      ARM: dts: aspeed: Correct palmetto device tree

Dan Haab (2):
      ARM: dts: BCM5301X: Add DT for Luxul XAP-1410
      ARM: dts: BCM5301X: Add DT for Luxul XWR-1200

David Lechner (6):
      ARM: dts: keystone: Add "ti,da830-uart" compatible string
      ARM: dts: da850: Add ti,da830-uart compatible for serial ports
      dt-bindings: Add vendor prefix for LEGO
      dt-bindings: Add LEGO MINDSTORMS EV3 compatible specification
      dt-bindings: add "microchip,24c128" compatible string
      ARM: dts: Add LEGO MINDSTORMS EV3 dts

Dawei Chien (1):
      arm: dts: mt2701: Add thermal device node.

Dinh Nguyen (11):
      ARM: dts: socfpga: enable GPIO and LEDs for Cyclone5 and Arria5 devkits
      ARM: dts: socfpga: set desired i2c clock on Cyclone5 and Arria5 devkits
      ARM: dts: socfpga: Add Rohm DH2228FV DAC
      ARM: dts: socfpga: enable CAN on Cyclone5 devkit
      ARM: dts: socfpga: enable watchdog timer on Arria5 and Arria10
      ARM: dts: socfpga: add the LTC2977 power monitor on Arria10 devkit
      ARM: dts: socfpga: add fpga-manager node for Arria10
      ARM: dts: socfpga: fpga manager data is 32 bits
      ARM: dts: socfpga: add fpga region support on Arria10
      ARM: dts: socfpga: add missing compatible string for SDRAM controller
      ARM: dts: watchdog0 cannot reliably trigger reset

Elaine Zhang (1):
      ARM: dts: rockchip: add qos node for rk3288

Emmanuel Vadot (3):
      ARM: dts: sunxi: Use axp209.dtsi for Olinuxino Lime2
      ARM: dts: sunxi: Add num-cs for A20 spi nodes
      ARM: dts: sunxi: Enable UEXT related nodes for Olimex A20 SOM EVB

Enric Balletbo i Serra (6):
      ARM: dts: am335x-sl50: Remove I2C1 node.
      ARM: dts: am335x-sl50: Enable UART1.
      ARM: dts: am335x-sl50: Enable SPI0 interface and Flash Memory.
      ARM: dts: am335x-sl50: Enable BQ32000 Real Time Clock.
      ARM: dts: am335x-sl50: Enable the MCP23017 GPIO Expander.
      ARM: dts: am335x-sl50: Enable the Ambient Light Sensor.

Fabio Estevam (4):
      ARM: dts: imx: Adjust CPU nodes
      ARM: dts: imx6sx-udoo-neo: Pass the 'phy-reset-duration' property
      ARM: dts: imx: Remove unexistant property
      ARM: dts: imx53-qsb: Provide the TVE DAC regulators

Fabrice GASNIER (4):
      ARM: dts: stm32: Add ADC support to stm32f429
      ARM: dts: stm32: enable ADC on stm32f429i-eval board
      ARM: dts: stm32: Add ADC support to stm32f429
      ARM: dts: stm32: enable ADC on stm32f429i-eval board

Florian Fainelli (9):
      Merge tag 'bcm2835-dt-next-2017-01-17' into devicetree/next
      ARM: dts: armada-370-rd: Utilize new DSA binding
      ARM: dts: armada-385-linksys: Utilize new DSA binding
      ARM: dts: armada-388-clearfog: Utilize new DSA binding
      ARM: dts: armada-xp-linksys-mamba: Utilize new DSA binding
      ARM: dts: kirkwood-dir665: Utilize new DSA binding
      ARM: dts: kirkwood-linksys-viper: Utilize new DSA binding
      ARM: dts: kirkwood-mv88f6281gtw-ge: Utilize new DSA binding
      ARM: dts: kirkwood-rd88f6281: Utilize new DSA binding

Gabriel Fernandez (9):
      clk: stm32f4: Update DT bindings documentation
      clk: stm32f4: Update DT bindings documentation
      ARM: dts: stm32: Add external I2S clock on stm32f429 MCU
      ARM: dts: stm32: Include auxiliary stm32fx clock definition
      ARM: dts: stm32: Add external I2S clock on stm32f429 MCU
      ARM: dts: stm32: Include auxiliary stm32fx clock definition
      dt-bindings: mfd: stm32f4: Fix STM32F4_X_CLOCK() macro
      dt-bindings: mfd: stm32f4: Add missing binding definition
      ARM: dts: stm32: Use clock DT binding definition on stm32f429 family

Gary Bisson (1):
      ARM: dts: boundary: remove hardcoded LVDS bus format

Geert Uytterhoeven (8):
      ARM: dts: r8a7743: Move RST node before SYSC node
      ARM: dts: r8a7745: Move RST node before SYSC node
      ARM: dts: r8a7743: Add device node for PRR
      ARM: dts: r8a7745: Add device node for PRR
      ARM: dts: gose: Add da9063 PMIC device node for system restart
      ARM: dts: r8a7779, marzen: Fix sata device status
      ARM: dts: r8a7743: Link ARM GIC to clock and clock domain
      ARM: dts: r8a7745: Link ARM GIC to clock and clock domain

Graham Moore (1):
      ARM: dts: socfpga: Add NAND device tree for Arria10

Grygorii Strashko (2):
      ARM: dts: dra72-evm-revc: enable irqs for dp83867 eth phys
      ARM: dts: am57xx-beagle-x15: implement errata "Ethernet RGMII2 Limited to 10/100 Mbps"

Heiko Stuebner (1):
      ARM: dts: rockchip: add soc-specific uart compatibles for rk3066/rk3188

Honghui Zhang (1):
      ARM: dts: mt2701: add iommu/smi dtsi node for mt2701

Hugues Fruchet (1):
      ARM: dts: STiH410: add DELTA dt node

Icenowy Zheng (11):
      ARM: dts: sunxi: add support for Orange Pi Zero board
      ARM: dts: sun8i: add a cpu0 label to cpu at 0 node on A23/33
      ARM: dts: sun8i: set cpu-supply in reference tablet DTSI
      ARM: dts: sun8i: add opp-v2 table for A33
      ARM: dts: sun8i: add a delay after reset xr819 on Orange Pi Zero
      ARM: dts: sun5i: add a pinctrl node for 4bit mmc2
      dt-bindings: add vendor prefix for Lichee Pi
      ARM: dts: sun5i: add support for Lichee Pi One board
      devicetree: bindings: Add vendor prefix for Shenzhen Xunlong Software
      ARM: dts: sunxi: add dtsi file for V3s SoC
      ARM: dts: sunxi: add support for Lichee Pi Zero board

Ivan T. Ivanov (1):
      ARM: dts: qcom: Add apq8064 CoreSight components

Jagan Teki (6):
      ARM: dts: imx6dl: Add Engicam i.CoreM6 DualLite/Solo RQS initial support
      ARM: dts: imx6q-icore-rqs: Update model to support Dual SOM
      ARM: dts: imx6ul: Add Engicam Is.IoT MX6UL initial support
      ARM: dts: imx6qdl: Fix "ERROR: code indent should use tabs where possible"
      ARM: dts: imx6ul: Add Engicam Is.IoT MX6UL eMMC initial support
      ARM: dts: imx6ul: Add Engicam Is.IoT MX6UL NAND initial support

James Liao (3):
      arm: dts: mt2701: Sort DT nodes by register address
      arm: dts: mt2701: Add subsystem clock controller device nodes
      arm: dts: mt2701: Add power domain controller device node

Javier Martinez Canillas (1):
      ARM: dts: exynos: Increase MFC left reserved memory region size

Jerome Coste (1):
      ARM: tegra: nyan-blaze: Proper pinmux for TPM I2C

Joel Stanley (2):
      ARM: dts: aspeed: Add ftgmac100 to g4 and g5 platforms
      ARM: dts: aspeed: Add Romulus BMC platform

John Crispin (1):
      ARM: dts: mediatek: update my email address

Jon Mason (7):
      ARM: dts: NSP: DT Clean-ups
      ARM: dts: NSP: Correct NAND partition unit address
      ARM: dts: NSP: Add QSPI support to missing boards
      ARM: dts: NSP: Add BCM958625K switch ports
      ARM: dts: NSP: Add and enable amac2
      ARM: dts: NSP: Add Ethernet to NSP XMC
      ARM: dts: NSP: Add SD/MMC support

J?rg Krause (3):
      ARM: dts: imx28: Add simple-card support
      ARM: dts: sun7i: Enable audio codec on Banana Pro
      ARM: dts: sun7i: Add wifi dt node on Banana Pro

Kevin Hilman (3):
      ARM: dts: davinci: da850: VPIF: add node and muxing
      ARM: dts: davinci: da850-evm: enable VPIF
      ARM: dts: davinci: da850-lcdk: enable VPIF

Kishon Vijay Abraham I (1):
      ARM: dts: dra7-evm: add pinmux configuration for mmc1/2

Krzysztof Kozlowski (2):
      Merge tag 'clk-v4.11-exynos4-pll' of git://linuxtv.org/snawrocki/samsung into next/dt
      ARM: dts: exynos: Fix indentation of EHCI and OHCI ports

Ladislav Michl (1):
      ARM: dts: omap3-igep: Remove NAND partition table

Laurent Pinchart (1):
      ARM: omap3: beagleboard-xm: dt: Add ethernet to the device tree

Leilk Liu (1):
      arm: dts: mt2701: Add spi device node

Linus Walleij (6):
      ARM: dts: rename MSM8660/APQ8060 pmicintc to pm8058
      ARM: dts: reference PM8058 as IRQ parent
      ARM: dts: Add gyro and accel to APQ8060 Dragonboard
      ARM: dts: push MMC/SD to board and add comments
      ARM: dts: Ux500: move USB PHY pins to PHY device
      ARM: dts: add the AB8500 sysclk to the device trees

Lokesh Vutla (4):
      ARM: dts: am33xx: Add stdout-path property
      ARM: dts: am43xx: Add stdout-path property
      ARM: dts: am57xx: Add stdout-path property
      ARM: dts: dra7xx: Add stdout-path property

Lucas Stach (4):
      ARM: imx6: fix min/max voltage of anatop 2p5 regulator
      ARM: imx6: fix regulator constraints on anatop 1p1 and 2p5
      ARM: imx6qp: adapt DT to changed FEC interrupts
      ARM: imx6: remove unit address from LDB node

Lukasz Majewski (2):
      Doc: devicetree: bindings: Add vendor prefix entry - lwn
      ARM: dts: imx6q: Add mccmon6 board support

M'boumba Cedric Madianga (2):
      ARM: dts: stm32: Add I2C1 support for STM32F429 SoC
      ARM: dts: stm32: Add I2C1 support for STM32429 eval board

Marc Dietrich (1):
      ARM: tegra: paz00: Mark panel regulator as enabled on boot

Marc Gonzalez (3):
      ARM: dts: tango4: Add alias for eth0
      ARM: dts: tango4: Import MMC nodes
      ARM: dts: tango4: Import USB nodes

Marc Zyngier (2):
      dt-bindings: arm,gic: Fix binding example for a virt-capable GIC
      ARM: DTS: Fix register map for virt-capable GIC

Marcel Ziswiler (5):
      ARM: tegra: apalis-tk1: Pull-up temperature alert
      ARM: tegra: apalis-tk1: Optional DisplayPort hot-plug detect
      ARM: tegra: apalis-tk1: Adjust pin muxing for v1.1 HW
      ARM: tegra: apalis-tk1: Fix SD card detect on v1.1 HW
      ARM: tegra: apalis-tk1: Update compatibility comment

Marcin Niestroj (3):
      ARM: dts: am335x-chilisom: Wakeup from RTC-only state by power on event
      ARM: dts: am335x-chiliboard: Support power button
      ARM: dts: am335x-chiliboard: Support charger

Marcus Cooper (9):
      ARM: dts: sun6i: Mele I7: Enable internal audio codec
      ARM: dts: sun6i: Add SPDIF TX pin to the A31
      ARM: dts: sun6i: Add the SPDIF block to the A31
      ARM: dts: sun4i: A1000: add axp209 regulator nodes
      ARM: dts: sun6i: Add SPDIF to the Mele I7
      ARM: dts: sun8i-h3: Add dts for the Beelink X2 STB
      ARM: dts: sun8i-h3: Add SPDIF TX pin to the H3
      ARM: dts: sun8i-h3: Add the SPDIF block to the H3
      ARM: dts: sun8i-h3: Add SPDIF to the Beelink X2

Marek Szyprowski (5):
      ARM: dts: exynos: Correct clocks for Exynos4 I2S module
      ARM: dts: exynos: Fix initial audio clocks configuration on Exynos4 boards
      ARM: dts: exynos: Enable DMA support for UART modules on Exynos5 SoCs
      ARM: dts: exynos: remove Exynos4212 support (dead code)
      ARM: dts: exynos: Add labels to all existing power domains

Mark Jackson (1):
      ARM: dts: Update Nanobone dts file to add external FRAM chip

Markus Reichl (1):
      ARM: dts: exynos: Cleanup Odroid-X2 and enable sound on Odroid-X

Martin Kaiser (1):
      ARM: dts: imx25.dtsi: DryIce security violation interrupt

Masahiro Yamada (2):
      ARM: dts: uniphier: add eMMC pin-mux node
      ARM: dts: uniphier: add SD pin-mux node

Maxime Ripard (8):
      ARM: sunxi: Remove useless allwinner,drive property
      ARM: sunxi: Remove useless allwinner,pull property
      ARM: sunxi: Convert pinctrl nodes to generic bindings
      ARM: sun8i: a23/a33: Enable the real LOSC and use it
      ARM: sun8i: a23/a33: Add the oscillators accuracy
      ARM: sun8i: sina33: Enable display
      dt-bindings: gpu: Add Mali Utgard bindings
      ARM: sun8i: dt: Add mali node

Milo Kim (3):
      ARM: dts: imx6: Add Savageboard common file
      ARM: dts: imx6: Support Savageboard dual
      ARM: dts: imx6: Support Savageboard quad

Murali Karicheri (1):
      ARM: keystone: dts: fix netcp clocks and add names

Myl?ne Josserand (3):
      ARM: dts: sun8i: Add audio codec, dai and card for A33
      ARM: dts: sun8i: parrot: Enable audio nodes
      ARM: dts: sun8i: sinlinx: Enable audio nodes

Neil Armstrong (2):
      ARM: dts: OX810: Update with dt-bindings includes
      ARM: dts: OX820: Update with dt-bindings includes

Nicolas Ferre (5):
      ARM: dts: at91: sama5d4: change DMA allocation for secure peripherals
      ARM: dts: at91: sama5d4 Xplained: enable UART1 node with DMA
      ARM: dts: at91: add dma1 definition to sama5d2
      ARM: dts: at91: sama5d2: move UART3 to DMA1
      ARM: dts: at91: sama5d2 Xplained: use DMA for UART3

Olof Johansson (27):
      Merge tag 'renesas-dt-for-v4.11' of https://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'oxnas-arm-soc-dt-for-4.11' of https://github.com/OXNAS/linux into next/dt
      Merge tag 'sunxi-generic-pinconf-for-4.10' of https://git.kernel.org/.../mripard/linux into next/dt
      Merge tag 'socfpga_dts_for_v4.11_part_1' of git://git.kernel.org/.../dinguyen/linux into next/dt
      Merge tag 'sti-dt-for-v4.11' of git://git.kernel.org/.../pchotard/sti into next/dt
      Merge tag 'samsung-dt-4.11' of git://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'mvebu-dt-4.11-1' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'stm32-dt-for-v4.11-1' of git://git.kernel.org/.../atorgue/stm32 into next/dt
      Merge tag 'at91-ab-4.11-dt' of git://git.kernel.org/.../abelloni/linux into next/dt
      Merge tag 'aspeed-4.11-devicetree' of git://git.kernel.org/.../joel/aspeed into next/dt
      Merge tag 'arm-soc/for-4.11/devicetree' of http://github.com/Broadcom/stblinux into next/dt
      Merge tag 'v4.11-rockchip-dts32-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'keystone_dts_for_4.11' of git://git.kernel.org/.../ssantosh/linux-keystone into next/dt
      Merge tag 'uniphier-dt-v4.11' of git://git.kernel.org/.../masahiroy/linux-uniphier into next/dt
      Merge tag 'qcom-dts-for-4.11' of git://git.kernel.org/.../agross/linux into next/dt
      Merge tag 'davinci-for-v4.11/dt' of git://git.kernel.org/.../nsekhar/linux-davinci into next/dt
      Merge tag 'omap-for-v4.11/dt-signed-v2' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'v4.10-next-dts32' of https://github.com/mbgg/linux-mediatek into next/dt
      Merge tag 'renesas-dt2-for-v4.11' of https://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'at91-ab-4.11-dt2' of git://git.kernel.org/.../abelloni/linux into next/dt
      Merge tag 'tegra-for-4.11-arm-dt' of git://git.kernel.org/.../tegra/linux into next/dt
      Merge branch 'sti-dt-for-v4.11-round2' of git://git.kernel.org/.../pchotard/sti into next/dt
      Merge tag 'mvebu-dt-4.11-2' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'imx-fixes-nc-4.11' of git://git.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'imx-dt-4.11' of git://git.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'samsung-dt-4.11-2' of git://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'stm32-dt-for-v4.11-1-v2' of git://git.kernel.org/.../atorgue/stm32 into next/dt

Patrice Chotard (11):
      ARM: dts: STiH410-B2120: enable sti-hda at board level
      ARM: dts: STiH410: add hqvdp node
      ARM: dts: STiH407-family: disable fdma1 and fdma2
      ARM: dts: STiH410-family: fix wrong parent clock frequency
      ARM: dts: STiH407-family: update gp0_reserved memory region
      ARM: dts: STiH407-family: remove audio remoteproc node
      ARM: dts: STiH407-family: remove gp1 remoteproc node
      ARM: dts: STiH407-family: update dmu remoteproc node
      ARM: dts: STiH407-family: Supply mailbox properties to GP0 RProc
      ARM: dts: STiH407-family: Supply Mailbox properties to delta RProc
      ARM: dts: STiH407-family: Add missing pwm irq

Patrick Bruenn (1):
      ARM: dts: imx53-qsb-common: fix FEC pinmux config

Paul Kocialkowski (5):
      ARM: tegra: nyan: Use proper IRQ type definitions
      ARM: tegra: nyan: Use external control for bq24735 charger
      ARM: tegra: nyan-big: Include compatible revisions for proper detection
      ARM: tegra: nyan-blaze: Include compatible revisions for proper detection
      ARM: tegra: nyan-big: Proper pinmux for TPM I2C

Pavel Machek (1):
      ARM: dts: n900: cleanup

Peter Rosin (2):
      ARM: dts: at91: sama5d3_uart: fix reg sizes to match documentation
      ARM: dts: at91: add devicetree for the Axentia TSE-850

Quentin Schulz (6):
      dt-bindings: power: axp20x-usb: add axp223 compatible
      ARM: dts: add DTSI for AXP223
      ARM: dts: sun8i: a33-olinuxino: use AXP223 DTSI
      ARM: dts: sun8i: sina33: use AXP223 DTSI
      ARM: dts: sun8i: parrot: use AXP223 DTSI
      ARM: dts: sun8i: reference-design: use AXP223 DTSI

Rafa? Mi?ecki (7):
      ARM: dts: BCM5301X: Enable UART by default for BCM4708(1), BCM4709(4) & BCM53012
      ARM: dts: BCM5301X: Fix LAN LED labels for Luxul XWR-3100
      ARM: dts: BCM5301X: Specify USB controllers in DT
      ARM: dts: BCM5301X: Set GPIO enabling USB power on Netgear R7000
      ARM: dts: BCM5301X: Specify all RAM by including an extra block
      ARM: dts: BCM53573: Specify USB ports of on-SoC controllers
      ARM: dts: BCM5301X: Set 5 GHz wireless frequency limits on Netgear R8000

Ralph Sennhauser (1):
      ARM: dts: armada-385-linksys: fix DSA compatible property

Rask Ingemann Lambertsen (1):
      ARM: dts: tegra: Fix missing card detection in Trimslice ?SD card slot

Robert Nelson (4):
      ARM: dts: Move most of am335x-boneblack.dts to am335x-boneblack-common.dtsi
      ARM: dts: Add am335x-boneblack-wireless
      ARM: dts: Move most of am335x-bonegreen.dts to am335x-bonegreen-common.dtsi
      ARM: dts: Add am335x-bonegreen-wireless

Russell King (14):
      ARM: dts: armada388-clearfog: fix SPI flash #size-cells
      ARM: dts: armada388-clearfog: move SPI flash into microsom
      ARM: dts: armada388-clearfog: move sdhci pinctrl node to microsom
      ARM: dts: armada388-clearfog: split clearfog DTS file
      ARM: dts: armada388-clearfog: move DSA switch
      ARM: dts: armada388-clearfog: move second PCIe port
      ARM: dts: armada388-clearfog: move SPI CS1
      ARM: dts: armada388-clearfog: move rear button
      ARM: dts: armada388-clearfog: add base model DTS file
      ARM: dts: armada388-clearfog: add pro model DTS file
      ARM: dts: armada388-clearfog: move device specific pinctrl nodes
      ARM: dts: armada388-clearfog: move I2C nodes
      ARM: dts: armada388-clearfog: move ethernet related nodes
      ARM: dts: armada388-clearfog: move uart nodes

Sascha Hauer (4):
      ARM: dts: imx7s-warp: Fix watchdog pinmux
      ARM: dts: imx7d-sdb: Fix watchdog and pwm pinmux
      ARM: dts: imx7d-cl-som: Fix OTG power pinctrl
      ARM: dts: imx7: Add "LPSR" to LPSR iomux pin names

Sekhar Nori (2):
      ARM: dts: dra7-evm: Remove pinmux configurations for erratum i869
      ARM: dts: dra72-evm: drop NAND support

Simon Horman (20):
      ARM: dts: r8a73a4: Use SoC-specific compat string for mmcif
      ARM: dts: r8a7778: Use SoC-specific compat string for mmcif
      ARM: dts: sh73a0: Use SoC-specific compat string for mmcif
      ARM: dts: r8a7790: Use renesas,rcar-gen2-usb-phy fallback binding
      ARM: dts: r8a7791: Use renesas,rcar-gen2-usb-phy fallback binding
      ARM: dts: r8a7794: Use renesas,rcar-gen2-usb-phy fallback binding
      ARM: dts: r8a7779: Use R-Car Gen 1 fallback binding for i2c nodes
      ARM: dts: r8a7778: Use R-Car Gen 1 fallback binding for i2c nodes
      ARM: dts: r8a7790: Use R-Car Gen 2 fallback binding for i2c nodes
      ARM: dts: r8a7791: Use R-Car Gen 2 fallback binding for i2c nodes
      ARM: dts: r8a7792: Use R-Car Gen 2 fallback binding for i2c nodes
      ARM: dts: r8a7793: Use R-Car Gen 2 fallback binding for i2c nodes
      ARM: dts: r8a7794: Use R-Car Gen 2 fallback binding for i2c nodes
      ARM: dts: r8a7790: Use R-Car Gen 2 fallback binding for iic nodes
      ARM: dts: r8a7791: Use R-Car Gen 2 fallback binding for iic nodes
      ARM: dts: r8a7793: Use R-Car Gen 2 fallback binding for iic nodes
      ARM: dts: r8a7794: Use R-Car Gen 2 fallback binding for iic nodes
      ARM: dts: r8a7791: Use R-Car Gen 2 fallback binding for msiof nodes
      ARM: dts: r8a7792: Use R-Car Gen 2 fallback binding for msiof nodes
      ARM: dts: r8a7790: Use R-Car Gen 2 fallback binding for msiof nodes

Srinivas Kandagatla (4):
      ARM: dts: apq8064: add support to pm8821
      ARM: dts: move hdmi pinctrl out of board file.
      ARM: dts: sd-600eval: add hdmi support
      ARM: dts: sd-600eval: enable 1.8v regulator on LS expansion

Stephen Boyd (2):
      ARM: dts: msm8974: Remove "unused" reserved region
      arm: dts: qcom: Fix ipq board clock rates

Suman Anna (12):
      ARM: dts: keystone-k2hk: Add MSM RAM node
      ARM: dts: keystone-k2l: Add MSM RAM node
      ARM: dts: keystone-k2e: Add MSM RAM node
      ARM: dts: keystone-k2g: Add MSM RAM node
      ARM: dts: keystone-k2hk: Reserve MSM RAM for boot monitor
      ARM: dts: keystone-k2l: Reserve MSM RAM for boot monitor
      ARM: dts: keystone-k2e: Reserve MSM RAM for boot monitor
      ARM: dts: keystone-k2g: Reserve MSM RAM for boot monitor
      ARM: dts: keystone: Add PSC node
      ARM: dts: keystone-k2hk: Add PSC reset controller node
      ARM: dts: keystone-k2l: Add PSC reset controller node
      ARM: dts: keystone-k2e: Add PSC reset controller node

S?bastien Szymanski (1):
      ARM: dts: add Armadeus Systems OPOS6UL and OPOS6ULDEV support

Teresa Remmet (7):
      ARM: dts: am335x-phycore-som: Update compatible string for spi nor
      ARM: dts: am335x-phycore-som: Add i2c temp sensor
      ARM: dts: am335x-wega: Set USB0 mode to otg
      ARM: dts: am335x-phycore-som: Update ethernet phy node
      ARM: dts: am335x-wega: Update ethernet phy node
      ARM: dts: am335x-phycore-som: Remove partition tables
      ARM: dts: Add support for phyCORE-AM335x PCM-953 carrier board

Thor Thayer (1):
      ARM: dts: Add EMAC AXI settings for Arria10

Tim Harvey (2):
      ARM: dts: imx: add SPI to GW54xx
      ARM: dts: imx: ventana: add LTC3676 PMIC support

Tomi Valkeinen (1):
      ARM: dts: dra72/1-evm: add pcf8575 used for lcd

Tony Lindgren (4):
      ARM: dts: pandaboard: Allow bootloader to configure USB Ethernet MAC
      ARM: dts: omap5-uevm: Allow bootloader to configure USB Ethernet MAC
      ARM: dts: omap5-igep0050: Allow bootloader to configure USB Ethernet MAC
      ARM: dts: Configure BeagleBone peripheral USB VBUS irq

Uwe Kleine-K?nig (1):
      ARM: dts: turris-omnia: add support for ethernet switch

Vivien Didelot (1):
      ARM: dts: vf610-zii-dev: add EEPROM entry to Rev C

Vladimir Zapolskiy (1):
      ARM: dts: imx: remove obsoleted property fsl,spi-num-chipselects

Wenyou Yang (1):
      ARM: dts: at91: add dts file for sama5d36ek CMP board

Xiaolei Li (1):
      arm: dts: mt2701: Add nand device node

Zhiyong Tao (1):
      arm: dts: mt2701: Add auxadc device node.

 Documentation/devicetree/bindings/arm/axentia.txt  |  19 +
 Documentation/devicetree/bindings/arm/davinci.txt  |   4 +
 .../devicetree/bindings/arm/marvell/98dx3236.txt   |  23 +
 .../devicetree/bindings/arm/omap/omap.txt          |   3 +
 .../devicetree/bindings/ata/ahci-da850.txt         |  18 +
 .../devicetree/bindings/clock/st,stm32-rcc.txt     |  17 +
 .../devicetree/bindings/eeprom/eeprom.txt          |   2 +
 .../devicetree/bindings/gpu/arm,mali-utgard.txt    |  81 ++
 .../bindings/interrupt-controller/arm,gic.txt      |   2 +-
 .../devicetree/bindings/net/marvell,prestera.txt   |  50 ++
 .../bindings/power/supply/axp20x_usb_power.txt     |   5 +
 .../devicetree/bindings/vendor-prefixes.txt        |   5 +
 MAINTAINERS                                        |   8 +
 arch/arm/boot/dts/Makefile                         |  32 +-
 arch/arm/boot/dts/alpine.dtsi                      |   2 +-
 arch/arm/boot/dts/am335x-bone-common.dtsi          |   2 +
 arch/arm/boot/dts/am335x-boneblack-common.dtsi     | 163 ++++
 arch/arm/boot/dts/am335x-boneblack-wireless.dts    | 109 +++
 arch/arm/boot/dts/am335x-boneblack.dts             | 155 +---
 arch/arm/boot/dts/am335x-bonegreen-common.dtsi     |  44 ++
 arch/arm/boot/dts/am335x-bonegreen-wireless.dts    | 126 +++
 arch/arm/boot/dts/am335x-bonegreen.dts             |  38 +-
 arch/arm/boot/dts/am335x-chiliboard.dts            |  16 +
 arch/arm/boot/dts/am335x-chilisom.dtsi             |   8 +
 arch/arm/boot/dts/am335x-evm.dts                   |   4 +
 arch/arm/boot/dts/am335x-evmsk.dts                 |   4 +
 arch/arm/boot/dts/am335x-icev2.dts                 |   4 +
 arch/arm/boot/dts/am335x-nano.dts                  |  31 +-
 arch/arm/boot/dts/am335x-pcm-953.dtsi              | 288 +++++++
 arch/arm/boot/dts/am335x-phycore-rdk.dts           |  27 +
 arch/arm/boot/dts/am335x-phycore-som.dtsi          |  72 +-
 arch/arm/boot/dts/am335x-sl50.dts                  |  70 +-
 arch/arm/boot/dts/am335x-wega.dtsi                 |   9 +-
 arch/arm/boot/dts/am437x-gp-evm.dts                |   4 +
 arch/arm/boot/dts/am437x-idk-evm.dts               |   4 +
 arch/arm/boot/dts/am437x-sk-evm.dts                |   4 +
 arch/arm/boot/dts/am43x-epos-evm.dts               |   4 +
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi    |  18 +-
 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts      |   5 +
 arch/arm/boot/dts/am57xx-beagle-x15.dts            |   5 +
 arch/arm/boot/dts/am57xx-idk-common.dtsi           |   4 +
 arch/arm/boot/dts/armada-370-db.dts                |  10 +-
 arch/arm/boot/dts/armada-370-dlink-dns327l.dts     |  10 +-
 arch/arm/boot/dts/armada-370-mirabox.dts           |  10 +-
 arch/arm/boot/dts/armada-370-netgear-rn102.dts     |  10 +-
 arch/arm/boot/dts/armada-370-netgear-rn104.dts     |  10 +-
 arch/arm/boot/dts/armada-370-rd.dts                |  54 +-
 arch/arm/boot/dts/armada-370-synology-ds213j.dts   |  10 +-
 arch/arm/boot/dts/armada-370-xp.dtsi               |  10 +-
 arch/arm/boot/dts/armada-370.dtsi                  |  10 +-
 arch/arm/boot/dts/armada-375-db.dts                |  10 +-
 arch/arm/boot/dts/armada-375.dtsi                  |  10 +-
 arch/arm/boot/dts/armada-380.dtsi                  |  10 +-
 arch/arm/boot/dts/armada-385-linksys.dtsi          |  52 +-
 arch/arm/boot/dts/armada-385-turris-omnia.dts      |  58 +-
 arch/arm/boot/dts/armada-385.dtsi                  |  10 +-
 arch/arm/boot/dts/armada-388-clearfog-base.dts     | 109 +++
 arch/arm/boot/dts/armada-388-clearfog-pro.dts      |  55 ++
 arch/arm/boot/dts/armada-388-clearfog.dts          | 435 ++++------
 arch/arm/boot/dts/armada-388-clearfog.dtsi         | 307 +++++++
 arch/arm/boot/dts/armada-388-db.dts                |  10 +-
 arch/arm/boot/dts/armada-388-rd.dts                |  10 +-
 .../arm/boot/dts/armada-38x-solidrun-microsom.dtsi | 130 +--
 arch/arm/boot/dts/armada-38x.dtsi                  |  10 +-
 arch/arm/boot/dts/armada-390-db.dts                |  10 +-
 arch/arm/boot/dts/armada-390.dtsi                  |  10 +-
 arch/arm/boot/dts/armada-395.dtsi                  |  10 +-
 arch/arm/boot/dts/armada-398-db.dts                |  10 +-
 arch/arm/boot/dts/armada-398.dtsi                  |  10 +-
 arch/arm/boot/dts/armada-39x.dtsi                  |  10 +-
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi          | 254 ++++++
 arch/arm/boot/dts/armada-xp-98dx3336.dtsi          |  76 ++
 arch/arm/boot/dts/armada-xp-98dx4251.dtsi          |  90 +++
 arch/arm/boot/dts/armada-xp-axpwifiap.dts          |  10 +-
 arch/arm/boot/dts/armada-xp-db-dxbc2.dts           | 151 ++++
 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts      | 142 ++++
 arch/arm/boot/dts/armada-xp-db.dts                 |  10 +-
 arch/arm/boot/dts/armada-xp-gp.dts                 |  10 +-
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts    |  10 +-
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts      |  53 ++
 arch/arm/boot/dts/armada-xp-matrix.dts             |  10 +-
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |  10 +-
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |  10 +-
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |  10 +-
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts     |  10 +-
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   |  10 +-
 arch/arm/boot/dts/armada-xp-synology-ds414.dts     |  10 +-
 arch/arm/boot/dts/armada-xp.dtsi                   |  10 +-
 arch/arm/boot/dts/aspeed-ast2500-evb.dts           |  14 +
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts      |  24 +-
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts       |  45 ++
 arch/arm/boot/dts/aspeed-g4.dtsi                   | 776 ++++++++++++++++++
 arch/arm/boot/dts/aspeed-g5.dtsi                   | 879 +++++++++++++++++++++
 arch/arm/boot/dts/at91-linea.dtsi                  |  49 ++
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |   4 +
 arch/arm/boot/dts/at91-sama5d4_xplained.dts        |   8 +
 arch/arm/boot/dts/at91-tse850-3.dts                | 274 +++++++
 arch/arm/boot/dts/axm55xx.dtsi                     |   2 +-
 arch/arm/boot/dts/axp223.dtsi                      |  58 ++
 arch/arm/boot/dts/bcm-nsp.dtsi                     |  64 +-
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |   5 +
 arch/arm/boot/dts/bcm283x.dtsi                     |   8 +
 arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts        |   3 +-
 arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts        |   3 +-
 arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts  |   7 +-
 arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts       |   4 -
 arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts       |   4 -
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts        |   7 +-
 arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts     |   3 +-
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts      |   7 +-
 arch/arm/boot/dts/bcm4708.dtsi                     |   4 +
 arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts        |   3 +-
 arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts |   7 +-
 arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts  |   3 +-
 arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts      |  60 ++
 arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts      | 107 +++
 arch/arm/boot/dts/bcm47081.dtsi                    |   4 +
 arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts        |   3 +-
 arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts  |   3 +-
 arch/arm/boot/dts/bcm4709-netgear-r7000.dts        |  11 +-
 arch/arm/boot/dts/bcm4709-netgear-r8000.dts        |  51 +-
 arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts  |   4 -
 arch/arm/boot/dts/bcm4709.dtsi                     |   1 +
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts      |   7 +-
 arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts      |  13 +-
 arch/arm/boot/dts/bcm47094-netgear-r8500.dts       |   7 +-
 arch/arm/boot/dts/bcm47094.dtsi                    |   1 +
 arch/arm/boot/dts/bcm5301x.dtsi                    |  41 +-
 arch/arm/boot/dts/bcm53573.dtsi                    |  22 +
 arch/arm/boot/dts/bcm94708.dts                     |   4 -
 arch/arm/boot/dts/bcm94709.dts                     |   4 -
 arch/arm/boot/dts/bcm953012er.dts                  |   4 -
 arch/arm/boot/dts/bcm953012k.dts                   |   1 -
 arch/arm/boot/dts/bcm958522er.dts                  |  35 +-
 arch/arm/boot/dts/bcm958525er.dts                  |  35 +-
 arch/arm/boot/dts/bcm958525xmc.dts                 |  68 +-
 arch/arm/boot/dts/bcm958622hr.dts                  |  42 +
 arch/arm/boot/dts/bcm958623hr.dts                  |  58 +-
 arch/arm/boot/dts/bcm958625hr.dts                  |  72 +-
 arch/arm/boot/dts/bcm958625k.dts                   | 151 +++-
 arch/arm/boot/dts/bcm988312hr.dts                  |  42 +
 arch/arm/boot/dts/da850-evm.dts                    |  20 +
 arch/arm/boot/dts/da850-lcdk.dts                   |  90 +++
 arch/arm/boot/dts/da850-lego-ev3.dts               | 313 ++++++++
 arch/arm/boot/dts/da850.dtsi                       |  51 +-
 arch/arm/boot/dts/dove-cm-a510.dtsi                |  10 +-
 arch/arm/boot/dts/dove-sbc-a510.dts                |  10 +-
 arch/arm/boot/dts/dra7-evm.dts                     | 286 +------
 arch/arm/boot/dts/dra7.dtsi                        |   2 +-
 arch/arm/boot/dts/dra71-evm.dts                    |   5 +
 arch/arm/boot/dts/dra72-evm-common.dtsi            |  20 +-
 arch/arm/boot/dts/dra72-evm-revc.dts               |   6 +-
 arch/arm/boot/dts/ecx-2000.dts                     |   2 +-
 arch/arm/boot/dts/exynos-mfc-reserved-memory.dtsi  |   2 +-
 arch/arm/boot/dts/exynos3250.dtsi                  |   2 +-
 arch/arm/boot/dts/exynos4.dtsi                     |  37 +-
 arch/arm/boot/dts/exynos4210.dtsi                  |   1 +
 arch/arm/boot/dts/exynos4212.dtsi                  | 133 ----
 arch/arm/boot/dts/exynos4412-itop-elite.dts        |  25 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |  28 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts          |   5 +-
 arch/arm/boot/dts/exynos4412-odroidx.dts           |  13 +
 arch/arm/boot/dts/exynos4412-odroidx2.dts          |  25 +-
 ...os4x12-pinctrl.dtsi => exynos4412-pinctrl.dtsi} |   4 +-
 arch/arm/boot/dts/exynos4412-prime.dtsi            |  41 +
 arch/arm/boot/dts/exynos4412.dtsi                  | 578 +++++++++++++-
 arch/arm/boot/dts/exynos4x12.dtsi                  | 594 --------------
 arch/arm/boot/dts/exynos5.dtsi                     |   4 +-
 arch/arm/boot/dts/exynos5250.dtsi                  |  11 +
 arch/arm/boot/dts/exynos5260.dtsi                  |   2 +-
 arch/arm/boot/dts/exynos5410.dtsi                  |   8 +
 arch/arm/boot/dts/exynos5420.dtsi                  |  13 +
 arch/arm/boot/dts/exynos5440.dtsi                  |   2 +-
 arch/arm/boot/dts/imx1-ads.dts                     |   1 -
 arch/arm/boot/dts/imx1.dtsi                        |   3 +-
 arch/arm/boot/dts/imx23.dtsi                       |   5 +-
 arch/arm/boot/dts/imx25.dtsi                       |   7 +-
 arch/arm/boot/dts/imx27-apf27dev.dts               |   2 -
 .../boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts  |   1 -
 arch/arm/boot/dts/imx27-pdk.dts                    |   1 -
 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi  |   1 -
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts     |   1 -
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi    |   1 -
 arch/arm/boot/dts/imx27.dtsi                       |   1 +
 arch/arm/boot/dts/imx28.dtsi                       |   7 +-
 arch/arm/boot/dts/imx31.dtsi                       |   5 +-
 arch/arm/boot/dts/imx35.dtsi                       |   5 +-
 arch/arm/boot/dts/imx50-evk.dts                    |   1 -
 arch/arm/boot/dts/imx51-apf51dev.dts               |   2 -
 arch/arm/boot/dts/imx51-babbage.dts                |   1 -
 arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi  |   1 -
 .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts  |   1 -
 arch/arm/boot/dts/imx53-qsb-common.dtsi            |  20 +-
 arch/arm/boot/dts/imx53-qsb.dts                    |   5 +-
 arch/arm/boot/dts/imx53-qsrb.dts                   |   6 +-
 arch/arm/boot/dts/imx53-smd.dts                    |   1 -
 arch/arm/boot/dts/imx53-tqma53.dtsi                |   2 -
 arch/arm/boot/dts/imx53-tx53.dtsi                  |   1 -
 arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi        |   1 -
 arch/arm/boot/dts/imx6dl-aristainetos2_4.dts       |  10 +-
 arch/arm/boot/dts/imx6dl-aristainetos2_7.dts       |  10 +-
 arch/arm/boot/dts/imx6dl-aristainetos_4.dts        |   1 -
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts       |  10 +-
 arch/arm/boot/dts/imx6dl-cubox-i.dts               |  10 +-
 arch/arm/boot/dts/imx6dl-hummingboard.dts          |  10 +-
 arch/arm/boot/dts/imx6dl-icore-rqs.dts             |  51 ++
 arch/arm/boot/dts/imx6dl-icore.dts                 |  10 +-
 arch/arm/boot/dts/imx6dl-nit6xlite.dts             |  10 +-
 arch/arm/boot/dts/imx6dl-nitrogen6x.dts            |  10 +-
 arch/arm/boot/dts/imx6dl-sabrelite.dts             |  10 +-
 arch/arm/boot/dts/imx6dl-savageboard.dts           |  51 ++
 arch/arm/boot/dts/imx6dl-ts4900.dts                |  10 +-
 arch/arm/boot/dts/imx6q-apalis-ixora.dts           |  10 +-
 arch/arm/boot/dts/imx6q-b450v3.dts                 |  10 +-
 arch/arm/boot/dts/imx6q-b650v3.dts                 |  10 +-
 arch/arm/boot/dts/imx6q-b850v3.dts                 |  10 +-
 arch/arm/boot/dts/imx6q-ba16.dtsi                  |  11 +-
 arch/arm/boot/dts/imx6q-bx50v3.dtsi                |  11 +-
 arch/arm/boot/dts/imx6q-cm-fx6.dts                 |  32 +-
 arch/arm/boot/dts/imx6q-cubox-i.dts                |  10 +-
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts            |   1 -
 arch/arm/boot/dts/imx6q-evi.dts                    |   3 -
 arch/arm/boot/dts/imx6q-gw5400-a.dts               |   1 -
 arch/arm/boot/dts/imx6q-h100.dts                   |  10 +-
 arch/arm/boot/dts/imx6q-hummingboard.dts           |  10 +-
 arch/arm/boot/dts/imx6q-icore-rqs.dts              |  12 +-
 arch/arm/boot/dts/imx6q-icore.dts                  |  10 +-
 arch/arm/boot/dts/imx6q-marsboard.dts              |  11 +-
 arch/arm/boot/dts/imx6q-mccmon6.dts                | 473 +++++++++++
 arch/arm/boot/dts/imx6q-nitrogen6_max.dts          |  10 +-
 arch/arm/boot/dts/imx6q-nitrogen6_som2.dts         |  10 +-
 arch/arm/boot/dts/imx6q-nitrogen6x.dts             |  10 +-
 arch/arm/boot/dts/imx6q-novena.dts                 |   1 -
 arch/arm/boot/dts/imx6q-sabrelite.dts              |  10 +-
 arch/arm/boot/dts/imx6q-savageboard.dts            |  55 ++
 arch/arm/boot/dts/imx6q-ts4900.dts                 |  10 +-
 arch/arm/boot/dts/imx6q-utilite-pro.dts            | 115 +++
 arch/arm/boot/dts/imx6qdl-apalis.dtsi              |  12 +-
 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi             |   1 -
 arch/arm/boot/dts/imx6qdl-aristainetos.dtsi        |   1 -
 arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi       |  13 +-
 arch/arm/boot/dts/imx6qdl-colibri.dtsi             |  11 +-
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi             |  10 +-
 arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi       |   1 -
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi              | 132 +++-
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi              | 166 ++--
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi              | 163 ++--
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              |  16 +
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi              | 132 +++-
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi              | 130 ++-
 arch/arm/boot/dts/imx6qdl-gw553x.dtsi              |  98 ++-
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi        |  10 +-
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi           |  14 +-
 arch/arm/boot/dts/imx6qdl-icore.dtsi               |  10 +-
 arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi     |  10 +-
 arch/arm/boot/dts/imx6qdl-microsom.dtsi            |  10 +-
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi           |  13 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi       |  15 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi      |  13 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |  13 +-
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi       |   1 -
 arch/arm/boot/dts/imx6qdl-rex.dtsi                 |   2 -
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |   1 -
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi           |  13 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |   1 -
 arch/arm/boot/dts/imx6qdl-savageboard.dtsi         | 255 ++++++
 arch/arm/boot/dts/imx6qdl-ts4900.dtsi              |  12 +-
 arch/arm/boot/dts/imx6qdl-tx6.dtsi                 |   1 -
 arch/arm/boot/dts/imx6qdl.dtsi                     |  12 +-
 arch/arm/boot/dts/imx6qp.dtsi                      |   6 +
 arch/arm/boot/dts/imx6sl-evk.dts                   |   1 -
 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts           |  11 +-
 arch/arm/boot/dts/imx6sx-sdb-sai.dts               |  10 +-
 arch/arm/boot/dts/imx6sx-udoo-neo.dtsi             | 137 ++++
 arch/arm/boot/dts/imx6ul-geam-kit.dts              |  10 +-
 arch/arm/boot/dts/imx6ul-geam.dtsi                 |  10 +-
 arch/arm/boot/dts/imx6ul-isiot-emmc.dts            |  77 ++
 arch/arm/boot/dts/imx6ul-isiot-nand.dts            |  79 ++
 arch/arm/boot/dts/imx6ul-isiot.dtsi                | 114 +++
 arch/arm/boot/dts/imx6ul-liteboard.dts             |  10 +-
 arch/arm/boot/dts/imx6ul-litesom.dtsi              |  10 +-
 arch/arm/boot/dts/imx6ul-opos6ul.dtsi              | 192 +++++
 arch/arm/boot/dts/imx6ul-opos6uldev.dts            | 412 ++++++++++
 arch/arm/boot/dts/imx6ul-pico-hobbit.dts           |  10 +-
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi                |   1 -
 arch/arm/boot/dts/imx6ul.dtsi                      |  11 +-
 arch/arm/boot/dts/imx6ull-14x14-evk.dts            |  10 +-
 arch/arm/boot/dts/imx6ull.dtsi                     |  10 +-
 arch/arm/boot/dts/imx7-colibri.dtsi                |  16 +-
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts            |  14 +-
 arch/arm/boot/dts/imx7d-nitrogen7.dts              |  14 +-
 arch/arm/boot/dts/imx7d-pinfunc.h                  | 110 +--
 arch/arm/boot/dts/imx7d-sdb.dts                    |  25 +-
 arch/arm/boot/dts/imx7s-warp.dts                   |   4 +-
 arch/arm/boot/dts/imx7s.dtsi                       |   1 -
 arch/arm/boot/dts/keystone-k2e-netcp.dtsi          |   3 +-
 arch/arm/boot/dts/keystone-k2e.dtsi                |  25 +
 arch/arm/boot/dts/keystone-k2g.dtsi                |  18 +-
 arch/arm/boot/dts/keystone-k2hk-netcp.dtsi         |   3 +-
 arch/arm/boot/dts/keystone-k2hk.dtsi               |  32 +
 arch/arm/boot/dts/keystone-k2l-netcp.dtsi          |   3 +-
 arch/arm/boot/dts/keystone-k2l.dtsi                |  32 +-
 arch/arm/boot/dts/keystone.dtsi                    |  13 +-
 arch/arm/boot/dts/kirkwood-dir665.dts              |  49 ++
 arch/arm/boot/dts/kirkwood-linkstation-6282.dtsi   |  10 +-
 .../boot/dts/kirkwood-linkstation-duo-6281.dtsi    |  10 +-
 arch/arm/boot/dts/kirkwood-linkstation-lsqvl.dts   |  10 +-
 arch/arm/boot/dts/kirkwood-linkstation-lsvl.dts    |  10 +-
 arch/arm/boot/dts/kirkwood-linkstation-lswsxl.dts  |  10 +-
 arch/arm/boot/dts/kirkwood-linkstation-lswvl.dts   |  10 +-
 arch/arm/boot/dts/kirkwood-linkstation-lswxl.dts   |  10 +-
 arch/arm/boot/dts/kirkwood-linkstation.dtsi        |  10 +-
 arch/arm/boot/dts/kirkwood-linksys-viper.dts       |  49 ++
 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts     |  49 ++
 arch/arm/boot/dts/kirkwood-rd88f6281-a.dts         |   9 +-
 arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts        |  11 +
 arch/arm/boot/dts/kirkwood-rd88f6281.dtsi          |  44 ++
 arch/arm/boot/dts/ls1021a.dtsi                     |   4 +-
 arch/arm/boot/dts/mt2701-evb.dts                   |  54 ++
 arch/arm/boot/dts/mt2701.dtsi                      | 249 +++++-
 arch/arm/boot/dts/mt6580.dtsi                      |   2 +-
 arch/arm/boot/dts/mt6589.dtsi                      |   2 +-
 arch/arm/boot/dts/mt7623-evb.dts                   |   2 +-
 arch/arm/boot/dts/mt7623.dtsi                      |   4 +-
 arch/arm/boot/dts/mt8127.dtsi                      |   2 +-
 arch/arm/boot/dts/mt8135.dtsi                      |   2 +-
 arch/arm/boot/dts/mvebu-linkstation-fan.dtsi       |  10 +-
 .../boot/dts/mvebu-linkstation-gpio-simple.dtsi    |  10 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts              |  16 +
 arch/arm/boot/dts/omap3-igep.dtsi                  |  21 -
 arch/arm/boot/dts/omap3-n900.dts                   |   3 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi          |  16 +
 arch/arm/boot/dts/omap5-igep0050.dts               |  21 +
 arch/arm/boot/dts/omap5-uevm.dts                   |  21 +
 arch/arm/boot/dts/omap5.dtsi                       |   2 +-
 arch/arm/boot/dts/orion5x-kuroboxpro.dts           |  10 +-
 arch/arm/boot/dts/orion5x-linkstation-lsgl.dts     |  10 +-
 arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts   |  10 +-
 arch/arm/boot/dts/orion5x-linkstation.dtsi         |  10 +-
 arch/arm/boot/dts/orion5x-lschl.dts                |  10 +-
 arch/arm/boot/dts/orion5x-lswsgl.dts               |  10 +-
 arch/arm/boot/dts/ox810se.dtsi                     |  10 +-
 arch/arm/boot/dts/ox820.dtsi                       |  14 +-
 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts     |  62 +-
 .../arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts |  69 ++
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts         |  22 -
 arch/arm/boot/dts/qcom-apq8064-pins.dtsi           |  37 +
 .../arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts |   7 +
 arch/arm/boot/dts/qcom-apq8064.dtsi                | 287 ++++++-
 arch/arm/boot/dts/qcom-ipq8064.dtsi                |   4 +-
 arch/arm/boot/dts/qcom-msm8660-surf.dts            |   2 +-
 arch/arm/boot/dts/qcom-msm8660.dtsi                |  12 +-
 .../boot/dts/qcom-msm8974-sony-xperia-honami.dts   |   8 +
 arch/arm/boot/dts/qcom-msm8974.dtsi                |  96 ++-
 arch/arm/boot/dts/r7s72100-rskrza1.dts             |   8 +
 arch/arm/boot/dts/r7s72100.dtsi                    |  28 +
 arch/arm/boot/dts/r8a73a4.dtsi                     |   6 +-
 arch/arm/boot/dts/r8a7743.dtsi                     |  18 +-
 arch/arm/boot/dts/r8a7745.dtsi                     |  18 +-
 arch/arm/boot/dts/r8a7778.dtsi                     |  10 +-
 arch/arm/boot/dts/r8a7779-marzen.dts               |   4 +
 arch/arm/boot/dts/r8a7779.dtsi                     |   9 +-
 arch/arm/boot/dts/r8a7790.dtsi                     |  37 +-
 arch/arm/boot/dts/r8a7791.dtsi                     |  35 +-
 arch/arm/boot/dts/r8a7792.dtsi                     |  26 +-
 arch/arm/boot/dts/r8a7793-gose.dts                 |  21 +
 arch/arm/boot/dts/r8a7793.dtsi                     |  23 +-
 arch/arm/boot/dts/r8a7794.dtsi                     |  23 +-
 arch/arm/boot/dts/rk1108.dtsi                      |   2 +-
 arch/arm/boot/dts/rk3036-evb.dts                   |   2 +-
 arch/arm/boot/dts/rk3036-kylin.dts                 |  12 +-
 arch/arm/boot/dts/rk3036.dtsi                      |   2 +-
 arch/arm/boot/dts/rk3066a-bqcurie2.dts             |   8 +-
 arch/arm/boot/dts/rk3066a-marsboard.dts            |   6 +-
 arch/arm/boot/dts/rk3066a-mk808.dts                |  10 +-
 arch/arm/boot/dts/rk3066a-rayeager.dts             |  18 +-
 arch/arm/boot/dts/rk3066a.dtsi                     |   4 +
 arch/arm/boot/dts/rk3188-px3-evb.dts               |  10 +-
 arch/arm/boot/dts/rk3188-radxarock.dts             |  20 +-
 arch/arm/boot/dts/rk3188.dtsi                      |   4 +
 arch/arm/boot/dts/rk3229-evb.dts                   |   2 +-
 arch/arm/boot/dts/rk322x.dtsi                      |   2 +-
 arch/arm/boot/dts/rk3288-evb-act8846.dts           |   6 +-
 arch/arm/boot/dts/rk3288-evb-rk808.dts             |   2 +-
 arch/arm/boot/dts/rk3288-evb.dtsi                  |  14 +-
 arch/arm/boot/dts/rk3288-fennec.dts                |   6 +-
 arch/arm/boot/dts/rk3288-firefly-beta.dts          |   2 +-
 arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi  |   2 +-
 arch/arm/boot/dts/rk3288-firefly-reload.dts        |  26 +-
 arch/arm/boot/dts/rk3288-firefly.dts               |   2 +-
 arch/arm/boot/dts/rk3288-firefly.dtsi              |  18 +-
 arch/arm/boot/dts/rk3288-miqi.dts                  |   8 +-
 arch/arm/boot/dts/rk3288-popmetal.dts              |   8 +-
 arch/arm/boot/dts/rk3288-r89.dts                   |  14 +-
 arch/arm/boot/dts/rk3288-rock2-som.dtsi            |   4 +-
 arch/arm/boot/dts/rk3288-rock2-square.dts          |  14 +-
 arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi  |   8 +-
 arch/arm/boot/dts/rk3288-veyron-brain.dts          |   8 +-
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi    |  14 +-
 arch/arm/boot/dts/rk3288-veyron-jaq.dts            |  14 +-
 arch/arm/boot/dts/rk3288-veyron-jerry.dts          |  12 +-
 arch/arm/boot/dts/rk3288-veyron-mickey.dts         |   6 +-
 arch/arm/boot/dts/rk3288-veyron-minnie.dts         |  18 +-
 arch/arm/boot/dts/rk3288-veyron-pinky.dts          |   4 +-
 arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi         |   2 +-
 arch/arm/boot/dts/rk3288-veyron-speedy.dts         |  10 +-
 arch/arm/boot/dts/rk3288-veyron.dtsi               |  10 +-
 arch/arm/boot/dts/rk3288.dtsi                      |  86 +-
 arch/arm/boot/dts/sama5d2.dtsi                     |  30 +-
 arch/arm/boot/dts/sama5d36ek_cmp.dts               |  87 ++
 arch/arm/boot/dts/sama5d3_uart.dtsi                |   4 +-
 arch/arm/boot/dts/sama5d3xcm_cmp.dtsi              | 201 +++++
 arch/arm/boot/dts/sama5d3xmb_cmp.dtsi              | 301 +++++++
 arch/arm/boot/dts/sama5d4.dtsi                     |  16 +-
 arch/arm/boot/dts/sh73a0.dtsi                      |   2 +-
 arch/arm/boot/dts/socfpga.dtsi                     |  31 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi             |  41 +-
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi       |   9 +
 arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts   |  31 +
 arch/arm/boot/dts/socfpga_arria5.dtsi              |   4 +
 arch/arm/boot/dts/socfpga_arria5_socdk.dts         |  43 +
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts       |  53 ++
 arch/arm/boot/dts/ste-dbx5x0.dtsi                  |   2 +
 arch/arm/boot/dts/ste-href.dtsi                    |  16 +-
 arch/arm/boot/dts/ste-hrefprev60.dtsi              |   1 +
 arch/arm/boot/dts/ste-hrefv60plus.dtsi             |   1 +
 arch/arm/boot/dts/ste-snowball.dts                 |  20 +-
 arch/arm/boot/dts/stih407-family.dtsi              |  59 +-
 arch/arm/boot/dts/stih410-b2120.dts                |   6 +
 arch/arm/boot/dts/stih410.dtsi                     |  24 +-
 arch/arm/boot/dts/stm32429i-eval.dts               |  37 +-
 arch/arm/boot/dts/stm32f429-disco.dts              |   6 +
 arch/arm/boot/dts/stm32f429.dtsi                   | 450 ++++++++++-
 arch/arm/boot/dts/stm32f469-disco.dts              |  36 +-
 arch/arm/boot/dts/sun4i-a10-a1000.dts              |  43 +-
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts         |   2 +-
 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts    |  14 +-
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts         |  14 +-
 arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts   |  38 +-
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts           |   6 +-
 arch/arm/boot/dts/sun4i-a10-hackberry.dts          |  12 +-
 arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts       |  16 +-
 arch/arm/boot/dts/sun4i-a10-inet1.dts              |  26 +-
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts          |  14 +-
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts       |  29 +-
 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts         |  12 +-
 arch/arm/boot/dts/sun4i-a10-marsboard.dts          |  13 +-
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts         |   2 +-
 arch/arm/boot/dts/sun4i-a10-mk802.dts              |  18 +-
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts     |  27 +-
 arch/arm/boot/dts/sun4i-a10-pcduino.dts            |  19 +-
 arch/arm/boot/dts/sun4i-a10-pcduino2.dts           |   6 +-
 arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts   |  32 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                   | 170 ++--
 arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts       |  18 +-
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts       |  29 +-
 arch/arm/boot/dts/sun5i-a10s-mk802.dts             |  19 +-
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts   |  36 +-
 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts      |  20 +-
 arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts           |  21 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi                  |  43 +-
 .../boot/dts/sun5i-a13-empire-electronix-d709.dts  |  23 +-
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts           |  22 +-
 arch/arm/boot/dts/sun5i-a13-licheepi-one.dts       | 224 ++++++
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts    |  40 +-
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts          |  36 +-
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts           |  11 +-
 arch/arm/boot/dts/sun5i-a13.dtsi                   |  24 +-
 arch/arm/boot/dts/sun5i-gr8-chip-pro.dts           |  12 +-
 arch/arm/boot/dts/sun5i-gr8-evb.dts                |  24 +-
 arch/arm/boot/dts/sun5i-gr8.dtsi                   | 122 +--
 arch/arm/boot/dts/sun5i-r8-chip.dts                |  27 +-
 .../boot/dts/sun5i-reference-design-tablet.dtsi    |  33 +-
 arch/arm/boot/dts/sun5i.dtsi                       |  84 +-
 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts          |   6 +-
 arch/arm/boot/dts/sun6i-a31-colombus.dts           |  22 +-
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts        |  42 +-
 arch/arm/boot/dts/sun6i-a31-i7.dts                 |  49 +-
 arch/arm/boot/dts/sun6i-a31-m9.dts                 |  19 +-
 arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts   |  19 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                   | 122 +--
 arch/arm/boot/dts/sun6i-a31s-primo81.dts           |  20 +-
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts           |  18 +-
 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts   |  29 +-
 .../dts/sun6i-a31s-yones-toptech-bs1078-v2.dts     |   9 +-
 .../boot/dts/sun6i-reference-design-tablet.dtsi    |  14 +-
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts   |  27 +-
 arch/arm/boot/dts/sun7i-a20-bananapi.dts           |  26 +-
 arch/arm/boot/dts/sun7i-a20-bananapro.dts          |  70 +-
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts        |  13 +-
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         |  38 +-
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts        |  24 +-
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts          |  26 +-
 arch/arm/boot/dts/sun7i-a20-itead-ibox.dts         |   7 +-
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts          |  30 +-
 arch/arm/boot/dts/sun7i-a20-m3.dts                 |   6 +-
 arch/arm/boot/dts/sun7i-a20-mk808c.dts             |  12 +-
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts     |  70 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts     |  27 +-
 .../boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts    |   6 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts    | 123 ++-
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts    |  28 +-
 arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts      |  45 +-
 arch/arm/boot/dts/sun7i-a20-orangepi.dts           |  38 +-
 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts      |  25 +-
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts           |  21 +-
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts     |  25 +-
 arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts   |  13 +-
 arch/arm/boot/dts/sun7i-a20.dtsi                   | 287 +++----
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               | 151 ++--
 arch/arm/boot/dts/sun8i-a23-evb.dts                |   7 +-
 .../boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts   |   8 +-
 .../boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts   |   8 +-
 arch/arm/boot/dts/sun8i-a23-q8-tablet.dts          |  23 +
 arch/arm/boot/dts/sun8i-a23.dtsi                   |  16 +
 arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts     |   9 +-
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts          |  20 +-
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |  59 +-
 arch/arm/boot/dts/sun8i-a33.dtsi                   |  86 +-
 arch/arm/boot/dts/sun8i-a83t.dtsi                  |  24 +-
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts  | 160 ++++
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    |  18 +-
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts          | 160 ++++
 arch/arm/boot/dts/sun8i-h3-nanopi.dtsi             |  18 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts          |  26 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts       |  18 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts        |  18 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts    |   4 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         |  26 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts       |  10 +-
 arch/arm/boot/dts/sun8i-h3.dtsi                    | 146 ++--
 arch/arm/boot/dts/sun8i-q8-common.dtsi             |   9 +-
 arch/arm/boot/dts/sun8i-r16-parrot.dts             |  50 +-
 .../boot/dts/sun8i-reference-design-tablet.dtsi    |  32 +-
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts      | 103 +++
 arch/arm/boot/dts/sun8i-v3s.dtsi                   | 309 ++++++++
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts        |  23 +-
 arch/arm/boot/dts/sun9i-a80-optimus.dts            |  41 +-
 arch/arm/boot/dts/sun9i-a80.dtsi                   |  66 +-
 arch/arm/boot/dts/sunxi-common-regulators.dtsi     |  24 +-
 arch/arm/boot/dts/tango4-common.dtsi               |  46 ++
 arch/arm/boot/dts/tango4-vantage-1172.dts          |   5 +
 arch/arm/boot/dts/tegra124-apalis-eval.dts         |  10 +-
 arch/arm/boot/dts/tegra124-apalis.dtsi             |  61 +-
 arch/arm/boot/dts/tegra124-nyan-big.dts            |  26 +-
 arch/arm/boot/dts/tegra124-nyan-blaze.dts          |  28 +-
 arch/arm/boot/dts/tegra124-nyan.dtsi               |   5 +-
 arch/arm/boot/dts/tegra20-paz00.dts                |   1 +
 arch/arm/boot/dts/tegra20-trimslice.dts            |   1 +
 arch/arm/boot/dts/uniphier-pinctrl.dtsi            |  18 +-
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi          |  10 +-
 arch/arm/boot/dts/vf-colibri.dtsi                  |  10 +-
 arch/arm/boot/dts/vf500-colibri-eval-v3.dts        |  10 +-
 arch/arm/boot/dts/vf500-colibri.dtsi               |  10 +-
 arch/arm/boot/dts/vf500.dtsi                       |  10 +-
 arch/arm/boot/dts/vf610-colibri-eval-v3.dts        |  10 +-
 arch/arm/boot/dts/vf610-colibri.dtsi               |  10 +-
 arch/arm/boot/dts/vf610-twr.dts                    |  10 +-
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts          | 334 +-------
 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts          | 416 ++++++++++
 arch/arm/boot/dts/vf610-zii-dev.dtsi               | 383 +++++++++
 arch/arm/boot/dts/vf610.dtsi                       |  10 +-
 arch/arm/boot/dts/vf610m4-colibri.dts              |  10 +-
 arch/arm/boot/dts/vf610m4-cosmic.dts               |  10 +-
 arch/arm/boot/dts/vf610m4.dtsi                     |  10 +-
 arch/arm/boot/dts/vfxxx.dtsi                       |  10 +-
 drivers/clk/samsung/clk-exynos4.c                  |   4 +
 include/dt-bindings/clock/r7s72100-clock.h         |   4 +
 include/dt-bindings/clock/stm32fx-clock.h          |  39 +
 include/dt-bindings/mfd/stm32f4-rcc.h              |  24 +-
 570 files changed, 17098 insertions(+), 5577 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/axentia.txt
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/98dx3236.txt
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-da850.txt
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
 create mode 100644 Documentation/devicetree/bindings/net/marvell,prestera.txt
 create mode 100644 arch/arm/boot/dts/am335x-boneblack-common.dtsi
 create mode 100644 arch/arm/boot/dts/am335x-boneblack-wireless.dts
 create mode 100644 arch/arm/boot/dts/am335x-bonegreen-common.dtsi
 create mode 100644 arch/arm/boot/dts/am335x-bonegreen-wireless.dts
 create mode 100644 arch/arm/boot/dts/am335x-pcm-953.dtsi
 create mode 100644 arch/arm/boot/dts/am335x-phycore-rdk.dts
 create mode 100644 arch/arm/boot/dts/armada-388-clearfog-base.dts
 create mode 100644 arch/arm/boot/dts/armada-388-clearfog-pro.dts
 create mode 100644 arch/arm/boot/dts/armada-388-clearfog.dtsi
 create mode 100644 arch/arm/boot/dts/armada-xp-98dx3236.dtsi
 create mode 100644 arch/arm/boot/dts/armada-xp-98dx3336.dtsi
 create mode 100644 arch/arm/boot/dts/armada-xp-98dx4251.dtsi
 create mode 100644 arch/arm/boot/dts/armada-xp-db-dxbc2.dts
 create mode 100644 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
 create mode 100644 arch/arm/boot/dts/at91-linea.dtsi
 create mode 100644 arch/arm/boot/dts/at91-tse850-3.dts
 create mode 100644 arch/arm/boot/dts/axp223.dtsi
 create mode 100644 arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts
 create mode 100644 arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts
 create mode 100644 arch/arm/boot/dts/da850-lego-ev3.dts
 delete mode 100644 arch/arm/boot/dts/exynos4212.dtsi
 rename arch/arm/boot/dts/{exynos4x12-pinctrl.dtsi => exynos4412-pinctrl.dtsi} (99%)
 create mode 100644 arch/arm/boot/dts/exynos4412-prime.dtsi
 delete mode 100644 arch/arm/boot/dts/exynos4x12.dtsi
 create mode 100644 arch/arm/boot/dts/imx6dl-icore-rqs.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-savageboard.dts
 create mode 100644 arch/arm/boot/dts/imx6q-mccmon6.dts
 create mode 100644 arch/arm/boot/dts/imx6q-savageboard.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-savageboard.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-isiot-emmc.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-isiot-nand.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-isiot.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-opos6ul.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-opos6uldev.dts
 create mode 100644 arch/arm/boot/dts/sama5d36ek_cmp.dts
 create mode 100644 arch/arm/boot/dts/sama5d3xcm_cmp.dtsi
 create mode 100644 arch/arm/boot/dts/sama5d3xmb_cmp.dtsi
 create mode 100644 arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts
 create mode 100644 arch/arm/boot/dts/sun5i-a13-licheepi-one.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
 create mode 100644 arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts
 create mode 100644 arch/arm/boot/dts/sun8i-v3s.dtsi
 create mode 100644 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
 create mode 100644 arch/arm/boot/dts/vf610-zii-dev.dtsi
 create mode 100644 include/dt-bindings/clock/stm32fx-clock.h
