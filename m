From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Wed, 27 Jan 2016 23:53:41 +0530
Subject: [PATCH] ARM: dts: vf-colibri-eval-v3: Use enable-gpios for BL_ON
In-Reply-To: <1452322793-26020-1-git-send-email-bhuvanchandra.dv@toradex.com>
References: <1452322793-26020-1-git-send-email-bhuvanchandra.dv@toradex.com>
Message-ID: <56A90B2D.70006@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping!

On 01/09/2016 12:29 PM, Bhuvanchandra DV wrote:
> Use pwm-backlight driver 'enable-gpios' property for backlight on/off
> control.
>
> Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
> ---
>   arch/arm/boot/dts/vf-colibri.dtsi | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
> index e5949b9..1c0da05 100644
> --- a/arch/arm/boot/dts/vf-colibri.dtsi
> +++ b/arch/arm/boot/dts/vf-colibri.dtsi
> @@ -10,7 +10,10 @@
>   / {
>   	bl: backlight {
>   		compatible = "pwm-backlight";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_bl_on>;
>   		pwms = <&pwm0 0 5000000 0>;
> +		enable-gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
>   		status = "disabled";
>   	};
>   };
> @@ -169,6 +172,12 @@
>   			>;
>   		};
>
> +		pinctrl_gpio_bl_on: gpio_bl_on {
> +			fsl,pins = <
> +				VF610_PAD_PTC0__GPIO_45		0x22ef
> +			>;
> +		};
> +
>   		pinctrl_i2c0: i2c0grp {
>   			fsl,pins = <
>   				VF610_PAD_PTB14__I2C0_SCL		0x37ff
>

-- 
Best regards,
Bhuvan
