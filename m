From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 9 May 2011 15:38:05 +0800
Subject: [PATCH] mx23: register clocks for mmc
In-Reply-To: <1304676335-1710-1-git-send-email-jacmet@sunsite.dk>
References: <1304676335-1710-1-git-send-email-jacmet@sunsite.dk>
Message-ID: <20110509073803.GA3375@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 06, 2011 at 12:05:35PM +0200, Peter Korsgaard wrote:
> Commit 47babe69 (mxs: dynamically allocate mmc device) added the ssp
> setup and mmc clocks for mx23/28, but forgot to register the mmc clocks
> on mx23.
> 
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

Acked-by: Shawn Guo <shawn.guo@freescale.com>

Somehow, this piece of the code got lost in the v4 of that patch.

-- 
Regards,
Shawn

> ---
>  arch/arm/mach-mxs/clock-mx23.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
> index c3577ea..0163b6d 100644
> --- a/arch/arm/mach-mxs/clock-mx23.c
> +++ b/arch/arm/mach-mxs/clock-mx23.c
> @@ -446,6 +446,8 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK("rtc", NULL, rtc_clk)
>  	_REGISTER_CLOCK("mxs-dma-apbh", NULL, hbus_clk)
>  	_REGISTER_CLOCK("mxs-dma-apbx", NULL, xbus_clk)
> +	_REGISTER_CLOCK("mxs-mmc.0", NULL, ssp_clk)
> +	_REGISTER_CLOCK("mxs-mmc.1", NULL, ssp_clk)
>  	_REGISTER_CLOCK(NULL, "usb", usb_clk)
>  	_REGISTER_CLOCK(NULL, "audio", audio_clk)
>  	_REGISTER_CLOCK("mxs-pwm.0", NULL, pwm_clk)
> -- 
> 1.7.2.3
> 
> 
