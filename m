From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 28 Jan 2016 16:39:14 +0800
Subject: [PATCH] ARM: dts: vf-colibri-eval-v3: Use enable-gpios for BL_ON
In-Reply-To: <1452322793-26020-1-git-send-email-bhuvanchandra.dv@toradex.com>
References: <1452322793-26020-1-git-send-email-bhuvanchandra.dv@toradex.com>
Message-ID: <20160128083914.GQ9070@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 09, 2016 at 12:29:53PM +0530, Bhuvanchandra DV wrote:
> Use pwm-backlight driver 'enable-gpios' property for backlight on/off
> control.
> 
> Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
> ---
>  arch/arm/boot/dts/vf-colibri.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
> index e5949b9..1c0da05 100644
> --- a/arch/arm/boot/dts/vf-colibri.dtsi
> +++ b/arch/arm/boot/dts/vf-colibri.dtsi
> @@ -10,7 +10,10 @@
>  / {
>  	bl: backlight {
>  		compatible = "pwm-backlight";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_bl_on>;
>  		pwms = <&pwm0 0 5000000 0>;
> +		enable-gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
>  		status = "disabled";
>  	};
>  };
> @@ -169,6 +172,12 @@
>  			>;
>  		};
>  
> +		pinctrl_gpio_bl_on: gpio_bl_on {
> +			fsl,pins = <
> +				VF610_PAD_PTC0__GPIO_45		0x22ef
> +			>;
> +		};
> +

@Stefan,

Do we need this?  My understanding is that on Vybrid, when gpio is
requested, the pinctrl will set it up automatically.

Shawn

>  		pinctrl_i2c0: i2c0grp {
>  			fsl,pins = <
>  				VF610_PAD_PTB14__I2C0_SCL		0x37ff
> -- 
> 2.7.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
