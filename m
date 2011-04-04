From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 4 Apr 2011 17:04:30 +0200
Subject: [PATCH 3/3] video: mxsfb: add DOTCLK polarity configuration
	support
In-Reply-To: <1299341931-30241-4-git-send-email-shawn.guo@freescale.com>
References: <1299341931-30241-1-git-send-email-shawn.guo@freescale.com>
	<1299341931-30241-4-git-send-email-shawn.guo@freescale.com>
Message-ID: <20110404150430.GB13963@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sun, Mar 06, 2011 at 12:18:51AM +0800, Shawn Guo wrote:
> The current implementation provides configuration for HSYNC_POL,
> VSYNC_POL and ENABLE_POL via 'sync' of fb_videomode, but DOTCLK_POL
> is missing there.  It's assuming that data sampling at rising/positive
> edge is always the case.  However, it's not true.  For example, the
> panel on mx28evk board (Seiko 43WVF1G) samples data at
> failing/negative edge.  The patch is to add this configuration.
s/failing/falling?

> 
> Also, to unify the naming schema of all these polarity configurations
> and match them with the bits name in Reference Manual, a couple of
> definitions are renamed.
> 
> Lastly, to reduce the chance of defining customized 'FB_SYNC_' flag
> by incrementing the preceeding value, the definitions are changed to
> bit shifting way.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/mach-mxs/include/mach/mxsfb.h |    3 ++-
>  drivers/video/mxsfb.c                  |    8 +++++---
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/include/mach/mxsfb.h b/arch/arm/mach-mxs/include/mach/mxsfb.h
> index 923f397..e4d7979 100644
> --- a/arch/arm/mach-mxs/include/mach/mxsfb.h
> +++ b/arch/arm/mach-mxs/include/mach/mxsfb.h
> @@ -24,7 +24,8 @@
>  #define STMLCDIF_18BIT 2 /** pixel data bus to the display is of 18 bit width */
>  #define STMLCDIF_24BIT 3 /** pixel data bus to the display is of 24 bit width */
>  
> -#define FB_SYNC_DATA_ENABLE_HIGH_ACT	64
> +#define FB_SYNC_DATA_ENABLE_HIGH_ACT	(1 << 6)
> +#define FB_SYNC_DOTCLK_FAILING_ACT	(1 << 7) /* failing/negtive edge sampling */
ditto + s/negtive/negative/

As your patch is already in mainline, do you care to send a followup?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
