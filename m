From: will.deacon@arm.com (Will Deacon)
Date: Wed, 5 Dec 2012 18:18:36 +0000
Subject: [PATCH] ARM: Add .smp entry for REALVIEW_EB
In-Reply-To: <1354634293-18343-1-git-send-email-steve.capper@arm.com>
References: <1354634293-18343-1-git-send-email-steve.capper@arm.com>
Message-ID: <20121205181836.GC18403@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

On Tue, Dec 04, 2012 at 03:18:13PM +0000, Steve Capper wrote:
> The REALVIEW EB board can host tiles with multiple cores thus needs to be able
> to initialise SMP. There is, however, no .smp entry in the MACHINE_START
> struct for REALVIEW_EB.
> 
> This patch adds the appropriate .smp entry to this struct.
> 
> Signed-off-by: Steve Capper <steve.capper@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/mach-realview/realview_eb.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
> index d3b3cd2..28511d4 100644
> --- a/arch/arm/mach-realview/realview_eb.c
> +++ b/arch/arm/mach-realview/realview_eb.c
> @@ -467,6 +467,7 @@ static void __init realview_eb_init(void)
>  MACHINE_START(REALVIEW_EB, "ARM-RealView EB")
>  	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
>  	.atag_offset	= 0x100,
> +	.smp		= smp_ops(realview_smp_ops),
>  	.fixup		= realview_fixup,
>  	.map_io		= realview_eb_map_io,
>  	.init_early	= realview_init_early,

Please can you put this in the patch system? Mainline is broken on SMP EB
without it.

Will
