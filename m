From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 23 Sep 2011 14:18:08 +0530
Subject: [GIT PULL] CPU PM notifiers and ARM driver PM updates for v3.2.
Message-ID: <1316767688-23705-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please pull the CPU PM notifier and ARM GIC, VFP PM updates for v3.2.
I have added vfp comment fix and strongly ordered descriptor patch
in this pull request.

Regards,
Santosh


The following changes since commit b6fd41e29dea9c6753b1843a77e50433e6123bcb:

  Linux 3.1-rc6 (2011-09-12 14:02:02 -0700)

are available in the git repository at:
  git://gitorious.org/omap-sw-develoment/linux-omap-dev.git for_3_2/for-rmk/arm_cpu_pm

Colin Cross (5):
      cpu_pm: Add cpu power management notifiers
      cpu_pm: call notifiers during suspend
      ARM: gic: Use cpu pm notifiers to save gic state
      ARM: vfp: Use cpu pm notifiers to save vfp state
      ARM: gic: Allow gic arch extensions to provide irqchip flags

Santosh Shilimkar (3):
      ARM: Enable CPU_PM notifiers on ARM machines.
      ARM: vfp: Fix the comment to make it consistent with the code.
      ARM: mm: Add strongly ordered descriptor support.

 arch/arm/Kconfig                    |    1 +
 arch/arm/common/gic.c               |  188 ++++++++++++++++++++++++++++
 arch/arm/include/asm/hardware/gic.h |    8 ++
 arch/arm/include/asm/mach/map.h     |    1 +
 arch/arm/include/asm/pgtable.h      |    3 +
 arch/arm/mm/mmu.c                   |    8 ++
 arch/arm/vfp/vfpmodule.c            |   31 ++++--
 include/linux/cpu_pm.h              |  109 ++++++++++++++++
 kernel/Makefile                     |    1 +
 kernel/cpu_pm.c                     |  233 +++++++++++++++++++++++++++++++++++
 kernel/power/Kconfig                |    4 +
 11 files changed, 578 insertions(+), 9 deletions(-)
 create mode 100644 include/linux/cpu_pm.h
 create mode 100644 kernel/cpu_pm.c
