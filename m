From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 30 Dec 2016 15:38:48 +0900
Subject: [PATCH v2 3/4] ARM64: dts: exynos5433: use macros for pinctrl
 configuration on Exynos5433
In-Reply-To: <20161230041421.24448-4-andi.shyti@samsung.com>
References: <20161230041421.24448-1-andi.shyti@samsung.com>
 <CGME20161230041427epcas1p1151d6e28fac143c63efaf4f7c8ed432d@epcas1p1.samsung.com>
 <20161230041421.24448-4-andi.shyti@samsung.com>
Message-ID: <586600F8.10002@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andi,

Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Regards,
Chanwoo Choi

On 2016? 12? 30? 13:14, Andi Shyti wrote:
> Use the macros defined in include/dt-bindings/pinctrl/samsung.h
> instead of hardcoded values.
> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi | 348 +++++++++++----------
>  1 file changed, 175 insertions(+), 173 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
> index ad71247b074f..2af854b11644 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
> @@ -12,6 +12,8 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#include <dt-bindings/pinctrl/samsung.h>
> +
>  #define PIN_PULL_NONE		0
>  #define PIN_PULL_DOWN		1
>  #define PIN_PULL_UP		3
> @@ -145,23 +147,23 @@
>  	i2s0_bus: i2s0-bus {
>  		samsung,pins = "gpz0-0", "gpz0-1", "gpz0-2", "gpz0-3",
>  				"gpz0-4", "gpz0-5", "gpz0-6";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <1>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  
>  	pcm0_bus: pcm0-bus {
>  		samsung,pins = "gpz1-0", "gpz1-1", "gpz1-2", "gpz1-3";
> -		samsung,pin-function = <3>;
> -		samsung,pin-pud = <1>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  
>  	uart_aud_bus: uart-aud-bus {
>  		samsung,pins = "gpz1-3", "gpz1-2", "gpz1-1", "gpz1-0";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <0>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  };
>  
> @@ -196,16 +198,16 @@
>  
>  	spi2_bus: spi2-bus {
>  		samsung,pins = "gpd5-0", "gpd5-2", "gpd5-3";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <3>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  
>  	hs_i2c6_bus: hs-i2c6-bus {
>  		samsung,pins = "gpd5-3", "gpd5-2";
> -		samsung,pin-function = <4>;
> -		samsung,pin-pud = <3>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  };
>  
> @@ -260,141 +262,141 @@
>  
>  	sd0_clk: sd0-clk {
>  		samsung,pins = "gpr0-0";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <0>;
> -		samsung,pin-drv = <3>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
>  	};
>  
>  	sd0_cmd: sd0-cmd {
>  		samsung,pins = "gpr0-1";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <0>;
> -		samsung,pin-drv = <3>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
>  	};
>  
>  	sd0_rdqs: sd0-rdqs {
>  		samsung,pins = "gpr0-2";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <1>;
> -		samsung,pin-drv = <3>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
>  	};
>  
>  	sd0_qrdy: sd0-qrdy {
>  		samsung,pins = "gpr0-3";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <1>;
> -		samsung,pin-drv = <3>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
>  	};
>  
>  	sd0_bus1: sd0-bus-width1 {
>  		samsung,pins = "gpr1-0";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <3>;
> -		samsung,pin-drv = <3>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
>  	};
>  
>  	sd0_bus4: sd0-bus-width4 {
>  		samsung,pins = "gpr1-1", "gpr1-2", "gpr1-3";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <3>;
> -		samsung,pin-drv = <3>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
>  	};
>  
>  	sd0_bus8: sd0-bus-width8 {
>  		samsung,pins = "gpr1-4", "gpr1-5", "gpr1-6", "gpr1-7";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <3>;
> -		samsung,pin-drv = <3>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
>  	};
>  
>  	sd1_clk: sd1-clk {
>  		samsung,pins = "gpr2-0";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <0>;
> -		samsung,pin-drv = <3>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
>  	};
>  
>  	sd1_cmd: sd1-cmd {
>  		samsung,pins = "gpr2-1";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <0>;
> -		samsung,pin-drv = <3>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
>  	};
>  
>  	sd1_bus1: sd1-bus-width1 {
>  		samsung,pins = "gpr3-0";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <3>;
> -		samsung,pin-drv = <3>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
>  	};
>  
>  	sd1_bus4: sd1-bus-width4 {
>  		samsung,pins = "gpr3-1", "gpr3-2", "gpr3-3";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <3>;
> -		samsung,pin-drv = <3>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
>  	};
>  
>  	sd1_bus8: sd1-bus-width8 {
>  		samsung,pins = "gpr3-4", "gpr3-5", "gpr3-6", "gpr3-7";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <3>;
> -		samsung,pin-drv = <3>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
>  	};
>  
>  	pcie_bus: pcie_bus {
>  		samsung,pins = "gpr3-4", "gpr3-5", "gpr3-6", "gpr3-7";
> -		samsung,pin-function = <3>;
> -		samsung,pin-pud = <3>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
>  	};
>  
>  	sd2_clk: sd2-clk {
>  		samsung,pins = "gpr4-0";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <0>;
> -		samsung,pin-drv = <3>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
>  	};
>  
>  	sd2_cmd: sd2-cmd {
>  		samsung,pins = "gpr4-1";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <0>;
> -		samsung,pin-drv = <3>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
>  	};
>  
>  	sd2_cd: sd2-cd {
>  		samsung,pins = "gpr4-2";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <3>;
> -		samsung,pin-drv = <3>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
>  	};
>  
>  	sd2_bus1: sd2-bus-width1 {
>  		samsung,pins = "gpr4-3";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <3>;
> -		samsung,pin-drv = <3>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
>  	};
>  
>  	sd2_bus4: sd2-bus-width4 {
>  		samsung,pins = "gpr4-4", "gpr4-5", "gpr4-6";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <3>;
> -		samsung,pin-drv = <3>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
>  	};
>  
>  	sd2_clk_output: sd2-clk-output {
>  		samsung,pins = "gpr4-0";
> -		samsung,pin-function = <1>;
> -		samsung,pin-pud = <0>;
> -		samsung,pin-drv = <2>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR3>;
>  	};
>  
>  	sd2_cmd_output: sd2-cmd-output {
>  		samsung,pins = "gpr4-1";
> -		samsung,pin-function = <1>;
> -		samsung,pin-pud = <0>;
> -		samsung,pin-drv = <2>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR3>;
>  	};
>  };
>  
> @@ -419,9 +421,9 @@
>  
>  	hs_i2c4_bus: hs-i2c4-bus {
>  		samsung,pins = "gpj0-1", "gpj0-0";
> -		samsung,pin-function = <4>;
> -		samsung,pin-pud = <3>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  };
>  
> @@ -564,225 +566,225 @@
>  
>  	hs_i2c8_bus: hs-i2c8-bus {
>  		samsung,pins = "gpb0-1", "gpb0-0";
> -		samsung,pin-function = <4>;
> -		samsung,pin-pud = <3>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  
>  	hs_i2c9_bus: hs-i2c9-bus {
>  		samsung,pins = "gpb0-3", "gpb0-2";
> -		samsung,pin-function = <4>;
> -		samsung,pin-pud = <3>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  
>  	i2s1_bus: i2s1-bus {
>  		samsung,pins = "gpd4-0", "gpd4-1", "gpd4-2",
>  				"gpd4-3", "gpd4-4";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <1>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  
>  	pcm1_bus: pcm1-bus {
>  		samsung,pins = "gpd4-0", "gpd4-1", "gpd4-2",
>  				"gpd4-3", "gpd4-4";
> -		samsung,pin-function = <3>;
> -		samsung,pin-pud = <1>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  
>  	spdif_bus: spdif-bus {
>  		samsung,pins = "gpd4-3", "gpd4-4";
> -		samsung,pin-function = <4>;
> -		samsung,pin-pud = <1>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  
>  	fimc_is_spi_pin0: fimc-is-spi-pin0 {
>  		samsung,pins = "gpc3-3", "gpc3-2", "gpc3-1", "gpc3-0";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <0>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  
>  	fimc_is_spi_pin1: fimc-is-spi-pin1 {
>  		samsung,pins = "gpc3-7", "gpc3-6", "gpc3-5", "gpc3-4";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <0>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  
>  	uart0_bus: uart0-bus {
>  		samsung,pins = "gpd0-3", "gpd0-2", "gpd0-1", "gpd0-0";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>  	};
>  
>  	hs_i2c2_bus: hs-i2c2-bus {
>  		samsung,pins = "gpd0-3", "gpd0-2";
> -		samsung,pin-function = <3>;
> -		samsung,pin-pud = <3>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  
>  	uart2_bus: uart2-bus {
>  		samsung,pins = "gpd1-5", "gpd1-4";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>  	};
>  
>  	uart1_bus: uart1-bus {
>  		samsung,pins = "gpd1-3", "gpd1-2", "gpd1-1", "gpd1-0";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>  	};
>  
>  	hs_i2c3_bus: hs-i2c3-bus {
>  		samsung,pins = "gpd1-3", "gpd1-2";
> -		samsung,pin-function = <3>;
> -		samsung,pin-pud = <3>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  
>  	hs_i2c0_bus: hs-i2c0-bus {
>  		samsung,pins = "gpd2-1", "gpd2-0";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <3>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  
>  	hs_i2c1_bus: hs-i2c1-bus {
>  		samsung,pins = "gpd2-3", "gpd2-2";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <3>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  
>  	pwm0_out: pwm0-out {
>  		samsung,pins = "gpd2-4";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <0>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  
>  	pwm1_out: pwm1-out {
>  		samsung,pins = "gpd2-5";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <0>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  
>  	pwm2_out: pwm2-out {
>  		samsung,pins = "gpd2-6";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <0>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  
>  	pwm3_out: pwm3-out {
>  		samsung,pins = "gpd2-7";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <0>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  
>  	spi1_bus: spi1-bus {
>  		samsung,pins = "gpd6-2", "gpd6-4", "gpd6-5";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <3>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  
>  	hs_i2c7_bus: hs-i2c7-bus {
>  		samsung,pins = "gpd2-7", "gpd2-6";
> -		samsung,pin-function = <4>;
> -		samsung,pin-pud = <3>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  
>  	spi0_bus: spi0-bus {
>  		samsung,pins = "gpd8-0", "gpd6-0", "gpd6-1";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <3>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  
>  	hs_i2c10_bus: hs-i2c10-bus {
>  		samsung,pins = "gpg3-1", "gpg3-0";
> -		samsung,pin-function = <4>;
> -		samsung,pin-pud = <3>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  
>  	hs_i2c11_bus: hs-i2c11-bus {
>  		samsung,pins = "gpg3-3", "gpg3-2";
> -		samsung,pin-function = <4>;
> -		samsung,pin-pud = <3>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  
>  	spi3_bus: spi3-bus {
>  		samsung,pins = "gpg3-4", "gpg3-6", "gpg3-7";
> -		samsung,pin-function = <3>;
> -		samsung,pin-pud = <3>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  
>  	spi4_bus: spi4-bus {
>  		samsung,pins = "gpv7-1", "gpv7-3", "gpv7-4";
> -		samsung,pin-function = <3>;
> -		samsung,pin-pud = <3>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  
>  	fimc_is_uart: fimc-is-uart {
>  		samsung,pins = "gpc1-1", "gpc0-7";
> -		samsung,pin-function = <3>;
> -		samsung,pin-pud = <0>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  
>  	fimc_is_ch0_i2c: fimc-is-ch0_i2c {
>  		samsung,pins = "gpc2-1", "gpc2-0";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <0>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  
>  	fimc_is_ch0_mclk: fimc-is-ch0_mclk {
>  		samsung,pins = "gpd7-0";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <0>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  
>  	fimc_is_ch1_i2c: fimc-is-ch1-i2c {
>  		samsung,pins = "gpc2-3", "gpc2-2";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <0>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  
>  	fimc_is_ch1_mclk: fimc-is-ch1-mclk {
>  		samsung,pins = "gpd7-1";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <0>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  
>  	fimc_is_ch2_i2c: fimc-is-ch2-i2c {
>  		samsung,pins = "gpc2-5", "gpc2-4";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <0>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  
>  	fimc_is_ch2_mclk: fimc-is-ch2-mclk {
>  		samsung,pins = "gpd7-2";
> -		samsung,pin-function = <2>;
> -		samsung,pin-pud = <0>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  };
>  
> @@ -797,8 +799,8 @@
>  
>  	hs_i2c5_bus: hs-i2c5-bus {
>  		samsung,pins = "gpj1-1", "gpj1-0";
> -		samsung,pin-function = <4>;
> -		samsung,pin-pud = <3>;
> -		samsung,pin-drv = <0>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
>  	};
>  };
> 
