From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 6 Jul 2017 22:50:30 +0200
Subject: [PATCH 2/2] pinctrl: sunxi: add support of R40 to A10 pinctrl
 driver
In-Reply-To: <20170706142822.20296-3-icenowy@aosc.io>
References: <20170706142822.20296-1-icenowy@aosc.io>
 <20170706142822.20296-3-icenowy@aosc.io>
Message-ID: <20170706205030.e6wzn5n7ix3443cl@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 06, 2017 at 10:28:22PM +0800, Icenowy Zheng wrote:
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 0),
>  		  SUNXI_FUNCTION(0x0, "gpio_in"),
>  		  SUNXI_FUNCTION(0x1, "gpio_out"),
> -		  SUNXI_FUNCTION(0x2, "i2c0")),		/* SCK */
> +		  SUNXI_FUNCTION(0x2, "i2c0"),		/* SCK */
> +		  SUNXI_FUNCTION_VARIANT(0x3,
> +					 "pll_lock_dbg",
> +					 PINCTRL_SUN8I_R40)),

You have a number of lines where the wrapping is not consistent with
the rest, such as this one, but also...

>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 20),
>  		  SUNXI_FUNCTION(0x0, "gpio_in"),
>  		  SUNXI_FUNCTION(0x1, "gpio_out"),
> -		  SUNXI_FUNCTION(0x2, "i2c2")),		/* SCK */
> +		  SUNXI_FUNCTION(0x2, "i2c2"),		/* SCK */
> +		  SUNXI_FUNCTION_VARIANT(0x4,
> +					 "pwm",		/* PWM4 */
> +					 PINCTRL_SUN8I_R40)),

... this one for example. Please fix this.

Looks good otherwise.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170706/b2248cfe/attachment.sig>
