From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 22 Oct 2014 11:57:55 +0900
Subject: [PATCH v3 4/4] ARM: dts: exynos4412-trats: Add suspend
 configuration for max77686 regulators
In-Reply-To: <1413897595-28752-5-git-send-email-k.kozlowski@samsung.com>
References: <1413897595-28752-1-git-send-email-k.kozlowski@samsung.com>
 <1413897595-28752-5-git-send-email-k.kozlowski@samsung.com>
Message-ID: <54471D33.8000906@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 10/21/2014 10:19 PM, Krzysztof Kozlowski wrote:
> Add suspend to RAM configuration for max77686 regulators. Some LDOs and
> bucks are disabled. This reduces energy consumption during S2R,
> approximately from 17 mA to 9 mA.
> 
> Additionally remove old and not supported bindings:
>  - regulator-mem-off
>  - regulator-mem-idle
>  - regulator-mem-on
> The max77686 driver does not parse them and they are not documented
> anywere.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  arch/arm/boot/dts/exynos4412-trats2.dts | 72 +++++++++++++++++++--------------
>  1 file changed, 42 insertions(+), 30 deletions(-)

Looks good to me.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi

> 
> diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
> index dd9ac66770f7..8067eb447829 100644
> --- a/arch/arm/boot/dts/exynos4412-trats2.dts
> +++ b/arch/arm/boot/dts/exynos4412-trats2.dts
> @@ -225,7 +225,6 @@
>  					regulator-min-microvolt = <1000000>;
>  					regulator-max-microvolt = <1000000>;
>  					regulator-always-on;
> -					regulator-mem-on;
>  				};
>  
>  				ldo2_reg: ldo2 {
> @@ -234,7 +233,9 @@
>  					regulator-min-microvolt = <1200000>;
>  					regulator-max-microvolt = <1200000>;
>  					regulator-always-on;
> -					regulator-mem-on;
> +					regulator-state-mem {
> +						regulator-on-in-suspend;
> +					};
>  				};
>  
>  				ldo3_reg: ldo3 {
> @@ -243,7 +244,6 @@
>  					regulator-min-microvolt = <1800000>;
>  					regulator-max-microvolt = <1800000>;
>  					regulator-always-on;
> -					regulator-mem-on;
>  				};
>  
>  				ldo4_reg: ldo4 {
> @@ -252,7 +252,6 @@
>  					regulator-min-microvolt = <2800000>;
>  					regulator-max-microvolt = <2800000>;
>  					regulator-always-on;
> -					regulator-mem-on;
>  				};
>  
>  				ldo5_reg: ldo5 {
> @@ -261,7 +260,6 @@
>  					regulator-min-microvolt = <1800000>;
>  					regulator-max-microvolt = <1800000>;
>  					regulator-always-on;
> -					regulator-mem-on;
>  				};
>  
>  				ldo6_reg: ldo6 {
> @@ -270,7 +268,9 @@
>  					regulator-min-microvolt = <1000000>;
>  					regulator-max-microvolt = <1000000>;
>  					regulator-always-on;
> -					regulator-mem-on;
> +					regulator-state-mem {
> +						regulator-on-in-suspend;
> +					};
>  				};
>  
>  				ldo7_reg: ldo7 {
> @@ -279,7 +279,9 @@
>  					regulator-min-microvolt = <1000000>;
>  					regulator-max-microvolt = <1000000>;
>  					regulator-always-on;
> -					regulator-mem-on;
> +					regulator-state-mem {
> +						regulator-on-in-suspend;
> +					};
>  				};
>  
>  				ldo8_reg: ldo8 {
> @@ -287,7 +289,9 @@
>  					regulator-name = "VMIPI_1.0V";
>  					regulator-min-microvolt = <1000000>;
>  					regulator-max-microvolt = <1000000>;
> -					regulator-mem-off;
> +					regulator-state-mem {
> +						regulator-off-in-suspend;
> +					};
>  				};
>  
>  				ldo9_reg: ldo9 {
> @@ -295,7 +299,6 @@
>  					regulator-name = "CAM_ISP_MIPI_1.2V";
>  					regulator-min-microvolt = <1200000>;
>  					regulator-max-microvolt = <1200000>;
> -					regulator-mem-idle;
>  				};
>  
>  				ldo10_reg: ldo10 {
> @@ -303,7 +306,9 @@
>  					regulator-name = "VMIPI_1.8V";
>  					regulator-min-microvolt = <1800000>;
>  					regulator-max-microvolt = <1800000>;
> -					regulator-mem-off;
> +					regulator-state-mem {
> +						regulator-off-in-suspend;
> +					};
>  				};
>  
>  				ldo11_reg: ldo11 {
> @@ -312,7 +317,9 @@
>  					regulator-min-microvolt = <1950000>;
>  					regulator-max-microvolt = <1950000>;
>  					regulator-always-on;
> -					regulator-mem-off;
> +					regulator-state-mem {
> +						regulator-off-in-suspend;
> +					};
>  				};
>  
>  				ldo12_reg: ldo12 {
> @@ -320,7 +327,9 @@
>  					regulator-name = "VUOTG_3.0V";
>  					regulator-min-microvolt = <3000000>;
>  					regulator-max-microvolt = <3000000>;
> -					regulator-mem-off;
> +					regulator-state-mem {
> +						regulator-off-in-suspend;
> +					};
>  				};
>  
>  				ldo13_reg: ldo13 {
> @@ -328,7 +337,6 @@
>  					regulator-name = "NFC_AVDD_1.8V";
>  					regulator-min-microvolt = <1800000>;
>  					regulator-max-microvolt = <1800000>;
> -					regulator-mem-idle;
>  				};
>  
>  				ldo14_reg: ldo14 {
> @@ -337,7 +345,9 @@
>  					regulator-min-microvolt = <1950000>;
>  					regulator-max-microvolt = <1950000>;
>  					regulator-always-on;
> -					regulator-mem-off;
> +					regulator-state-mem {
> +						regulator-off-in-suspend;
> +					};
>  				};
>  
>  				ldo15_reg: ldo15 {
> @@ -345,7 +355,9 @@
>  					regulator-name = "VHSIC_1.0V";
>  					regulator-min-microvolt = <1000000>;
>  					regulator-max-microvolt = <1000000>;
> -					regulator-mem-off;
> +					regulator-state-mem {
> +						regulator-on-in-suspend;
> +					};
>  				};
>  
>  				ldo16_reg: ldo16 {
> @@ -353,7 +365,9 @@
>  					regulator-name = "VHSIC_1.8V";
>  					regulator-min-microvolt = <1800000>;
>  					regulator-max-microvolt = <1800000>;
> -					regulator-mem-off;
> +					regulator-state-mem {
> +						regulator-on-in-suspend;
> +					};
>  				};
>  
>  				ldo17_reg: ldo17 {
> @@ -361,7 +375,6 @@
>  					regulator-name = "CAM_SENSOR_CORE_1.2V";
>  					regulator-min-microvolt = <1200000>;
>  					regulator-max-microvolt = <1200000>;
> -					regulator-mem-idle;
>  				};
>  
>  				ldo18_reg: ldo18 {
> @@ -369,7 +382,6 @@
>  					regulator-name = "CAM_ISP_SEN_IO_1.8V";
>  					regulator-min-microvolt = <1800000>;
>  					regulator-max-microvolt = <1800000>;
> -					regulator-mem-idle;
>  				};
>  
>  				ldo19_reg: ldo19 {
> @@ -377,7 +389,6 @@
>  					regulator-name = "VT_CAM_1.8V";
>  					regulator-min-microvolt = <1800000>;
>  					regulator-max-microvolt = <1800000>;
> -					regulator-mem-idle;
>  				};
>  
>  				ldo20_reg: ldo20 {
> @@ -385,7 +396,6 @@
>  					regulator-name = "VDDQ_PRE_1.8V";
>  					regulator-min-microvolt = <1800000>;
>  					regulator-max-microvolt = <1800000>;
> -					regulator-mem-idle;
>  				};
>  
>  				ldo21_reg: ldo21 {
> @@ -393,7 +403,6 @@
>  					regulator-name = "VTF_2.8V";
>  					regulator-min-microvolt = <2800000>;
>  					regulator-max-microvolt = <2800000>;
> -					regulator-mem-idle;
>  				};
>  
>  				ldo22_reg: ldo22 {
> @@ -408,7 +417,6 @@
>  					regulator-name = "TSP_AVDD_3.3V";
>  					regulator-min-microvolt = <3300000>;
>  					regulator-max-microvolt = <3300000>;
> -					regulator-mem-idle;
>  				};
>  
>  				ldo24_reg: ldo24 {
> @@ -416,7 +424,6 @@
>  					regulator-name = "TSP_VDD_1.8V";
>  					regulator-min-microvolt = <1800000>;
>  					regulator-max-microvolt = <1800000>;
> -					regulator-mem-idle;
>  				};
>  
>  				ldo25_reg: ldo25 {
> @@ -424,7 +431,6 @@
>  					regulator-name = "LCD_VCC_3.3V";
>  					regulator-min-microvolt = <2800000>;
>  					regulator-max-microvolt = <2800000>;
> -					regulator-mem-idle;
>  				};
>  
>  				ldo26_reg: ldo26 {
> @@ -432,7 +438,6 @@
>  					regulator-name = "MOTOR_VCC_3.0V";
>  					regulator-min-microvolt = <3000000>;
>  					regulator-max-microvolt = <3000000>;
> -					regulator-mem-idle;
>  				};
>  
>  				buck1_reg: buck1 {
> @@ -442,7 +447,9 @@
>  					regulator-max-microvolt = <1100000>;
>  					regulator-always-on;
>  					regulator-boot-on;
> -					regulator-mem-off;
> +					regulator-state-mem {
> +						regulator-off-in-suspend;
> +					};
>  				};
>  
>  				buck2_reg: buck2 {
> @@ -452,7 +459,9 @@
>  					regulator-max-microvolt = <1500000>;
>  					regulator-always-on;
>  					regulator-boot-on;
> -					regulator-mem-off;
> +					regulator-state-mem {
> +						regulator-on-in-suspend;
> +					};
>  				};
>  
>  				buck3_reg: buck3 {
> @@ -462,7 +471,9 @@
>  					regulator-max-microvolt = <1150000>;
>  					regulator-always-on;
>  					regulator-boot-on;
> -					regulator-mem-off;
> +					regulator-state-mem {
> +						regulator-off-in-suspend;
> +					};
>  				};
>  
>  				buck4_reg: buck4 {
> @@ -471,7 +482,9 @@
>  					regulator-min-microvolt = <850000>;
>  					regulator-max-microvolt = <1150000>;
>  					regulator-boot-on;
> -					regulator-mem-off;
> +					regulator-state-mem {
> +						regulator-off-in-suspend;
> +					};
>  				};
>  
>  				buck5_reg: buck5 {
> @@ -510,7 +523,6 @@
>  					regulator-name = "CAM_ISP_CORE_1.2V";
>  					regulator-min-microvolt = <1000000>;
>  					regulator-max-microvolt = <1200000>;
> -					regulator-mem-off;
>  				};
>  			};
>  		};
> 
