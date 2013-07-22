From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 Jul 2013 16:35:47 +0900
Subject: [GIT 00/11] Renesas ARM-based SoC DT updates for v3.12
Message-ID: <cover.1374478037.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following DT updates for v3.12.

This pull request is based on renesas-cleanup-for-v3.12 which I
have already sent a pull request for.

The following changes since commit ebd9616f439a8a46b9dca9a272b342f34c5f3614:

  ARM: shmobile: Remove unused mach/dma.h (2013-07-17 10:02:30 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v3.12

for you to fetch changes up to 66a5cab04d339d02b93a4671eadf8e251dbfdc2c:

  ARM: shmobile: Add SMSC ethernet chip to KZM9D DT reference (2013-07-17 10:06:47 +0900)

----------------------------------------------------------------
Renesas ARM-based SoC DT updates for v3.12

* Reference implementation for kzm9d board
* Add MMCIF and SDHI DT templates for r8a7790 and r8a73a4 SoCs
* Use DT for SMP and GIC initialisation on emev2 SoC and kzm9d board
* Add GIO to dtsi of emev2 SoC
* Update dts command line of kzm9d board
* Add CPUFreq support to ape6evm board
* Add I2C controller DT nodes to r8a73a4 SoC

----------------------------------------------------------------
Guennadi Liakhovetski (4):
      ARM: shmobile: r8a73a4: add I2C controller DT nodes
      ARM: shmobile: ape6evm: add CPUFreq support
      ARM: shmobile: r8a73a4: add MMCIF and SDHI DT templates
      ARM: shmobile: r8a7790: add MMCIF and SDHI DT templates

Magnus Damm (7):
      ARM: shmobile: Update KZM9D dts command line
      ARM: shmobile: Add GIO to EMEV2 dtsi
      ARM: shmobile: Use DT for GIC on EMEV2 and KZM9D
      ARM: shmobile: Use DT for SMP on EMEV2 and KZM9D
      ARM: shmobile: EMEV2 map_io update
      ARM: shmobile: KZM9D DT reference implementation
      ARM: shmobile: Add SMSC ethernet chip to KZM9D DT reference

 arch/arm/boot/dts/Makefile                     |   1 +
 arch/arm/boot/dts/emev2-kzm9d-reference.dts    |  57 +++++++++++
 arch/arm/boot/dts/emev2-kzm9d.dts              |   2 +-
 arch/arm/boot/dts/emev2.dtsi                   |  59 ++++++++++++
 arch/arm/boot/dts/r8a73a4-ape6evm.dts          |  22 +++++
 arch/arm/boot/dts/r8a73a4.dtsi                 | 126 +++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7790.dtsi                 |  54 +++++++++++
 arch/arm/mach-shmobile/Kconfig                 |  12 +++
 arch/arm/mach-shmobile/Makefile                |   1 +
 arch/arm/mach-shmobile/Makefile.boot           |   1 +
 arch/arm/mach-shmobile/board-kzm9d-reference.c |  46 +++++++++
 arch/arm/mach-shmobile/board-kzm9d.c           |   2 -
 arch/arm/mach-shmobile/include/mach/emev2.h    |   1 -
 arch/arm/mach-shmobile/setup-emev2.c           |  23 +----
 arch/arm/mach-shmobile/smp-emev2.c             |  17 +---
 15 files changed, 384 insertions(+), 40 deletions(-)
 create mode 100644 arch/arm/boot/dts/emev2-kzm9d-reference.dts
 create mode 100644 arch/arm/mach-shmobile/board-kzm9d-reference.c
