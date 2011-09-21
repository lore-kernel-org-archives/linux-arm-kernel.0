From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 21 Sep 2011 15:18:51 -0400 (EDT)
Subject: Git pull request: OMAP/Davinci debug-macro.S cleanups
Message-ID: <alpine.LFD.2.00.1109211438110.12663@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, please pull:

	git://git.linaro.org/people/nico/linux debug-macro

This is the OMAP and Davinci debug-macro cleanups I've done in the 
course of the mach/memory.h removal series.  The odds for that series to 
be merged as is before the next merge window appear thin (I may only 
speculate about the reasons at this point), but at least some of its 
basic prerequisites may certainly go in this cycle, simplifying that 
series for the next cycle.

The included patches were reviewed and tested by Tony and Kevin already.  
If ever new SOC architectures are merged into arm-soc.git at this point, 
you might have to fix their addruart macro to include an extra tmp 
argument (nothing appears to require that now).

Nicolas Pitre (6):
      ARM: add an extra temp register to the low level debugging addruart macro
      ARM: plat-omap: make OMAP_UART_INFO into a relative offset
      ARM: mach-omap1: clean up debug-macro.S
      ARM: mach-omap2: clean up debug-macro.S
      ARM: mach-davinci: make DAVINCI_UART_INFO into a relative offset
      ARM: mach-davinci: clean up debug-macro.S

 arch/arm/kernel/debug.S                            |    4 +-
 arch/arm/kernel/head.S                             |    2 +-
 arch/arm/mach-at91/include/mach/debug-macro.S      |    2 +-
 arch/arm/mach-clps711x/include/mach/debug-macro.S  |    2 +-
 arch/arm/mach-cns3xxx/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-davinci/include/mach/debug-macro.S   |   52 ++++-----
 arch/arm/mach-davinci/include/mach/serial.h        |    3 +-
 arch/arm/mach-davinci/include/mach/uncompress.h    |    7 +-
 arch/arm/mach-dove/include/mach/debug-macro.S      |    2 +-
 arch/arm/mach-ebsa110/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-ep93xx/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-exynos4/include/mach/debug-macro.S   |    2 +-
 .../arm/mach-footbridge/include/mach/debug-macro.S |    4 +-
 arch/arm/mach-gemini/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-h720x/include/mach/debug-macro.S     |    2 +-
 .../arm/mach-integrator/include/mach/debug-macro.S |    2 +-
 arch/arm/mach-iop13xx/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-iop32x/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-iop33x/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-ixp2000/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-ixp23xx/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-ixp4xx/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-kirkwood/include/mach/debug-macro.S  |    2 +-
 arch/arm/mach-ks8695/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-l7200/include/mach/debug-macro.S     |    2 +-
 arch/arm/mach-lpc32xx/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-mmp/include/mach/debug-macro.S       |    2 +-
 arch/arm/mach-msm/include/mach/debug-macro.S       |    4 +-
 arch/arm/mach-mv78xx0/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-mxs/include/mach/debug-macro.S       |    2 +-
 arch/arm/mach-netx/include/mach/debug-macro.S      |    2 +-
 arch/arm/mach-nomadik/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-omap1/include/mach/debug-macro.S     |   48 ++++-----
 arch/arm/mach-omap2/include/mach/debug-macro.S     |   81 ++++++--------
 arch/arm/mach-orion5x/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-pnx4008/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-prima2/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-pxa/include/mach/debug-macro.S       |    2 +-
 arch/arm/mach-realview/include/mach/debug-macro.S  |    2 +-
 arch/arm/mach-rpc/include/mach/debug-macro.S       |    2 +-
 arch/arm/mach-s3c2410/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-s3c64xx/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-s5p64x0/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-s5pc100/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-s5pv210/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-sa1100/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-shark/include/mach/debug-macro.S     |    2 +-
 arch/arm/mach-tegra/include/mach/debug-macro.S     |    2 +-
 arch/arm/mach-u300/include/mach/debug-macro.S      |    2 +-
 arch/arm/mach-ux500/include/mach/debug-macro.S     |    2 +-
 arch/arm/mach-versatile/include/mach/debug-macro.S |    2 +-
 arch/arm/mach-vexpress/include/mach/debug-macro.S  |    2 +-
 arch/arm/mach-vt8500/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-zynq/include/mach/debug-macro.S      |    2 +-
 arch/arm/plat-mxc/include/mach/debug-macro.S       |    2 +-
 arch/arm/plat-omap/include/plat/serial.h           |    6 +-
 arch/arm/plat-omap/include/plat/uncompress.h       |    8 +-
 arch/arm/plat-spear/include/plat/debug-macro.S     |    2 +-
 arch/arm/plat-tcc/include/mach/debug-macro.S       |    2 +-
 59 files changed, 153 insertions(+), 162 deletions(-)


Nicolas
