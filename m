From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Nov 2014 10:20:14 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Updates for v3.19
Message-ID: <cover.1415755881.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC DT updates for
v3.19.

This pull request is based on the previous round of
such requests, tagged as renesas-dt-for-v3.19,
which I have already sent a pull-request for.


The following changes since commit 25af9c83151822eb6d413b4d15d5f89804606ac7:

  ARM: shmobile: r8a7779 dtsi: Add SoC-specific SATA compatible property (2014-10-30 10:01:37 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt2-for-v3.19

for you to fetch changes up to 2887bd4265cfbec6ccdd099c1728f82b4bebb69b:

  ARM: shmobile: kzm9g-reference dts: Add labels for the LEDs (2014-11-10 10:12:04 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC DT Updates for v3.19

* Add labels for LEDs on kzm9g-reference and koelsch
* Use SoC-specific IIC compatible properties on sh73a0 and r8a73a4
* Add Sound DMA support to r8a7790/lager and r8a7791/koelsch

----------------------------------------------------------------
Geert Uytterhoeven (4):
      ARM: shmobile: r8a73a4 dtsi: Add SoC-specific IIC compatible properties
      ARM: shmobile: sh73a0 dtsi: Add SoC-specific IIC compatible properties
      ARM: shmobile: koelsch dts: Add labels for the LEDs
      ARM: shmobile: kzm9g-reference dts: Add labels for the LEDs

Koji Matsuoka (1):
      ARM: shmobile: r8a7794: Add VIN clock to device tree

Kuninori Morimoto (20):
      ARM: shmobile: r8a7790: Add Audio DMAC devices to DT
      ARM: shmobile: r8a7791: Add Audio DMAC devices to DT
      ARM: shmobile: r8a7790: Add Audio DMAC peri peri devices to DT
      ARM: shmobile: r8a7791: Add Audio DMAC peri peri devices to DT
      ARM: shmobile: r8a7790: sound enables Audio DMAC entry on DTSI
      ARM: shmobile: r8a7791: sound enables Audio DMAC entry on DTSI
      ARM: shmobile: r8a7790: sound enables Audio DMAC peri peri entry on DTSI
      ARM: shmobile: r8a7791: sound enables Audio DMAC peri peri entry on DTSI
      ARM: shmobile: lager: fixup IIC2 clock frequency
      ARM: shmobile: lager: Sound PIO support on DTS
      ARM: shmobile: lager: Sound DMA support on DTS
      ARM: shmobile: lager: Sound DMA support via BUSIF on DTS
      ARM: shmobile: lager: Sound DMA support via SRC on DTS
      ARM: shmobile: lager: Sound DMA support via DVC on DTS
      ARM: shmobile: koelsch: fixup I2C2 clock frequency
      ARM: shmobile: koelsch: Sound PIO support on DTS
      ARM: shmobile: koelsch: Sound DMA support on DTS
      ARM: shmobile: koelsch: Sound DMA support via BUSIF on DTS
      ARM: shmobile: koelsch: Sound DMA support via SRC on DTS
      ARM: shmobile: koelsch: Sound DMA support via DVC on DTS

 arch/arm/boot/dts/r8a73a4.dtsi               |  18 +--
 arch/arm/boot/dts/r8a7790-lager.dts          |  74 ++++++++++
 arch/arm/boot/dts/r8a7790.dtsi               | 203 ++++++++++++++++++++++++++-
 arch/arm/boot/dts/r8a7791-koelsch.dts        |  77 +++++++++-
 arch/arm/boot/dts/r8a7791.dtsi               | 202 +++++++++++++++++++++++++-
 arch/arm/boot/dts/r8a7794.dtsi               |   6 +-
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |   4 +
 arch/arm/boot/dts/sh73a0.dtsi                |  10 +-
 include/dt-bindings/clock/r8a7790-clock.h    |   2 +
 include/dt-bindings/clock/r8a7791-clock.h    |   2 +
 include/dt-bindings/clock/r8a7794-clock.h    |   2 +
 11 files changed, 576 insertions(+), 24 deletions(-)
