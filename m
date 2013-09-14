From: magnus.damm@gmail.com (Magnus Damm)
Date: Sat, 14 Sep 2013 22:46:16 +0900
Subject: [PATCH 00/05] ARM: shmobile: Use CPU notifiers for SCU boot vector
 code
Message-ID: <20130914134616.19258.27110.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: Use CPU notifiers for SCU boot vector code

[PATCH 01/05] ARM: shmobile: Add CPU notifier based SCU boot vector code
[PATCH 02/05] ARM: shmobile: Let sh73a0 rely on SCU CPU notifier
[PATCH 03/05] ARM: shmobile: Let EMEV2 rely on SCU CPU notifier
[PATCH 04/05] ARM: shmobile: Let r8a7779 rely on SCU CPU notifier
[PATCH 05/05] ARM: shmobile: Remove shmobile_smp_scu_boot_secondary()

This series converts mach-shmobile to use CPU notifiers for boot vector
setup for SCU based SoCs such as sh73a0, EMEV2 and r8a7779. This
allows us to remove the shmobile_smp_scu_boot_secondary() function,
and it is also ground work for the CPUIdle resume path.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git tag renesas-devel-20130906

 arch/arm/mach-shmobile/include/mach/common.h |    2 -
 arch/arm/mach-shmobile/platsmp-scu.c         |   32 +++++++++++++++++++-------
 arch/arm/mach-shmobile/smp-emev2.c           |    6 ----
 arch/arm/mach-shmobile/smp-r8a7779.c         |    4 ---
 arch/arm/mach-shmobile/smp-sh73a0.c          |    5 ----
 5 files changed, 24 insertions(+), 25 deletions(-)
