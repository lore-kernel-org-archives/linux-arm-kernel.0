From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 10 Feb 2016 16:12:49 +0000
Subject: [PATCH v9 2/2] mfd: add documentation for ACT8945A DT bindings
In-Reply-To: <1453887530-22490-3-git-send-email-wenyou.yang@atmel.com>
References: <1453887530-22490-1-git-send-email-wenyou.yang@atmel.com>
 <1453887530-22490-3-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160210161249.GA3782@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Jan 2016, Wenyou Yang wrote:

> The Active-semi ACT8945A PMIC is a Multi-Function Device, it has
> two subdevices:
>  - Regulator
>  - Charger
> 
> This patch adds documentation for ACT8945A DT bindings.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
> 
> Changes in v9: None
> Changes in v8: None
> Changes in v7:
>  - collect Acked-by from Lee Jones
> 
> Changes in v6:
>  - change the regulator name.
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3:
>  - fix the tabbing errors in Example.
>  - use "pmic at 5b" label, not "act8945a at 5b" in Example.
>  - collect Acked-by from Rob.
> 
> Changes in v2:
>  - use more specific label in Example.
>  - add pmic and charger nodes in Example.
> 
>  Documentation/devicetree/bindings/mfd/act8945a.txt |   82 ++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/act8945a.txt

Applied, thanks.

> diff --git a/Documentation/devicetree/bindings/mfd/act8945a.txt b/Documentation/devicetree/bindings/mfd/act8945a.txt
> new file mode 100644
> index 0000000..f2a8387
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/act8945a.txt
> @@ -0,0 +1,82 @@
> +Device-Tree bindings for Active-semi ACT8945A MFD driver
> +
> +Required properties:
> + - compatible: "active-semi,act8945a".
> + - reg: the I2C slave address for the ACT8945A chip
> +
> +The chip exposes two subdevices:
> + - a regulators: see ../regulator/act8945a-regulator.txt
> + - a charger: see ../power/act8945a-charger.txt
> +
> +Example:
> +	pmic at 5b {
> +		compatible = "active-semi,act8945a";
> +		reg = <0x5b>;
> +		status = "okay";
> +
> +		pmic {
> +			compatible = "active-semi,act8945a-regulator";
> +			active-semi,vsel-high;
> +
> +			regulators {
> +				vdd_1v35_reg: REG_DCDC1 {
> +					regulator-name = "VDD_1V35";
> +					regulator-min-microvolt = <1350000>;
> +					regulator-max-microvolt = <1350000>;
> +					regulator-always-on;
> +				};
> +
> +				vdd_1v2_reg: REG_DCDC2 {
> +					regulator-name = "VDD_1V2";
> +					regulator-min-microvolt = <1100000>;
> +					regulator-max-microvolt = <1300000>;
> +					regulator-always-on;
> +				};
> +
> +				vdd_3v3_reg: REG_DCDC3 {
> +					regulator-name = "VDD_3V3";
> +					regulator-min-microvolt = <3300000>;
> +					regulator-max-microvolt = <3300000>;
> +					regulator-always-on;
> +				};
> +
> +				vdd_fuse_reg: REG_LDO1 {
> +					regulator-name = "VDD_FUSE";
> +					regulator-min-microvolt = <2500000>;
> +					regulator-max-microvolt = <2500000>;
> +					regulator-always-on;
> +				};
> +
> +				vdd_3v3_lp_reg: REG_LDO2 {
> +					regulator-name = "VDD_3V3_LP";
> +					regulator-min-microvolt = <3300000>;
> +					regulator-max-microvolt = <3300000>;
> +					regulator-always-on;
> +				};
> +
> +				vdd_led_reg: REG_LDO3 {
> +					regulator-name = "VDD_LED";
> +					regulator-min-microvolt = <3300000>;
> +					regulator-max-microvolt = <3300000>;
> +					regulator-always-on;
> +				};
> +
> +				vdd_sdhc_1v8_reg: REG_LDO4 {
> +					regulator-name = "VDD_SDHC_1V8";
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					regulator-always-on;
> +				};
> +			};
> +		};
> +
> +		charger {
> +			compatible = "active-semi,act8945a-charger";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_charger_chglev>;
> +			active-semi,chglev-gpio = <&pioA 12 GPIO_ACTIVE_HIGH>;
> +			active-semi,input_voltage_threshold = <6600>;
> +			active-semi,precondition_timeout = <40>;
> +			active-semi,total_timeout = <3>;
> +		};
> +	};

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
