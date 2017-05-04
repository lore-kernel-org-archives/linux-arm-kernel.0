From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 4 May 2017 16:02:20 +0200
Subject: [PATCH v2 03/10] pinctrl: sunxi: add A20 support to A10 driver
In-Reply-To: <20170504135006.16483-4-icenowy@aosc.io>
References: <20170504135006.16483-1-icenowy@aosc.io>
 <20170504135006.16483-4-icenowy@aosc.io>
Message-ID: <20170504140220.26kguf3trz7ocylv@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 04, 2017 at 09:49:59PM +0800, Icenowy Zheng wrote:
>  static const struct of_device_id sun4i_a10_pinctrl_match[] = {
> -	{ .compatible = "allwinner,sun4i-a10-pinctrl", },
> +	{
> +		.compatible = "allwinner,sun4i-a10-pinctrl",
> +		.data = (void *)PINCTRL_SUN4I_A10
> +	},
> +	{
> +		.compatible = "allwinner,sun7i-a20-pinctrl",
> +		.data = (void *)PINCTRL_SUN7I_A20
> +	},
>  	{}
>  };

This means you're going to have two drivers probing for the same
device: this driver, and the old one. This is not ok, and probably
introduces some corner cases.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170504/f2a3c055/attachment.sig>
