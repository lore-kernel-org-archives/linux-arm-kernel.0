From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 4 Feb 2010 11:05:36 +0100
Subject: [PATCH 11/16] ARM: LPC32XX: Converted interrupt registers to
	void __iomem *
In-Reply-To: <1265155168-28909-12-git-send-email-wellsk40@gmail.com>
References: <1265155168-28909-12-git-send-email-wellsk40@gmail.com>
Message-ID: <20100204100536.GC6562@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kevin,

On Tue, Feb 02, 2010 at 03:59:23PM -0800, wellsk40 at gmail.com wrote:
> From: Kevin Wells <wellsk40@gmail.com>
> 
> Added register access macros (similar to other register accesses).
> Updated irq handler to use new access macros.
> 
> Signed-off-by: Kevin Wells <wellsk40@gmail.com>
> ---
>  arch/arm/mach-lpc32xx/include/mach/entry-macro.S |    6 +-
>  arch/arm/mach-lpc32xx/include/mach/platform.h    |   12 ++--
>  arch/arm/mach-lpc32xx/irq.c                      |   66 +++++++++++-----------
>  3 files changed, 42 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/arm/mach-lpc32xx/include/mach/entry-macro.S b/arch/arm/mach-lpc32xx/include/mach/entry-macro.S
> index 25f2adc..9626bac 100644
> --- a/arch/arm/mach-lpc32xx/include/mach/entry-macro.S
> +++ b/arch/arm/mach-lpc32xx/include/mach/entry-macro.S
> @@ -39,7 +39,7 @@
>  	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
>  	/* Get MIC status first */
>  	ldr	\base, =IO_ADDRESS(LPC32XX_MIC_BASE)
> -	ldr	\irqstat, [\base, #LPC32XX_INTC_STAT]
> +	ldr	\irqstat, [\base, #8]
I consider this a step back.  What about

	ldr	\irqstat, [\base, #(LPC32XX_INTC_STAT - LPC32XX_MIC_BASE)]

?

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
