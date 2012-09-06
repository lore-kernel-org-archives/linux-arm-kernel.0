From: balbi@ti.com (Felipe Balbi)
Date: Thu, 6 Sep 2012 20:28:05 +0300
Subject: [PATCH] arm: omap: hwmod: make *phy_48m* as the main_clk of
 ocp2scp
In-Reply-To: <1341219337-25815-1-git-send-email-kishon@ti.com>
References: <1341219337-25815-1-git-send-email-kishon@ti.com>
Message-ID: <20120906172802.GD30717@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 02, 2012 at 02:25:37PM +0530, Kishon Vijay Abraham I wrote:
> Made *ocp2scp_usb_phy_phy_48m* as the main_clk for ocp2scp.
> Since this ocp2scp module does not have any fck but does have a
> single opt_clock, it is added as the main_clk for ocp2scp. Also
> removed phy_48m as the optional clock since it is now made as the
> main clock.

Just one comment here, you failed to note what good does it do from the
driver perspective, other than that, you can add my Reviewed-by as below

> Cc: Beno?t Cousson <b-cousson@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

FWIW:

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
> Changes from [RFC PATCH 1/5] arm: omap: hwmod: make *phy_48m* as the main_clk
> of ocp2scp:
> * Removed *ocp2scp_usb_phy_phy_48m* as the optional functional clock
> 
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    7 +------
>  1 files changed, 1 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index f30e861..17cf933 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -2504,14 +2504,11 @@ static struct omap_hwmod_class omap44xx_ocp2scp_hwmod_class = {
>  };
>  
>  /* ocp2scp_usb_phy */
> -static struct omap_hwmod_opt_clk ocp2scp_usb_phy_opt_clks[] = {
> -	{ .role = "phy_48m", .clk = "ocp2scp_usb_phy_phy_48m" },
> -};
> -
>  static struct omap_hwmod omap44xx_ocp2scp_usb_phy_hwmod = {
>  	.name		= "ocp2scp_usb_phy",
>  	.class		= &omap44xx_ocp2scp_hwmod_class,
>  	.clkdm_name	= "l3_init_clkdm",
> +	.main_clk	= "ocp2scp_usb_phy_phy_48m",
>  	.prcm = {
>  		.omap4 = {
>  			.clkctrl_offs = OMAP4_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL_OFFSET,
> @@ -2519,8 +2516,6 @@ static struct omap_hwmod omap44xx_ocp2scp_usb_phy_hwmod = {
>  			.modulemode   = MODULEMODE_HWCTRL,
>  		},
>  	},
> -	.opt_clks	= ocp2scp_usb_phy_opt_clks,
> -	.opt_clks_cnt	= ARRAY_SIZE(ocp2scp_usb_phy_opt_clks),
>  };
>  
>  /*
> -- 
> 1.7.5.4
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120906/9eea0718/attachment.sig>
