From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 14 May 2015 10:06:56 +0900
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.2
Message-ID: <cover.1431565427.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT updates for v4.2.


The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v4.2

for you to fetch changes up to 7706993e2deb75022dbcfc3043890aa1a0020189:

  ARM: shmobile: r8a7791: Enable DMA for HSUSB (2015-05-12 08:55:16 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC DT Updates for v4.2

* Enable DMA for HSUSB on r8a7790 and r8a7791 SoCs
* Configure the HOME key as wake-up source on kzm9g board
* Use generic names for device nodes on SH Mobile SoCs and boards
* Add "nor-jedec" compatible value to SH Mobile boards
* Add IRQC clock to r8a73a4, r8a779* SoCs
* Remove MSIOF address from r8a7790 and r8a7791 SoCs

----------------------------------------------------------------
Geert Uytterhoeven (25):
      ARM: shmobile: r8a7740 dtsi: Fix SCIFB naming
      ARM: shmobile: sh73a0 dtsi: Fix SCIFB naming
      ARM: shmobile: r8a73a4: Add IRQC clock to device tree
      ARM: shmobile: r8a7790: Add IRQC clock to device tree
      ARM: shmobile: r8a7791: Add IRQC clock to device tree
      ARM: shmobile: r8a7794: Add IRQC clock to device tree
      ARM: shmobile: r8a7740 dtsi: Use generic names for device nodes
      ARM: shmobile: r8a7778 dtsi: Use generic names for device nodes
      ARM: shmobile: r8a7779 dtsi: Use generic names for device nodes
      ARM: shmobile: r8a7790 dtsi: Use generic names for device nodes
      ARM: shmobile: r8a7791 dtsi: Use generic names for device nodes
      ARM: shmobile: sh73a0 dtsi: Use generic names for device nodes
      ARM: shmobile: ape6evm dts: Use generic names for device nodes
      ARM: shmobile: kzm9d dts: Use generic names for device nodes
      ARM: shmobile: marzen dts: Use generic names for device nodes
      ARM: shmobile: armadillo800eva dts: Use generic names for device nodes
      ARM: shmobile: henninger dts: Add "nor-jedec" compatible value
      ARM: shmobile: bockw-reference dts: Add "nor-jedec" compatible value
      ARM: shmobile: lager dts: Add "nor-jedec" compatible value
      ARM: shmobile: bockw dts: Add "nor-jedec" compatible value
      ARM: shmobile: koelsch dts: Add "nor-jedec" compatible value
      ARM: shmobile: bockw dts: Use generic names for device nodes
      ARM: shmobile: lager dts: Use generic names for device nodes
      ARM: shmobile: koelsch dts: Use generic names for device nodes
      ARM: shmobile: kzm9g dts: Configure the HOME key as wake-up source

Ryo Kataoka (2):
      ARM: shmobile: r8a7790: Remove MSIOF address from device tree
      ARM: shmobile: r8a7791: Remove MSIOF address from device tree

Yoshihiro Shimoda (4):
      ARM: shmobile: r8a7790: add USB-DMAC device nodes
      ARM: shmobile: r8a7790: Enable DMA for HSUSB
      ARM: shmobile: r8a7791: add USB-DMAC device nodes
      ARM: shmobile: r8a7791: Enable DMA for HSUSB

 Documentation/devicetree/bindings/spi/sh-msiof.txt |  2 +-
 arch/arm/boot/dts/emev2-kzm9d.dts                  |  4 +-
 arch/arm/boot/dts/r8a73a4-ape6evm.dts              |  2 +-
 arch/arm/boot/dts/r8a73a4.dtsi                     | 11 ++++--
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts      |  2 +-
 arch/arm/boot/dts/r8a7740.dtsi                     | 10 ++---
 arch/arm/boot/dts/r8a7778-bockw-reference.dts      |  2 +-
 arch/arm/boot/dts/r8a7778-bockw.dts                |  4 +-
 arch/arm/boot/dts/r8a7778.dtsi                     |  2 +-
 arch/arm/boot/dts/r8a7779-marzen.dts               |  6 +--
 arch/arm/boot/dts/r8a7779.dtsi                     |  2 +-
 arch/arm/boot/dts/r8a7790-lager.dts                |  4 +-
 arch/arm/boot/dts/r8a7790.dtsi                     | 44 +++++++++++++++++++---
 arch/arm/boot/dts/r8a7791-henninger.dts            |  2 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts              |  4 +-
 arch/arm/boot/dts/r8a7791.dtsi                     | 42 +++++++++++++++++++--
 arch/arm/boot/dts/r8a7794.dtsi                     |  9 +++++
 arch/arm/boot/dts/sh73a0-kzm9g.dts                 |  1 +
 arch/arm/boot/dts/sh73a0.dtsi                      | 10 ++---
 include/dt-bindings/clock/r8a73a4-clock.h          |  1 +
 include/dt-bindings/clock/r8a7790-clock.h          |  3 ++
 include/dt-bindings/clock/r8a7791-clock.h          |  3 ++
 include/dt-bindings/clock/r8a7794-clock.h          |  3 ++
 23 files changed, 132 insertions(+), 41 deletions(-)
