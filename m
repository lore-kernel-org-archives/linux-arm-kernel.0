From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Feb 2016 15:30:02 +0100
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.6
Message-ID: <cover.1454595846.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT updates for v4.6.


The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v4.6

for you to fetch changes up to d7a11140d0a659e5c1f83627792f95b6713030a2:

  ARM: dts: silk: Enable SCIF_CLK frequency and pins (2016-02-02 14:02:28 +0100)

----------------------------------------------------------------
Renesas ARM Based SoC DT Updates for v4.6

* Use SCIF and USBHS fallback compatibility strings
* Add Baud Rate Generator (BRG) support for (H)SCIF
* Enable SCIF_CLK frequency and pins
* Use GIC_* defines
* Migrate to generic l2c OF initialization on r8a7740
* Enable audio on r8a7793/gose
* Enable HDMI vidio out on r8a7793
* Enable i2c on r8a7793/gose
* Enable QSPI on alt
* Enable GPIO keys and leds on gise
* Enable audio on porter
* Enable DU on porter

----------------------------------------------------------------
Geert Uytterhoeven (22):
      ARM: shmobile: r8a7740: Migrate to generic l2c OF initialization
      ARM: shmobile: r8a7740: Remove mapping of L2 cache controller registers
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

Magnus Damm (1):
      ARM: dts: r8a7793: gose: Add HDMI video out support

Sergei Shtylyov (3):
      ARM: dts: porter: add DU DT support
      ARM: dts: silk: add DU DT support
      ARM: dts: porter: add sound support

Simon Horman (33):
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

 arch/arm/boot/dts/emev2.dtsi              |  39 +-
 arch/arm/boot/dts/r7s72100.dtsi           | 177 +++----
 arch/arm/boot/dts/r8a73a4.dtsi            | 224 ++++-----
 arch/arm/boot/dts/r8a7740.dtsi            | 161 +++----
 arch/arm/boot/dts/r8a7778-bockw.dts       |  13 +
 arch/arm/boot/dts/r8a7778.dtsi            | 144 +++---
 arch/arm/boot/dts/r8a7779-marzen.dts      |  13 +
 arch/arm/boot/dts/r8a7779.dtsi            | 135 +++---
 arch/arm/boot/dts/r8a7790-lager.dts       |  13 +
 arch/arm/boot/dts/r8a7790.dtsi            | 441 +++++++++--------
 arch/arm/boot/dts/r8a7791-koelsch.dts     |  13 +
 arch/arm/boot/dts/r8a7791-porter.dts      | 165 +++++++
 arch/arm/boot/dts/r8a7791.dtsi            | 514 ++++++++++----------
 arch/arm/boot/dts/r8a7793-gose.dts        | 304 ++++++++++++
 arch/arm/boot/dts/r8a7793.dtsi            | 758 ++++++++++++++++++++++++------
 arch/arm/boot/dts/r8a7794-alt.dts         |  59 +++
 arch/arm/boot/dts/r8a7794-silk.dts        | 122 +++++
 arch/arm/boot/dts/r8a7794.dtsi            | 362 +++++++-------
 arch/arm/boot/dts/sh73a0.dtsi             | 186 ++++----
 arch/arm/mach-shmobile/setup-r8a7740.c    |  18 +-
 include/dt-bindings/clock/r8a7793-clock.h |   2 +
 21 files changed, 2571 insertions(+), 1292 deletions(-)
