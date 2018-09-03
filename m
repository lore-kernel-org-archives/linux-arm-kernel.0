From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 3 Sep 2018 12:54:28 +0800
Subject: [PATCH 1/2] ARM: dts: imx6: RDU2: Fix the audio CODEC's reset pin
In-Reply-To: <20180831191732.25504-1-afd@ti.com>
References: <20180831191732.25504-1-afd@ti.com>
Message-ID: <20180903045426.GM3850@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2018 at 02:17:31PM -0500, Andrew F. Davis wrote:
> The correct DT property for specifying a GPIO used for reset
> is "reset-gpios", fix this here.
> 
> Fixes: d763762e3b58 ("ARM: dts: imx6: add ZII RDU2 boards")

This Fixes tag and word 'Fix' in subject is inappropriate to me, as you
are not fixing something wrong from the beginning, but actually
replacing a deprecated property with new one.

Shawn

> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> index 7fff3717cf7c..a0f5cfda0055 100644
> --- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> @@ -384,7 +384,7 @@
>  		AVDD-supply = <&reg_3p3v>;
>  		IOVDD-supply = <&reg_3p3v>;
>  		DVDD-supply = <&vgen4_reg>;
> -		gpio-reset = <&gpio1 2 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
>  	};
>  
>  	accel at 1c {
> @@ -572,7 +572,7 @@
>  		AVDD-supply = <&reg_3p3v>;
>  		IOVDD-supply = <&reg_3p3v>;
>  		DVDD-supply = <&vgen4_reg>;
> -		gpio-reset = <&gpio1 0 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
>  	};
>  
>  	touchscreen at 20 {
> -- 
> 2.18.0
> 
