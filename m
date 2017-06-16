From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Jun 2017 15:30:17 +0200
Subject: [GIT PULL] Second Round of Renesas ARM64 Based SoC DT Updates for
 v4.13
Message-ID: <cover.1497617276.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM64 based SoC DT updates
for v4.13.

This pull request is based on the previous round of
such requests, tagged as renesas-arm64-dt-for-v4.13,
which you have already pulled.


The following changes since commit 0b03c32db03d63de695c1e0ab1950eb12b135fa7:

  arm64: dts: r8a7795: salvator-x: Add support for R-Car H3 ES2.0 (2017-05-22 14:54:57 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt2-for-v4.13

for you to fetch changes up to 4d1255ebefb6838eab4f652107433438bea0051f:

  arm64: dts: r8a7796: Add reset control properties for audio (2017-06-14 11:00:29 +0200)

----------------------------------------------------------------
Second Round of Renesas ARM64 Based SoC DT Updates for v4.13

* Add reset control properties for audio to r9a779[56] SoCs
* Add add DMA for IIC_DVFS to r9a779[56] SoCs
* Add support for Salvator-XS and H3ULCB with R-Car H3 (r8a7795) ES2
* Add missing index to PWM pinctrl subnode name to Salvator-X board
* Add 12288000 for sound ADG to Salvator-X and ULCB boards

----------------------------------------------------------------
Geert Uytterhoeven (7):
      arm64: dts: r8a7795: h3ulcb: Add support for R-Car H3 ES2.0
      arm64: dts: salvator-x: Add missing index to PWM pinctrl subnode name
      arm64: dts: renesas: Extract common Salvator-X/XS board support
      arm64: dts: renesas: Add common Salvator-XS board support
      arm64: dts: renesas: Add support for Salvator-XS with R-Car H3 ES2.0
      arm64: dts: r8a7795: Add reset control properties for audio
      arm64: dts: r8a7796: Add reset control properties for audio

Kuninori Morimoto (2):
      arm64: dts: salvator-x: add 12288000 for sound ADG
      arm64: dts: ulcb: add 12288000 for sound ADG

Wolfram Sang (2):
      arm64: dts: r8a7795: add DMA for IIC_DVFS
      arm64: dts: r8a7796: add DMA for IIC_DVFS

 arch/arm64/boot/dts/renesas/Makefile               |   3 +-
 arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb.dts |  42 ++
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts     |   4 +-
 .../arm64/boot/dts/renesas/r8a7795-salvator-xs.dts | 109 ++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  12 +
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           |  12 +
 arch/arm64/boot/dts/renesas/salvator-common.dtsi   | 629 +++++++++++++++++++++
 arch/arm64/boot/dts/renesas/salvator-x.dtsi        | 616 +-------------------
 arch/arm64/boot/dts/renesas/salvator-xs.dtsi       |  20 +
 arch/arm64/boot/dts/renesas/ulcb.dtsi              |   2 +-
 10 files changed, 830 insertions(+), 619 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
 create mode 100644 arch/arm64/boot/dts/renesas/salvator-common.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/salvator-xs.dtsi
