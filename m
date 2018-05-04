From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 4 May 2018 15:48:22 +0800
Subject: [PATCH V5 2/6] ARM: dts: imx6sx-sabreauto: add max7322 IO
 expander support
In-Reply-To: <1524725898-27974-2-git-send-email-Anson.Huang@nxp.com>
References: <1524725898-27974-1-git-send-email-Anson.Huang@nxp.com>
 <1524725898-27974-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180504074821.GX3443@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2018 at 02:58:14PM +0800, Anson Huang wrote:
> Add MAX7322 IO expander support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> no changes since V4.
>  arch/arm/boot/dts/imx6sx-sabreauto.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> index 2caca934..d59084f 100644
> --- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
> +++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> @@ -163,6 +163,13 @@
>  	pinctrl-0 = <&pinctrl_i2c2_1>;
>  	status = "okay";
>  
> +	max7322: gpio at 68 {
> +		compatible = "maxim,max7322";
> +		reg = <0x68>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +

For child nodes having unit-address ('reg' property), sort them in order
of unit-address.

Shawn

>  	pmic: pfuze100 at 08 {
>  		compatible = "fsl,pfuze100";
>  		reg = <0x08>;
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
