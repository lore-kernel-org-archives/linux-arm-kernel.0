From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 20 Sep 2015 11:22:11 +0200
Subject: [PATCH v4 4/8] ARM: dts: imx: imx7d-sbd add iomuxc-lpsr hoggrp-2
 pads
In-Reply-To: <1442593798-11501-4-git-send-email-aalonso@freescale.com>
References: <1442593798-11501-1-git-send-email-aalonso@freescale.com>
 <1442593798-11501-4-git-send-email-aalonso@freescale.com>
Message-ID: <20150920092211.GA27897@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 18, 2015 at 11:29:54AM -0500, Adrian Alonso wrote:
> Add imx7d-sdb iomuxc-lpsr hoggrp-2 default pads settings
> 
> Signed-off-by: Adrian Alonso <aalonso@freescale.com>
> ---
> Changes for V2: Resend
> Changes for V3: Resend
> Changes for V4: Resend
> 
>  arch/arm/boot/dts/imx7d-sdb.dts | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
> index 8059458..c8a178c 100644
> --- a/arch/arm/boot/dts/imx7d-sdb.dts
> +++ b/arch/arm/boot/dts/imx7d-sdb.dts
> @@ -419,3 +419,18 @@
>  
>  	};
>  };
> +
> +&iomuxc_lpsr {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog_2>;
> +
> +	imx7d-sdb {
> +		pinctrl_hog_2: hoggrp-2 {
> +			fsl,pins = <
> +				MX7D_PAD_GPIO1_IO05__GPIO1_IO5    0x14
> +				MX7D_PAD_GPIO1_IO07__GPIO1_IO7    0x59
> +				MX7D_PAD_GPIO1_IO00__WDOD1_WDOG_B 0x74

I think this belong to the watchdog node.

Also some comments for the GPIOs may probably be nice to know what they
are for.

Regards,

Markus

> +			>;
> +		};
> +	};
> +};
> -- 
> 2.1.4
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150920/1fcca3ed/attachment.sig>
