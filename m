From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 7 Nov 2011 08:52:54 +0100
Subject: [PATCH 1/1] ARM: mx51/53: correct clocks that take ipg_perclk as
 parent
In-Reply-To: <1320399263-14885-1-git-send-email-richard.zhao@linaro.org>
References: <1320399263-14885-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <20111107075254.GQ16886@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2011 at 05:34:23PM +0800, Richard Zhao wrote:
> gpt_clk, pwm1_clk and pwm2_clk parent clock are all ipg_perclk.
> 
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> ---
>  arch/arm/mach-mx5/clock-mx51-mx53.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
> index 2aacf41..a3ca4ce 100644
> --- a/arch/arm/mach-mx5/clock-mx51-mx53.c
> +++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
> @@ -1278,12 +1278,12 @@ DEFINE_CLOCK(uart5_clk, 4, MXC_CCM_CCGR7, MXC_CCM_CCGRx_CG7_OFFSET,
>  DEFINE_CLOCK(gpt_ipg_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG10_OFFSET,
>  	NULL,  NULL, &ipg_clk, NULL);
>  DEFINE_CLOCK(gpt_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG9_OFFSET,
> -	NULL,  NULL, &ipg_clk, &gpt_ipg_clk);
> +	NULL,  NULL, &ipg_perclk, &gpt_ipg_clk);

No. The gpt has several parents and the one we are using is the ipg
clock. Try a sleep 10 with your patch applied.

Sascha

>  
>  DEFINE_CLOCK(pwm1_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG6_OFFSET,
> -	NULL, NULL, &ipg_clk, NULL);
> +	NULL, NULL, &ipg_perclk, NULL);
>  DEFINE_CLOCK(pwm2_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG8_OFFSET,
> -	NULL, NULL, &ipg_clk, NULL);
> +	NULL, NULL, &ipg_perclk, NULL);
>  
>  /* I2C */
>  DEFINE_CLOCK(i2c1_clk, 0, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG9_OFFSET,
> -- 
> 1.7.5.4
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
