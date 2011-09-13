From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 13 Sep 2011 08:50:46 -0400 (EDT)
Subject: Pull request: removal of most instances of mach/memory.h
In-Reply-To: <alpine.LFD.2.00.1109062158450.20358@xanadu.home>
References: <alpine.LFD.2.00.1109062158450.20358@xanadu.home>
Message-ID: <alpine.LFD.2.00.1109130849590.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Ping.


On Tue, 6 Sep 2011, Nicolas Pitre wrote:

> Russell, please consider this pull request for the next merge window:
> 
> 	git://git.linaro.org/people/nico/linux mach_memory_h
> 
> The bulk of the patches included in there were already posted on the 
> list on July 5th.  Some others like the OMAP debug macro cleanups were 
> posted and reviewed more recently.
> 
> The base for this series is your devel-stable branch where some 
> prerequisite series are, into which I also merged commit daece59689 in 
> order to get ARM_PATCH_PHYS_VIRT enabled by default as this series also 
> depends on this.
> 
> I also merged the patch entitled "get rid of a few StrongARM 
> cache-related build time constants" as this is a prerequisite for the 
> removal of mach/memory.h in mach-ebsa110 and mach-shark (more if the 
> sparsemem stuff gets moved).  If you don't feel comfortable having this 
> patch merged then I can remove it along with those commits that depend 
> on it.
> 
> And the last commit switches the initially introduced logic with the 
> Kconfig symbol NO_MACH_MEMORY_H to NEED_MACH_MEMORY_H since not having a 
> mach/memory.h has become the dominant case. However this makes for a 
> long and boringly trivial patch, especially if posted alone, so I didn't 
> post it.
> 
> The summary stat is a net reduction of almost 1000 lines, and another 
> step towards the ability to combine multiple SOCs in the same kernel 
> binary.
> 
> Here's the shortlog and diffstat:
> 
> Nicolas Pitre (53):
>       Merge the enabling by default of ARM_PATCH_PHYS_VIRT
>       ARM: mach-prima2: move ARM_DMA_ZONE_SIZE to mdesc->dma_zone_size
>       ARM: get rid of a few StrongARM cache-related build time constants
>       musb_debugfs.c: remove unneeded includes on ARM
>       ARM: add an extra temp register to the addruart low level debugging macro
>       ARM: plat-omap: make OMAP_UART_INFO into a relative offset
>       ARM: mach-omap1: clean up debug-macro.S
>       ARM: mach-omap2: clean up debug-macro.S
>       ARM: mach-davinci: make DAVINCI_UART_INFO into a relative offset
>       ARM: mach-davinci: clean up debug-macro.S
>       ARM: prepare for removal of a bunch of <mach/memory.h> files
>       ARM: mach-dove: remove include/mach/memory.h
>       ARM: mach-kirkwood: remove mach/memory.h
>       ARM: mach-orion5x: remove mach/memory.h
>       ARM: OMAP: move OMAP1 memory config from plat/memory.h to its mach/memory.h
>       ARM: mach-omap2: remove mach/memory.h
>       ARM: mach-iop33x: remove mach/memory.h
>       ARM: mach-ep93xx: remove mach/memory.h and Kconfig selection of SDRAM bank
>       ARM: mach-s3c2410: remove memory.h
>       ARM: mach-mv78xx0: remove mach/memory.h
>       ARM: mach-vexpress: remove mach/memory.h
>       ARM: mach-w90x900: remove mach/memory.h
>       ARM: mach-pnx4008: remove mach/memory.h
>       ARM: mach-iop32x: remove mach/memory.h
>       ARM: mach-nomadik: remove mach/memory.h
>       ARM: mach-ux500: remove mach/memory.h
>       ARM: mach-versatile: remove mach/memory.h
>       ARM: mach-netx: remove mach/memory.h
>       ARM: mach-lpc32xx: remove mach/memory.h
>       ARM: mach-gemini: remove mach/memory.h
>       ARM: mach-msm: remove mach/memory.h
>       ARM: spear: remove mach/memory.h and plat/memory.h
>       ARM: mach-mxs: remove mach/memory.h
>       ARM: mach-nuc93x: remove mach/memory.h
>       ARM: mach-cns3xxx: remove mach/memory.h
>       ARM: mach-mmp: remove mach/memory.h
>       ARM: plat-tcc: remove mach/memory.h
>       ARM: mach-tegra: remove mach/memory.h
>       ARM: mach-s5pc100: remove mach/memory.h
>       ARM: mach-vt8500: remove mach/memory.h
>       ARM: mach-shark: remove mach/memory.h
>       ARM: mach-ebsa110: remove mach/memory.h
>       ARM: mach-h720x: remove mach/memory.h
>       ARM: mach-ixp4xx: remove mach/memory.h
>       ARM: mach-pxa: remove mach/memory.h
>       ARM: mach-davinci: remove mach/memory.h
>       ARM: mach-bcmring: remove mach/memory.h
>       ARM: mach-zynq: remove mach/memory.h
>       ARM: mach-prima2: remove mach/memory.h
>       ARM: plat-mxc: remove mach/memory.h
>       ARM: mach-s3c64xx: remove mach/memory.h
>       ARM: mach-s5p64x0: remove mach/memory.h
>       ARM: switch from NO_MACH_MEMORY_H to NEED_MACH_MEMORY_H
> 
>  Documentation/arm/memory.txt                       |    7 +-
>  arch/arm/Kconfig                                   |   28 ++++
>  arch/arm/include/asm/cacheflush.h                  |   10 ++
>  arch/arm/include/asm/memory.h                      |    9 ++-
>  arch/arm/kernel/debug.S                            |    2 +-
>  arch/arm/kernel/head.S                             |    4 +-
>  arch/arm/mach-at91/include/mach/debug-macro.S      |    2 +-
>  arch/arm/mach-bcmring/include/mach/hardware.h      |    3 +-
>  arch/arm/mach-bcmring/include/mach/memory.h        |   28 ----
>  arch/arm/mach-clps711x/include/mach/debug-macro.S  |    2 +-
>  arch/arm/mach-cns3xxx/include/mach/debug-macro.S   |    2 +-
>  arch/arm/mach-cns3xxx/include/mach/memory.h        |   26 ----
>  arch/arm/mach-davinci/cpuidle.c                    |    2 +-
>  arch/arm/mach-davinci/include/mach/ddr2.h          |    4 +
>  arch/arm/mach-davinci/include/mach/debug-macro.S   |   52 ++++-----
>  arch/arm/mach-davinci/include/mach/memory.h        |   39 ------
>  arch/arm/mach-davinci/include/mach/serial.h        |    3 +-
>  arch/arm/mach-davinci/include/mach/uncompress.h    |    7 +-
>  arch/arm/mach-davinci/sleep.S                      |    2 +-
>  arch/arm/mach-dove/include/mach/debug-macro.S      |    2 +-
>  arch/arm/mach-dove/include/mach/memory.h           |   10 --
>  arch/arm/mach-ebsa110/core.c                       |    4 +
>  arch/arm/mach-ebsa110/include/mach/debug-macro.S   |    2 +-
>  arch/arm/mach-ebsa110/include/mach/hardware.h      |    5 -
>  arch/arm/mach-ebsa110/include/mach/memory.h        |   30 -----
>  arch/arm/mach-ep93xx/Kconfig                       |   53 --------
>  arch/arm/mach-ep93xx/Makefile.boot                 |   14 --
>  arch/arm/mach-ep93xx/include/mach/debug-macro.S    |    2 +-
>  arch/arm/mach-ep93xx/include/mach/memory.h         |   22 ----
>  arch/arm/mach-exynos4/include/mach/debug-macro.S   |    2 +-
>  arch/arm/mach-footbridge/common.c                  |    3 +
>  .../arm/mach-footbridge/include/mach/debug-macro.S |    4 +-
>  arch/arm/mach-footbridge/include/mach/hardware.h   |    2 -
>  arch/arm/mach-footbridge/include/mach/memory.h     |    7 -
>  arch/arm/mach-gemini/include/mach/debug-macro.S    |    2 +-
>  arch/arm/mach-gemini/include/mach/memory.h         |   19 ---
>  arch/arm/mach-h720x/include/mach/debug-macro.S     |    2 +-
>  arch/arm/mach-h720x/include/mach/memory.h          |   11 --
>  .../arm/mach-integrator/include/mach/debug-macro.S |    2 +-
>  arch/arm/mach-iop13xx/include/mach/debug-macro.S   |    2 +-
>  arch/arm/mach-iop32x/include/mach/debug-macro.S    |    2 +-
>  arch/arm/mach-iop32x/include/mach/memory.h         |   13 --
>  arch/arm/mach-iop33x/include/mach/debug-macro.S    |    2 +-
>  arch/arm/mach-iop33x/include/mach/memory.h         |   13 --
>  arch/arm/mach-ixp2000/include/mach/debug-macro.S   |    2 +-
>  arch/arm/mach-ixp23xx/include/mach/debug-macro.S   |    2 +-
>  arch/arm/mach-ixp4xx/include/mach/debug-macro.S    |    2 +-
>  arch/arm/mach-ixp4xx/include/mach/memory.h         |   17 ---
>  arch/arm/mach-kirkwood/include/mach/debug-macro.S  |    2 +-
>  arch/arm/mach-kirkwood/include/mach/memory.h       |   10 --
>  arch/arm/mach-ks8695/include/mach/debug-macro.S    |    2 +-
>  arch/arm/mach-l7200/include/mach/debug-macro.S     |    2 +-
>  arch/arm/mach-lpc32xx/include/mach/debug-macro.S   |    2 +-
>  arch/arm/mach-lpc32xx/include/mach/memory.h        |   27 ----
>  arch/arm/mach-mmp/include/mach/debug-macro.S       |    2 +-
>  arch/arm/mach-mmp/include/mach/memory.h            |   14 --
>  arch/arm/mach-msm/include/mach/debug-macro.S       |    4 +-
>  arch/arm/mach-msm/include/mach/memory.h            |   35 ------
>  arch/arm/mach-mv78xx0/include/mach/debug-macro.S   |    2 +-
>  arch/arm/mach-mv78xx0/include/mach/memory.h        |   10 --
>  arch/arm/mach-mxs/include/mach/debug-macro.S       |    2 +-
>  arch/arm/mach-mxs/include/mach/memory.h            |   24 ----
>  arch/arm/mach-netx/include/mach/debug-macro.S      |    2 +-
>  arch/arm/mach-netx/include/mach/memory.h           |   26 ----
>  arch/arm/mach-nomadik/include/mach/debug-macro.S   |    2 +-
>  arch/arm/mach-nomadik/include/mach/memory.h        |   28 ----
>  arch/arm/mach-nuc93x/include/mach/memory.h         |   21 ---
>  arch/arm/mach-omap1/include/mach/debug-macro.S     |   48 +++----
>  arch/arm/mach-omap1/include/mach/memory.h          |   53 ++++++++-
>  arch/arm/mach-omap2/include/mach/debug-macro.S     |   81 ++++++-------
>  arch/arm/mach-omap2/include/mach/memory.h          |    5 -
>  arch/arm/mach-orion5x/include/mach/debug-macro.S   |    2 +-
>  arch/arm/mach-orion5x/include/mach/memory.h        |   12 --
>  arch/arm/mach-pnx4008/include/mach/debug-macro.S   |    2 +-
>  arch/arm/mach-pnx4008/include/mach/memory.h        |   21 ---
>  arch/arm/mach-prima2/include/mach/debug-macro.S    |    2 +-
>  arch/arm/mach-prima2/include/mach/memory.h         |   21 ---
>  arch/arm/mach-prima2/l2x0.c                        |    5 +-
>  arch/arm/mach-prima2/prima2.c                      |    1 +
>  arch/arm/mach-pxa/include/mach/debug-macro.S       |    2 +-
>  arch/arm/mach-pxa/include/mach/memory.h            |   20 ---
>  arch/arm/mach-pxa/z2.c                             |    2 +-
>  arch/arm/mach-realview/include/mach/debug-macro.S  |    2 +-
>  arch/arm/mach-rpc/include/mach/debug-macro.S       |    2 +-
>  arch/arm/mach-rpc/include/mach/hardware.h          |    2 -
>  arch/arm/mach-rpc/include/mach/memory.h            |    6 -
>  arch/arm/mach-rpc/riscpc.c                         |    4 +
>  arch/arm/mach-s3c2400/include/mach/memory.h        |   20 ---
>  arch/arm/mach-s3c2410/include/mach/debug-macro.S   |    2 +-
>  arch/arm/mach-s3c2410/include/mach/memory.h        |   16 ---
>  arch/arm/mach-s3c64xx/include/mach/debug-macro.S   |    2 +-
>  arch/arm/mach-s3c64xx/include/mach/memory.h        |   18 ---
>  arch/arm/mach-s5p64x0/include/mach/debug-macro.S   |    2 +-
>  arch/arm/mach-s5p64x0/include/mach/memory.h        |   18 ---
>  arch/arm/mach-s5pc100/include/mach/debug-macro.S   |    2 +-
>  arch/arm/mach-s5pc100/include/mach/memory.h        |   18 ---
>  arch/arm/mach-s5pv210/include/mach/debug-macro.S   |    2 +-
>  arch/arm/mach-sa1100/generic.c                     |    5 +
>  arch/arm/mach-sa1100/include/mach/debug-macro.S    |    2 +-
>  arch/arm/mach-sa1100/include/mach/hardware.h       |    4 -
>  arch/arm/mach-sa1100/include/mach/memory.h         |    7 -
>  arch/arm/mach-shark/core.c                         |    2 +
>  arch/arm/mach-shark/include/mach/debug-macro.S     |    2 +-
>  arch/arm/mach-shark/include/mach/hardware.h        |   16 ---
>  arch/arm/mach-shark/include/mach/memory.h          |   26 ----
>  arch/arm/mach-spear3xx/include/mach/memory.h       |   19 ---
>  arch/arm/mach-spear6xx/include/mach/memory.h       |   19 ---
>  arch/arm/mach-tegra/include/mach/debug-macro.S     |    2 +-
>  arch/arm/mach-tegra/include/mach/memory.h          |   28 ----
>  arch/arm/mach-u300/include/mach/debug-macro.S      |    2 +-
>  arch/arm/mach-ux500/include/mach/debug-macro.S     |    2 +-
>  arch/arm/mach-ux500/include/mach/memory.h          |   18 ---
>  arch/arm/mach-versatile/include/mach/debug-macro.S |    2 +-
>  arch/arm/mach-versatile/include/mach/memory.h      |   28 ----
>  arch/arm/mach-vexpress/include/mach/debug-macro.S  |    2 +-
>  arch/arm/mach-vexpress/include/mach/memory.h       |   25 ----
>  arch/arm/mach-vt8500/include/mach/debug-macro.S    |    2 +-
>  arch/arm/mach-vt8500/include/mach/memory.h         |   28 ----
>  arch/arm/mach-w90x900/include/mach/memory.h        |   23 ----
>  arch/arm/mach-zynq/include/mach/debug-macro.S      |    2 +-
>  arch/arm/mach-zynq/include/mach/memory.h           |   22 ----
>  arch/arm/mm/Makefile                               |    2 +-
>  arch/arm/mm/cache-v4wb-init.c                      |   89 ++++++++++++++
>  arch/arm/mm/cache-v4wb.S                           |   31 +----
>  arch/arm/mm/mmu.c                                  |   43 ++-----
>  arch/arm/mm/proc-sa110.S                           |    6 +-
>  arch/arm/mm/proc-sa1100.S                          |    6 +-
>  arch/arm/plat-mxc/include/mach/debug-macro.S       |    2 +-
>  arch/arm/plat-mxc/include/mach/memory.h            |   43 -------
>  arch/arm/plat-omap/Kconfig                         |    1 +
>  arch/arm/plat-omap/include/plat/memory.h           |   89 --------------
>  arch/arm/plat-omap/include/plat/serial.h           |    6 +-
>  arch/arm/plat-omap/include/plat/uncompress.h       |    8 +-
>  arch/arm/plat-spear/include/plat/debug-macro.S     |    2 +-
>  arch/arm/plat-spear/include/plat/memory.h          |   20 ---
>  arch/arm/plat-tcc/include/mach/debug-macro.S       |    2 +-
>  arch/arm/plat-tcc/include/mach/memory.h            |   18 ---
>  drivers/usb/musb/musb_debugfs.c                    |    6 -
>  138 files changed, 400 insertions(+), 1357 deletions(-)
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
