From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 28 Oct 2013 08:54:01 +0100
Subject: [PATCH 1/1] pinctrl: imx: fix using pin->input_val wrongly
In-Reply-To: <1382940076-11898-1-git-send-email-peter.chen@freescale.com>
References: <1382940076-11898-1-git-send-email-peter.chen@freescale.com>
Message-ID: <20131028075401.GH30088@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 02:01:16PM +0800, Peter Chen wrote:
> The commit: "pinctrl: imx: Use struct type for pins" relaced
> pin->input_reg by pin->input_val wrongly, fix it at this commit.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>

Oops.

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

> ---
>  drivers/pinctrl/pinctrl-imx.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-imx.c b/drivers/pinctrl/pinctrl-imx.c
> index d78dd81..4779b8e 100644
> --- a/drivers/pinctrl/pinctrl-imx.c
> +++ b/drivers/pinctrl/pinctrl-imx.c
> @@ -245,11 +245,11 @@ static int imx_pmx_enable(struct pinctrl_dev *pctldev, unsigned selector,
>  			 * The input_reg[i] here is actually some IOMUXC general
>  			 * purpose register, not regular select input register.
>  			 */
> -			val = readl(ipctl->base + pin->input_val);
> +			val = readl(ipctl->base + pin->input_reg);
>  			val &= ~mask;
>  			val |= select << shift;
> -			writel(val, ipctl->base + pin->input_val);
> -		} else if (pin->input_val) {
> +			writel(val, ipctl->base + pin->input_reg);
> +		} else if (pin->input_reg) {
>  			/*
>  			 * Regular select input register can never be at offset
>  			 * 0, and we only print register value for regular case.
> -- 
> 1.7.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
