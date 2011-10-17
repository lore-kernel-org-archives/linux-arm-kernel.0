From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 16 Oct 2011 20:48:49 -0400 (EDT)
Subject: Pull request: removal of most instances of mach/memory.h
In-Reply-To: <alpine.LFD.2.02.1110041452330.9106@xanadu.home>
References: <alpine.LFD.2.00.1109062158450.20358@xanadu.home>
	<alpine.LFD.2.00.1109130849590.20358@xanadu.home>
	<alpine.LFD.2.00.1109201349400.12663@xanadu.home>
	<20110926131524.GJ22455@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1109260952490.2718@xanadu.home>
	<alpine.LFD.2.00.1109261023360.2718@xanadu.home>
	<20110926191055.GP22455@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1110041452330.9106@xanadu.home>
Message-ID: <alpine.LFD.2.02.1110161956110.17040@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Oct 2011, Nicolas Pitre wrote:

> On Mon, 26 Sep 2011, Russell King - ARM Linux wrote:
> 
> > This also gives additional merge conflicts elsewhere, and while git
> > rerere makes some of them easy, the quantity is going to be a right
> > pain to deal with on a repeated basis.
> 
> Does this mean that you will only merge this before asking Linus to 
> pull?  I would like to know on which leg I should stand with this 
> series.

Here's where things stand with this series from my end:

1) The SA/XScale cache maintenance mapping patch is still untested on
   SA110, hence this patch and all those that depended on it have been 
   dropped for now.

2) The EP93xx patch removed the ability to use ZBOOT_ROM on 
   corresponding machines, so this patch has been dropped until the 
   ZBOOT_ROM facility is reworked in a more generic way.

3) Performing a test merge with your for-next branch produces merge
   conflicts in arch/arm/Kconfig and arch/arm/plat-omap/Kconfig only, 
   and they are very trivial to fix.

4) During the few days this series was pulled into linux-next via the 
   arm-soc tree, no issues were reported.

5) I can't recall any further objections to this series, neither from 
   you nor anyone else.

If I'm missing something, or if I overlooked a previous comment of 
yours, I'd be glad to address it promptly.

I therefore would appreciate if you could pull the following:

    git://git.linaro.org/people/nico/linux mach_memory_h

The updated diffstat follows:

 arch/arm/Kconfig                                   |   30 +++++
 arch/arm/include/asm/memory.h                      |    9 ++-
 arch/arm/kernel/debug.S                            |    4 +-
 arch/arm/kernel/head.S                             |    4 +-
 arch/arm/mach-at91/include/mach/debug-macro.S      |    2 +-
 arch/arm/mach-bcmring/include/mach/hardware.h      |    3 +-
 arch/arm/mach-bcmring/include/mach/memory.h        |   28 ----
 arch/arm/mach-clps711x/include/mach/debug-macro.S  |    2 +-
 arch/arm/mach-cns3xxx/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-cns3xxx/include/mach/memory.h        |   26 ----
 arch/arm/mach-davinci/cpuidle.c                    |    2 +-
 arch/arm/mach-davinci/include/mach/ddr2.h          |    4 +
 arch/arm/mach-davinci/include/mach/debug-macro.S   |   52 ++++-----
 arch/arm/mach-davinci/include/mach/memory.h        |   39 ------
 arch/arm/mach-davinci/include/mach/serial.h        |    3 +-
 arch/arm/mach-davinci/include/mach/uncompress.h    |    7 +-
 arch/arm/mach-davinci/sleep.S                      |    2 +-
 arch/arm/mach-dove/include/mach/debug-macro.S      |    2 +-
 arch/arm/mach-dove/include/mach/memory.h           |   10 --
 arch/arm/mach-ebsa110/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-ep93xx/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-exynos4/include/mach/debug-macro.S   |    2 +-
 .../arm/mach-footbridge/include/mach/debug-macro.S |    4 +-
 arch/arm/mach-gemini/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-gemini/include/mach/memory.h         |   19 ---
 arch/arm/mach-h720x/include/mach/debug-macro.S     |    2 +-
 arch/arm/mach-h720x/include/mach/memory.h          |   11 --
 .../arm/mach-integrator/include/mach/debug-macro.S |    2 +-
 arch/arm/mach-iop13xx/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-iop32x/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-iop32x/include/mach/memory.h         |   13 --
 arch/arm/mach-iop33x/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-iop33x/include/mach/memory.h         |   13 --
 arch/arm/mach-ixp2000/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-ixp23xx/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-ixp4xx/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-ixp4xx/include/mach/memory.h         |   17 ---
 arch/arm/mach-kirkwood/include/mach/debug-macro.S  |    2 +-
 arch/arm/mach-kirkwood/include/mach/memory.h       |   10 --
 arch/arm/mach-ks8695/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-l7200/include/mach/debug-macro.S     |    2 +-
 arch/arm/mach-lpc32xx/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-lpc32xx/include/mach/memory.h        |   27 ----
 arch/arm/mach-mmp/include/mach/debug-macro.S       |    2 +-
 arch/arm/mach-mmp/include/mach/memory.h            |   14 --
 arch/arm/mach-msm/include/mach/debug-macro.S       |    4 +-
 arch/arm/mach-msm/include/mach/memory.h            |   35 ------
 arch/arm/mach-mv78xx0/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-mv78xx0/include/mach/memory.h        |   10 --
 arch/arm/mach-mxs/include/mach/debug-macro.S       |    2 +-
 arch/arm/mach-mxs/include/mach/memory.h            |   24 ----
 arch/arm/mach-netx/include/mach/debug-macro.S      |    2 +-
 arch/arm/mach-netx/include/mach/memory.h           |   26 ----
 arch/arm/mach-nomadik/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-nomadik/include/mach/memory.h        |   28 ----
 arch/arm/mach-nuc93x/include/mach/memory.h         |   21 ---
 arch/arm/mach-omap1/include/mach/debug-macro.S     |   48 +++----
 arch/arm/mach-omap1/include/mach/memory.h          |   53 ++++++++-
 arch/arm/mach-omap2/include/mach/debug-macro.S     |   81 ++++++-------
 arch/arm/mach-omap2/include/mach/memory.h          |    5 -
 arch/arm/mach-orion5x/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-orion5x/include/mach/memory.h        |   12 --
 arch/arm/mach-pnx4008/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-pnx4008/include/mach/memory.h        |   21 ---
 arch/arm/mach-prima2/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-prima2/include/mach/memory.h         |   21 ---
 arch/arm/mach-prima2/l2x0.c                        |    5 +-
 arch/arm/mach-prima2/prima2.c                      |    1 +
 arch/arm/mach-pxa/include/mach/debug-macro.S       |    2 +-
 arch/arm/mach-pxa/include/mach/memory.h            |   20 ---
 arch/arm/mach-pxa/z2.c                             |    2 +-
 arch/arm/mach-realview/include/mach/debug-macro.S  |    2 +-
 arch/arm/mach-rpc/include/mach/debug-macro.S       |    2 +-
 arch/arm/mach-s3c2400/include/mach/memory.h        |   20 ---
 arch/arm/mach-s3c2410/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-s3c2410/include/mach/memory.h        |   16 ---
 arch/arm/mach-s3c64xx/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-s3c64xx/include/mach/memory.h        |   18 ---
 arch/arm/mach-s5p64x0/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-s5p64x0/include/mach/memory.h        |   18 ---
 arch/arm/mach-s5pc100/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-s5pc100/include/mach/memory.h        |   18 ---
 arch/arm/mach-s5pv210/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-sa1100/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-shark/include/mach/debug-macro.S     |    2 +-
 arch/arm/mach-spear3xx/include/mach/memory.h       |   19 ---
 arch/arm/mach-spear6xx/include/mach/memory.h       |   19 ---
 arch/arm/mach-tegra/include/mach/debug-macro.S     |    2 +-
 arch/arm/mach-tegra/include/mach/memory.h          |   28 ----
 arch/arm/mach-u300/include/mach/debug-macro.S      |    2 +-
 arch/arm/mach-ux500/include/mach/debug-macro.S     |    2 +-
 arch/arm/mach-ux500/include/mach/memory.h          |   18 ---
 arch/arm/mach-versatile/include/mach/debug-macro.S |    2 +-
 arch/arm/mach-versatile/include/mach/memory.h      |   28 ----
 arch/arm/mach-vexpress/include/mach/debug-macro.S  |    2 +-
 arch/arm/mach-vexpress/include/mach/memory.h       |   25 ----
 arch/arm/mach-vt8500/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-vt8500/include/mach/memory.h         |   28 ----
 arch/arm/mach-w90x900/include/mach/memory.h        |   23 ----
 arch/arm/mach-zynq/include/mach/debug-macro.S      |    2 +-
 arch/arm/mach-zynq/include/mach/memory.h           |   22 ----
 arch/arm/plat-mxc/include/mach/debug-macro.S       |    2 +-
 arch/arm/plat-mxc/include/mach/memory.h            |   43 -------
 arch/arm/plat-omap/Kconfig                         |    1 +
 arch/arm/plat-omap/include/plat/memory.h           |   89 --------------
 arch/arm/plat-omap/include/plat/serial.h           |    6 +-
 arch/arm/plat-omap/include/plat/uncompress.h       |    8 +-
 arch/arm/plat-spear/include/plat/debug-macro.S     |    2 +-
 arch/arm/plat-spear/include/plat/memory.h          |   20 ---
 arch/arm/plat-tcc/include/mach/debug-macro.S       |    2 +-
 arch/arm/plat-tcc/include/mach/memory.h            |   18 ---
 drivers/usb/musb/musb_debugfs.c                    |    6 -
 112 files changed, 256 insertions(+), 1099 deletions(-)


Nicolas
