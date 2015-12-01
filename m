From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 1 Dec 2015 09:57:10 +0800
Subject: [PATCH] pinctrl: freescale: add ZERO_OFFSET_VALID flag for vf610
 pinctrl
In-Reply-To: <1448437251-21487-1-git-send-email-shawnguo@kernel.org>
References: <1448437251-21487-1-git-send-email-shawnguo@kernel.org>
Message-ID: <20151201015707.GA692@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 03:40:51PM +0800, Shawn Guo wrote:
> To support i.MX7D Low Power State Retention IOMUXC, commit e7b37a522aa9
> ("pinctrl: freescale: imx: allow mux_reg offset zero") changes the way
> of zero mux_reg offset support with a new flag ZERO_OFFSET_VALID.  But,
> unfortunately, it forgot to add this flag for vf610 pinctrl which has
> zero mux_reg offset be valid as well, and hence breaks the vf610
> support.
> 
> Fix the regression by adding flag ZERO_OFFSET_VALID for vf610 pinctrl
> driver.
> 
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> Fixes: e7b37a522aa9 ("pinctrl: freescale: imx: allow mux_reg offset zero")
> Reported-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Stefan Agner <stefan@agner.ch>

Linus,

Can you help apply the fix for v4.4-rc?

Shawn

> ---
>  drivers/pinctrl/freescale/pinctrl-vf610.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/freescale/pinctrl-vf610.c b/drivers/pinctrl/freescale/pinctrl-vf610.c
> index 37a037543d29..587d1ff6210e 100644
> --- a/drivers/pinctrl/freescale/pinctrl-vf610.c
> +++ b/drivers/pinctrl/freescale/pinctrl-vf610.c
> @@ -299,7 +299,7 @@ static const struct pinctrl_pin_desc vf610_pinctrl_pads[] = {
>  static struct imx_pinctrl_soc_info vf610_pinctrl_info = {
>  	.pins = vf610_pinctrl_pads,
>  	.npins = ARRAY_SIZE(vf610_pinctrl_pads),
> -	.flags = SHARE_MUX_CONF_REG,
> +	.flags = SHARE_MUX_CONF_REG | ZERO_OFFSET_VALID,
>  };
>  
>  static const struct of_device_id vf610_pinctrl_of_match[] = {
> -- 
> 1.9.1
> 
> 
