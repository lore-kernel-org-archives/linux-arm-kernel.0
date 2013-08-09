From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 09 Aug 2013 18:47:48 +0900
Subject: [PATCH 00/14] ARM: shmobile: Cleanups and machine descriptor rework
Message-ID: <20130809094748.6530.16511.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: Cleanups and machine descriptor rework

[PATCH 01/14] ARM: shmobile: r8a7779: Remove ->init_machine() special case
[PATCH 02/14] ARM: shmobile: r8a7740: Remove ->init_machine() special case
[PATCH 03/14] ARM: shmobile: sh7372: Remove ->init_machine() special case 
[PATCH 04/14] ARM: shmobile: sh73a0: Remove ->init_machine() special case 
[PATCH 05/14] ARM: shmobile: Remove r8a7740_add_early_devices_dt()
[PATCH 06/14] ARM: shmobile: Remove sh73a0_init_irq_dt()
[PATCH 07/14] ARM: shmobile: Remove r8a7779 ->nr_irqs
[PATCH 08/14] ARM: shmobile: Remove sh73a0 ->nr_irqs
[PATCH 09/14] ARM: shmobile: Rename to sh7372_init_early()
[PATCH 10/14] ARM: shmobile: Rename to emev2_init_early(), use smp_set_ops()
[PATCH 11/14] ARM: shmobile: Rename to r8a7779_init_early(), use smp_set_ops()
[PATCH 12/14] ARM: shmobile: Rename to r8a7740_init_early()
[PATCH 13/14] ARM: shmobile: Rename to r8a7778_init_early()
[PATCH 14/14] ARM: shmobile: Rename to sh73a0_init_early(), use smp_set_ops()

This series contains various machine descriptor related cleanups
and removal of unused code.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git renesas-devel-20130807 and
 [PATCH 00/02] ARM: shmobile: Rename to r8a73a4/r8a7790_init_early()

 arch/arm/mach-shmobile/board-armadillo800eva-reference.c |    6 +-
 arch/arm/mach-shmobile/board-bockw-reference.c           |    2 
 arch/arm/mach-shmobile/board-bockw.c                     |    2 
 arch/arm/mach-shmobile/board-kzm9d-reference.c           |    3 -
 arch/arm/mach-shmobile/board-kzm9d.c                     |    3 -
 arch/arm/mach-shmobile/board-kzm9g-reference.c           |   13 +++-
 arch/arm/mach-shmobile/board-kzm9g.c                     |    1 
 arch/arm/mach-shmobile/board-marzen-reference.c          |   11 ++-
 arch/arm/mach-shmobile/board-marzen.c                    |    1 
 arch/arm/mach-shmobile/include/mach/emev2.h              |    2 
 arch/arm/mach-shmobile/include/mach/r8a7740.h            |    4 -
 arch/arm/mach-shmobile/include/mach/r8a7778.h            |    2 
 arch/arm/mach-shmobile/include/mach/r8a7779.h            |    4 -
 arch/arm/mach-shmobile/include/mach/sh7372.h             |    2 
 arch/arm/mach-shmobile/include/mach/sh73a0.h             |    5 -
 arch/arm/mach-shmobile/setup-emev2.c                     |    8 +-
 arch/arm/mach-shmobile/setup-r8a7740.c                   |   40 +++-----------
 arch/arm/mach-shmobile/setup-r8a7778.c                   |    4 -
 arch/arm/mach-shmobile/setup-r8a7779.c                   |   36 +++++-------
 arch/arm/mach-shmobile/setup-sh7372.c                    |   22 -------
 arch/arm/mach-shmobile/setup-sh73a0.c                    |   35 ++++--------
 21 files changed, 82 insertions(+), 124 deletions(-)
