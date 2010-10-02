From: nico@fluxnic.net (Nicolas Pitre)
Date: Sat, 02 Oct 2010 00:00:08 -0400 (EDT)
Subject: Git pull request: core features and fixes for next merge window
Message-ID: <alpine.LFD.2.00.1010012352040.1146@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, could you please pull the following:

	git://git.linaro.org/kernel/linux-linaro-next.git for_rmk

This contains a few changes that were posted on the list, including all 
received feedback.  Based on v2.6.36-rc6.

Amit Kucheria (1):
      ARM: mxc: turn off HWCAP_NEON for older versions of imx51 silicon

Nicolas Pitre (5):
      ARM: link board specific files after core files
      ARM: do not define VMALLOC_END relative to PAGE_OFFSET
      ARM: implement CONFIG_STRICT_DEVMEM by disabling access to RAM via /dev/mem
      ARM: SECCOMP support
      ARM: add a vma entry for the user accessible vector page

 arch/arm/Kconfig                                |   14 ++++++++
 arch/arm/Kconfig.debug                          |   14 ++++++++
 arch/arm/Makefile                               |    7 ++--
 arch/arm/include/asm/elf.h                      |    4 ++
 arch/arm/include/asm/io.h                       |    1 +
 arch/arm/include/asm/mmu_context.h              |   29 ++++++++++++++++-
 arch/arm/include/asm/seccomp.h                  |   11 ++++++
 arch/arm/include/asm/thread_info.h              |    2 +
 arch/arm/kernel/entry-common.S                  |   15 +++++++-
 arch/arm/kernel/process.c                       |   21 ++++++++++++
 arch/arm/mach-aaec2000/include/mach/vmalloc.h   |    2 +-
 arch/arm/mach-bcmring/include/mach/vmalloc.h    |    2 +-
 arch/arm/mach-clps711x/include/mach/vmalloc.h   |    2 +-
 arch/arm/mach-ebsa110/include/mach/vmalloc.h    |    2 +-
 arch/arm/mach-footbridge/include/mach/vmalloc.h |    2 +-
 arch/arm/mach-h720x/include/mach/vmalloc.h      |    2 +-
 arch/arm/mach-integrator/include/mach/vmalloc.h |    2 +-
 arch/arm/mach-msm/include/mach/vmalloc.h        |    2 +-
 arch/arm/mach-mx5/cpu.c                         |   19 +++++++++++
 arch/arm/mach-netx/include/mach/vmalloc.h       |    2 +-
 arch/arm/mach-omap1/include/mach/vmalloc.h      |    2 +-
 arch/arm/mach-omap2/include/mach/vmalloc.h      |    2 +-
 arch/arm/mach-pnx4008/include/mach/vmalloc.h    |    2 +-
 arch/arm/mach-rpc/include/mach/vmalloc.h        |    2 +-
 arch/arm/mach-shark/include/mach/vmalloc.h      |    2 +-
 arch/arm/mach-versatile/include/mach/vmalloc.h  |    2 +-
 arch/arm/mm/mmap.c                              |   22 +++++++++++++
 27 files changed, 168 insertions(+), 21 deletions(-)
