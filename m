From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 8 Dec 2010 12:07:13 +0100
Subject: [PATCH v2] OMAP4: Pandaboard: Add omap_reserve functionality
In-Reply-To: <1291792247-26634-1-git-send-email-raghuveer.murthy@ti.com>
References: <1291792247-26634-1-git-send-email-raghuveer.murthy@ti.com>
Message-ID: <201012081207.14044.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 December 2010 08:10:47 Raghuveer Murthy wrote:
> This patch adds omap_reserve functionality to board-omap4panda.c.
> Helps in the reserving boot time memory in SDRAM, used here for
> framebuffer allocation.
> 
> This patch is in similar lines to commit id 71ee7dad9b6991, from
> Russell king

Russell King ... it's a surname, not a title :-D

btw. CCing linux-arm-kernel, as that's a proper mailing list.

Cheers
> 
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: linux-arm at lists.arm.linux.org.uk
> Signed-off-by: Raghuveer Murthy <raghuveer.murthy@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap4panda.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c
> b/arch/arm/mach-omap2/board-omap4panda.c index da24745..0ccc24f 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -393,6 +393,7 @@ MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
>  	/* Maintainer: David Anders - Texas Instruments Inc */
>  	.boot_params	= 0x80000100,
>  	.map_io		= omap4_panda_map_io,
> +	.reserve	= omap_reserve,
>  	.init_irq	= omap4_panda_init_irq,
>  	.init_machine	= omap4_panda_init,
>  	.timer		= &omap_timer,
