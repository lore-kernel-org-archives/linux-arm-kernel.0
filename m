From: will.deacon@arm.com (Will Deacon)
Date: Fri,  9 Sep 2016 12:15:59 +0100
Subject: [PATCH 0/6] Further NOP/sysreg cleanups
Message-ID: <1473419765-3437-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's clearly something going round our office, as both Rutland and I
ended up doing some mundane NOP and sysreg cleanups for the arm64 headers.

I plan to queue the first three patches here, but the GIC stuff can wait,
as it depends on Vladimir's patch (included here for completeness) and
this is hardly urgent.

Will

--->8

Vladimir Murzin (1):
  arm64: KVM: Move GIC accessors to arch_gicv3.h

Will Deacon (5):
  arm64: sysreg: replace open-coded mrs_s/msr_s with
    {read,write}_sysreg_s
  arm64: barriers: introduce nops and __nops macros for NOP sequences
  arm64: lse: convert lse alternatives NOP padding to use __nops
  irqchip/gic-v3: Convert arm64 GIC accessors to {read,write}_sysreg_s
  irqchip/gic-v3: Use nops macro for Cavium ThunderX erratum 23154

 arch/arm64/include/asm/arch_gicv3.h | 33 +++++++++----------
 arch/arm64/include/asm/assembler.h  |  9 ++++++
 arch/arm64/include/asm/atomic_lse.h | 64 ++++++++++++++++---------------------
 arch/arm64/include/asm/barrier.h    |  3 ++
 arch/arm64/include/asm/cmpxchg.h    |  4 +--
 arch/arm64/include/asm/cputype.h    |  6 +---
 arch/arm64/include/asm/spinlock.h   | 27 +++++++---------
 arch/arm64/include/asm/sysreg.h     | 16 ++++++++++
 arch/arm64/kvm/hyp/vgic-v3-sr.c     | 13 --------
 9 files changed, 83 insertions(+), 92 deletions(-)

-- 
2.1.4
