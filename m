From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 28 Sep 2012 10:21:23 +0100
Subject: [GIT PULL] ARM: cache flushing LoUIS API v2
Message-ID: <20120928092123.GA28967@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

I updated as discussed the patch series and folded the xscale and feroceon
fix into the first patch of the series, please consider dropping the old
series and pulling this updated version.

Changes wrt v1:
	# fixed LoUIS cache aliases for xscale and feroceon
	# rebased against v3.6-rc7

It has been tested on:

- OMAP4/5 (ARM and T2 kernels)
  # suspend/hotplug and CPU idle
- iMX6q (ARM kernel)
  # suspend and hotplug
- TC2 big.LITTLE testchip (ARM and T2 kernels)
  # CPU idle

Thank you very much indeed,
Lorenzo

The following changes since commit 979570e02981d4a8fc20b3cc8fd651856c98ee9d:

  Linux 3.6-rc7 (2012-09-23 18:10:57 -0700)

are available in the git repository at:

  git://linux-arm.org/linux-2.6-lp.git cache-louis

for you to fetch changes up to 94966a21d293668115e2195cb3488e009236b140:

  ARM: mm: update __v7_setup() to the new LoUIS cache maintenance API (2012-09-28 09:46:18 +0100)

----------------------------------------------------------------
Lorenzo Pieralisi (4):
      ARM: mm: implement LoUIS API for cache maintenance ops
      ARM: mm: rename jump labels in v7_flush_dcache_all function
      ARM: kernel: update cpu_suspend code to use cache LoUIS operations
      ARM: kernel: update __cpu_disable to use cache LoUIS maintenance API

Santosh Shilimkar (1):
      ARM: mm: update __v7_setup() to the new LoUIS cache maintenance API

 arch/arm/include/asm/cacheflush.h | 15 ++++++++++++
 arch/arm/include/asm/glue-cache.h |  1 +
 arch/arm/kernel/smp.c             |  5 +++-
 arch/arm/kernel/suspend.c         | 17 +++++++++++++-
 arch/arm/mm/cache-fa.S            |  3 +++
 arch/arm/mm/cache-v3.S            |  3 +++
 arch/arm/mm/cache-v4.S            |  3 +++
 arch/arm/mm/cache-v4wb.S          |  3 +++
 arch/arm/mm/cache-v4wt.S          |  3 +++
 arch/arm/mm/cache-v6.S            |  3 +++
 arch/arm/mm/cache-v7.S            | 48 ++++++++++++++++++++++++++++++++++-----
 arch/arm/mm/proc-arm1020.S        |  3 +++
 arch/arm/mm/proc-arm1020e.S       |  3 +++
 arch/arm/mm/proc-arm1022.S        |  3 +++
 arch/arm/mm/proc-arm1026.S        |  3 +++
 arch/arm/mm/proc-arm920.S         |  3 +++
 arch/arm/mm/proc-arm922.S         |  3 +++
 arch/arm/mm/proc-arm925.S         |  3 +++
 arch/arm/mm/proc-arm926.S         |  3 +++
 arch/arm/mm/proc-arm940.S         |  3 +++
 arch/arm/mm/proc-arm946.S         |  3 +++
 arch/arm/mm/proc-feroceon.S       |  4 ++++
 arch/arm/mm/proc-macros.S         |  1 +
 arch/arm/mm/proc-mohawk.S         |  3 +++
 arch/arm/mm/proc-v7.S             |  2 +-
 arch/arm/mm/proc-xsc3.S           |  3 +++
 arch/arm/mm/proc-xscale.S         |  4 ++++
 27 files changed, 142 insertions(+), 9 deletions(-)
