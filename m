From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 25 Sep 2012 13:57:58 +0100
Subject: [GIT PULL] ARM: cache flushing LoUIS API
Message-ID: <20120925125758.GA16842@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

I know it is coming quite late in the cycle but please consider pulling
the patch series implementing the new cache maintenance LoUIS API, since
it provides a stepping stone to implementing power management on upcoming
A15 and A7 based platforms, leaving functionality for earlier processor
versions unchanged.

It has been tested on:

- OMAP4/5
  # suspend/hotplug and CPU idle
- iMX6q
  # suspend and hotplug
- TC2 big.LITTLE testchip
  # CPU idle

Thanks,
Lorenzo

The following changes since commit 5698bd757d55b1bb87edd1a9744ab09c142abfc2:

  Linux 3.6-rc6 (2012-09-16 14:58:51 -0700)

are available in the git repository at:

  git://linux-arm.org/linux-2.6-lp.git cache-louis

for you to fetch changes up to 6323fa2256baa73d6a960ee57ec086b66aeecd0b:

  ARM: mm: update __v7_setup() to the new LoUIS cache maintenance API (2012-09-25 11:20:26 +0100)

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
 arch/arm/mm/proc-feroceon.S       |  3 +++
 arch/arm/mm/proc-macros.S         |  1 +
 arch/arm/mm/proc-mohawk.S         |  3 +++
 arch/arm/mm/proc-v7.S             |  2 +-
 arch/arm/mm/proc-xsc3.S           |  3 +++
 arch/arm/mm/proc-xscale.S         |  3 +++
 27 files changed, 140 insertions(+), 9 deletions(-)
