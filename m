From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 12 May 2014 11:56:35 +0200
Subject: [PATCH] ARM: dts: at91-sama5d3_xplained: add the regulator device
 node
In-Reply-To: <1398054547-5834-1-git-send-email-wenyou.yang@atmel.com>
References: <1398054547-5834-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <53709AD3.1080502@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/04/2014 06:29, Wenyou Yang :
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Stacked on the at91-3.16-dt2 branch.

Thanks, bye,

> ---
>  arch/arm/boot/dts/at91-sama5d3_xplained.dts |   42 +++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
> index ce13755..57cdd83 100644
> --- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
> @@ -48,6 +48,48 @@
>  
>  			i2c1: i2c at f0018000 {
>  				status = "okay";
> +
> +				pmic: act8865 at 5b {
> +					compatible = "active-semi,act8865";
> +					reg = <0x5b>;
> +					status = "okay";
> +
> +					regulators {
> +						vcc_1v8_reg: DCDC_REG1 {
> +							regulator-name = "VCC_1V8";
> +							regulator-min-microvolt = <1800000>;
> +							regulator-max-microvolt = <1800000>;
> +							regulator-always-on;
> +						};
> +
> +						vcc_1v2_reg: DCDC_REG2 {
> +							regulator-name = "VCC_1V2";
> +							regulator-min-microvolt = <1200000>;
> +							regulator-max-microvolt = <1200000>;
> +							regulator-always-on;
> +						};
> +
> +						vcc_3v3_reg: DCDC_REG3 {
> +							regulator-name = "VCC_3V3";
> +							regulator-min-microvolt = <3300000>;
> +							regulator-max-microvolt = <3300000>;
> +							regulator-always-on;
> +						};
> +
> +						vddfuse_reg: LDO_REG1 {
> +							regulator-name = "FUSE_2V5";
> +							regulator-min-microvolt = <2500000>;
> +							regulator-max-microvolt = <2500000>;
> +						};
> +
> +						vddana_reg: LDO_REG2 {
> +							regulator-name = "VDDANA";
> +							regulator-min-microvolt = <3300000>;
> +							regulator-max-microvolt = <3300000>;
> +							regulator-always-on;
> +						};
> +					};
> +				};
>  			};
>  
>  			macb0: ethernet at f0028000 {
> 


-- 
Nicolas Ferre
