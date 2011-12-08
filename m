From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 8 Dec 2011 21:22:44 +0800
Subject: [PATCH] arm/imx: fix power button on imx51 babbage board
In-Reply-To: <1323052091-23354-1-git-send-email-shawn.guo@linaro.org>
References: <1323052091-23354-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20111208132243.GD7913@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

Can you please send this fix for -rc?

Regards,
Shawn

On Mon, Dec 05, 2011 at 10:28:11AM +0800, Shawn Guo wrote:
> Since commit 6571534 (plat-mxc: iomux-v3.h: implicitly enable
> pull-up/down when that's desired) was in, the power button on imx51
> babbage board stopped working because it's pulled up by mistake.
> The patch removes the pull-up setting from the pad configuration for
> that gpio to make the power button back to work.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/mach-mx5/board-mx51_babbage.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
> index 5c83760..24994bb 100644
> --- a/arch/arm/mach-mx5/board-mx51_babbage.c
> +++ b/arch/arm/mach-mx5/board-mx51_babbage.c
> @@ -362,7 +362,7 @@ static void __init mx51_babbage_init(void)
>  {
>  	iomux_v3_cfg_t usbh1stp = MX51_PAD_USBH1_STP__USBH1_STP;
>  	iomux_v3_cfg_t power_key = NEW_PAD_CTRL(MX51_PAD_EIM_A27__GPIO2_21,
> -		PAD_CTL_SRE_FAST | PAD_CTL_DSE_HIGH | PAD_CTL_PUS_100K_UP);
> +		PAD_CTL_SRE_FAST | PAD_CTL_DSE_HIGH);
>  
>  	imx51_soc_init();
>  
> -- 
> 1.7.4.1
