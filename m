From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 25 Sep 2015 12:49:22 +0200
Subject: [PATCH v5 3/7] ARM: dts: imx: imx7d-sbd add iomuxc-lpsr hoggrp-2
 pads
In-Reply-To: <1443128043-21063-3-git-send-email-aalonso@freescale.com>
References: <1443128043-21063-1-git-send-email-aalonso@freescale.com>
 <1443128043-21063-3-git-send-email-aalonso@freescale.com>
Message-ID: <20150925104922.GK11805@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2015 at 03:53:59PM -0500, Adrian Alonso wrote:
> Add imx7d-sdb iomuxc-lpsr hoggrp-2 default pads settings
> 
> Signed-off-by: Adrian Alonso <aalonso@freescale.com>
> ---
> Changes for V2: Resend
> Changes for V3: Resend
> Changes for V4: Resend
> Changes for V5: Resend
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

In my opinion this should still be in the pincontrol for the watchdog
instead of hogging. Also it is not obvious what the GPIOs are for.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150925/928633ce/attachment.sig>
