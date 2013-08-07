From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 08 Aug 2013 07:13:21 +0900
Subject: [PATCH 00/05] ARM: shmobile: Yet another SMP series
Message-ID: <20130807221321.22251.22774.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: Yet another SMP series

[PATCH 01/05] ARM: shmobile: Introduce shmobile_smp_cpu_disable()
[PATCH 02/05] ARM: shmobile: Use shmobile_smp_cpu_disable() on sh73a0
[PATCH 03/05] ARM: shmobile: Remove unused shmobile_smp_init_cpus()
[PATCH 04/05] ARM: shmobile: Expose shmobile_invalidate_start()
[PATCH 05/05] ARM: shmobile: Introduce shmobile_boot_size

This series cleans up the existing SMP code and introduces various new SMP
functions for mach-shmobile. The new functions are partially used by existing
SMP support code, but are also consumed by upcoming SMP support patches.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git renesas-devel-20130806v4 

 arch/arm/mach-shmobile/headsmp.S             |    3 +++
 arch/arm/mach-shmobile/include/mach/common.h |    4 +++-
 arch/arm/mach-shmobile/platsmp.c             |   22 +++++++---------------
 arch/arm/mach-shmobile/smp-sh73a0.c          |    9 +--------
 4 files changed, 14 insertions(+), 24 deletions(-)
