From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 03 Feb 2011 21:20:51 -0500 (EST)
Subject: [PATCH 2/2] ARM: Add empty inituart macros
In-Reply-To: <20110204012209.26298.75402.stgit@baageli.muru.com>
References: <20110204012008.26298.16341.stgit@baageli.muru.com>
	<20110204012209.26298.75402.stgit@baageli.muru.com>
Message-ID: <alpine.LFD.2.00.1102032116091.12104@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 3 Feb 2011, Tony Lindgren wrote:

> Add empty inituart macros. These can be used to initialize
> the debug serial port based on the machine ID.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-aaec2000/include/mach/debug-macro.S  |    4 ++++
>  arch/arm/mach-at91/include/mach/debug-macro.S      |    3 +++
>  arch/arm/mach-clps711x/include/mach/debug-macro.S  |    3 +++
>  arch/arm/mach-cns3xxx/include/mach/debug-macro.S   |    3 +++
>  arch/arm/mach-davinci/include/mach/debug-macro.S   |    3 +++
>  arch/arm/mach-dove/include/mach/debug-macro.S      |    3 +++
>  arch/arm/mach-ebsa110/include/mach/debug-macro.S   |    3 +++
>  arch/arm/mach-ep93xx/include/mach/debug-macro.S    |    3 +++
>  .../arm/mach-footbridge/include/mach/debug-macro.S |    4 ++++
>  arch/arm/mach-gemini/include/mach/debug-macro.S    |    3 +++
>  .../arm/mach-integrator/include/mach/debug-macro.S |    3 +++
>  arch/arm/mach-iop13xx/include/mach/debug-macro.S   |    3 +++
>  arch/arm/mach-iop32x/include/mach/debug-macro.S    |    3 +++
>  arch/arm/mach-iop33x/include/mach/debug-macro.S    |    3 +++
>  arch/arm/mach-ixp23xx/include/mach/debug-macro.S   |    3 +++
>  arch/arm/mach-kirkwood/include/mach/debug-macro.S  |    3 +++
>  arch/arm/mach-ks8695/include/mach/debug-macro.S    |    3 +++
>  arch/arm/mach-l7200/include/mach/debug-macro.S     |    3 +++
>  arch/arm/mach-loki/include/mach/debug-macro.S      |    3 +++
>  arch/arm/mach-lpc32xx/include/mach/debug-macro.S   |    3 +++
>  arch/arm/mach-mmp/include/mach/debug-macro.S       |    3 +++
>  arch/arm/mach-msm/include/mach/debug-macro.S       |    4 ++++
>  arch/arm/mach-mv78xx0/include/mach/debug-macro.S   |    3 +++
>  arch/arm/mach-mxs/include/mach/debug-macro.S       |    3 +++
>  arch/arm/mach-netx/include/mach/debug-macro.S      |    3 +++
>  arch/arm/mach-nomadik/include/mach/debug-macro.S   |    3 +++
>  arch/arm/mach-ns9xxx/include/mach/debug-macro.S    |    3 +++
>  arch/arm/mach-omap1/include/mach/debug-macro.S     |    3 +++
>  arch/arm/mach-omap2/include/mach/debug-macro.S     |    3 +++
>  arch/arm/mach-pnx4008/include/mach/debug-macro.S   |    3 +++
>  arch/arm/mach-pxa/include/mach/debug-macro.S       |    3 +++
>  arch/arm/mach-realview/include/mach/debug-macro.S  |    3 +++
>  arch/arm/mach-rpc/include/mach/debug-macro.S       |    3 +++
>  arch/arm/mach-s3c2410/include/mach/debug-macro.S   |    3 +++
>  arch/arm/mach-s3c24a0/include/mach/debug-macro.S   |    3 +++
>  arch/arm/mach-s3c64xx/include/mach/debug-macro.S   |    3 +++
>  arch/arm/mach-s5p6442/include/mach/debug-macro.S   |    3 +++
>  arch/arm/mach-s5p64x0/include/mach/debug-macro.S   |    3 +++
>  arch/arm/mach-s5pc100/include/mach/debug-macro.S   |    3 +++
>  arch/arm/mach-s5pv210/include/mach/debug-macro.S   |    3 +++
>  arch/arm/mach-s5pv310/include/mach/debug-macro.S   |    3 +++
>  arch/arm/mach-sa1100/include/mach/debug-macro.S    |    3 +++
>  arch/arm/mach-shark/include/mach/debug-macro.S     |    3 +++
>  arch/arm/mach-u300/include/mach/debug-macro.S      |    3 +++
>  arch/arm/mach-ux500/include/mach/debug-macro.S     |    3 +++
>  arch/arm/mach-versatile/include/mach/debug-macro.S |    3 +++
>  arch/arm/mach-vexpress/include/mach/debug-macro.S  |    3 +++
>  arch/arm/plat-mxc/include/mach/debug-macro.S       |    3 +++
>  arch/arm/plat-spear/include/plat/debug-macro.S     |    3 +++
>  arch/arm/plat-stmp3xxx/include/mach/debug-macro.S  |    3 +++
>  arch/arm/plat-tcc/include/mach/debug-macro.S       |    3 +++
>  51 files changed, 156 insertions(+), 0 deletions(-)

A better way would be to define the empty inituart macro in a common 
place, and use the following in the machine specific header file:

	.purgem inituart
	.macro inituart ...
	...
	.endm

This way you won't need to add empty inituart all over the place.


Nicolas
