From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 25 Nov 2015 03:10:34 +0100
Subject: VF610 broken by pinctrl: freescale: imx: allow mux_reg offset zero
In-Reply-To: <20151123132838.GM13744@tiger>
References: <20151115024409.GB2194@lunn.ch>
 <20151123132838.GM13744@tiger>
Message-ID: <20151125021034.GB11384@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Can you please try the following change to see if it fixes your problem?
> 
> Shawn
> 
> diff --git a/drivers/pinctrl/freescale/pinctrl-vf610.c b/drivers/pinctrl/freescale/pinctrl-vf610.c
> index 37a037543d29..587d1ff6210e 100644
> --- a/drivers/pinctrl/freescale/pinctrl-vf610.c
> +++ b/drivers/pinctrl/freescale/pinctrl-vf610.c
> @@ -299,7 +299,7 @@ static const struct pinctrl_pin_desc vf610_pinctrl_pads[] = {
>  static struct imx_pinctrl_soc_info vf610_pinctrl_info = {
>         .pins = vf610_pinctrl_pads,
>         .npins = ARRAY_SIZE(vf610_pinctrl_pads),
> -       .flags = SHARE_MUX_CONF_REG,
> +       .flags = SHARE_MUX_CONF_REG | ZERO_OFFSET_VALID,
>  };
>  
>  static const struct of_device_id vf610_pinctrl_of_match[] = {

Hi Shawn

I tested it, and it does work.

Thanks
	Andrew
