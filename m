From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:46:52 +0900
Subject: [GIT PULL] Renesas ARM-based SoC updates for v3.10
Message-ID: <1363607255-6385-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:

  Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v3.10

for you to fetch changes up to da8288d03cd9e22036c759c1bfb5ec91e4ad01fd:

  ARM: shmobile: fix kzm9g-reference compile breakage (2013-03-14 00:00:14 +0900)

----------------------------------------------------------------
Renesas ARM-based SoC updates for v3.10

----------------------------------------------------------------
Bastian Hecht (1):
      ARM: mach-shmobile: r8a7740: Add DT names to clock list

Guennadi Liakhovetski (3):
      ARM: shmobile: add MMCIF and SDHI DT clock aliases to sh73a0 and r8a7740
      ARM: shmobile: sh73a0: fix Z and ZG clock hierarchy
      ARM: shmobile: fix kzm9g-reference compile breakage

Kuninori Morimoto (6):
      ARM: shmobile: add gic_iid macro for ICCIAR / interrupt ID
      ARM: shmobile: r8a7779: fixup dtsi typo
      ARM: shmobile: r8a7779: fixup DT machine name
      ARM: shmobile: r8a7779: use gic_iid macro
      ARM: shmobile: tidyup chip series definition order for r8a7740/r8a7779
      ARM: shmobile: r8a7779: add Thermal support on DT

Magnus Damm (21):
      ARM: shmobile: Remove unused headers from hotplug.c
      ARM: shmobile: Remove partial CPU Hotplug from EMEV2
      ARM: shmobile: Move EMEV2 CPU boot vector setup code
      ARM: shmobile: Remove sh73a0_get_core_count()
      ARM: shmobile: Remove r8a7779_get_core_count()
      ARM: shmobile: Remove emev2_get_core_count()
      ARM: shmobile: Kill off sh73a0 scu_base_addr() function
      ARM: shmobile: Kill off r8a7779 scu_base_addr() function
      ARM: shmobile: Rework EMEV2 scu_base variable
      ARM: shmobile: Move headsmp-sh73a0.S to headsmp-scu.S
      ARM: shmobile: Common shmobile_scu_base in headsmp-scu.S
      ARM: shmobile: Update EMEV2 to use scu_power_mode()
      ARM: shmobile: Make EMEV2 setup functions static
      ARM: shmobile: Fix base address readout in headsmp-scu.S
      ARM: shmobile: Rework SH73A0_SCU_BASE IOMEM() usage
      ARM: shmobile: Use R8A7779_SCU_BASE with TWD
      ARM: shmobile: Update r8a7779 to check SCU for hotplug
      ARM: shmobile: Update r8a7779 to use scu_power_mode()
      ARM: shmobile: Use sh73a0-specific cpu disable code
      ARM: shmobile: Rearrange r8a7779 cpu hotplug code
      ARM: shmobile: Remove unused hotplug.c

Sergei Shtylyov (1):
      ARM: shmobile: R8A7779: use gic_iid() in SATA IRQ resource

Simon Horman (9):
      ARM: mach-shmobile: r8a7779: Allow initialisation of GIC by DT
      ARM: mach-shmobile: r8a7779: Minimal setup using DT
      ARM: shmobile: sh73a0: Remove sh73a0_init_irq_dt()
      ARM: shmobile: sh73a0: Add smp ops to DT_MACHINE_START
      ARM: shmobile: sh73a0: Remove warning about SMP
      ARM: shmobile: sh73a0: Do not use early devices with DT reference
      ARM: shmobile: r8a7779: Do not use early devices with DT reference
      ARM: shmobile: r8a7779: Do not initialise i2c as an early device
      ARM: shmobile: r8a7779: Remove lan from dtsi

Vladimir Barinov (2):
      ARM: mach-shmobile: r8a7779: SATA DT configuration
      ARM: mach-shmobile: r8a7779: add SATA support

 arch/arm/boot/dts/r8a7779.dtsi                     |   98 +++++++++++++++
 arch/arm/mach-shmobile/Makefile                    |    7 +-
 arch/arm/mach-shmobile/clock-r8a7740.c             |   13 ++
 arch/arm/mach-shmobile/clock-r8a7779.c             |    8 +-
 arch/arm/mach-shmobile/clock-sh73a0.c              |    7 +-
 .../{headsmp-sh73a0.S => headsmp-scu.S}            |   15 ++-
 arch/arm/mach-shmobile/hotplug.c                   |   68 -----------
 arch/arm/mach-shmobile/include/mach/common.h       |   21 ++--
 arch/arm/mach-shmobile/include/mach/irqs.h         |    1 +
 arch/arm/mach-shmobile/intc-r8a7779.c              |   27 +++-
 arch/arm/mach-shmobile/intc-sh73a0.c               |    8 --
 arch/arm/mach-shmobile/setup-emev2.c               |    4 +-
 arch/arm/mach-shmobile/setup-r8a7779.c             |  104 +++++++++++++---
 arch/arm/mach-shmobile/setup-sh73a0.c              |   36 ++----
 arch/arm/mach-shmobile/smp-emev2.c                 |   86 ++-----------
 arch/arm/mach-shmobile/smp-r8a7779.c               |  129 ++++++++++----------
 arch/arm/mach-shmobile/smp-sh73a0.c                |   36 +++---
 17 files changed, 355 insertions(+), 313 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a7779.dtsi
 rename arch/arm/mach-shmobile/{headsmp-sh73a0.S => headsmp-scu.S} (85%)
 delete mode 100644 arch/arm/mach-shmobile/hotplug.c
