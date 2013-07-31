From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 01 Aug 2013 03:38:08 +0900
Subject: [PATCH 00/02] ARM: shmobile: Per-CPU SMP boot / sleep code
Message-ID: <20130731183808.31551.47235.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: Per-CPU SMP boot / sleep code

[PATCH 01/02] ARM: shmobile: Introduce per-CPU SMP boot / sleep code
[PATCH 02/02] ARM: shmobile: Per-CPU SMP boot / sleep code for SCU SoCs

This series adds per-CPU SMP boot / sleep code to mach-shmobile and ties
it in with the Cortex-A9 SoCs using the shared SCU code. With this code
in place mach-shmobile has a common per-CPU demuxer that CPUs to start
from and a place where CPUs also go to sleep (perhaps forever).

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git renesas-devel-20130731 and
 [PATCH 00/07] ARM: shmobile: sh73a0, r8a7779 and emev2 SMP SCU rework
 
 Requires "[PATCH] ARM: Fix memblock_reserve() to include stext" during
 run time to allow test of CPU Hotplug with v3.11-rc kernels.

 arch/arm/mach-shmobile/headsmp.S             |   50 ++++++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/common.h |    4 ++
 arch/arm/mach-shmobile/platsmp-scu.c         |   17 +++++---
 arch/arm/mach-shmobile/platsmp.c             |   18 +++++++++
 4 files changed, 83 insertions(+), 6 deletions(-)
