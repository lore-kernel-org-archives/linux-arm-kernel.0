From: olof@lixom.net (Olof Johansson)
Date: Mon,  1 Aug 2016 14:39:27 -0700
Subject: [GIT PULL 6/7] ARM: DT updates for v4.8
In-Reply-To: <1470087568-4222-1-git-send-email-olof@lixom.net>
References: <1470087568-4222-1-git-send-email-olof@lixom.net>
Message-ID: <1470087568-4222-7-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device tree contents continue to be the largest branches we submit. This
time around, some of the contents worth pointing out is:

- New SoC platforms:
- Freescale i.MX 7Solo
- Broadcom BCM23550
- Cirrus Logic EP7209 and EP7211 (clps711x platforms)_
- Hisilicon HI3519
- Renesas R8A7792

Some of the other delta that is sticking out, line-count wise:
- Exynos moves of IP blocks under an SoC bus, which causes a large delta due
to indentation changes
- A new Tegra K1 board: Apalis
- A bunch of small updates to many Allwinner platforms; new hardware support,
some cleanup, etc.



Conflicts:

None

----------------------------------------------------------------

The following changes since commit 42f4ed1c19c3d7e2969c4e56b186f034053d7ba3:

  Merge branch 'next/drivers' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt

for you to fetch changes up to d95eabc7b8ee4c8ef471e8a97aa62d353b110880:

  Merge tag 'renesas-dt-fixes-for-v4.8' of git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas into next/dt

----------------------------------------------------------------

Aleksei Mamlin (2):
      ARM: dts: sun4i: Re-order pinctrl nodes alphabetically
      ARM: dts: sun7i: Re-order pinctrl nodes alphabetically

Alexander Shiyan (1):
      ARM: dts: clps711x: Add DT Cirrus Logic EDB7211 Development board

Alexandre Belloni (25):
      ARM: dts: at91: usb_a9g20: use stdout-path
      ARM: dts: at91: ma5d4: properly define crystals frequencies
      ARM: dts: at91: animeo_ip: remove leftovers clock definition
      ARM: dts: at91: at91-ariag25: remove leftovers clock definition
      ARM: dts: at91: at91-cosino: remove leftovers clock definition
      ARM: dts: at91: at91-foxg20: remove leftovers clock definition
      ARM: dts: at91: ge863-pro3: remove leftovers clock definition
      ARM: dts: at91: mpa1600: remove leftovers clock definition
      ARM: dts: at91: pm9g45: remove leftovers clock definition
      ARM: dts: at91: calao: remove leftovers clock definition
      Documentation: dt: iio: at91_adc: fix trigger node names
      ARM: dts: at91: Fix ADC trigger nodes
      Documentation: dt: usb: atmel-usb: add unit-address
      ARM: dts: at91: Fix USB endpoint nodes
      ARM: dts: at91: sama5d4ek: remove useless lcd_bus
      ARM: dts: at91: sama5d3_xplained: fix regulator name
      ARM: dts: at91: sama5d4_xplained: fix regulator names
      ARM: dts: at91: sama5d4_ma5d4: fix regulator names
      ARM: dts: at91: sama5d4_ma5d4evk: fix regulator names
      ARM: dts: at91: ariag25 : fix onewire node
      ARM: dts: at91: vinco: fix regulator name
      ARM: dts: at91: fix i2c-gpio node name
      ARM: dts: at91: move isi definition to at91sam9g25ek
      ARM: dts: at91: at91sam9g25ek: fix isi endpoint node
      ARM: dts: at91: sama5d3x: separate motherboard gmac and emac definitions

Andrew F. Davis (2):
      ARM: dts: am437x-idk-evm: Mark MAC as having only one PHY
      ARM: dts: am335x-bone-common: Mark MAC as having only one PHY

Andy Gross (10):
      Revert "Revert "dts: msm8974: Add blsp2_bam dma node""
      Revert "Revert "dts: msm8974: Add dma channels for blsp2_i2c1 node""
      ARM: dts: qcom: Remove size elements from pmic reg
      ARM: dts: qcom: pma8084: Add pwrkey entry
      dt/bindings: firmware: Add Qualcomm SCM binding
      dts: qcom: apq8084: Add SCM firmware node
      dts: qcom: msm8974: Add SCM firmware node
      dts: qcom: apq8064: Add SCM firmware node
      ARM: dts: qcom: msm8974-honami: Set DMA as remotely controlled
      arm: dts: qcom: Update smem state cells usage

Arnd Bergmann (11):
      Merge tag 'sunxi-dt-for-4.8' of https://git.kernel.org/.../mripard/linux into next/dt
      Merge tag 'hisi-armv7-soc-dt-for-4.8-v2' of git://github.com/hisilicon/linux-hisi into next/dt
      Merge tag 'arm-soc/for-4.8/devicetree-part2' of http://github.com/Broadcom/stblinux into next/dt
      Merge tag 'tegra-for-4.8-arm-dt' of git://git.kernel.org/.../tegra/linux into next/dt
      Merge branch 'reset/for-4.8-2' into next/dt
      Merge tag 'sti-late-v4.8' of git://git.kernel.org/.../pchotard/sti into next/late
      ARM: dts: at91: Don't build unnecessary dtbs
      Merge tag 'at91-ab-4.8-dt3' of git://git.kernel.org/.../abelloni/linux into next/dt
      Merge tag 'sunxi-dt-for-4.8-2-bis' of https://git.kernel.org/.../mripard/linux into next/dt
      Merge tag 'mvebu-dt-4.8-1' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'renesas-dt-fixes-for-v4.8' of git://git.kernel.org/.../horms/renesas into next/dt

Bjorn Andersson (1):
      dt: binding: Add Qualcomm WCNSS control binding

Boris Brezillon (2):
      ARM: dts: sun4i: Add NFC node to Allwinner A10 SoC
      ARM: dts: sun7i: Add NFC node to Allwinner A20 SoC

Brian Norris (1):
      ARM: dts: rockchip: add SPI flash node for rk3288-veyron

Chen-Yu Tsai (23):
      ARM: dts: axp209: Disable ldo5 by default
      ARM: dts: sun5i: q8-common: Enable USB power supply
      ARM: dts: sun5i: q8-common: Enable audio codec
      ARM: dts: sun5i: q8-common: Enable display pipeline and LCD display
      ARM: dts: sunxi: Add dtsi file for AXP809 PMIC
      ARM: dts: sun9i: a80-optimus: Add AXP809 PMIC device node and regulators
      ARM: dts: sun9i: cubieboard4: Add AXP809 PMIC device node and regulators
      ARM: dts: sun8i-h3: move uart0 pins to sort pinmux list in proper order
      ARM: dts: sun8i-h3: Add uart1 pinmux setting
      ARM: dts: sun8i-h3: Add dts file for Sinovoip BPI-M2+
      ARM: dts: sun9i: a80-optimus: Drop sunxi-common-regulators.dtsi
      ARM: dts: sun9i: cubieboard4: Drop sunxi-common-regulators.dtsi
      ARM: dts: sun9i: cubieboard4: Order nodes by alphabetical order
      ARM: dts: sun9i: a80-optimus: Order nodes by alphabetical order
      ARM: dts: sun5i: q8-common: Enable USB-based WiFi
      ARM: dts: sun7i: lamobo-r1: Fix USB-based WiFi module power
      ARM: dts: sun7i: lamobo-r1: Remove usb1 vbus regulator
      ARM: dts: sun8i-h3: Rename sinovoip-bpi-m2-plus to bananapi-m2-plus
      ARM: dts: sun7i: lamobo-r1: Fix GPIO flags in reg_ahci_5v
      ARM: dts: sun7i: lamobo-r1: Enable audio codec
      ARM: dts: sun7i: bananapi-m1-plus: Reindent whole file using tabs
      ARM: dts: sun7i: bananapi-m1-plus: Unify suffix for board specific labels
      ARM: dts: sun7i: bananapi-m1-plus: red LED is power LED

Chris Brand (5):
      Documentation: Binding docs for bcm11351 enable method
      ARM: dts: fix use of bcm11351 enable method
      ARM: BCM: modify Broadcom CPU enable method
      Documentation: devicetree: Document BCM23550 bindings
      ARM: dts: bcm23550: Add device tree files

Christopher Spinrath (5):
      ARM: dts: imx6q-cm-fx6: remove iomuxc container node
      ARM: dts: imx6q: extend support for the cm-fx6
      ARM: dts: imx6q: add support for the Utilite Pro
      ARM: dts: imx6q-cm-fx6: Relicense under GPLv2/X11
      ARM: dts: utilite-pro: add mmc card slot support

Damien Riegel (2):
      ARM: dts: TS-4800: add FPGA's IRQ controller support
      ARM: dts: TS-4800: add CAN support

Dave Gerlach (10):
      ARM: dts: dra7: Add ocmcram nodes
      ARM: dts: dra7: Add ti,secure-ram node to ocmcram1 node
      ARM: dts: am335x: Update MPU regulator range for TI boards
      ARM: dts: am33xx: Move to operating-points-v2 table and ti-cpufreq driver
      ARM: dts: am335x-boneblack: Enable 1GHz OPP for cpu
      ARM: dts: am4372: Add operating-points-v2 table
      ARM: dts: am437x-gp-evm: Hook dcdc2 as the cpu0-supply
      ARM: dts: dra7: Add dt node for the syscon control module wkup
      ARM: dts: dra7: Move cpus node to parent dts for dra74x and dra72x
      ARM: dts: dra7: Move to operating-points-v2 table

Diego Dorta (4):
      ARM: dts: imx6ul-pico-hobbit: Fix Ethernet PHY reset GPIO
      ARM: dts: imx7d: Add SPI support
      ARM: dts: imx7d-sdb: Add display support
      ARM: dts: imx7d-sdb: Add support for touchscreen

Dinh Nguyen (1):
      ARM: dts: socfpga: add ethernet alias on Arria10

Emilio L?pez (1):
      ARM: sun7i: Add mod1 clock nodes

Enric Balletbo i Serra (3):
      ARM: dts: rockchip: Add shared file for audio on rk3288-veyron boards
      ARM: dts: rockchip: Enable analog audio on rk3288-veyron chromebooks
      ARM: dts: am335x-bone-common: use stdout-path in Beaglebone boards.

Fabio Estevam (9):
      ARM: dts: imx: Remove unneeded unit-addresses
      ARM: dts: imx6ul: Add SAI alias
      ARM: dts: imx6ul-14x14-evk: Pass "fsl, sai-mclk-direction-output"
      ARM: dts: imx6ul-14x14-evk: Add LCD and backlight support
      ARM: dts: imx6qdl-sabresd: Pass the correct PCI reset polarity
      ARM: dts: imx6qdl-sabresd: Use WDOG_B pin reset
      ARM: dts: imx7d-sdb: Use WDOG_B pin reset
      ARM: dts: imx6ul-evk: Use WDOG_B pin reset
      ARM: dts: imx6sx-sdb: Use WDOG_B pin reset

Florian Fainelli (8):
      ARM: dts: Enable SRAB switch and GMACs on 5301x DTS
      ARM: dts: BCM5301X: Add SRAB interrupts
      ARM: dts: BCM5310x: Enable switch ports on SmartRG SR400AC
      ARM: dts: BCM5301x: Add RNG Device Tree node
      ARM: dts: BCM5301x: Add BCM953012ER board
      ARM: dts: sun7i: Add BCM53125 switch nodes to the lamobo-r1 board
      Merge tag 'bcm2835-dt-next-2016-07-03' into devicetree/next
      ARM: dts: NSP: Specify RAM amount for BCM958625HR board

Franklin S Cooper Jr (5):
      ARM: dts: am437x: Add missing compatibles to PWM binding documents
      pwm: pwm-tiehrpwm: Update dt binding document to use generic node name
      pwm: pwm-tiecap: Update dt binding document to use proper unit address
      ARM: dts: am437x/am33xx/da850: Add new ECAP and EPWM bindings
      ARM: dts: am437x/am33xx: Remove hwmod entries for ECAP and EPWM nodes

Geert Uytterhoeven (51):
      ARM: dts: bockw: SCIF0 supports RTS/CTS hardware flow control
      ARM: dts: kzm9g: SCIFA4 supports RTS/CTS hardware flow control
      ARM: dts: r8a7790: Correct unit names for cpu nodes
      ARM: dts: r8a7794: Remove nonexistent thermal sensor clock
      ARM: dts: emev2: Fix W=1 dtc warnings
      ARM: dts: r8a73a4: Fix W=1 dtc warnings
      ARM: dts: r8a7740: Fix W=1 dtc warnings
      ARM: dts: r8a7778: Fix W=1 dtc warnings
      ARM: dts: r8a7790: Fix W=1 dtc warnings
      ARM: dts: r8a7791: Fix W=1 dtc warnings
      ARM: dts: r8a7793: Fix W=1 dtc warnings
      ARM: dts: r8a7794: Fix W=1 dtc warnings
      ARM: dts: sh73a0: Fix W=1 dtc warnings
      ARM: dts: ape6evm: Fix W=1 dtc warnings
      ARM: dts: armadillo800eva: Fix W=1 dtc warnings
      ARM: dts: bockw: Fix W=1 dtc warnings
      ARM: dts: genmai: Fix W=1 dtc warnings
      ARM: dts: gose: Fix W=1 dtc warnings
      ARM: dts: koelsch: Fix W=1 dtc warnings
      ARM: dts: kzm9d: Fix W=1 dtc warnings
      ARM: dts: kzm9g: Fix W=1 dtc warnings
      ARM: dts: lager: Fix W=1 dtc warnings
      ARM: dts: marzen: Fix W=1 dtc warnings
      ARM: dts: porter: Fix W=1 dtc warnings
      ARM: dts: silk: Fix W=1 dtc warnings
      ARM: dts: imx28: Use generic uart-has-rtscts DT property
      ARM: dts: imx: Use generic uart-has-rtscts DT property
      ARM: dts: ape6evm: Name serial port pfc subnode after device name
      ARM: dts: ape6evm: Name mmc pfc subnode after device name
      ARM: dts: armadillo800eva: Name serial port pfc subnode after device name
      ARM: dts: bockw: Name serial port pfc subnode after device name
      ARM: dts: marzen: Name serial port pfc subnodes after device names
      ARM: dts: lager: Name serial port pfc subnodes after device names
      ARM: dts: lager: Name spi pfc subnodes after device names
      ARM: dts: lager: Name vin pfc subnode after device name
      ARM: dts: koelsch: Name serial port pfc subnodes after device names
      ARM: dts: koelsch: Name spi pfc subnodes after device names
      ARM: dts: porter: Name serial port pfc subnode after device name
      ARM: dts: porter: Name spi pfc subnode after device name
      ARM: dts: gose: Name serial port pfc subnodes after device names
      ARM: dts: gose: Name spi pfc subnode after device name
      ARM: dts: alt: Name serial port pfc subnode after device name
      ARM: dts: alt: Name spi pfc subnode after device name
      ARM: dts: silk: Name serial port pfc subnode after device name
      ARM: dts: silk: Name spi pfc subnode after device name
      ARM: dts: kzm9g: Name serial port pfc subnode after device name
      ARM: dts: armadillo800eva: Update console parameters
      ARM: dts: genmai: Update console parameters
      ARM: dts: marzen: Add serial port config to chosen/stdout-path
      ARM: dts: kzm9d: Update console parameters
      ARM: dts: kzm9g: Update console parameters

H. Nikolaus Schaller (5):
      ARM: dts: omap3-gta04: Define and use bma180 irq pin
      ARM: dta: omap3-gta04: Define and use itg3200  irq pin
      ARM: dta: omap3-gta04: Define and use hmc5843 irq pin
      ARM: dts: omap3-gat04: Fix wifi handling
      ARM: dts: omap3-gta04: Add RFID eeprom node

Hans de Goede (33):
      ARM: dts: sun5i-a10s-wobo-i5: Enable ldo4 too
      ARM: dts: sunxi: Add a startup delay for fixed regulator enabled phys
      ARM: dts: sun4i: HDMI and the tv-encoder use tcon ch1 not ch0
      ARM: dts: sun7i: HDMI and the tv-encoder use tcon ch1 not ch0
      ARM: dts: axp22x.dtsi: Disable axp22x ldo_io# regulators by default
      ARM: dts: axp22x.dtsi: Add usb_power_supply node
      ARM: dts: axp22x.dtsi: Add reg_drivebus node
      ARM: dts: sun8i-a?3-q8-tablet.dts: Add full otg support
      ARM: dts: sun8i-a23-polaroid-mid2809pxe04: Add full otg support
      ARM: dts: sun8i-a23-polaroid-mid2809pxe04: Disable ehci0
      ARM: dts: sun4i: The blue led on the Mele A1000 is a power led
      ARM: dts: sun6i: The blue led on the Mele A1000G quad is a power led
      ARM: dts: sun6i: The blue led on the Mele M9 is a power led
      ARM: dts: sun6i: Add pmic / regulator nodes to Mele A1000G quad dts
      ARM: dts: sun6i: Add pmic / regulator nodes to Mele M9 dts
      ARM: dts: sun8i-q8-common: Add support for USB wifi controllers
      ARM: dts: sun5i: Enable otg on the mk802
      ARM: dts: sun5i: Add axp152 pmic node to mk802
      ARM: dts: sun5i: Add mmc1 / sdio-wifi node to mk802
      ARM: dts: sun5i: Enable otg on the auxtex t004
      ARM: dts: sunxi: Rename sunxi-q8-common.dtsi sunxi-reference-design-tablet.dtsi
      ARM: dts: sun5i: Move q8 display bits to sun5i-a13-q8-tablet.dts
      ARM: dts: sun5i: Rename sun5i-q8-common.dtsi sun5i-reference-design-tablet.dtsi
      ARM: dts: sun5i: reference-design-tablet: Set lradc vref to avcc
      ARM: dts: sun5i: reference-design-tablet: Remove mention of q8
      ARM: dts: sun5i: Use sun5i-reference-design-tablet.dtsi for dit4350 dts
      ARM: dts: sun5i: Use sun5i-reference-design-tablet.dtsi for utoo p66 dts
      ARM: dts: Copy sun8i-q8-common.dtsi sun8i-reference-design-tablet.dtsi
      ARM: dts: sun8i: reference-design-tablet: Add drivevbus-supply
      ARM: dts: sun8i: Use sun8i-reference-design-tablet for polaroid mid2809pxe04
      ARM: dts: sun8i: Use sun8i-reference-design-tablet for ga10h dts
      ARM: dts: sun8i: Add dts file for Polaroid MID2407PXE03 tablet
      ARM: dts: sun8i: Add dts file for inet86dz board

Heiko Stuebner (3):
      ARM: dts: rockchip: move rk3288 io-domain nodes to the grf
      ARM: dts: rockchip: rename i2s model for Veyron devices
      Merge branch 'v4.8-shared/clkids' into v4.8-armsoc/dts32

Ivaylo Dimitrov (1):
      ARM: dts: n900: enable lirc-rx51 driver

Javier Martinez Canillas (30):
      ARM: dts: exynos: Add async-bridge clock to MFC power domain for Exynos5420
      ARM: dts: exynos: Remove unneded always-on for regulators on Peach boards
      ARM: dts: exynos: Add TMU nodes regulator supply for Peach boards
      ARM: dts: omap2: add missing unit name to func_96m_ck
      ARM: dts: am3517-craneboard: remove unneeded unit name for fixedregulator
      ARM: dts: dm3730-torpedo-devkit: remove unneeded unit names
      ARM: dts: n900: remove unneeded unit name for dmtimer-pwm
      ARM: dts: omap3-beagle: remove unneeded unit names
      ARM: dts: omap3-beagle-xm: remove unneeded unit names
      ARM: dts: cm-t3x: remove unneeded unit name in connector
      ARM: dts: omap3-devkit8000: remove unneeded unit names
      ARM: dts: omap3-devkit8000-lcd-common: remove unneeded unit names
      ARM: dts: omap3-gta04: remove unneeded unit names
      ARM: dts: omap3-ha-lcd: remove unneeded unit name
      ARM: dts: omap3: overo: remove unneded unit names in display nodes
      ARM: dts: omap3-igep0020-common: remove unneded unit names
      ARM: dts: omap3-overo-common-dvi: remove unneded unit names
      ARM: dts: omap3-pandora-common: remove unneded unit name
      ARM: dts: sbc-t3x30: remove unneded unit names
      ARM: dts: omap3-thunder: remove unneded unit name
      ARM: dts: omap4-duovero-parlor: remove unneded unit name
      ARM: dts: omap4-panda-common: remove unneded unit names
      ARM: dts: omap4-sdp: remove unneded unit names
      ARM: dts: omap4-var-om44customboard: remove unneded unit name
      ARM: dts: am43xx-epos-evm: remove unneded unit name
      ARM: dts: am437x-gp-evm: remove unneded unit name
      ARM: dts: am437x: cm-t43: remove unneded unit names
      ARM: dts: omap5-cm-t54: remove unneded unit names and add reg properties
      ARM: dts: omap5-board-common: remove unneded unit names
      ARM: dts: am57xx: sbc-am57x: remove unneded unit name

Jiancheng Xue (2):
      ARM: dt-bindings: add device tree bindings for Hi3519 sysctrl
      ARM: dts: add dts files for Hi3519 and tidy up the makefile entries

Joel Fernandes (2):
      ARM: dts: DRA7: Add DT node for DES IP
      ARM: dts: DRA7: Add DT nodes for AES IP

John Stultz (1):
      device-tree: nexus7: Remove power gpio key entry and use pmic8xxx-pwrkey

Jon Hunter (2):
      dt-bindings: phy: Fix description of Tegra210 PHY nodes
      dt-bindings: usb: Fix Tegra XUSB example

Jon Mason (5):
      ARM: dts: NSP: Add MSI support on PCI
      ARM: dts: NSP: modify second CPU address
      ARM: dts: NSP: Add new DT file for bcm958625hr
      ARM: dts: NSP: Add XMC board support
      ARM: dts: NSP: Add PL330 support

Juergen Borleis (1):
      ARM: dts: imx6: fix IPU1 DI1 node name

Keerthy (1):
      ARM: dts: keystone-k2l: Add pinctrl node

Ken Lin (1):
      ARM: dts: imx6q-bx50v3: Add gpio power off support

Kishon Vijay Abraham I (1):
      ARM: dts: DRA7: fix unit address of second PCIe instance

Krzysztof Kozlowski (30):
      ARM: dts: exynos: Define vqmmc for SD card and allow disabling regulators on Odroid X/X2/U3
      ARM: dts: exynos: Define vqmmc for eMMC card on Odroid X/X2/U3
      ARM: dts: exynos: Lower SD card interface voltage to 2.8 V on Odroid X/X2/U3
      ARM: dts: exynos: Only Odroid XU3-family boards use DTSI with CPU thermal nodes
      Merge tag 'clk-v4.8-exynos5410-dt' of git://linuxtv.org/snawrocki/samsung into for-v4.8/dts-exynos5410-odroid-xu
      ARM: dts: exynos: Replace deprecated hsi2c compatible on Exynos5420
      ARM: dts: exynos: Re-order alphabetically Exynos5420 SD0/SD1 pinctrl nodes
      ARM: dts: exynos: Enable CLKOUT on Exynos5410
      ARM: dts: exynos: Use lowercase for Exynos5410 CPU node labels
      ARM: dts: exynos: Configure Exynos5410 pinctrl for eMMC and SD card
      ARM: dts: exynos: Split Odroid XU3 LEDs to separate DTSI
      ARM: dts: exynos: Move common nodes to exynos5.dtsi
      ARM: dts: exynos: Prepare for inclusion of exynos5.dtsi in exynos5410.dtsi
      ARM: dts: exynos: Use phandle to get parent node in exynos5250-snow
      ARM: dts: exynos: Move Exynos5250 and Exynos5420 nodes under soc
      ARM: dts: exynos: Include common exynos5 in exynos5410.dtsi
      ARM: dts: exynos: Enable UART3 on Exynos5410
      ARM: dts: exynos: MCT is not an interrupt controller and extend length of iomap
      ARM: dts: exynos: Move common Exynos5410/542x/5800 nodes to new DTSI
      ARM: dts: exynos: Add USB to Exynos5410
      ARM: dts: exynos: Add initial support for Odroid XU board
      ARM: dts: exynos: Move HSI2C nodes to exynos54xx.dtsi
      ARM: dts: exynos: Add I2C, PWM and UART pinctrl to Exynos5410
      ARM: dts: exynos: Add RTC and I2C to Exynos5410
      ARM: dts: exynos: Interrupt for USB DWC3-1 differs between Exynos5420 and 5410
      Merge tag 'clk-v4.8-exynos5410-dt-2' of git://linuxtv.org/snawrocki/samsung into for-v4.8/dts-exynos5410-odroid-xu
      ARM: dts: exynos: Add Thermal Management Unit to Exynos5410
      ARM: dts: exynos: Configure PWM, usb3503, PMIC and thermal on Odroid XU board
      ARM: dts: exynos: Add watchdog and Security SubSystem to Exynos5410
      ARM: dts: exynos: No need to enable TMU nodes on Odroid XU3 family

Lee Jones (3):
      ARM: sti: stih407-family: Supply defines for CLOCKGEN A0
      ARM: sti: stih410-clocks: Identify critical clocks
      spi: st-ssc4: Remove 'no clocking' hack

Linus Walleij (11):
      ARM: dts: Ux500: move compatible string to chipset
      ARM: dts: Ux500: name the GPIO lines on Snowball
      ARM: dts: UX500: name the GPIO lines on HREFv60plus
      ARM: dts: add GPIO and MPP to MSM8660 PMIC
      ARM: dts: add SDCC5 to Qualcomm MSM8660
      ARM: dts: add L2CC and RPM with regulators for MSM8660
      ARM: dts: add I2C block in GSBI12
      ARM: dts: fix the MSM8660 RTC base address
      ARM: dts: move the fixed MMC regulator to SURF board
      ARM: dts: add Qualcomm APQ8060-based Dragonboard
      ARM: dts: Ux500: fix up TVK sensor data

Lokesh Vutla (6):
      ARM: dts: keystone: Header file for pinctrl constants
      ARM: dts: k2g-evm: Add pinmuxing for UART0
      ARM: dts: DRA7: Add support for SHA IP
      ARM: dts: DRA7: Add DT node for RNG IP
      ARM: dts: AM43xx: clk: Add RNG clk node
      ARM: dts: AM43xx: Add node for RNG

Lubomir Rintel (1):
      ARM: bcm2835: dt: Add the ethernet to the device trees

Lucas Stach (2):
      ARM: dts: imx6: tag boards that have the HW workaround for ERR006687
      ARM: dts: imx6: add support for Auvidea H100 board

Luo Yi (1):
      ARM: dts: sun7i: Add dts file for Bananapi M1 Plus board

Magnus Damm (4):
      devicetree: bindings: Renesas APMU and SMP Enable method
      ARM: dts: r8a7790: Add APMU nodes
      ARM: dts: r8a7791: Add APMU node
      ARM: dts: r8a7793: Add APMU node and second CPU core

Marcel Ziswiler (4):
      dt-bindings: tegra: Add Colibri T30 device tree binding documentation
      dt-bindings: tegra: Add Apalis TK1 device tree binding documentation
      ARM: tegra: Remove commas from unit addresses on Tegra124
      ARM: tegra: Initial support for Apalis TK1

Marek Belisko (1):
      ARM: dts: omap3-gta04: Add backlight support

Marek Szyprowski (3):
      ARM: dts: exynos: replace hardcoded reserved memory ranges with auto-allocated ones
      ARM: dts: exynos: move MFC reserved memory regions from boards to .dtsi
      ARM: dts: exynos: enable MFC device for all boards

Marek Vasut (4):
      ARM: dts: mxs: Add SSP2 SD mux
      ARM: dts: mxs: Add AUART2 pinmux
      ARM: dts: mxs: Add Creative X-Fi3 support
      ARM: dts: mxs: Add SanDisk Sansa Fuze+ support

Masahiro Yamada (3):
      ARM: dts: uniphier: add System Bus pinmux node
      ARM: dts: uniphier: add SoC-Glue node to UniPhier 32bit SoCs
      ARM: dts: uniphier: renumber serial aliases for Gentil/Vodka boards

Matthew Gerlach (1):
      ARM: dts: socfpga: fix definitions of serial console

Matthew Leach (1):
      ARM: dts: exynos: Enable AX88760 USB hub on Origen board

Maxime Ripard (4):
      ARM: sun5i: a13: Add LCD pins
      ARM: sun5i: Move display blocks to A13
      ARM: sun7i: Add DAI nodes
      ARM: sun5i: Allow PLL3 2x fixed factor clock to change PLL3 rate

Michal Suchanek (2):
      ARM: dts: sun5i: a10s: add spi2 pins
      ARM: dts: sun5i: add spi2 on A10s Olinuxino Micro

Misael Lopez Cruz (1):
      ARM: dts: dra72-evm: Rename 3.3V regulator tag

Murali Karicheri (2):
      ARM: dts: keystone: remove bogus IO resource entry from PCI binding
      ARM: dts: keystone: add interrupt property to PCI controller bindings

Naveen Krishna Chatradhi (1):
      ARM: dts: exynos: Use new compatible string for thermistors in Trats2

Neil Armstrong (1):
      ARM: dts: amlogic: Enable Reset Controller on Meson8b platforms

Nicolas Ferre (1):
      ARM: dts: at91: add at91sam9260ek board DT

Niklas S?derlund (4):
      ARM: dts: r8a7790: Reference both DMA controllers
      ARM: dts: r8a7791: Reference both DMA controllers
      ARM: dts: r8a7793: Reference both DMA controllers
      ARM: dts: r8a7794: Reference both DMA controllers

Olivier Schonken (1):
      ARM: dts: at91: sama5d2: add PMU node

Olof Johansson (19):
      Merge tag 'samsung-dt-4.8' of git://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'samsung-dt-odroid-xu-4.8' of git://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'renesas-dt-for-v4.8' of git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'ux500-dt-asoc-1' of git://git.kernel.org/.../linusw/linux-stericsson into next/dt
      Merge tag 'socfpga_updates_v4.8' of git://git.kernel.org/.../dinguyen/linux into next/dt
      Merge tag 'at91-ab-4.8-dt' of git://git.kernel.org/.../abelloni/linux into next/dt
      Merge tag 'amlogic-dt' of git://git.kernel.org/.../khilman/linux-amlogic into next/dt
      Merge tag 'arm-soc/for-4.8/devicetree' of http://github.com/Broadcom/stblinux into next/dt
      Merge tag 'keystone_dts_for_4.8' of git://git.kernel.org/.../ssantosh/linux-keystone into next/dt
      Merge tag 'at91-ab-4.8-dt2' of git://git.kernel.org/.../abelloni/linux into next/dt
      Merge tag 'omap-for-v4.8/dt-part1-signed-v2' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'qcom-dt-for-4.8' of git://git.kernel.org/.../agross/linux into next/dt
      Merge tag 'imx-dt-4.8' of git://git.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'omap-for-v4.8/dt-part2-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'samsung-drivers-exynos-mfc-4.8-2' of git://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'renesas-dt2-for-v4.8' of git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'v4.8-rockchip-dts32-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'tegra-for-4.8-dt-bindings' of git://git.kernel.org/.../tegra/linux into next/dt
      Merge tag 'pxa-dt-4.7' of https://github.com/rjarzmik/linux into next/dt

Parth Pancholi (1):
      ARM: dts: sd_600eval: Fix eMMC lockup issue

Peng Fan (2):
      ARM: dts: imx6qdl: add clocks property for ocotp node
      ARM: dts: imx6sl: add clocks property for ocotp node

Peter Chen (1):
      ARM: dts: imx6qdl.dtsi: add "arm,shared-override" for pl310

Peter Ujfalusi (6):
      ARM: dts: omap3: Add clocks to McBSP nodes
      ARM: dts: omap5-board-common: Add pdmclk binding for audio
      ARM: dts: omap4-panda-common: Add pdmclk binding for audio
      ARM: dts: omap4-sdp: Add pdmclk binding for audio
      ARM: dts: omap4-var-som-om44: Add pdmclk binding for audio
      ARM: dts: omap4-duovero: Add pdmclk binding for audio

Priit Laes (2):
      ARM: sun4i: A10: Add display and TCON clocks
      ARM: sun7i: A20: Add display and TCON clocks

Quentin Schulz (1):
      ARM: sun8i: Add Parrot Board DTS

Raashid Muhammed (4):
      ARM: dts: at91: at91sam9260: Remove leading zeros in OHCI node.
      ARM: dts: at91: Add DT support for Olimex SAM9-L9260 board.
      ARM: dts: at91: sam9_l9260: Add pinctrl information to ethernet node.
      ARM: dts: at91: sam9_l9260: Modify information in LED nodes.

Rafa? Mi?ecki (3):
      ARM: BCM5301X: Enable SPI-NOR on dual flash devices
      ARM: BCM5301X: Specify NAND chip select and ECC in separated files
      ARM: BCM5301X: Fix NAND ECC parameters for D-Link DIR-885L

Rajesh Bhagat (1):
      ARM: dts: ls1021a: Add dis_rxdet_inp3_quirk property to USB3 node

Raveendra Padasalagi (1):
      ARM: dts: Cygnus: Add Broadcom iproc-static-adc DT node

Robert Jarzmik (6):
      ARM: dts: pxa: add pxa framebuffer device
      ARM: dts: pxa: add pxa3xx pwm nodes
      ARM: dts: add pincontroller to pxa27x
      ARM: dts: pxa: fix the ohci clock for pxa3xx
      ARM: dts: pxa: add pinctrl to pxa3xx
      ARM: dts: pxa3xx: add pincontrol helpers

Robert P. J. Day (1):
      ARM: dts: Correct misspelling, "emda3" -> "edma3"

Russell King (1):
      ARM: dts: armada-388-clearfog: remove duplicate mdio entry

Sergei Shtylyov (15):
      ARM: dts: r8a7792: add clock index macros
      ARM: dts: r8a7792: add power domain index macros
      ARM: dts: r8a7792: initial SoC device tree
      ARM: dts: r8a7792: add SYS-DMAC support
      ARM: dts: r8a7792: add [H]SCIF support
      ARM: dts: r8a7792: add IRQC support
      ARM: dts: blanche: document Blanche board
      ARM: dts: blanche: initial device tree
      ARM: dts: blanche: add Ethernet support
      ARM: dts: silk: add DU pins
      ARM: dts: r8a7792: add JPU clocks
      ARM: dts: r8a7792: add JPU support
      ARM: dts: r8a7792: add SMP support
      ARM: dts: r8a7792: add PLL1 divided by 2 clock
      ARM: dts: r8a7792: remove ADSP clock

Soeren Moch (1):
      ARM: dts: imx6q-tbs2910: fix pcie reset polarity

Srinivas Kandagatla (3):
      ARM: dts: apq8064: move sdcc1 pinctrl nodes to soc file
      ARM: dts: apq8064: move sdcc3 pinctrls out of baord file
      ARM: dts: apq8064: rename db600c to SD_600eval

Stefan Agner (5):
      ARM: dts: imx7d-pinfunc: add input mux for UART2 RX DTE mode
      ARM: dts: imx7d: use imx7s.dtsi as base device tree
      ARM: dts: imx7d: recreate imx7d.dtsi with i.MX 7Dual specifics
      ARM: dts: imx7d: move input header into base device tree
      ARM: dts: imx7: add Toradex Colibri iMX7S/iMX7D support

Stefan Wahren (4):
      ARM: dts: mxs: add missing reg properties for GPIO banks
      ARM: dts: imx28-eukrea-mbmx28lc: add missing reg properties
      ARM: dts: imx28-cfa10049: fix dtc warning
      ARM: dts: imx28-tx28: fix dtc warning

Stephen Boyd (2):
      ARM: dts: qcom: Enable RPM regulators on apq8074 dragonboard
      ARM: dts: qcom: Enable sdcard and emmc on apq8074 dragonboard

Stephen Warren (1):
      ARM: tegra: Import latest Jetson TK1 spreadsheet

Thierry Reding (2):
      ARM: tegra: Fix a couple of DTC warnings
      ARM: tegra: Add spaces around = in properties

Thor Thayer (2):
      ARM: dts: Arria10 ECC Manager IRQ controller changes
      ARM: dts: Move Arria10 SDRAM as child of ECC Manager

Ulrich Hecht (1):
      ARM: dts: r8a7793: Add MMCIF0

Uwe Kleine-K?nig (2):
      ARM: imx25-pinfunc: document SION being important for MX25_PAD_SD1_CMD__SD1_CMD
      ARM: imx25-pinfunc: remove SION from all modes

Valentin Raevsky (1):
      ARM: dts: imx6q-cm-fx6: fix the operation points

Vignesh R (2):
      ARM: dts: DRA7: Add dt nodes for PWMSS
      ARM: dts: am335x-icev2: Add DT node for TI PCA9536

Vitaly Andrianov (1):
      ARM: dts: k2g: Add pinctrl support

Wenyou Yang (1):
      ARM: dts: at91: sama5d2_xplained: Update the pmic node

Xing Zheng (4):
      ARM: dts: rockchip: rename rk3228.dtsi to rk322x.dtsi
      ARM: dts: rockchip: add i2s nodes for RK322x SoCs
      ARM: dts: rockchip: add GMAC nodes for RK322x SoCs
      ARM: dts: rockchip: add support rk3229 evb board

twp at codeaurora.org (1):
      dts: ipq4019: support ARMv7 PMU


 .../arm/bcm/brcm,bcm11351-cpu-method.txt        |    6 +-
 .../arm/bcm/brcm,bcm23550-cpu-method.txt        |   36 +
 .../bindings/arm/bcm/brcm,bcm23550.txt          |   15 +
 Documentation/devicetree/bindings/arm/cpus.txt  |    3 +
 .../bindings/arm/hisilicon/hi3519-sysctrl.txt   |   14 +
 .../devicetree/bindings/arm/olimex.txt          |    8 +-
 .../devicetree/bindings/arm/rockchip.txt        |    3 +
 .../bindings/arm/samsung/samsung-boards.txt     |    1 +
 .../devicetree/bindings/arm/shmobile.txt        |    2 +
 Documentation/devicetree/bindings/arm/tegra.txt |    4 +
 .../devicetree/bindings/dma/ti-edma.txt         |    4 +-
 .../devicetree/bindings/firmware/qcom,scm.txt   |   28 +
 .../devicetree/bindings/iio/adc/at91_adc.txt    |   12 +-
 .../phy/nvidia,tegra124-xusb-padctl.txt         |    2 +-
 .../devicetree/bindings/power/renesas,apmu.txt  |   31 +
 .../devicetree/bindings/pwm/pwm-tiecap.txt      |   38 +-
 .../devicetree/bindings/pwm/pwm-tiehrpwm.txt    |   38 +-
 .../devicetree/bindings/pwm/pwm-tipwmss.txt     |   33 +-
 .../devicetree/bindings/soc/qcom/qcom,wcnss.txt |  116 +
 .../devicetree/bindings/usb/atmel-usb.txt       |   14 +-
 .../bindings/usb/nvidia,tegra124-xusb.txt       |    8 +-
 arch/arm/boot/dts/Makefile                      |   43 +-
 arch/arm/boot/dts/aks-cdu.dts                   |    2 +-
 arch/arm/boot/dts/am335x-bone-common.dtsi       |   12 +-
 arch/arm/boot/dts/am335x-boneblack.dts          |   11 +
 arch/arm/boot/dts/am335x-evm.dts                |    2 +-
 arch/arm/boot/dts/am335x-evmsk.dts              |    2 +-
 arch/arm/boot/dts/am335x-icev2.dts              |    7 +
 arch/arm/boot/dts/am33xx.dtsi                   |  126 +-
 arch/arm/boot/dts/am3517-craneboard.dts         |    2 +-
 arch/arm/boot/dts/am4372.dtsi                   |  111 +-
 arch/arm/boot/dts/am437x-gp-evm.dts             |    6 +-
 arch/arm/boot/dts/am437x-idk-evm.dts            |    1 +
 arch/arm/boot/dts/am437x-sbc-t43.dts            |    2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts            |    2 +-
 arch/arm/boot/dts/am43xx-clocks.dtsi            |    8 +
 arch/arm/boot/dts/am57xx-sbc-am57x.dts          |    2 +-
 arch/arm/boot/dts/animeo_ip.dts                 |   11 +-
 arch/arm/boot/dts/armada-388-clearfog.dts       |   16 -
 arch/arm/boot/dts/at91-ariag25.dts              |   11 +-
 arch/arm/boot/dts/at91-cosino.dtsi              |    9 -
 arch/arm/boot/dts/at91-foxg20.dts               |   13 +-
 arch/arm/boot/dts/at91-kizbox.dts               |    4 +-
 arch/arm/boot/dts/at91-qil_a9260.dts            |   13 +-
 arch/arm/boot/dts/at91-sam9_l9260.dts           |  121 +
 arch/arm/boot/dts/at91-sama5d2_xplained.dts     |   41 +-
 arch/arm/boot/dts/at91-sama5d3_xplained.dts     |    2 +-
 arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi       |   11 +-
 arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts     |    2 +-
 arch/arm/boot/dts/at91-sama5d4_xplained.dts     |    4 +-
 arch/arm/boot/dts/at91-sama5d4ek.dts            |   20 -
 arch/arm/boot/dts/at91-vinco.dts                |    2 +-
 arch/arm/boot/dts/at91rm9200.dtsi               |    2 +-
 arch/arm/boot/dts/at91sam9260.dtsi              |   16 +-
 arch/arm/boot/dts/at91sam9260ek.dts             |  211 ++
 arch/arm/boot/dts/at91sam9261.dtsi              |    2 +-
 arch/arm/boot/dts/at91sam9263.dtsi              |    2 +-
 arch/arm/boot/dts/at91sam9263ek.dts             |    2 +-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi     |    4 +-
 arch/arm/boot/dts/at91sam9g25ek.dts             |   26 +
 arch/arm/boot/dts/at91sam9g45.dtsi              |   28 +-
 arch/arm/boot/dts/at91sam9n12.dtsi              |    2 +-
 arch/arm/boot/dts/at91sam9rl.dtsi               |   30 +-
 arch/arm/boot/dts/at91sam9rlek.dts              |    4 +-
 arch/arm/boot/dts/at91sam9x5.dtsi               |   32 +-
 arch/arm/boot/dts/at91sam9x5ek.dtsi             |   33 -
 arch/arm/boot/dts/axp209.dtsi                   |    1 +
 arch/arm/boot/dts/axp22x.dtsi                   |   12 +
 arch/arm/boot/dts/axp809.dtsi                   |   53 +
 arch/arm/boot/dts/bcm-cygnus.dtsi               |   11 +
 arch/arm/boot/dts/bcm-nsp.dtsi                  |   55 +-
 arch/arm/boot/dts/bcm11351.dtsi                 |    2 +-
 arch/arm/boot/dts/bcm21664.dtsi                 |    2 +-
 arch/arm/boot/dts/bcm23550-sparrow.dts          |   80 +
 arch/arm/boot/dts/bcm23550.dtsi                 |  415 +++
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts        |    1 +
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts        |    1 +
 arch/arm/boot/dts/bcm2835-rpi-b.dts             |    1 +
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts           |    1 +
 arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi     |   19 +
 arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi     |   19 +
 arch/arm/boot/dts/bcm283x.dtsi                  |    2 +
 .../boot/dts/bcm4708-buffalo-wzr-1750dhp.dts    |    4 +
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts     |    4 +
 arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts  |    4 +
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts   |   40 +
 .../boot/dts/bcm4709-buffalo-wxr-1900dhp.dts    |    4 +
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts   |    6 +-
 arch/arm/boot/dts/bcm5301x-nand-cs0-bch1.dtsi   |   15 +
 arch/arm/boot/dts/bcm5301x-nand-cs0-bch8.dtsi   |   16 +-
 arch/arm/boot/dts/bcm5301x-nand-cs0.dtsi        |   18 +
 arch/arm/boot/dts/bcm5301x.dtsi                 |   47 +
 arch/arm/boot/dts/bcm953012er.dts               |  104 +
 arch/arm/boot/dts/bcm958525xmc.dts              |  109 +
 arch/arm/boot/dts/bcm958625hr.dts               |  111 +
 arch/arm/boot/dts/compulab-sb-som.dtsi          |    2 +-
 arch/arm/boot/dts/dm814x.dtsi                   |    2 +-
 arch/arm/boot/dts/dra7.dtsi                     |  242 +-
 arch/arm/boot/dts/dra72-evm-common.dtsi         |   12 +-
 arch/arm/boot/dts/dra72x.dtsi                   |   16 -
 arch/arm/boot/dts/dra74x.dtsi                   |   25 +-
 arch/arm/boot/dts/emev2-kzm9d.dts               |   24 +-
 arch/arm/boot/dts/emev2.dtsi                    |   26 +-
 arch/arm/boot/dts/ep7209.dtsi                   |  191 ++
 arch/arm/boot/dts/ep7211-edb7211.dts            |  100 +
 arch/arm/boot/dts/ep7211.dtsi                   |   12 +
 arch/arm/boot/dts/ethernut5.dts                 |    4 +-
 arch/arm/boot/dts/evk-pro3.dts                  |    4 +-
 .../boot/dts/exynos-mfc-reserved-memory.dtsi    |   14 +-
 arch/arm/boot/dts/exynos3250-rinato.dts         |    4 -
 arch/arm/boot/dts/exynos3250.dtsi               |    1 -
 arch/arm/boot/dts/exynos4.dtsi                  |    1 -
 arch/arm/boot/dts/exynos4210-origen.dts         |    5 -
 arch/arm/boot/dts/exynos4210-smdkv310.dts       |    5 -
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |   33 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts       |   18 +
 arch/arm/boot/dts/exynos4412-odroidx.dts        |   11 +
 arch/arm/boot/dts/exynos4412-odroidx2.dts       |   11 +
 arch/arm/boot/dts/exynos4412-origen.dts         |   21 +-
 arch/arm/boot/dts/exynos4412-smdk4412.dts       |    5 -
 arch/arm/boot/dts/exynos4412-trats2.dts         |    4 +-
 arch/arm/boot/dts/exynos5.dtsi                  |  215 +-
 arch/arm/boot/dts/exynos5250-arndale.dts        |    4 -
 arch/arm/boot/dts/exynos5250-smdk5250.dts       |    4 -
 arch/arm/boot/dts/exynos5250-snow-common.dtsi   |    2 +-
 arch/arm/boot/dts/exynos5250-spring.dts         |    4 -
 arch/arm/boot/dts/exynos5250.dtsi               | 1701 ++++++-----
 arch/arm/boot/dts/exynos5410-odroidxu.dts       |  580 ++++
 arch/arm/boot/dts/exynos5410-pinctrl.dtsi       |  210 ++
 arch/arm/boot/dts/exynos5410-smdk5410.dts       |    6 +-
 arch/arm/boot/dts/exynos5410.dtsi               |  333 ++-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts   |    4 -
 arch/arm/boot/dts/exynos5420-peach-pit.dts      |   30 +-
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi       |   12 +-
 arch/arm/boot/dts/exynos5420-smdk5420.dts       |    4 -
 arch/arm/boot/dts/exynos5420.dtsi               | 2770 ++++++++----------
 arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi   |  103 -
 .../boot/dts/exynos5422-odroidxu3-common.dtsi   |  102 +-
 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts |   35 +-
 arch/arm/boot/dts/exynos5422-odroidxu3.dts      |   35 +-
 arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi |   50 +
 arch/arm/boot/dts/exynos54xx.dtsi               |  199 ++
 arch/arm/boot/dts/exynos5800-peach-pi.dts       |   30 +-
 arch/arm/boot/dts/ge863-pro3.dtsi               |    9 -
 arch/arm/boot/dts/hi3519-demb.dts               |   42 +
 arch/arm/boot/dts/hi3519.dtsi                   |  187 ++
 arch/arm/boot/dts/imx1-ads.dts                  |    4 +-
 arch/arm/boot/dts/imx1-apf9328.dts              |    4 +-
 arch/arm/boot/dts/imx23-sansa.dts               |  207 ++
 arch/arm/boot/dts/imx23-xfi3.dts                |  179 ++
 arch/arm/boot/dts/imx23.dtsi                    |   48 +
 .../dts/imx25-eukrea-mbimxsd25-baseboard.dts    |    4 +-
 arch/arm/boot/dts/imx25-pdk.dts                 |    2 +-
 arch/arm/boot/dts/imx25-pinfunc.h               |  627 ++--
 arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi    |    2 +-
 .../dts/imx27-eukrea-mbimxsd27-baseboard.dts    |    6 +-
 arch/arm/boot/dts/imx27-pdk.dts                 |    2 +-
 .../arm/boot/dts/imx27-phytec-phycard-s-rdk.dts |    6 +-
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts  |    4 +-
 arch/arm/boot/dts/imx28-apf28dev.dts            |    2 +-
 arch/arm/boot/dts/imx28-cfa10049.dts            |    2 +-
 arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi    |    4 +
 arch/arm/boot/dts/imx28-evk.dts                 |    2 +-
 arch/arm/boot/dts/imx28-tx28.dts                |    2 +-
 arch/arm/boot/dts/imx28.dtsi                    |    5 +
 arch/arm/boot/dts/imx31-bug.dts                 |    2 +-
 .../dts/imx35-eukrea-mbimxsd35-baseboard.dts    |    4 +-
 arch/arm/boot/dts/imx35-pdk.dts                 |    2 +-
 arch/arm/boot/dts/imx51-babbage.dts             |    4 +-
 .../dts/imx51-eukrea-mbimxsd51-baseboard.dts    |    4 +-
 arch/arm/boot/dts/imx51-ts4800.dts              |   27 +
 arch/arm/boot/dts/imx53-smd.dts                 |    2 +-
 arch/arm/boot/dts/imx53-tqma53.dtsi             |    2 +-
 arch/arm/boot/dts/imx53-tx53.dtsi               |    6 +-
 arch/arm/boot/dts/imx6dl-riotboard.dts          |    1 +
 arch/arm/boot/dts/imx6q-apalis-ixora.dts        |    4 +-
 arch/arm/boot/dts/imx6q-arm2.dts                |    3 +-
 arch/arm/boot/dts/imx6q-ba16.dtsi               |    2 +-
 arch/arm/boot/dts/imx6q-bx50v3.dtsi             |    6 +
 arch/arm/boot/dts/imx6q-cm-fx6.dts              |  281 +-
 arch/arm/boot/dts/imx6q-h100.dts                |  395 +++
 arch/arm/boot/dts/imx6q-tbs2910.dts             |    2 +-
 arch/arm/boot/dts/imx6q-utilite-pro.dts         |  197 ++
 arch/arm/boot/dts/imx6qdl-apalis.dtsi           |    4 +-
 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi          |    2 +-
 arch/arm/boot/dts/imx6qdl-aristainetos.dtsi     |    4 +-
 arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi    |    4 +-
 arch/arm/boot/dts/imx6qdl-microsom.dtsi         |    2 +-
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi        |    3 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi    |    1 +
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi       |    1 +
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi        |    1 +
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi        |    1 +
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi          |   19 +-
 arch/arm/boot/dts/imx6qdl-tx6.dtsi              |    6 +-
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi        |    3 +-
 arch/arm/boot/dts/imx6qdl.dtsi                  |    4 +-
 arch/arm/boot/dts/imx6sl-warp.dts               |    2 +-
 arch/arm/boot/dts/imx6sl.dtsi                   |   13 +-
 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts        |    2 +-
 arch/arm/boot/dts/imx6sx-sdb.dtsi               |   14 +-
 arch/arm/boot/dts/imx6sx.dtsi                   |   12 +-
 arch/arm/boot/dts/imx6ul-14x14-evk.dts          |   63 +-
 arch/arm/boot/dts/imx6ul-pico-hobbit.dts        |    6 +-
 arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dts    |    4 +-
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi             |    6 +-
 arch/arm/boot/dts/imx6ul.dtsi                   |    9 +-
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi     |  148 +
 arch/arm/boot/dts/imx7-colibri.dtsi             |  571 ++++
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts         |    1 -
 arch/arm/boot/dts/imx7d-colibri-eval-v3.dts     |   66 +
 arch/arm/boot/dts/imx7d-colibri.dtsi            |   54 +
 arch/arm/boot/dts/imx7d-nitrogen7.dts           |    3 +-
 arch/arm/boot/dts/imx7d-pinfunc.h               |    2 +-
 arch/arm/boot/dts/imx7d-sdb.dts                 |  131 +-
 arch/arm/boot/dts/imx7d.dtsi                    |  923 +-----
 arch/arm/boot/dts/imx7s-colibri-eval-v3.dts     |   51 +
 arch/arm/boot/dts/imx7s-colibri.dtsi            |   50 +
 arch/arm/boot/dts/imx7s.dtsi                    |  933 ++++++
 arch/arm/boot/dts/keystone-k2e.dtsi             |    7 +-
 arch/arm/boot/dts/keystone-k2g-evm.dts          |   11 +
 arch/arm/boot/dts/keystone-k2g.dtsi             |    8 +
 arch/arm/boot/dts/keystone-k2l.dtsi             |  149 +
 arch/arm/boot/dts/keystone.dtsi                 |    7 +-
 .../boot/dts/logicpd-torpedo-37xx-devkit.dts    |    4 +-
 arch/arm/boot/dts/ls1021a.dtsi                  |    1 +
 arch/arm/boot/dts/meson8b.dtsi                  |    7 +
 arch/arm/boot/dts/mpa1600.dts                   |   11 +-
 arch/arm/boot/dts/omap24xx-clocks.dtsi          |    2 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts           |   10 +-
 arch/arm/boot/dts/omap3-beagle.dts              |   10 +-
 arch/arm/boot/dts/omap3-cm-t3x.dtsi             |    2 +-
 arch/arm/boot/dts/omap3-devkit8000-common.dtsi  |   12 +-
 .../boot/dts/omap3-devkit8000-lcd-common.dtsi   |    4 +-
 arch/arm/boot/dts/omap3-devkit8000-lcd43.dts    |    2 +-
 arch/arm/boot/dts/omap3-devkit8000-lcd70.dts    |    2 +-
 arch/arm/boot/dts/omap3-gta04.dtsi              |   72 +-
 arch/arm/boot/dts/omap3-ha-lcd.dts              |    2 +-
 arch/arm/boot/dts/omap3-igep0020-common.dtsi    |    8 +-
 arch/arm/boot/dts/omap3-n900.dts                |   12 +
 arch/arm/boot/dts/omap3-overo-common-dvi.dtsi   |    8 +-
 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi |    2 +-
 arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi |    2 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi     |    2 +-
 arch/arm/boot/dts/omap3-sb-t35.dtsi             |    8 +-
 arch/arm/boot/dts/omap3-thunder.dts             |    2 +-
 arch/arm/boot/dts/omap3.dtsi                    |   10 +
 arch/arm/boot/dts/omap4-duovero-parlor.dts      |    2 +-
 arch/arm/boot/dts/omap4-duovero.dtsi            |    5 +
 arch/arm/boot/dts/omap4-panda-common.dtsi       |   21 +-
 arch/arm/boot/dts/omap4-sdp.dts                 |   13 +-
 .../arm/boot/dts/omap4-var-om44customboard.dtsi |    2 +-
 arch/arm/boot/dts/omap4-var-som-om44.dtsi       |    5 +
 arch/arm/boot/dts/omap5-board-common.dtsi       |   13 +-
 arch/arm/boot/dts/omap5-cm-t54.dts              |   15 +-
 arch/arm/boot/dts/pm9g45.dts                    |    9 -
 arch/arm/boot/dts/pxa27x.dtsi                   |    7 +
 arch/arm/boot/dts/pxa2xx.dtsi                   |    8 +
 arch/arm/boot/dts/pxa3xx.dtsi                   |  133 +-
 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts  |  626 ++++
 ... => qcom-apq8064-arrow-sd-600eval-pins.dtsi} |    0
 ...0c.dts => qcom-apq8064-arrow-sd-600eval.dts} |   10 +-
 .../boot/dts/qcom-apq8064-asus-nexus7-flo.dts   |    6 -
 arch/arm/boot/dts/qcom-apq8064-pins.dtsi        |   40 +
 .../boot/dts/qcom-apq8064-sony-xperia-yuga.dts  |   44 +-
 arch/arm/boot/dts/qcom-apq8064.dtsi             |   10 +-
 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts  |  247 ++
 arch/arm/boot/dts/qcom-apq8084.dtsi             |    8 +
 arch/arm/boot/dts/qcom-ipq4019.dtsi             |    6 +
 arch/arm/boot/dts/qcom-msm8660-surf.dts         |   11 +
 arch/arm/boot/dts/qcom-msm8660.dtsi             |  166 +-
 .../dts/qcom-msm8974-sony-xperia-honami.dts     |    4 +
 arch/arm/boot/dts/qcom-msm8974.dtsi             |   28 +-
 arch/arm/boot/dts/qcom-pma8084.dtsi             |   20 +-
 arch/arm/boot/dts/r7s72100-genmai.dts           |    6 +-
 arch/arm/boot/dts/r8a73a4-ape6evm.dts           |   12 +-
 arch/arm/boot/dts/r8a73a4.dtsi                  |   34 +-
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts   |   20 +-
 arch/arm/boot/dts/r8a7740.dtsi                  |    2 +-
 arch/arm/boot/dts/r8a7778-bockw.dts             |    7 +-
 arch/arm/boot/dts/r8a7778.dtsi                  |   28 +-
 arch/arm/boot/dts/r8a7779-marzen.dts            |   10 +-
 arch/arm/boot/dts/r8a7790-lager.dts             |   30 +-
 arch/arm/boot/dts/r8a7790.dtsi                  |  237 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts           |   20 +-
 arch/arm/boot/dts/r8a7791-porter.dts            |   12 +-
 arch/arm/boot/dts/r8a7791.dtsi                  |  227 +-
 arch/arm/boot/dts/r8a7792-blanche.dts           |   66 +
 arch/arm/boot/dts/r8a7792.dtsi                  |  385 +++
 arch/arm/boot/dts/r8a7793-gose.dts              |   18 +-
 arch/arm/boot/dts/r8a7793.dtsi                  |  213 +-
 arch/arm/boot/dts/r8a7794-alt.dts               |    4 +-
 arch/arm/boot/dts/r8a7794-silk.dts              |   22 +-
 arch/arm/boot/dts/r8a7794.dtsi                  |  132 +-
 arch/arm/boot/dts/rk3228-evb.dts                |    2 +-
 arch/arm/boot/dts/rk3229-evb.dts                |   90 +
 arch/arm/boot/dts/{rk3228.dtsi => rk322x.dtsi}  |  118 +-
 arch/arm/boot/dts/rk3288-firefly.dtsi           |   31 +-
 arch/arm/boot/dts/rk3288-miqi.dts               |   26 +-
 arch/arm/boot/dts/rk3288-popmetal.dts           |   31 +-
 arch/arm/boot/dts/rk3288-rock2-som.dtsi         |   31 +-
 .../boot/dts/rk3288-veyron-analog-audio.dtsi    |  101 +
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi |    1 +
 arch/arm/boot/dts/rk3288-veyron.dtsi            |   31 +-
 arch/arm/boot/dts/rk3288.dtsi                   |    5 +
 arch/arm/boot/dts/sama5d2.dtsi                  |   37 +-
 arch/arm/boot/dts/sama5d3.dtsi                  |   44 +-
 arch/arm/boot/dts/sama5d31ek.dts                |    1 +
 arch/arm/boot/dts/sama5d33ek.dts                |    1 +
 arch/arm/boot/dts/sama5d34ek.dts                |    1 +
 arch/arm/boot/dts/sama5d35ek.dts                |    2 +
 arch/arm/boot/dts/sama5d36ek.dts                |    2 +
 arch/arm/boot/dts/sama5d3xcm.dtsi               |   34 -
 arch/arm/boot/dts/sama5d3xmb.dtsi               |   12 -
 arch/arm/boot/dts/sama5d3xmb_emac.dtsi          |   26 +
 arch/arm/boot/dts/sama5d3xmb_gmac.dtsi          |   48 +
 arch/arm/boot/dts/sama5d4.dtsi                  |   40 +-
 arch/arm/boot/dts/sh73a0-kzm9g.dts              |   19 +-
 arch/arm/boot/dts/sh73a0.dtsi                   |    2 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi          |   24 +-
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi    |    7 +-
 arch/arm/boot/dts/ste-dbx5x0.dtsi               |    1 +
 arch/arm/boot/dts/ste-href-tvk1281618.dtsi      |   62 +-
 arch/arm/boot/dts/ste-href.dtsi                 |    1 -
 arch/arm/boot/dts/ste-hrefv60plus.dtsi          |  120 +
 arch/arm/boot/dts/ste-snowball.dts              |   84 +-
 arch/arm/boot/dts/stih410-clock.dtsi            |    9 +
 arch/arm/boot/dts/sun4i-a10-a1000.dts           |    4 +-
 arch/arm/boot/dts/sun4i-a10-hackberry.dts       |    1 +
 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts      |    1 +
 arch/arm/boot/dts/sun4i-a10.dtsi                |  227 +-
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts    |   19 +
 arch/arm/boot/dts/sun5i-a10s-mk802.dts          |   32 +
 .../arm/boot/dts/sun5i-a10s-olinuxino-micro.dts |    7 +
 arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts        |   10 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi               |   14 +
 arch/arm/boot/dts/sun5i-a13-difrnce-dit4350.dts |  178 +-
 arch/arm/boot/dts/sun5i-a13-q8-tablet.dts       |   40 +-
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts        |  180 +-
 arch/arm/boot/dts/sun5i-a13.dtsi                |  122 +
 arch/arm/boot/dts/sun5i-r8.dtsi                 |  120 +-
 ....dtsi => sun5i-reference-design-tablet.dtsi} |   36 +-
 arch/arm/boot/dts/sun5i.dtsi                    |    2 +-
 arch/arm/boot/dts/sun6i-a31-m9.dts              |   96 +-
 .../arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts |   96 +-
 .../arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts |  229 ++
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts       |   80 +-
 arch/arm/boot/dts/sun7i-a20.dtsi                |  474 ++-
 arch/arm/boot/dts/sun8i-a23-inet86dz.dts        |   58 +
 .../dts/sun8i-a23-polaroid-mid2407pxe03.dts     |   50 +
 .../dts/sun8i-a23-polaroid-mid2809pxe04.dts     |  195 +-
 arch/arm/boot/dts/sun8i-a23-q8-tablet.dts       |   15 -
 arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts      |   77 +-
 arch/arm/boot/dts/sun8i-a33-q8-tablet.dts       |   15 -
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts |  195 ++
 arch/arm/boot/dts/sun8i-h3.dtsi                 |   21 +-
 arch/arm/boot/dts/sun8i-q8-common.dtsi          |  139 +-
 arch/arm/boot/dts/sun8i-r16-parrot.dts          |  351 +++
 .../boot/dts/sun8i-reference-design-tablet.dtsi |  216 ++
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts     |  164 +-
 arch/arm/boot/dts/sun9i-a80-optimus.dts         |  195 +-
 ....dtsi => sunxi-reference-design-tablet.dtsi} |    0
 arch/arm/boot/dts/tegra114-dalmore.dts          |    2 +-
 arch/arm/boot/dts/tegra114-roth.dts             |    4 +-
 arch/arm/boot/dts/tegra114-tn7.dts              |    2 +-
 arch/arm/boot/dts/tegra124-apalis-emc.dtsi      | 1502 ++++++++++
 arch/arm/boot/dts/tegra124-apalis-eval.dts      |  284 ++
 arch/arm/boot/dts/tegra124-apalis.dtsi          | 2100 +++++++++++++
 arch/arm/boot/dts/tegra124-jetson-tk1-emc.dtsi  |    6 +-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts       |   88 +-
 arch/arm/boot/dts/tegra124-nyan-big-emc.dtsi    |    6 +-
 arch/arm/boot/dts/tegra124-nyan-big.dts         |    4 +-
 arch/arm/boot/dts/tegra124-nyan-blaze-emc.dtsi  |    6 +-
 arch/arm/boot/dts/tegra124-nyan-blaze.dts       |    2 +-
 arch/arm/boot/dts/tegra124-nyan.dtsi            |   60 +-
 arch/arm/boot/dts/tegra124-venice2.dts          |   70 +-
 arch/arm/boot/dts/tegra124.dtsi                 |  125 +-
 arch/arm/boot/dts/tegra20-colibri-512.dtsi      |    2 +-
 arch/arm/boot/dts/tegra20-harmony.dts           |    2 +-
 arch/arm/boot/dts/tegra20-paz00.dts             |    2 +-
 arch/arm/boot/dts/tegra20-seaboard.dts          |    2 +-
 arch/arm/boot/dts/tegra20-tamonten.dtsi         |    2 +-
 arch/arm/boot/dts/tegra20-trimslice.dts         |    2 +-
 arch/arm/boot/dts/tegra20-ventana.dts           |    2 +-
 arch/arm/boot/dts/tegra20-whistler.dts          |    2 +-
 arch/arm/boot/dts/tegra30-apalis.dtsi           |    7 +-
 arch/arm/boot/dts/tegra30-beaver.dts            |    2 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi           |    2 +-
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts   |    2 +-
 arch/arm/boot/dts/tegra30-colibri.dtsi          |    2 +-
 arch/arm/boot/dts/tny_a9260_common.dtsi         |    9 -
 arch/arm/boot/dts/tny_a9263.dts                 |   11 +-
 arch/arm/boot/dts/uniphier-common32.dtsi        |   12 +-
 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi         |    2 +-
 arch/arm/boot/dts/uniphier-ph1-ld6b.dtsi        |    2 +-
 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi        |    2 +-
 arch/arm/boot/dts/uniphier-ph1-pro5.dtsi        |    2 +-
 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi        |    2 +-
 arch/arm/boot/dts/uniphier-pinctrl.dtsi         |    5 +
 .../boot/dts/uniphier-proxstream2-gentil.dts    |    8 +-
 .../arm/boot/dts/uniphier-proxstream2-vodka.dts |    8 +-
 arch/arm/boot/dts/uniphier-proxstream2.dtsi     |    2 +-
 arch/arm/boot/dts/usb_a9260_common.dtsi         |   13 +-
 arch/arm/boot/dts/usb_a9263.dts                 |   11 +-
 arch/arm/boot/dts/usb_a9g20_common.dtsi         |    5 +-
 arch/arm/mach-bcm/platsmp.c                     |  116 +-
 drivers/clk/ti/clk-43xx.c                       |    1 +
 drivers/spi/spi-st-ssc4.c                       |   36 +-
 include/dt-bindings/clock/r8a7792-clock.h       |  102 +
 include/dt-bindings/clock/r8a7794-clock.h       |    1 -
 include/dt-bindings/clock/stih407-clks.h        |    4 +
 include/dt-bindings/pinctrl/keystone.h          |   39 +
 include/dt-bindings/power/r8a7792-sysc.h        |   26 +
 413 files changed, 21016 insertions(+), 6944 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550-cpu-method.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550.txt
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hi3519-sysctrl.txt
 create mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.txt
 create mode 100644 Documentation/devicetree/bindings/power/renesas,apmu.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.txt
 create mode 100644 arch/arm/boot/dts/at91-sam9_l9260.dts
 create mode 100644 arch/arm/boot/dts/at91sam9260ek.dts
 create mode 100644 arch/arm/boot/dts/axp809.dtsi
 create mode 100644 arch/arm/boot/dts/bcm23550-sparrow.dts
 create mode 100644 arch/arm/boot/dts/bcm23550.dtsi
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi
 create mode 100644 arch/arm/boot/dts/bcm5301x-nand-cs0-bch1.dtsi
 create mode 100644 arch/arm/boot/dts/bcm5301x-nand-cs0.dtsi
 create mode 100644 arch/arm/boot/dts/bcm953012er.dts
 create mode 100644 arch/arm/boot/dts/bcm958525xmc.dts
 create mode 100644 arch/arm/boot/dts/bcm958625hr.dts
 create mode 100644 arch/arm/boot/dts/ep7209.dtsi
 create mode 100644 arch/arm/boot/dts/ep7211-edb7211.dts
 create mode 100644 arch/arm/boot/dts/ep7211.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5410-odroidxu.dts
 delete mode 100644 arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi
 create mode 100644 arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi
 create mode 100644 arch/arm/boot/dts/exynos54xx.dtsi
 create mode 100644 arch/arm/boot/dts/hi3519-demb.dts
 create mode 100644 arch/arm/boot/dts/hi3519.dtsi
 create mode 100644 arch/arm/boot/dts/imx23-sansa.dts
 create mode 100644 arch/arm/boot/dts/imx23-xfi3.dts
 create mode 100644 arch/arm/boot/dts/imx6q-h100.dts
 create mode 100644 arch/arm/boot/dts/imx6q-utilite-pro.dts
 create mode 100644 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
 create mode 100644 arch/arm/boot/dts/imx7-colibri.dtsi
 create mode 100644 arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
 create mode 100644 arch/arm/boot/dts/imx7d-colibri.dtsi
 create mode 100644 arch/arm/boot/dts/imx7s-colibri-eval-v3.dts
 create mode 100644 arch/arm/boot/dts/imx7s-colibri.dtsi
 create mode 100644 arch/arm/boot/dts/imx7s.dtsi
 create mode 100644 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
 rename arch/arm/boot/dts/{qcom-apq8064-arrow-db600c-pins.dtsi => qcom-apq8064-arrow-sd-600eval-pins.dtsi} (100%)
 rename arch/arm/boot/dts/{qcom-apq8064-arrow-db600c.dts => qcom-apq8064-arrow-sd-600eval.dts} (96%)
 create mode 100644 arch/arm/boot/dts/r8a7792-blanche.dts
 create mode 100644 arch/arm/boot/dts/r8a7792.dtsi
 create mode 100644 arch/arm/boot/dts/rk3229-evb.dts
 rename arch/arm/boot/dts/{rk3228.dtsi => rk322x.dtsi} (80%)
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi
 create mode 100644 arch/arm/boot/dts/sama5d3xmb_emac.dtsi
 create mode 100644 arch/arm/boot/dts/sama5d3xmb_gmac.dtsi
 rename arch/arm/boot/dts/{sun5i-q8-common.dtsi => sun5i-reference-design-tablet.dtsi} (85%)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a23-inet86dz.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
 create mode 100644 arch/arm/boot/dts/sun8i-r16-parrot.dts
 create mode 100644 arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
 rename arch/arm/boot/dts/{sunxi-q8-common.dtsi => sunxi-reference-design-tablet.dtsi} (100%)
 create mode 100644 arch/arm/boot/dts/tegra124-apalis-emc.dtsi
 create mode 100644 arch/arm/boot/dts/tegra124-apalis-eval.dts
 create mode 100644 arch/arm/boot/dts/tegra124-apalis.dtsi
 create mode 100644 include/dt-bindings/clock/r8a7792-clock.h
 create mode 100644 include/dt-bindings/pinctrl/keystone.h
 create mode 100644 include/dt-bindings/power/r8a7792-sysc.h
