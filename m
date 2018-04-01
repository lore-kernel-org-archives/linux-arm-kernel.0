From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Sun, 1 Apr 2018 14:32:10 -0700
Subject: [PATCH] ARM: dts: qcom-apq8064: disable i2c by default at soc dtsi
In-Reply-To: <20180315144434.14095-1-srinivas.kandagatla@linaro.org>
References: <20180315144434.14095-1-srinivas.kandagatla@linaro.org>
Message-ID: <20180401213210.GE510@tuxbook-pro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 15 Mar 07:44 PDT 2018, Srinivas Kandagatla wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch marks all the gsbi i2c node at soc level dtsi, so that kernel
> would not assume that its enabled and result in pin conflicts when gsbi
> is used for UART or SPI.
> 
> Without this patch we see below pin conflict.
> 
> apq8064-pinctrl 800000.pinctrl: pin GPIO_20 already requested by
>  12450000.serial; cannot claim for 12460000.i2c
> apq8064-pinctrl 800000.pinctrl: pin-20 (12460000.i2c) status -22
> apq8064-pinctrl 800000.pinctrl: could not request pin 20 (GPIO_20)
>  from group gpio20  on device 800000.pinctrl
> i2c_qup 12460000.i2c: Error applying setting, reverse things back
> i2c_qup: probe of 12460000.i2c failed with error -22
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-apq8064.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
> index 3ca96e361878..54cff79f5725 100644
> --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
> @@ -444,6 +444,7 @@
>  				clock-names = "core", "iface";
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> +				status = "disabled";
>  			};
>  
>  		};
> @@ -472,6 +473,7 @@
>  				clock-names = "core", "iface";
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> +				status = "disabled";
>  			};
>  		};
>  
> @@ -497,6 +499,7 @@
>  				clock-names = "core", "iface";
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> +				status = "disabled";
>  			};
>  		};
>  
> @@ -521,6 +524,7 @@
>  				clocks = <&gcc GSBI4_QUP_CLK>,
>  					 <&gcc GSBI4_H_CLK>;
>  				clock-names = "core", "iface";
> +				status = "disabled";
>  			};
>  		};
>  
> -- 
> 2.16.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
