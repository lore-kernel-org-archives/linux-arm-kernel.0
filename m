From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 14 Dec 2010 16:56:47 +0900
Subject: [PATCH 00/03] ARM: mach-shmobile: Initial SMP support
Message-ID: <20101214075647.11275.25933.sendpatchset@t400s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: mach-shmobile: Initial SMP support

[PATCH 01/03] ARM: mach-shmobile: SMP base support 
[PATCH 02/03] ARM: mach-shmobile: Enable SMP support
[PATCH 03/03] ARM: mach-shmobile: sh73a0 SMP support

These patches add SMP framework support for R-Mobile and
SH-Mobile processors, together with hardware specific SMP
support for the sh73a0 processor.

Survives onlining and offlining of secondary processor cores
through sysfs. Should compile and boot regardless of 
CONFIG_SMP, CONFIG_HOTPLUG_CPU and CONFIG_LOCAL_TIMERS.

I suggest that patch 1 and 3 are taken through sh-2.6 and
patch 2 goes through the RMK patch tracker.

Signed-off-by: Magnus Damm <damm@opensource.se>
---
 arch/arm/Kconfig                                       |    3 
 arch/arm/mach-shmobile/Makefile                        |    7 +
 arch/arm/mach-shmobile/headsmp.S                       |   26 ++++
 arch/arm/mach-shmobile/hotplug.c                       |   41 ++++++
 arch/arm/mach-shmobile/include/mach/common.h           |    6 
 arch/arm/mach-shmobile/include/mach/entry-macro-intc.S |    6 
 arch/arm/mach-shmobile/include/mach/smp.h              |   16 ++
 arch/arm/mach-shmobile/localtimer.c                    |   25 ++++
 arch/arm/mach-shmobile/platsmp.c                       |   87 ++++++++++++++
 arch/arm/mach-shmobile/smp-sh73a0.c                    |   98 ++++++++++++++++
 10 files changed, 313 insertions(+), 2 deletions(-)
