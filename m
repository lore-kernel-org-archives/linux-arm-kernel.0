From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue, 27 Mar 2018 11:00:49 +0200
Subject: [PATCH v2 7/7] ARM64: dts: meson-axg: add an 32K alt aoclk
In-Reply-To: <20180323143816.200573-8-yixun.lan@amlogic.com>
References: <20180323143816.200573-1-yixun.lan@amlogic.com>
 <20180323143816.200573-8-yixun.lan@amlogic.com>
Message-ID: <1522141249.2632.25.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-03-23 at 22:38 +0800, Yixun Lan wrote:
> The ao_clk81 in AO domain have two clock source,
> one from a 32K alt crystal we name it as ao_alt_clk,
> another is the clk81 signal from EE domain.
> 
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index b3d394f5d95a..48584d5a329b 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -109,6 +109,13 @@
>  		#clock-cells = <0>;
>  	};
>  
> +	ao_alt_xtal: ao_alt_xtal-clk {
> +		compatible = "fixed-clock";
> +		clock-frequency = <32000000>;
> +		clock-output-names = "ao_alt_xtal";
> +		#clock-cells = <0>;
> +	};

In DT, we seem to be using 'ao' and 'AO' to designate the Always On domain.
Maybe we should be try be consistent about this.

Anyway, this patch looks good but does not need to be part of the clkc_ao
series, it could go in independently.

Acked-by: Jerome Brunet <jbrunet@baylibre.com>

> +
>  	soc {
>  		compatible = "simple-bus";
>  		#address-cells = <2>;
