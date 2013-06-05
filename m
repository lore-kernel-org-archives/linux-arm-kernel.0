From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 13:32:09 +0900
Subject: [PATCH 0/7] Renesas ARM-based SoC DT updates for v3.11
Message-ID: <1370406736-32272-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

The following changes since commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:

  Linux 3.10-rc2 (2013-05-20 14:37:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v3.11

for you to fetch changes up to 24603f3caf07f5f65aa17ed7851ad4741595cf6a:

  ARM: shmobile: marzen-reference: add irqpin support in DT (2013-06-04 18:05:59 +0900)

----------------------------------------------------------------
Renesas ARM-based SoC DT updates for v3.11

* Armadillo800eva reference DT - bring up armadillo800eva baord
  using DT as much as possible
* Remove unused GIC dtsi entries for r8a7790 and r8a73a4
* Add AS3711 and CPUFreq DT bindings for kzm9g-reference
* Add irqpin DT support for marzen-reference

----------------------------------------------------------------
Bastian Hecht (3):
      ARM: shmobile: r8a7740: Add OF support to initialze the GIC
      ARM: shmobile: r8a7740: Prepare for reference DT setup
      ARM: shmobile: armadillo800eva: Reference DT implementation

Guennadi Liakhovetski (2):
      ARM: shmobile: kzm9g-reference: add AS3711 and CPUFreq DT bindings
      ARM: shmobile: marzen-reference: add irqpin support in DT

Magnus Damm (2):
      ARM: shmobile: Remove unused r8a73a4 GIC CPU interface DT bits
      ARM: shmobile: Remove unused r8a7790 GIC CPU interface DT bits

 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/r8a73a4.dtsi                     |   6 -
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |  45 +++++
 arch/arm/boot/dts/r8a7740.dtsi                     | 117 +++++++++++
 arch/arm/boot/dts/r8a7779.dtsi                     |  17 ++
 arch/arm/boot/dts/r8a7790.dtsi                     |   6 -
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       |  86 +++++++++
 arch/arm/mach-shmobile/Kconfig                     |  14 ++
 arch/arm/mach-shmobile/Makefile                    |   1 +
 .../board-armadillo800eva-reference.c              | 213 +++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/r8a7740.h      |   3 +
 arch/arm/mach-shmobile/intc-r8a7740.c              |  24 ++-
 arch/arm/mach-shmobile/setup-r8a7740.c             |  54 +++---
 13 files changed, 544 insertions(+), 43 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
 create mode 100644 arch/arm/mach-shmobile/board-armadillo800eva-reference.c

-- 
1.8.2.1
