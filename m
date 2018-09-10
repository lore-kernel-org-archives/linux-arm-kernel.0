From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 10 Sep 2018 08:48:58 +0800
Subject: [PATCH v2 1/2] ARM: dts: imx6: RDU2: Use new CODEC reset pin name
In-Reply-To: <20180904142018.4267-1-afd@ti.com>
References: <20180904142018.4267-1-afd@ti.com>
Message-ID: <20180910004857.GF21218@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2018 at 09:20:17AM -0500, Andrew F. Davis wrote:
> The correct DT property for specifying a GPIO used for reset
> is "reset-gpios", the driver now accepts this name use this here.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
> 
> Changes from v1:
>  - Remove "fix" from commit message
> 
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

Is it intended to change the polarity?

Shawn

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
