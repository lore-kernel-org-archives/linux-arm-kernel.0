From: khilman@baylibre.com (Kevin Hilman)
Date: Sun, 29 Oct 2017 09:43:08 -0700
Subject: [GIT PULL] Amlogic SoC updates for v4.15
Message-ID: <7hy3ntq50j.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-soc

for you to fetch changes up to dea54268f3925d05e75b9c6dec487a6515dc0ed5:

  ARM: meson: enable MESON_IRQ_GPIO in Kconfig for meson8b (2017-10-29 08:40:08 -0700)

----------------------------------------------------------------
Amlogic SoC updates for v4.15
- add SMP support to Meson8/8b

----------------------------------------------------------------
Carlo Caione (1):
      dt-bindings: Amlogic: Add Meson8 and Meson8b SMP related documentation

Jerome Brunet (1):
      ARM: meson: enable MESON_IRQ_GPIO in Kconfig for meson8b

Martin Blumenstingl (3):
      ARM: smp_scu: add a helper for powering on a specific CPU
      ARM: smp_scu: allow the platform code to read the SCU CPU status
      ARM: meson: Add SMP bringup code for Meson8 and Meson8b

 Documentation/devicetree/bindings/arm/amlogic/pmu.txt      |  18 ++++
 Documentation/devicetree/bindings/arm/amlogic/smp-sram.txt |  32 +++++++
 Documentation/devicetree/bindings/arm/cpus.txt             |   2 +
 arch/arm/Makefile                                          |   1 +
 arch/arm/include/asm/smp_scu.h                             |  12 +++
 arch/arm/kernel/smp_scu.c                                  |  43 +++++++--
 arch/arm/mach-meson/Kconfig                                |   2 +
 arch/arm/mach-meson/Makefile                               |   1 +
 arch/arm/mach-meson/platsmp.c                              | 440 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 545 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic/pmu.txt
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic/smp-sram.txt
 create mode 100644 arch/arm/mach-meson/platsmp.c
