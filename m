From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 11 Jan 2010 14:47:19 -0800
Subject: [RFC 00/18] generic arm needed for msm
Message-ID: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is just a lot of generic arm code that has been sitting here at Qualcomm
for some time.. Most of it seems fairly reasonable, but I figured I would send it
out for some review. I need the bulk of it merged eventually in some form for
2.6.34.

Daniel Walker (2):
  arm: msm: allow ARCH_MSM to have v7 cpus
  arm: msm: add oprofile pmu support

Dave Estes (3):
  arm: vfp: Add additional vfp interfaces
  arm: mm: Add SW emulation for ARM domain manager feature
  arm: mm: qsd8x50: Fix incorrect permission faults

Larry Bassel (3):
  arm: msm: implement ioremap_strongly_ordered
  arm: msm: implement proper dmb() for 7x27
  arm: msm: set L2CR1 to enable prefetch and burst on Scorpion.

Praveen Chidambaram (1):
  arm: msm: Enable frequency scaling.

Steve Muckle (6):
  arm: boot: remove old ARM ID for QSD
  arm: mm: retry on QSD icache parity errors
  arm: mm: support error reporting in L1/L2 caches on QSD
  arm: msm: add ARCH_MSM_SCORPION to CPU_V7
  arm: msm: define HAVE_CLK for ARCH_MSM
  arm: msm: add arch_has_speculative_dfetch()

Taniya Das (1):
  arm: msm: add v7 support for compiler version-4.1.1

Willie Ruan (2):
  arm: cache-l2x0: add l2x0 suspend and resume functions
  arm: mm: enable L2X0 to use L2 cache on MSM7X27

 Documentation/arm/msm/emulate_domain_manager.txt |  282 ++++++++++++++++
 arch/arm/Kconfig                                 |   20 +-
 arch/arm/Makefile                                |    8 +-
 arch/arm/boot/compressed/head.S                  |    2 +
 arch/arm/include/asm/dma-mapping.h               |   11 +-
 arch/arm/include/asm/domain.h                    |   13 +
 arch/arm/include/asm/hardware/cache-l2x0.h       |    3 +
 arch/arm/include/asm/io.h                        |    2 +
 arch/arm/include/asm/mach/map.h                  |    1 +
 arch/arm/include/asm/memory.h                    |    7 +
 arch/arm/include/asm/system.h                    |   11 +-
 arch/arm/include/asm/vfp.h                       |    6 +
 arch/arm/kernel/entry-armv.S                     |    8 +
 arch/arm/kernel/head.S                           |    8 +
 arch/arm/mach-msm/Kconfig                        |    2 +
 arch/arm/mach-msm/include/mach/memory.h          |    3 +
 arch/arm/mm/Kconfig                              |   19 +-
 arch/arm/mm/Makefile                             |    1 +
 arch/arm/mm/abort-ev7.S                          |   78 +++++
 arch/arm/mm/cache-l2x0.c                         |   29 ++
 arch/arm/mm/emulate_domain_manager-v7.c          |  386 ++++++++++++++++++++++
 arch/arm/mm/fault.c                              |   50 +++-
 arch/arm/mm/mmu.c                                |    6 +
 arch/arm/mm/proc-v7.S                            |   21 ++
 arch/arm/oprofile/op_model_v6.c                  |    2 +
 arch/arm/vfp/vfpmodule.c                         |   37 ++-
 26 files changed, 995 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/arm/msm/emulate_domain_manager.txt
 create mode 100644 arch/arm/mm/emulate_domain_manager-v7.c
