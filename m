From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Aug 2011 18:30:44 +0100
Subject: [PATCH v2 0/8] Introduce logical CPU mapping
Message-ID: <1313429452-2820-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is version 2 of the RFC originally posted here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-August/060594.html

Changes since v1 include:

  * Fixed the GIC code to compile when !CONFIG_SMP
  * Based on -rc2
  * Added acks / tested-bys from various platform maintainers (thanks!)

Any feedback on the approach taken and comments from the shmobile folks
would be much appreciated.

Thanks,

Will


Will Deacon (8):
  ARM: cpuid: add support for reading MPIDR
  ARM: smp: populate logical CPU mapping during boot
  ARM: gic: convert logical CPU numbers into physical numbers
  ARM: exynos4: convert logical CPU numbers to physical numbers
  ARM: msm: convert logical CPU numbers to physical numbers
  ARM: shmobile: convert logical CPU numbers to physical numbers
  ARM: ux500: convert logical CPU numbers to physical numbers
  ARM: versatile: convert logical CPU numbers to physical numbers

 arch/arm/common/gic.c               |   17 ++++++++++++++---
 arch/arm/include/asm/cputype.h      |    6 ++++++
 arch/arm/include/asm/smp.h          |    6 ++++++
 arch/arm/kernel/smp.c               |   15 +++++++++++++++
 arch/arm/mach-exynos4/hotplug.c     |    2 +-
 arch/arm/mach-exynos4/platsmp.c     |    2 +-
 arch/arm/mach-msm/hotplug.c         |    2 +-
 arch/arm/mach-msm/platsmp.c         |    2 +-
 arch/arm/mach-realview/hotplug.c    |    2 +-
 arch/arm/mach-shmobile/smp-sh73a0.c |    6 +++++-
 arch/arm/mach-ux500/hotplug.c       |    2 +-
 arch/arm/mach-ux500/platsmp.c       |    2 +-
 arch/arm/mach-vexpress/hotplug.c    |    2 +-
 arch/arm/plat-versatile/platsmp.c   |    2 +-
 14 files changed, 55 insertions(+), 13 deletions(-)
