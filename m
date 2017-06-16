From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Jun 2017 15:30:45 +0200
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Updates for v4.13
Message-ID: <cover.1497618353.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC DT updates for v4.13.

This pull request is based on the previous round of
such requests, tagged as renesas-dt-for-v4.13,
which you have already merged.


The following changes since commit 2ae0fcc57e00c11fae80678e2a9fabbeec82a185:

  ARM: dts: renesas: Switch to panel-lvds bindings for Mitsubishi panels (2017-05-15 11:14:39 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt2-for-v4.13

for you to fetch changes up to f7d569c1e6a6fa731fc34083a9f0191b7360eeb1:

  ARM: dts: r8a779x: Fix PCI bus dtc warnings (2017-06-12 11:18:30 +0200)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC DT Updates for v4.13

Cleanup:
* Correct PCI bus dtc warnings for r8a779x SoCs

Enhancements:
* Add support for iWave G20D-Q7 board based on RZ/G1M SoC
* Add support for GR-Peach board based on r7s72100 SoC
* Add composite video and HDMI input to gose board

----------------------------------------------------------------
Biju Das (2):
      ARM: dts: iwg20m: Add iWave RZG1M Qseven SOM
      ARM: dts: iwg20d-q7: Add support for iWave G20D-Q7 board based on RZ/G1M

Jacopo Mondi (1):
      ARM: dts: r7s72100: Add support for GR-Peach

Rob Herring (1):
      ARM: dts: r8a779x: Fix PCI bus dtc warnings

Ulrich Hecht (2):
      ARM: dts: gose: add HDMI input
      ARM: dts: gose: add composite video input

 Documentation/devicetree/bindings/arm/shmobile.txt |   2 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/r7s72100-gr-peach.dts            |  66 +++++++++++
 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts            |  25 ++++
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi              |  29 +++++
 arch/arm/boot/dts/r8a7790.dtsi                     |  16 +--
 arch/arm/boot/dts/r8a7791.dtsi                     |  16 +--
 arch/arm/boot/dts/r8a7793-gose.dts                 | 127 ++++++++++++++++++++-
 arch/arm/boot/dts/r8a7794.dtsi                     |  16 +--
 9 files changed, 267 insertions(+), 32 deletions(-)
 create mode 100644 arch/arm/boot/dts/r7s72100-gr-peach.dts
 create mode 100644 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
 create mode 100644 arch/arm/boot/dts/r8a7743-iwg20m.dtsi
