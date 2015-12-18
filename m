From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Dec 2015 11:29:43 +0900
Subject: [GIT PULL] Third Round of Renesas ARM Based SoC DT Updates for v4.5
Message-ID: <cover.1450402264.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these third round of Renesas ARM based SoC DT updates for v4.5.

This pull request is based on the previous round of
such requests, tagged as renesas-dt2-for-v4.5,
which you have already pulled.


The following changes since commit c8d9fdbe2d648caaa510d45dc13eba2e9957140b:

  ARM: shmobile: sh73a0 dtsi: Add L2 cache-controller node (2015-11-25 10:42:38 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt3-for-v4.5

for you to fetch changes up to d01c8bec91414f2110370dfcb9dd33fc0e573cee:

  ARM: shmobile: r8a779x: use SoC-specific usb-dmac compatibility strings (2015-12-17 10:10:54 +0900)

----------------------------------------------------------------
Third Round of Renesas ARM Based SoC DT Updates for v4.5

* Use SoC-specific usb-dmac and IPMMU compatibility strings
* Add internal delay for i2c IPs
* Add missing serial devices to r8a7793
* Enable DMA for r8a7793 serial devices
* Add serial port config to chosen/stdout-path
* Tidyup #sound-dai-cells settings for r8a7798/bockw
* Remove deprecated #gpio-range-cells from r8a7793
* Add EtherAVB support to r8a7791
* Add MSIOF support to sh73a0

----------------------------------------------------------------
Geert Uytterhoeven (11):
      ARM: shmobile: sh73a0: Add MSIOF clocks
      ARM: shmobile: sh73a0: Add MSIOF device nodes
      ARM: shmobile: bockw dts: Override #sound-dai-cells to zero
      ARM: shmobile: koelsch dts: Add serial port config to chosen/stdout-path
      ARM: shmobile: alt dts: Add serial port config to chosen/stdout-path
      ARM: shmobile: ape6evm dts: Add serial port config to chosen/stdout-path
      ARM: shmobile: bockw dts: Update console parameters
      ARM: shmobile: gose dts: Add serial port config to chosen/stdout-path
      ARM: shmobile: silk dts: Add serial port config to chosen/stdout-path
      ARM: shmobile: porter dts: Add serial port config to chosen/stdout-path
      ARM: shmobile: lager dts: Add serial port config to chosen/stdout-path

Kuninori Morimoto (1):
      ARM: shmobile: r8a7778: tidyup #sound-dai-cells settings

Magnus Damm (4):
      ARM: shmobile: r8a7790: IPMMU compat string SoC part number update
      ARM: shmobile: r8a7791: IPMMU compat string SoC part number update
      ARM: shmobile: r8a7793: IPMMU compat string SoC part number update
      ARM: shmobile: r8a7794: IPMMU compat string SoC part number update

Sergei Shtylyov (2):
      ARM: shmobile: r8a7791: add EtherAVB clock
      ARM: shmobile: r8a7791: add EtherAVB DT support

Simon Horman (4):
      ARM: shmobile: r8a7793: remove deprecated #gpio-range-cells
      ARM: shmobile: r8a7793: Add missing serial devices to DT
      ARM: shmobile: r8a7793: Describe DMA for the serial ports
      ARM: shmobile: r8a779x: use SoC-specific usb-dmac compatibility strings

Wolfram Sang (3):
      ARM: shmobile: r8a7790: dtsi: add internal delay for i2c IPs
      ARM: shmobile: r8a7791: dtsi: add internal delay for i2c IPs
      ARM: shmobile: r8a7794: dtsi: add internal delay for i2c IPs

 arch/arm/boot/dts/r8a73a4-ape6evm.dts     |   2 +-
 arch/arm/boot/dts/r8a7778-bockw.dts       |   9 +-
 arch/arm/boot/dts/r8a7778.dtsi            |   7 +-
 arch/arm/boot/dts/r8a7790-lager.dts       |   2 +-
 arch/arm/boot/dts/r8a7790.dtsi            |  20 +--
 arch/arm/boot/dts/r8a7791-koelsch.dts     |   2 +-
 arch/arm/boot/dts/r8a7791-porter.dts      |   2 +-
 arch/arm/boot/dts/r8a7791.dtsi            |  46 ++++--
 arch/arm/boot/dts/r8a7793-gose.dts        |   2 +-
 arch/arm/boot/dts/r8a7793.dtsi            | 230 ++++++++++++++++++++++++++++--
 arch/arm/boot/dts/r8a7794-alt.dts         |   2 +-
 arch/arm/boot/dts/r8a7794-silk.dts        |   2 +-
 arch/arm/boot/dts/r8a7794.dtsi            |  18 ++-
 arch/arm/boot/dts/sh73a0.dtsi             |  72 ++++++++--
 include/dt-bindings/clock/r8a7791-clock.h |   1 +
 include/dt-bindings/clock/sh73a0-clock.h  |   6 +-
 16 files changed, 363 insertions(+), 60 deletions(-)
