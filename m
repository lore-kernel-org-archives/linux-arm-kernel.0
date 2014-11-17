From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Nov 2014 20:29:11 +0000
Subject: [PATCH 0/8] ARM cleanups
Message-ID: <20141117202911.GZ4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series is partly a result of reviewing differences
between ARM and ARM64, and cleans up ARM with some of the changes
made to ARM64.  Many of these changes are trivial cleanups.

I've also dropped some of the kernel boot messages - removing the
"SMP: Total of %d processors activated" message which was redundant,
and dropping a couple of others to debug level.

I've moved the ftrace assembly code to its own separate file, just
like on ARM64.

I've been running stuff with this for a number of weeks now, and
haven't noticed any regressions.

 arch/arm/common/sa1111.c        |  13 +--
 arch/arm/kernel/Makefile        |   1 +
 arch/arm/kernel/atags_compat.c  |   6 +-
 arch/arm/kernel/atags_parse.c   |   5 +-
 arch/arm/kernel/atags_proc.c    |   4 +-
 arch/arm/kernel/bios32.c        |   2 +-
 arch/arm/kernel/dma-isa.c       |   4 +-
 arch/arm/kernel/dma.c           |  26 ++---
 arch/arm/kernel/entry-common.S  | 235 --------------------------------------
 arch/arm/kernel/entry-ftrace.S  | 243 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/etm.c           |  12 +-
 arch/arm/kernel/fiq.c           |   2 +-
 arch/arm/kernel/io.c            |   5 +-
 arch/arm/kernel/irq.c           |   8 +-
 arch/arm/kernel/machine_kexec.c |   6 +-
 arch/arm/kernel/module.c        |   2 +-
 arch/arm/kernel/setup.c         |   1 +
 arch/arm/kernel/smp.c           |  15 +--
 arch/arm/kernel/smp_twd.c       |   4 +-
 arch/arm/kernel/swp_emulate.c   |   2 +-
 arch/arm/kernel/thumbee.c       |   2 +-
 arch/arm/kernel/topology.c      |   4 +-
 arch/arm/kernel/traps.c         |  42 +++----
 arch/arm/kernel/xscale-cp0.c    |   7 +-
 arch/arm/mm/alignment.c         |  10 +-
 arch/arm/mm/cache-feroceon-l2.c |   6 +-
 arch/arm/mm/cache-tauros2.c     |  12 +-
 arch/arm/mm/fault-armv.c        |   6 +-
 arch/arm/mm/fault.c             |  31 +++--
 arch/arm/mm/init.c              |   4 +-
 arch/arm/mm/mmu.c               |  38 +++----
 arch/arm/nwfpe/fpmodule.c       |   8 +-
 arch/arm/vfp/vfpsingle.c        |   2 +-
 33 files changed, 378 insertions(+), 390 deletions(-)

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
