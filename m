From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 12 Jul 2017 13:57:25 +0000
Subject: [PATCH V4 3/7] pinctrl: imx: switch to use the generic pinmux
 property
In-Reply-To: <1498046395-30001-4-git-send-email-aisheng.dong@nxp.com>
References: <1498046395-30001-1-git-send-email-aisheng.dong@nxp.com>
 <1498046395-30001-4-git-send-email-aisheng.dong@nxp.com>
Message-ID: <AM3PR04MB3068BC904003E560AF4F62280AF0@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

> -----Original Message-----
> From: Dong Aisheng [mailto:aisheng.dong at nxp.com]
> Sent: Wednesday, June 21, 2017 8:00 PM
> To: linux-gpio at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org; linus.walleij at linaro.org;
> shawnguo at kernel.org; stefan at agner.ch; Jacky Bai; Andy Duan;
> kernel at pengutronix.de; A.s. Dong
> Subject: [PATCH V4 3/7] pinctrl: imx: switch to use the generic pinmux
> property
> 
> The generic pinmux property seems to be more suitable for IMX.
> So we change to use 'pinmux' instead of 'pins'.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Bai Ping <ping.bai@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> 

Would you help review this minor change?

I will collect your ACKs and resent based on 4.13 RC1.

Regards
Dong Aisheng

> ---
> ChangeLog:
>  * new patch
> ---
>  drivers/pinctrl/freescale/pinctrl-imx.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c
> b/drivers/pinctrl/freescale/pinctrl-imx.c
> index 72aca75..fc1ba3c 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx.c
> +++ b/drivers/pinctrl/freescale/pinctrl-imx.c
> @@ -563,14 +563,14 @@ static int imx_pinctrl_parse_groups(struct
> device_node *np,
>  	 * do sanity check and calculate pins number
>  	 *
>  	 * First try legacy 'fsl,pins' property, then fall back to the
> -	 * generic 'pins'.
> +	 * generic 'pinmux'.
>  	 *
> -	 * Note: for generic 'pins' case, there's no CONFIG part in
> +	 * Note: for generic 'pinmux' case, there's no CONFIG part in
>  	 * the binding format.
>  	 */
>  	list = of_get_property(np, "fsl,pins", &size);
>  	if (!list) {
> -		list = of_get_property(np, "pins", &size);
> +		list = of_get_property(np, "pinmux", &size);
>  		if (!list) {
>  			dev_err(info->dev,
>  				"no fsl,pins and pins property in node %s\n",
> --
> 2.7.4
