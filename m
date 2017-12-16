From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 15 Dec 2017 21:23:36 -0800
Subject: [PATCH v2 10/10] arm64: dts: qcom: msm8916: add nodes for i2c1,
 i2c3, i2c5
In-Reply-To: <20171207151942.5805-11-damien.riegel@savoirfairelinux.com>
References: <20171207151942.5805-1-damien.riegel@savoirfairelinux.com>
 <20171207151942.5805-11-damien.riegel@savoirfairelinux.com>
Message-ID: <20171216052336.GG4281@tuxbook>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 07 Dec 07:19 PST 2017, Damien Riegel wrote:

> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>

Please move pinconf settings into the structure in
apq8016-sbc-soc-pins.dtsi (didn't see this when commenting on the
previous patch).

Apart from this, the patch looks good.

Regards,
Bjorn

> ---
> Changes in v2:
>  - Reworded commit title
>  - Changed size to 0x500
> 
>  arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi  | 48 ++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/msm8916-pins.dtsi | 42 ++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/msm8916.dtsi      | 45 ++++++++++++++++++++++++++++
>  3 files changed, 135 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> index 53c1ddd281a4..11305015ba0b 100644
> --- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> @@ -630,6 +630,22 @@
>  	};
>  };
>  
> +&i2c1_default {
> +	pinconf {
> +		pins = "gpio2", "gpio3";
> +		drive-strength = <16>;
> +		bias-disable;
> +	};
> +};
> +
> +&i2c1_sleep {
> +	pinconf {
> +		pins = "gpio2", "gpio3";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +};
> +
>  &i2c2_default {
>  	pinconf {
>  		pins = "gpio6", "gpio7";
> @@ -646,6 +662,22 @@
>  	};
>  };
>  
> +&i2c3_default {
> +	pinconf {
> +		pins = "gpio10", "gpio11";
> +		drive-strength = <16>;
> +		bias-disable;
> +	};
> +};
> +
> +&i2c3_sleep {
> +	pinconf {
> +		pins = "gpio10", "gpio11";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +};
> +
>  &i2c4_default {
>  	pinconf {
>  		pins = "gpio14", "gpio15";
> @@ -662,6 +694,22 @@
>  	};
>  };
>  
> +&i2c5_default {
> +	pinconf {
> +		pins = "gpio18", "gpio19";
> +		drive-strength = <16>;
> +		bias-disable;
> +	};
> +};
> +
> +&i2c5_sleep {
> +	pinconf {
> +		pins = "gpio18", "gpio19";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +};
> +
>  &i2c6_default {
>  	pinconf {
>  		pins = "gpio22", "gpio23";
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
> index 7704ddecb6c4..44e68860fc8c 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
> @@ -152,6 +152,20 @@
>  		};
>  	};
>  
> +	i2c1_default: i2c1_default {
> +		pinmux {
> +			function = "blsp_i2c1";
> +			pins = "gpio2", "gpio3";
> +		};
> +	};
> +
> +	i2c1_sleep: i2c1_sleep {
> +		pinmux {
> +			function = "gpio";
> +			pins = "gpio2", "gpio3";
> +		};
> +	};
> +
>  	i2c2_default: i2c2_default {
>  		pinmux {
>  			function = "blsp_i2c2";
> @@ -166,6 +180,20 @@
>  		};
>  	};
>  
> +	i2c3_default: i2c3_default {
> +		pinmux {
> +			function = "blsp_i2c3";
> +			pins = "gpio10", "gpio11";
> +		};
> +	};
> +
> +	i2c3_sleep: i2c3_sleep {
> +		pinmux {
> +			function = "gpio";
> +			pins = "gpio10", "gpio11";
> +		};
> +	};
> +
>  	i2c4_default: i2c4_default {
>  		pinmux {
>  			function = "blsp_i2c4";
> @@ -180,6 +208,20 @@
>  		};
>  	};
>  
> +	i2c5_default: i2c5_default {
> +		pinmux {
> +			function = "blsp_i2c5";
> +			pins = "gpio18", "gpio19";
> +		};
> +	};
> +
> +	i2c5_sleep: i2c5_sleep {
> +		pinmux {
> +			function = "gpio";
> +			pins = "gpio18", "gpio19";
> +		};
> +	};
> +
>  	i2c6_default: i2c6_default {
>  		pinmux {
>  			function = "blsp_i2c6";
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index ac440f287633..7478c7337995 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -455,6 +455,21 @@
>  			status = "disabled";
>  		};
>  
> +		blsp_i2c1: i2c at 78b5000 {
> +			compatible = "qcom,i2c-qup-v2.2.1";
> +			reg = <0x078b5000 0x500>;
> +			interrupts = <GIC_SPI 95 0>;
> +			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
> +				 <&gcc GCC_BLSP1_QUP1_I2C_APPS_CLK>;
> +			clock-names = "iface", "core";
> +			pinctrl-names = "default", "sleep";
> +			pinctrl-0 = <&i2c1_default>;
> +			pinctrl-1 = <&i2c1_sleep>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
>  		blsp_i2c2: i2c at 78b6000 {
>  			compatible = "qcom,i2c-qup-v2.2.1";
>  			reg = <0x078b6000 0x500>;
> @@ -470,6 +485,21 @@
>  			status = "disabled";
>  		};
>  
> +		blsp_i2c3: i2c at 78b7000 {
> +			compatible = "qcom,i2c-qup-v2.2.1";
> +			reg = <0x078b7000 0x500>;
> +			interrupts = <GIC_SPI 97 0>;
> +			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
> +				 <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>;
> +			clock-names = "iface", "core";
> +			pinctrl-names = "default", "sleep";
> +			pinctrl-0 = <&i2c3_default>;
> +			pinctrl-1 = <&i2c3_sleep>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
>  		blsp_i2c4: i2c at 78b8000 {
>  			compatible = "qcom,i2c-qup-v2.2.1";
>  			reg = <0x078b8000 0x500>;
> @@ -485,6 +515,21 @@
>  			status = "disabled";
>  		};
>  
> +		blsp_i2c5: i2c at 78b9000 {
> +			compatible = "qcom,i2c-qup-v2.2.1";
> +			reg = <0x078b9000 0x500>;
> +			interrupts = <GIC_SPI 99 0>;
> +			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
> +				 <&gcc GCC_BLSP1_QUP5_I2C_APPS_CLK>;
> +			clock-names = "iface", "core";
> +			pinctrl-names = "default", "sleep";
> +			pinctrl-0 = <&i2c5_default>;
> +			pinctrl-1 = <&i2c5_sleep>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
>  		blsp_i2c6: i2c at 78ba000 {
>  			compatible = "qcom,i2c-qup-v2.2.1";
>  			reg = <0x078ba000 0x500>;
> -- 
> 2.15.0
> 
