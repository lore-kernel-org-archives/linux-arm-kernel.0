From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 08 Oct 2016 02:39:51 +0200
Subject: [GIT PULL 8/8] ARM: SoC: late DT updates for v4.9
In-Reply-To: <3637015.LRn5VyhPVM@wuerfel>
References: <3637015.LRn5VyhPVM@wuerfel>
Message-ID: <5946904.G3JhgjvTMc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d63a5e7c713a68bd368016f2022326a1a91310d8:

  clk: sunxi-ng: Add hardware dependency (2016-09-10 11:41:21 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-late

for you to fetch changes up to 8185041f5fa6f02acf75229a590e16aac028fc5e:

  ARM: dts: lpc32xx: add device node for IRAM on-chip memory (2016-10-02 22:08:11 -0700)

----------------------------------------------------------------
ARM: SoC: late DT updates for v4.9

These updates have been kept in a separate branch mostly because
they rely on updates to the respective clk drivers to keep the
shared header files in sync.

- The Renesas r8a7796 (R-Car M3-W) platform gets added, this is an
  automotive SoC similar to the ?8a7795 chip we already support, but
  the dts changes rely on a clock driver change that has been
  merged for v4.9 through the clk tree.

- The Amlogic meson-gxbb (S905) platform gains support for a few
  drivers merged through our tree, in particular the network and
  usb driver changes are required and included here, and also
  the clk tree changes.

- The Allwinner platforms have seen a large-scale change to their
  clk drivers and the dts file updates must come after that.
  This includes the newly added Nextthing GR8 platform, which is
  derived from sun5i/A13.

- Some integrator (arm32) changes rely on clk driver changes.

- A single patch for lpc32xx has no such dependency but wasn't
  added until just before the merge window

----------------------------------------------------------------
Arnd Bergmann (8):
      Merge tag 'sunxi-dt-for-4.9-2' of https://git.kernel.org/.../mripard/linux into next/late
      Merge tag 'amlogic-dt64' of git://git.kernel.org/.../khilman/linux-amlogic into next/late
      Merge tag 'renesas-arm64-dt-for-v4.9' of git://git.kernel.org/.../horms/renesas into next/late
      Merge tag 'integrator-armsoc-1' of git://git.kernel.org/.../linusw/linux-integrator into next/late
      Merge tag 'amlogic-drivers-2' of git://git.kernel.org/.../khilman/linux-amlogic into next/late
      Merge tag 'amlogic-dt64-2' of git://git.kernel.org/.../khilman/linux-amlogic into next/late
      Merge tag 'sunxi-dt-for-4.9-3' of https://git.kernel.org/.../mripard/linux into next/late
      Merge branch 'next/late' into HEAD

Carlo Caione (4):
      documentation: Add secure monitor bindings documentation
      ARM64: dts: amlogic: gxbb: Enable secure monitor
      documentation: Add nvmem bindings documentation
      ARM64: dts: amlogic: gxbb: Enable NVMEM

Chen-Yu Tsai (7):
      ARM: dts: sun6i: switch A31/A31s to new CCU clock bindings
      ARM: dts: sun8i: Move A23/A33 usbphy and usb_otg nodes to common dtsi
      ARM: dts: sun9i: a80-optimus: Declare AXP809 SW regulator as unused
      ARM: dts: sun9i: cubieboard4: Declare AXP809 SW regulator as unused
      ARM: dts: sun9i: a80-optimus: Add AXP806 PMIC device node and regulators
      ARM: dts: sun9i: cubieboard4: Add AXP806 PMIC device node and regulators
      ARM: dts: sun9i: a80-optimus: Disable EHCI1

Geert Uytterhoeven (1):
      arm64: dts: r8a7795: Add SoC-specific compatible property to audio-dmac nodes

Hans de Goede (6):
      ARM: dts: sun8i: Add touchscreen node for sun8i-a23-gt90h
      ARM: dts: sun8i: Add touchscreen node for sun8i-a23-inet86dz
      ARM: dts: sun8i: Add touchscreen node for sun8i-a23-polaroid-mid2407pxe03
      ARM: dts: sun8i: Add touchscreen node for sun8i-a23-polaroid-mid2809pxe04
      ARM: dts: sun8i: Add touchscreen node for sun8i-a33-ga10h
      ARM: dts: sun8i: Add accelerometer to polaroid-mid2407pxe03

Icenowy Zheng (2):
      ARM: dts: sun8i: add pinmux for UART1 at PG
      ARM: dts: sun8i: enable UART1 for iNet D978 Rev2 board

Jerome Brunet (7):
      ARM64: dts: amlogic: add spi nor pins
      ARM64: dts: meson-gxbb: add pins for I2C
      ARM64: dts: gxbb: add i2c bus
      usb: dwc2: add support for Meson8b and GXBB SoCs
      clk: gxbb: expose spifc clock
      clk: gxbb: expose i2c clocks
      ARM64: dts: meson-gxbb-p20x: Enable USB Nodes

Joachim Eastwood (1):
      stmmac: introduce get_stmmac_bsp_priv() helper

Jorik Jonker (5):
      dts: sun8i-h3: add pinmux definitions for UART2-3
      dts: sun8i-h3: split off RTS/CTS for UART1 in seperate pinmux
      dts: sun8i-h3: associate exposed UARTs on Orange Pi Boards
      dts: sun8i-h3: add pinmux definitions for I2C0-2
      dts: sun8i-h3: add I2C0-2 peripherals to H3 SOC

Kevin Hilman (7):
      ARM64: DTS: meson-gxbb: switch ethernet to real clock
      Merge branch 'clk-meson-gxbb-ao' of git://git.kernel.org/.../clk/linux into v4.8/dt64
      ARM64: dts: amlogic: add the input pin for the IR remote
      ARM64: dts: meson-gxbb: Add PWM pinctrl nodes
      Merge branch 'clk-meson-gxbb' of git://git.kernel.org/.../clk/linux into v4.8/drivers
      Merge tag 'amlogic-drivers-2' into v4.8/dt64-2
      Merge branch 'v4.8/dt64' into v4.8/dt64-2

Kieran Bingham (2):
      arm64: dts: r8a7795: add FCPF device nodes
      arm64: dts: r8a7795: add FDP1 device nodes

Laurent Pinchart (5):
      arm64: dts: renesas: r8a7795: Add FCPV nodes
      arm64: dts: renesas: r8a7795: Add VSP instances
      arm64: dts: renesas: r8a7795: Add DU device to DT
      arm64: dts: r8a7795: renesas: salvator-x: Enable DU
      arm64: dts: r8a7795: salvator-x: Configure pins for the DU RGB output

Linus Walleij (8):
      ARM: dts: set the 24MHz xtal as parent of the UART clock
      ARM: dts: add the Integrator/AP baseboard clocks
      ARM: dts: Add the core module clocks to Integrator/AP
      ARM: dts: add the core module clocks to Integrator/CP
      ARM: integrator: move CP CLCD display to DTS
      ARM: integrator: delete some auxdata
      ARM: integrator: cut down on static maps
      ARM: integrator: read counter using syscon/regmap

Martin Blumenstingl (11):
      ARM64: dts: meson-gxbb: Enable the the IR decoder on supported boards
      net: dt-bindings: Document the new Meson8b and GXBB DWMAC bindings
      net: stmmac: add a glue driver for the Amlogic Meson 8b / GXBB DWMAC
      net: stmmac: update the module description of the dwmac-meson driver
      ARM64: dts: amlogic: enable ethernet on all Tronsmart Vega S95 devices
      ARM64: dts: meson-gxbb: use the new GXBB DWMAC glue driver
      ARM64: dts: meson-gxbb: add USB Nodes
      Documentation: dt-bindings: Add documentation for the Meson USB2 PHYs
      clk: gxbb: expose MPLL2 clock for use by DT
      clk: gxbb: expose USB clocks
      ARM64: dts: meson-gxbb-vega-s95: Enable USB Nodes

Maxime Ripard (4):
      Merge branch 'sunxi/clk-for-4.9' into sunxi/dt-for-4.9
      ARM: sun8i: Convert the A23 and A33 to the CCU
      ARM: sun8i: a33: Add display pipeline
      ARM: sun8i: a23/a33: Add RGB666 pins

Myl?ne Josserand (2):
      ARM: dts: Add NextThing GR8 dtsi
      ARM: dts: gr8: Add support for the GR8 evaluation board

Neil Armstrong (9):
      ARM64: dts: amlogic: meson-gxbb: Add watchdog node
      ARM64: dts: meson-gxbb: Add GXBB AO Clock and Reset node
      dt-bindings: media: meson-ir: Add Meson8b and GXBB compatible strings
      ARM64: dts: meson-gxbb: Add Infrared Remote Controller decoder
      ARM64: dts: meson-gxbb: Add Meson MHU Node
      ARM64: dts: meson-gxbb: Add Meson GXBB PWM Controller nodes
      ARM64: dts: meson-gxbb: add the SDIO pins
      ARM64: dts: meson-gxbb: Add SPIFC node
      ARM64: dts: meson-gxbb: add I2C nodes

Simon Horman (1):
      arm64: dts: r8a7795: remove unnecessary cap-mmc-highspeed property

Takeshi Kihara (2):
      arm64: dts: r8a7796: Add pinctrl device node
      arm64: dts: r8a7796: Add GPIO device nodes

Ulrich Hecht (1):
      arm64: dts: r8a7796: salvator-x: add serial console pins

Vladimir Barinov (13):
      arm64: dts: h3ulcb: add H3ULCB board DT bindings
      arm64: dts: h3ulcb: initial device tree
      arm64: dts: h3ulcb: enable SCIF clk and pins
      arm64: dts: h3ulcb: enable EthernetAVB
      arm64: dts: h3ulcb: enable I2C2
      arm64: dts: h3ulcb: enable EXTALR clk
      arm64: dts: h3ulcb: enable WDT
      arm64: dts: h3ulcb: enable USB2 PHY of channel 1
      arm64: dts: h3ulcb: enable USB2.0 Host channel 1
      arm64: dts: h3ulcb: enable GPIO keys
      arm64: dts: h3ulcb: enable SDHI0
      arm64: dts: h3ulcb: Sound SSI support
      arm64: dts: h3ulcb: enable GPIO leds

Vladimir Zapolskiy (1):
      ARM: dts: lpc32xx: add device node for IRAM on-chip memory

Wolfram Sang (1):
      arm64: dts: r8a7795: set maximum frequency for SDHI clocks

Yoshihiro Shimoda (4):
      arm64: dts: r8a7795: Add HSUSB device node
      arm64: dts: r8a7795: salvator-x: enable usb2_phy of channel 0
      arm64: dts: r8a7795: salvator-x: enable USB 2.0 Host channel 0
      arm64: dts: r8a7795: salvator-x: enable HSUSB

 Documentation/devicetree/bindings/arm/shmobile.txt |    2 +
 .../bindings/firmware/meson/meson_sm.txt           |   15 +
 .../devicetree/bindings/media/meson-ir.txt         |    5 +-
 .../devicetree/bindings/net/meson-dwmac.txt        |   45 +-
 .../devicetree/bindings/nvmem/amlogic-efuse.txt    |   39 +
 .../devicetree/bindings/phy/meson-usb2-phy.txt     |   27 +
 Documentation/devicetree/bindings/usb/dwc2.txt     |    2 +
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/integratorap.dts                 |   51 +-
 arch/arm/boot/dts/integratorcp.dts                 |   74 +-
 arch/arm/boot/dts/lpc32xx.dtsi                     |   12 +-
 arch/arm/boot/dts/ntc-gr8-evb.dts                  |  342 ++++++
 arch/arm/boot/dts/ntc-gr8.dtsi                     | 1087 ++++++++++++++++++++
 arch/arm/boot/dts/sun6i-a31.dtsi                   |  424 ++------
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               |  305 ++----
 arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts           |    9 +
 arch/arm/boot/dts/sun8i-a23-inet86dz.dts           |    9 +
 .../boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts   |   26 +
 .../boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts   |    9 +
 arch/arm/boot/dts/sun8i-a23.dtsi                   |   80 +-
 arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts         |   10 +
 arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts     |   20 +
 arch/arm/boot/dts/sun8i-a33.dtsi                   |  236 +++--
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    |    2 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts          |   18 +
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts        |   18 +
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         |   18 +
 arch/arm/boot/dts/sun8i-h3.dtsi                    |   85 +-
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts        |  116 +++
 arch/arm/boot/dts/sun9i-a80-optimus.dts            |  123 ++-
 arch/arm/mach-integrator/integrator_ap.c           |   36 -
 arch/arm/mach-integrator/integrator_cp.c           |  123 +--
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |   11 +
 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts    |    6 +
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   |   35 +
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      |   42 +
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |  329 +++++-
 arch/arm64/boot/dts/renesas/Makefile               |    2 +-
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts     |  328 ++++++
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |   87 ++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  276 ++++-
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |   16 +
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           |  117 +++
 drivers/clk/meson/gxbb.h                           |   18 +-
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |    6 +-
 drivers/net/ethernet/stmicro/stmmac/Makefile       |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c  |    4 +-
 .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    |  324 ++++++
 .../net/ethernet/stmicro/stmmac/stmmac_platform.h  |    8 +
 drivers/usb/dwc2/platform.c                        |   34 +
 include/dt-bindings/clock/gxbb-clkc.h              |    9 +
 51 files changed, 4153 insertions(+), 870 deletions(-)
