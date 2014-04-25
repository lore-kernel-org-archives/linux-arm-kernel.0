From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 25 Apr 2014 15:07:55 +0300
Subject: [PATCH] arm: dts: am33xx-clock: Fix ehrpwm tbclk data.
In-Reply-To: <1398416125-7139-1-git-send-email-sourav.poddar@ti.com>
References: <1398416125-7139-1-git-send-email-sourav.poddar@ti.com>
Message-ID: <535A501B.5080501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/2014 11:55 AM, Sourav Poddar wrote:
> tbclk does not need to be a composite clock, we can simply
> use gate clock for this purpose.
>
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> ---
>   arch/arm/boot/dts/am33xx-clocks.dtsi |   42 ++++++++++------------------------
>   1 file changed, 12 insertions(+), 30 deletions(-)
>
> diff --git a/arch/arm/boot/dts/am33xx-clocks.dtsi b/arch/arm/boot/dts/am33xx-clocks.dtsi
> index 9ccfe50..a45d27f 100644
> --- a/arch/arm/boot/dts/am33xx-clocks.dtsi
> +++ b/arch/arm/boot/dts/am33xx-clocks.dtsi
> @@ -96,46 +96,28 @@
>   		clock-div = <1>;
>   	};
>
> -	ehrpwm0_gate_tbclk: ehrpwm0_gate_tbclk {
> +	ehrpwm0_tbclk: ehrpwm0_tbclk at 44e10664 {
>   		#clock-cells = <0>;
> -		compatible = "ti,composite-no-wait-gate-clock";
> +		compatible = "gate-clock";

ti,gate-clock? Simple "gate-clock" is not supported.

>   		clocks = <&dpll_per_m2_ck>;
> -		ti,bit-shift = <0>;
> -		reg = <0x0664>;
> +		bit-shift = <0>;

Should be ti,bit-shift as above.

> +		reg = <0x44e10664 0x4>;

You are using an obsolete register format here, the one you removed from 
above was correct.

Same comment applies for the rest of this patch.

-Tero

>   	};
>
> -	ehrpwm0_tbclk: ehrpwm0_tbclk {
> +	ehrpwm1_tbclk: ehrpwm1_tbclk at 44e10664 {
>   		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&ehrpwm0_gate_tbclk>;
> -	};
> -
> -	ehrpwm1_gate_tbclk: ehrpwm1_gate_tbclk {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-no-wait-gate-clock";
> +		compatible = "gate-clock";
>   		clocks = <&dpll_per_m2_ck>;
> -		ti,bit-shift = <1>;
> -		reg = <0x0664>;
> -	};
> -
> -	ehrpwm1_tbclk: ehrpwm1_tbclk {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&ehrpwm1_gate_tbclk>;
> +		bit-shift = <1>;
> +		reg = <0x44e10664 0x4>;
>   	};
>
> -	ehrpwm2_gate_tbclk: ehrpwm2_gate_tbclk {
> +	ehrpwm2_tbclk: ehrpwm2_tbclk at 44e10664 {
>   		#clock-cells = <0>;
> -		compatible = "ti,composite-no-wait-gate-clock";
> +		compatible = "gate-clock";
>   		clocks = <&dpll_per_m2_ck>;
> -		ti,bit-shift = <2>;
> -		reg = <0x0664>;
> -	};
> -
> -	ehrpwm2_tbclk: ehrpwm2_tbclk {
> -		#clock-cells = <0>;
> -		compatible = "ti,composite-clock";
> -		clocks = <&ehrpwm2_gate_tbclk>;
> +		bit-shift = <2>;
> +		reg = <0x44e10664 0x4>;
>   	};
>   };
>   &prcm_clocks {
>
