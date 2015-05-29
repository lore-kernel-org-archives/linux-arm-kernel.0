From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 May 2015 09:54:16 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Updates for v4.2
Message-ID: <cover.1432860632.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC DT updates for v4.2.

This pull request is based on the previous round of
such requests, tagged as renesas-dt-for-v4.2,
which I have already sent a pull-request for.

The change from using "nor-jedec" instead of "jedec,spi-nor" should
be safe as the usage of "nor-jedec" was added earlier in the v4.2 release
cycle and thus has not been present in a release.


The following changes since commit 7706993e2deb75022dbcfc3043890aa1a0020189:

  ARM: shmobile: r8a7791: Enable DMA for HSUSB (2015-05-12 08:55:16 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt2-for-v4.2

for you to fetch changes up to acea43fcb02746e907725c6dbd2eb95b32d79ea5:

  ARM: shmobile: r8a7790 dtsi: Describe DMA for the serial ports (2015-05-26 10:02:43 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC DT Updates for v4.2

* Describe DMA for the serial ports of R-Car Gen2 SoCs
* Add MMCIF max-frequency to R-Car Gen2 SoCs
* Use "nor-jedec" instead of "jedec,spi-nor"

----------------------------------------------------------------
Geert Uytterhoeven (8):
      ARM: shmobile: lager dts: Replace "nor-jedec" by "jedec,spi-nor"
      ARM: shmobile: koelsch dts: Replace "nor-jedec" by "jedec,spi-nor"
      ARM: shmobile: bockw-reference dts: Replace "nor-jedec" by "jedec,spi-nor"
      ARM: shmobile: henninger dts: Replace "nor-jedec" by "jedec,spi-nor"
      ARM: shmobile: bockw dts: Replace "nor-jedec" by "jedec,spi-nor"
      ARM: shmobile: r8a7794 dtsi: Describe DMA for the serial ports
      ARM: shmobile: r8a7791 dtsi: Describe DMA for the serial ports
      ARM: shmobile: r8a7790 dtsi: Describe DMA for the serial ports

Kuninori Morimoto (2):
      ARM: shmobile: r8a7790: add MMCIF max-frequency
      ARM: shmobile: r8a7791: add MMCIF max-frequency

 arch/arm/boot/dts/r8a7778-bockw-reference.dts |  2 +-
 arch/arm/boot/dts/r8a7778-bockw.dts           |  2 +-
 arch/arm/boot/dts/r8a7790-lager.dts           |  2 +-
 arch/arm/boot/dts/r8a7790.dtsi                | 22 ++++++++++++++++
 arch/arm/boot/dts/r8a7791-henninger.dts       |  2 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts         |  2 +-
 arch/arm/boot/dts/r8a7791.dtsi                | 37 +++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7794.dtsi                | 36 ++++++++++++++++++++++++++
 8 files changed, 100 insertions(+), 5 deletions(-)
