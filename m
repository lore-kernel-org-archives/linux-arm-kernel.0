From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 29 Aug 2016 16:18:10 +0800
Subject: [PATCH] ARM: dts: imx7s-warp: Let the codec control MCLK pinctrl
In-Reply-To: <1472148347-504-1-git-send-email-fabio.estevam@nxp.com>
References: <1472148347-504-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <20160829081810.GK30790@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2016 at 03:05:47PM -0300, Fabio Estevam wrote:
> sgtl5000 codec needs MCLK clock to be provided so that it can
> successfully read/write via I2C, so we should better let the
> codec control the pinctrl for such pin.
> 
> Thanks to Stefan Agner who provided the fix on Toradex's tree:
> http://git.toradex.com/cgit/linux-toradex.git/commit/?h=toradex_imx_4.1.15_1.0.0_ga-next&id=0a55a7e5f58d46eef0d4d1d357d89e36d0c32fa4
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  arch/arm/boot/dts/imx7s-warp.dts | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
> index 92d9c857..7c3f110e 100644
> --- a/arch/arm/boot/dts/imx7s-warp.dts
> +++ b/arch/arm/boot/dts/imx7s-warp.dts
> @@ -199,6 +199,8 @@
>  		reg = <0x0a>;
>  		compatible = "fsl,sgtl5000";
>  		clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_sai1_mclk>;
>  		VDDA-supply = <&vgen4_reg>;
>  		VDDIO-supply = <&vgen4_reg>;
>  		VDDD-supply = <&vgen2_reg>;
> @@ -291,7 +293,12 @@
>  			MX7D_PAD_SAI1_TX_BCLK__SAI1_TX_BCLK	0x1f
>  			MX7D_PAD_SAI1_TX_SYNC__SAI1_TX_SYNC	0x1f
>  			MX7D_PAD_SAI1_TX_DATA__SAI1_TX_DATA0	0x30
> -			MX7D_PAD_SAI1_MCLK__SAI1_MCLK		0x1f
> +		>;
> +	};
> +
> +	pinctrl_sai1_mclk: sai1grp_mclk {

We do not use underscore in node name.  I changed it to sai1mclkgrp and
applied the patch.

Shawn

> +		fsl,pins = <
> +			MX7D_PAD_SAI1_MCLK__SAI1_MCLK           0x1f
>  		>;
>  	};
>  
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
