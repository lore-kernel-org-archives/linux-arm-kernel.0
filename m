From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 18 Feb 2013 22:46:48 +0900
Subject: [PATCH 00/08] ARM: shmobile: CPU Hotplug and SMP CA9 SCU rework part 2
Message-ID: <20130218134648.17303.97576.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: CPU Hotplug and SMP CA9 SCU rework part 2

[PATCH 01/08] ARM: shmobile: Fix base address readout in headsmp-scu.S
[PATCH 02/08] ARM: shmobile: Rework SH73A0_SCU_BASE IOMEM() usage
[PATCH 03/08] ARM: shmobile: Use R8A7779_SCU_BASE with TWD
[PATCH 04/08] ARM: shmobile: Update r8a7779 to check SCU for hotplug
[PATCH 05/08] ARM: shmobile: Update r8a7779 to use scu_power_mode()
[PATCH 06/08] ARM: shmobile: Use sh73a0-specific cpu disable code
[PATCH 07/08] ARM: shmobile: Rearrange r8a7779 cpu hotplug code
[PATCH 08/08] ARM: shmobile: Remove unused hotplug.c

Finalize the SCU rework by performing minor fixes and converting
the r8a7779 SMP code to make use of common scu_power_mode() code
and the early SCU setup code in headsmp-scu.S.

Also, to save a few line remove hotplug.c while at it.

The only remaining itch to scratch here is to fix up CPU Hotplug
of CPU0 on r8a7779, but for that to happen we first need to start
accounting for spurious interrupts during shut down.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 No known dependencies apart from previous SMP cleanup series
 "[PATCH 00/06] ARM: shmobile: SMP Cortex-A9 SCU rework"
 Written against -next in renesas.git.

 arch/arm/mach-shmobile/Makefile              |    1 
 arch/arm/mach-shmobile/headsmp-scu.S         |    3 
 arch/arm/mach-shmobile/hotplug.c             |   64 ---------
 arch/arm/mach-shmobile/include/mach/common.h |   10 -
 arch/arm/mach-shmobile/smp-r8a7779.c         |  173 +++++++++++++-------------
 arch/arm/mach-shmobile/smp-sh73a0.c          |   11 +
 6 files changed, 99 insertions(+), 163 deletions(-)
