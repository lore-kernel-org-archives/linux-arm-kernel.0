From: will.deacon@arm.com (Will Deacon)
Date: Tue,  9 Aug 2011 22:42:34 +0100
Subject: [RFC PATCH 0/8] Introduce logical CPU mapping
Message-ID: <1312926162-22469-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series is an RFC following a discussion I had with Russell
the other day:

 http://lists.infradead.org/pipermail/linux-arm-kernel/2011-August/060370.html

The approach I've taken is fairly simple but is enough for booting on a
CPU with physical ID != 0 on platforms which can handle it.

Note that I haven't touched the OMAP4 or Tegra platforms since it's not
clear from the code how they would be adapted to make use of the
physical CPU number.

I've tested this with a Cortex-A9 on the vexpress platform but other
platforms have been compile-tested only.

This is an RFC, so I'd value any feedback or comments.

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

 arch/arm/common/gic.c               |   12 +++++++++---
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
 14 files changed, 50 insertions(+), 13 deletions(-)
