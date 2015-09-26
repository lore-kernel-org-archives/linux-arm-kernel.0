From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 25 Sep 2015 17:38:04 -0700
Subject: [PATCH v6 2/6] ARM: dts: imx: imx7d-sbd add iomuxc-lpsr hoggrp-2
 pads
In-Reply-To: <1443215162-13716-2-git-send-email-aalonso@freescale.com>
References: <1443215162-13716-1-git-send-email-aalonso@freescale.com>
 <1443215162-13716-2-git-send-email-aalonso@freescale.com>
Message-ID: <20150926003803.GC3529@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 25, 2015 at 04:05:58PM -0500, Adrian Alonso wrote:
> Add imx7d-sdb iomuxc-lpsr hoggrp-2 default pads settings
> 
> Signed-off-by: Adrian Alonso <aalonso@freescale.com>

Looked at this patch again, and please see comments below.

> ---
> Changes for V2: Resend
> Changes for V3: Resend
> Changes for V4: Resend
> Changes for V5: Resend
> Changes for V6:
> - Add wdog pinctrl group, add comments for hog2 group gpios
> 
>  arch/arm/boot/dts/imx7d-sdb.dts | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
> index 8059458..2da704a 100644
> --- a/arch/arm/boot/dts/imx7d-sdb.dts
> +++ b/arch/arm/boot/dts/imx7d-sdb.dts
> @@ -419,3 +419,23 @@
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
> +				MX7D_PAD_GPIO1_IO05__GPIO1_IO5    0x14 	/* usb_otg1_pwr */

Shouldn't this be handled by a pinctrl of regulator at 0 ...

> +				MX7D_PAD_GPIO1_IO07__GPIO1_IO7    0x59 	/* sensor_int_b */

... and this by a pinctrl of regulator at 2?

> +			>;
> +		};
> +
> +		pinctrl_wdog: wdoggrp {
> +			fsl,pins = <
> +				MX7D_PAD_GPIO1_IO00__WDOD1_WDOG_B 0x74
> +			>;
> +		};

Add this only when you have a user for it.

Shawn

> +	};
> +};
> -- 
> 2.1.4
> 
