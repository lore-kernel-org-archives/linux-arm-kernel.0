From: will.deacon@arm.com (Will Deacon)
Date: Fri, 2 Dec 2011 16:08:33 +0000
Subject: [GIT PULL] Identity mapping changes for 3.3
Message-ID: <20111202160833.GK5540@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

This is the same as the pull request I sent in this thread:

http://lists.arm.linux.org.uk/lurker/message/20111201.132625.2e9e2d3e.en.html

I thought I'd better send it as a separate post to highlight it as a PULL.

Cheers,

Will


The following changes since commit 2d13ccaa8797d7e599f3792aed4b1e44b47f94a5:

  Merge branch 'irqchip-consolidation' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into devel-stable (2011-11-21 21:56:56 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git kexec/idmap

Will Deacon (6):
      ARM: idmap: populate identity map pgd at init time using .init.text
      ARM: suspend: use idmap_pgd instead of suspend_pgd
      ARM: proc-*.S: place cpu_reset functions into .idmap.text section
      ARM: idmap: use idmap_pgd when setting up mm for reboot
      ARM: head.S: only include __turn_mmu_on in the initial identity mapping
      ARM: SMP: use idmap_pgd for mapping MMU enable during secondary booting

 arch/arm/include/asm/idmap.h   |   14 +++++++++
 arch/arm/include/asm/pgtable.h |    3 --
 arch/arm/kernel/head.S         |   18 ++++++-----
 arch/arm/kernel/sleep.S        |    2 +
 arch/arm/kernel/smp.c          |   32 +-------------------
 arch/arm/kernel/suspend.c      |   18 ++---------
 arch/arm/kernel/vmlinux.lds.S  |    7 ++++
 arch/arm/mm/idmap.c            |   63 +++++++++++++++++++---------------------
 arch/arm/mm/proc-arm1020.S     |    3 ++
 arch/arm/mm/proc-arm1020e.S    |    3 ++
 arch/arm/mm/proc-arm1022.S     |    3 ++
 arch/arm/mm/proc-arm1026.S     |    3 ++
 arch/arm/mm/proc-arm6_7.S      |    4 ++
 arch/arm/mm/proc-arm720.S      |    3 ++
 arch/arm/mm/proc-arm740.S      |    3 ++
 arch/arm/mm/proc-arm7tdmi.S    |    3 ++
 arch/arm/mm/proc-arm920.S      |    3 ++
 arch/arm/mm/proc-arm922.S      |    3 ++
 arch/arm/mm/proc-arm925.S      |    3 ++
 arch/arm/mm/proc-arm926.S      |    3 ++
 arch/arm/mm/proc-arm940.S      |    3 ++
 arch/arm/mm/proc-arm946.S      |    3 ++
 arch/arm/mm/proc-arm9tdmi.S    |    3 ++
 arch/arm/mm/proc-fa526.S       |    3 ++
 arch/arm/mm/proc-feroceon.S    |    3 ++
 arch/arm/mm/proc-mohawk.S      |    3 ++
 arch/arm/mm/proc-sa110.S       |    3 ++
 arch/arm/mm/proc-sa1100.S      |    3 ++
 arch/arm/mm/proc-v6.S          |    3 ++
 arch/arm/mm/proc-v7.S          |    2 +
 arch/arm/mm/proc-xsc3.S        |    3 ++
 arch/arm/mm/proc-xscale.S      |    3 ++
 32 files changed, 140 insertions(+), 89 deletions(-)
 create mode 100644 arch/arm/include/asm/idmap.h
