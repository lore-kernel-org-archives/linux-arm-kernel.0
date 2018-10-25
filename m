From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 25 Oct 2018 10:38:27 +0100
Subject: [PATCH v5 3/5] dt-bindings: mfd: rk808: Add binding information
 for RK809 and RK817.
In-Reply-To: <1540294467-25813-4-git-send-email-tony.xie@rock-chips.com>
References: <1540294467-25813-1-git-send-email-tony.xie@rock-chips.com>
 <1540294467-25813-4-git-send-email-tony.xie@rock-chips.com>
Message-ID: <20181025093827.GP4939@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Oct 2018, Tony Xie wrote:

> Add device tree bindings documentation for Rockchip's RK809 & RK817 PMIC.
> 
> Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/rk808.txt | 44 +++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/rk808.txt b/Documentation/devicetree/bindings/mfd/rk808.txt
> index 91b6522..d575780 100644
> --- a/Documentation/devicetree/bindings/mfd/rk808.txt
> +++ b/Documentation/devicetree/bindings/mfd/rk808.txt
> @@ -3,11 +3,15 @@ RK8XX Power Management Integrated Circuit
>  The rk8xx family current members:
>  rk805
>  rk808
> +rk809
> +rk817
>  rk818
>  
>  Required properties:
>  - compatible: "rockchip,rk805"
>  - compatible: "rockchip,rk808"
> +- compatible: "rockchip,rk809"
> +- compatible: "rockchip,rk817"
>  - compatible: "rockchip,rk818"
>  - reg: I2C slave address
>  - interrupt-parent: The parent interrupt controller.
> @@ -46,6 +50,23 @@ Optional RK808 properties:
>    the gpio controller. If DVS GPIOs aren't present, voltage changes will happen
>    very quickly with no slow ramp time.
>  
> +Optional shared RK809 and RK817 properties:
> +- vcc1-supply:  The input supply for DCDC_REG1
> +- vcc2-supply:  The input supply for DCDC_REG2
> +- vcc3-supply:  The input supply for DCDC_REG3
> +- vcc4-supply:  The input supply for DCDC_REG4
> +- vcc5-supply:  The input supply for LDO_REG1, LDO_REG2, LDO_REG3
> +- vcc6-supply:  The input supply for LDO_REG4, LDO_REG5, LDO_REG6
> +- vcc7-supply:  The input supply for LDO_REG7, LDO_REG8, LDO_REG9
> +
> +Optional RK809 properties:
> +- vcc8-supply:  The input supply for SWITCH_REG1
> +- vcc9-supply:  The input supply for DCDC_REG5, SWITCH_REG2
> +
> +Optional RK817 properties:
> +- vcc8-supply:  The input supply for BOOST
> +- vcc9-supply:  The input supply for OTG_SWITCH
> +
>  Optional RK818 properties:
>  - vcc1-supply:  The input supply for DCDC_REG1
>  - vcc2-supply:  The input supply for DCDC_REG2
> @@ -87,6 +108,21 @@ number as described in RK808 datasheet.
>  	- SWITCH_REGn
>  		- valid values for n are 1 to 2
>  
> +Following regulators of the RK809 and RK817 PMIC blocks are supported. Note that
> +the 'n' in regulator name, as in DCDC_REGn or LDOn, represents the DCDC or LDO
> +number as described in RK809 and RK817 datasheets.
> +
> +	- DCDC_REGn
> +		- valid values for n are 1 to 5 for RK809.
> +		- valid values for n are 1 to 4 for RK817.
> +	- LDO_REGn
> +		- valid values for n are 1 to 9 for RK809.
> +		- valid values for n are 1 to 9 for RK817.
> +	- SWITCH_REGn
> +		- valid values for n are 1 to 2 for RK809.
> +	- BOOST for RK817
> +	- OTG_SWITCH for RK817
> +
>  Following regulators of the RK818 PMIC block are supported. Note that
>  the 'n' in regulator name, as in DCDC_REGn or LDOn, represents the DCDC or LDO
>  number as described in RK818 datasheet.
> @@ -99,6 +135,14 @@ number as described in RK818 datasheet.
>  	- HDMI_SWITCH
>  	- OTG_SWITCH
>  
> +There are three pins needed to config for each of RK809 and RK817,

Nit: "configure" in full please.

Actually: "It is necessary to configure three pins for both the RK809 and RK817"

> +named "gpio_ts" "gpio_gt" "gpio_slp".
> +	The gpio_gt and gpio_ts pins support the gpio function.
> +	The gpio_slp pin is for controlling the pmic states, as below:
> +		- reset
> +		- power down
> +		- sleep
> +
>  Standard regulator bindings are used inside regulator subnodes. Check
>    Documentation/devicetree/bindings/regulator/regulator.txt
>  for more details

Once that's fixed, please apply my:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
