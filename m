From: jonathan.austin@arm.com (Jonathan Austin)
Date: Tue, 14 May 2013 12:48:50 +0100
Subject: [PATCH 0/7] NOMMU fixes and preparation for NOMMU/SMP
Message-ID: <1368532137-8871-1-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series, mostly written by Will Deacon, contains fixes for
!CONFIG_MMU that are required in order to be able to run an SMP/NOMMU system.

These patches are required for Cortex-R7 and MPU support, that will be posted
to this list shortly.

This series represents my 'nommu' branch, which can be found at
http://www.linux-arm.org/git?p=linux-ja.git

These patches have been tested over the last year on Versatile Express/NOMMU.

Jonathan Austin (2):
  ARM: nommu: Don't build smp_tlb.c for !CONFIG_MMU
  ARM: nommu: add stub local_flush_bp_all() for !CONFIG_MMUU

Will Deacon (5):
  ARM: nommu: add entry point for secondary CPUs to head-nommu.S
  ARM: nommu: define dummy TLB operations for nommu configurations
  ARM: nommu: provide dummy cpu_switch_mm implementation
  ARM: nommu: do not initialise page tables in secondary_data structure
  ARM: suspend: fix CPU suspend code for !CONFIG_MMU configurations

 arch/arm/include/asm/proc-fns.h |    4 +++
 arch/arm/include/asm/smp_plat.h |    4 +++
 arch/arm/include/asm/tlbflush.h |   25 ++++++++++++++-
 arch/arm/kernel/Makefile        |    5 ++-
 arch/arm/kernel/head-nommu.S    |   50 +++++++++++++++++++++++++++---
 arch/arm/kernel/smp.c           |    2 ++
 arch/arm/kernel/suspend.c       |   64 ++++++++++++++++++++++-----------------
 arch/arm/mm/proc-v6.S           |    6 +++-
 arch/arm/mm/proc-v7.S           |   14 ++++++---
 9 files changed, 134 insertions(+), 40 deletions(-)

-- 
1.7.9.5
