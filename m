From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 12 Feb 2010 11:49:47 +0100
Subject: [PATCH 1/2] ARM: ixp2000: fix type of ixp2000_timer_interrupt
In-Reply-To: <1264280500-22878-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1264280500-22878-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20100212104947.GB6590@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Sat, Jan 23, 2010 at 10:01:39PM +0100, Uwe Kleine-K?nig wrote:
> This fixes a build warning for 2.6.33-rc5:
> 
> 	arch/arm/mach-ixp2000/core.c:217: warning: initialization from incompatible pointer type
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/mach-ixp2000/core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-ixp2000/core.c b/arch/arm/mach-ixp2000/core.c
> index babb225..e24e3d0 100644
> --- a/arch/arm/mach-ixp2000/core.c
> +++ b/arch/arm/mach-ixp2000/core.c
> @@ -197,7 +197,7 @@ unsigned long ixp2000_gettimeoffset (void)
>  	return offset / ticks_per_usec;
>  }
>  
> -static int ixp2000_timer_interrupt(int irq, void *dev_id)
> +static irqreturn_t ixp2000_timer_interrupt(int irq, void *dev_id)
>  {
>  	/* clear timer 1 */
>  	ixp2000_reg_wrb(IXP2000_T1_CLR, 1);
what do you think about this patch?  It's (IMHO) trivial and fixes a
long standing build warning.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
