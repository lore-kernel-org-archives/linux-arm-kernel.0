From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 01 Aug 2013 04:01:10 +0900
Subject: [PATCH 00/13] ARM: shmobile: Rework ->init_time() /
 shmobile_timer_init()
Message-ID: <20130731190110.31796.96552.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: Rework ->init_time() / shmobile_timer_init()

[PATCH 01/13] ARM: shmobile: Use default ->init_time() on r8a73a4
[PATCH 02/13] ARM: shmobile: Use default ->init_time() on r8a7740
[PATCH 03/13] ARM: shmobile: Use default ->init_time() on r8a7778
[PATCH 04/13] ARM: shmobile: Use default ->init_time() on r8a7779
[PATCH 05/13] ARM: shmobile: Use default ->init_time() on Bockw
[PATCH 06/13] ARM: shmobile: Use default ->init_time() on Bockw DT ref
[PATCH 07/13] ARM: shmobile: Use default ->init_time() on Armadillo DT ref
[PATCH 08/13] ARM: shmobile: Use default ->init_time() on APE6EVM
[PATCH 09/13] ARM: shmobile: Use default ->init_time() on APE6EVM DT ref
[PATCH 10/13] ARM: shmobile: Use default ->init_time() on Marzen DT ref
[PATCH 11/13] ARM: shmobile: Use default ->init_time() on KZM9G DT ref
[PATCH 12/13] ARM: shmobile: Use clocksource_of_init() on r8a7790
[PATCH 13/13] ARM: shmobile: Remove unused shmobile_init_time()

Set ->init_time() to NULL to use the default ARM behaviour which
happens to be clocksource_of_init(). Also, replace the call to
shmobile_time_init() with clocksource_of_init(). Finally, remove
shmobile_init_time() that now is unused.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git renesas-devel-20130731 and
 [PATCH 00/07] ARM: shmobile: sh73a0, r8a7779 and emev2 SMP SCU rework
 [PATCH 00/02] ARM: shmobile: Per-CPU SMP boot / sleep code

 arch/arm/mach-shmobile/board-ape6evm-reference.c         |    1 -
 arch/arm/mach-shmobile/board-ape6evm.c                   |    1 -
 arch/arm/mach-shmobile/board-armadillo800eva-reference.c |    1 -
 arch/arm/mach-shmobile/board-bockw-reference.c           |    1 -
 arch/arm/mach-shmobile/board-bockw.c                     |    1 -
 arch/arm/mach-shmobile/board-kzm9g-reference.c           |    1 -
 arch/arm/mach-shmobile/board-marzen-reference.c          |    1 -
 arch/arm/mach-shmobile/include/mach/common.h             |    1 -
 arch/arm/mach-shmobile/setup-r8a73a4.c                   |    1 -
 arch/arm/mach-shmobile/setup-r8a7740.c                   |    1 -
 arch/arm/mach-shmobile/setup-r8a7778.c                   |    1 -
 arch/arm/mach-shmobile/setup-r8a7779.c                   |    1 -
 arch/arm/mach-shmobile/setup-r8a7790.c                   |    2 +-
 arch/arm/mach-shmobile/timer.c                           |    4 ----
 14 files changed, 1 insertion(+), 17 deletions(-)
