From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 30 Sep 2015 13:40:28 +0800
Subject: [PATCH v15 1/2] arm:dts:ls1021a: Add DCU dts node
In-Reply-To: <1440656027-8542-1-git-send-email-jianwei.wang.chn@gmail.com>
References: <1440656027-8542-1-git-send-email-jianwei.wang.chn@gmail.com>
Message-ID: <20150930054028.GA16362@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 27, 2015 at 02:13:46PM +0800, Jianwei Wang wrote:
> Add DCU node, DCU is a display controller of Freescale
> named 2D-ACE.
> 
> Signed-off-by: Alison Wang <b18965@freescale.com>
> Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
> Signed-off-by: Jianwei Wang <jianwei.wang.chn@gmail.com>

MAINTAINERS file has been updated for a couple of release cycles.
Please stop using shawn.guo at linaro.org, and resend to
shawnguo at kernel.org instead.

Shawn

> ---
>  arch/arm/boot/dts/ls1021a.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> index c70bb27..6d6e3e2 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -383,6 +383,16 @@
>  				 <&platform_clk 1>;
>  		};
>  
> +		dcu: dcu at 2ce0000 {
> +			compatible = "fsl,ls1021a-dcu";
> +			reg = <0x0 0x2ce0000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&platform_clk 0>;
> +			clock-names = "dcu";
> +			big-endian;
> +			status = "disabled";
> +		};
> +
>  		mdio0: mdio at 2d24000 {
>  			compatible = "gianfar";
>  			device_type = "mdio";
> -- 
> 2.1.0.27.g96db324
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
