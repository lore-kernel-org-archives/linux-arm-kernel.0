From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 27 Aug 2014 23:32:49 +0200
Subject: [PATCH v5 2/3] ARM: dts: Add main PWM info to rk3288
In-Reply-To: <1409007567-23523-3-git-send-email-dianders@chromium.org>
References: <1409007567-23523-1-git-send-email-dianders@chromium.org>
 <1409007567-23523-3-git-send-email-dianders@chromium.org>
Message-ID: <3711416.XmBfSOmzxP@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 25. August 2014, 15:59:26 schrieb Doug Anderson:
> This adds the PWM info (other than the VOP PWM) to the main rk3288
> dtsi file.
> 
> Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---

Applied to my v3.18-next/dts branch.

I've changed the RK_FUNC_3 to its numerical equivalent for now, as the pinctrl 
binding change is probably going through the pinctrl tree at some point.


> Changes in v5:
> - Back to version 3 (no rockchip,grf).
> 
> Changes in v4:
> - Add rockchip,grf to pwm nodes.
> 
> Changes in v3: None
> 
>  arch/arm/boot/dts/rk3288.dtsi | 68
> +++++++++++++++++++++++++++++++++++++++++++ 1 file changed, 68
> insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 36be7bb..9c9d9c5 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -261,6 +261,50 @@
>  		status = "disabled";
>  	};
> 
> +	pwm0: pwm at ff680000 {
> +		compatible = "rockchip,rk3288-pwm";
> +		reg = <0xff680000 0x10>;
> +		#pwm-cells = <3>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pwm0_pin>;
> +		clocks = <&cru PCLK_PWM>;
> +		clock-names = "pwm";
> +		status = "disabled";
> +	};
> +
> +	pwm1: pwm at ff680010 {
> +		compatible = "rockchip,rk3288-pwm";
> +		reg = <0xff680010 0x10>;
> +		#pwm-cells = <3>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pwm1_pin>;
> +		clocks = <&cru PCLK_PWM>;
> +		clock-names = "pwm";
> +		status = "disabled";
> +	};
> +
> +	pwm2: pwm at ff680020 {
> +		compatible = "rockchip,rk3288-pwm";
> +		reg = <0xff680020 0x10>;
> +		#pwm-cells = <3>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pwm2_pin>;
> +		clocks = <&cru PCLK_PWM>;
> +		clock-names = "pwm";
> +		status = "disabled";
> +	};
> +
> +	pwm3: pwm at ff680030 {
> +		compatible = "rockchip,rk3288-pwm";
> +		reg = <0xff680030 0x10>;
> +		#pwm-cells = <2>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pwm3_pin>;
> +		clocks = <&cru PCLK_PWM>;
> +		clock-names = "pwm";
> +		status = "disabled";
> +	};
> +
>  	pmu: power-management at ff730000 {
>  		compatible = "rockchip,rk3288-pmu", "syscon";
>  		reg = <0xff730000 0x100>;
> @@ -611,5 +655,29 @@
>  				rockchip,pins = <5 15 3 &pcfg_pull_none>;
>  			};
>  		};
> +
> +		pwm0 {
> +			pwm0_pin: pwm0-pin {
> +				rockchip,pins = <7 0 RK_FUNC_1 &pcfg_pull_none>;
> +			};
> +		};
> +
> +		pwm1 {
> +			pwm1_pin: pwm1-pin {
> +				rockchip,pins = <7 1 RK_FUNC_1 &pcfg_pull_none>;
> +			};
> +		};
> +
> +		pwm2 {
> +			pwm2_pin: pwm2-pin {
> +				rockchip,pins = <7 22 RK_FUNC_3 &pcfg_pull_none>;
> +			};
> +		};
> +
> +		pwm3 {
> +			pwm3_pin: pwm3-pin {
> +				rockchip,pins = <7 23 RK_FUNC_3 &pcfg_pull_none>;
> +			};
> +		};
>  	};
>  };
