From: robh@kernel.org (Rob Herring)
Date: Fri, 12 Aug 2016 14:00:31 -0500
Subject: [PATCH 2/2] ARM: dts: am335x-icev2: Add nodes for gpio-decoder
In-Reply-To: <20160812045229.29241-3-vigneshr@ti.com>
References: <20160812045229.29241-1-vigneshr@ti.com>
 <20160812045229.29241-3-vigneshr@ti.com>
Message-ID: <20160812190031.GA16954@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 12, 2016 at 10:22:29AM +0530, Vignesh R wrote:
> AM335x ICE board has a rotary-switch connected to PCA9536 I2C GPIO
> expander. The position of the rotary-switch is reflected by status of
> GPIO lines. Add gpio-decoder node to read these GPIO line status via
> gpio-decoder driver and report it as an input event to the system.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  arch/arm/boot/dts/am335x-icev2.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-icev2.dts b/arch/arm/boot/dts/am335x-icev2.dts
> index 7d8b8fefdf08..f2de594343f2 100644
> --- a/arch/arm/boot/dts/am335x-icev2.dts
> +++ b/arch/arm/boot/dts/am335x-icev2.dts
> @@ -139,6 +139,15 @@
>  			default-state = "off";
>  		};
>  	};
> +	gpio-decoder0 {

Drop the 0 here.

> +		compatible = "gpio-decoder";
> +		gpios = <&pca9536 3 GPIO_ACTIVE_HIGH>,
> +			<&pca9536 2 GPIO_ACTIVE_HIGH>,
> +			<&pca9536 1 GPIO_ACTIVE_HIGH>,
> +			<&pca9536 0 GPIO_ACTIVE_HIGH>;
> +		linux,axis = <0>; /* ABS_X */
> +		gpio-decoder,max-value = <9>;
> +	};
>  };
>  
>  &am33xx_pinmux {
> -- 
> 2.9.2
> 
