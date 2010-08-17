From: tony@atomide.com (Tony Lindgren)
Date: Tue, 17 Aug 2010 13:53:12 +0300
Subject: [PATCH 0/4] Hacks to allow booting ARM SMP kernel on UP ARMv7
Message-ID: <20100817104414.19061.38999.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are some experimental patches to allow booting ARMv7 SMP
kernel on UP to some extent. Posting these early in case it is
of any help as I know at least Bryan Wu is working on similar
issues.

The patches are very much work in progress, and does not quite
boot to init yet so there's all kinds of things to fix. But at
least these patches allow booting to the point where the fixing
issues might be a bit easier.. Currently it boots to the point
where there are tons of "WARNING: at mm/percpu-vm.c:320 pcpu_alloc"
prints.

I've only tested these on omap3 UP systems so far so YMMV. The
patches are posted on top of v2.6.36-rc1 + omap-fixes branch.
Also available in devel-smp-on-unicore branch in the linux-omap
tree.

Cheers,

Tony

---

Tony Lindgren (4):
      ARM: Add SMP_ON_UP Kconfig option for booting SMP kernel on UP
      ARM: Allow optional UP processor functions for SMP kernels
      ARM: Set separate proc-v7 functions for SMP
      omap: Fix SMP on UP interrupt handling for multi-omap


 arch/arm/Kconfig                               |    7 ++
 arch/arm/include/asm/cacheflush.h              |    6 ++
 arch/arm/include/asm/proc-fns.h                |    8 ++
 arch/arm/include/asm/procinfo.h                |    6 ++
 arch/arm/include/asm/smp_plat.h                |    9 +++
 arch/arm/include/asm/tlbflush.h                |   16 ++++-
 arch/arm/kernel/setup.c                        |   45 ++++++++++++++
 arch/arm/mach-omap2/include/mach/entry-macro.S |   22 +++++++
 arch/arm/mach-omap2/omap-smp.c                 |   16 ++++-
 arch/arm/mach-omap2/timer-gp.c                 |    7 ++
 arch/arm/mm/cache-v7.S                         |   60 +++++++++++++++++++
 arch/arm/mm/mmu.c                              |   20 +++---
 arch/arm/mm/proc-v7.S                          |   77 ++++++++++++++++++++++--
 arch/arm/mm/tlb-v7.S                           |   51 ++++++++++++++++
 14 files changed, 325 insertions(+), 25 deletions(-)

-- 
Signature
