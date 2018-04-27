From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 27 Apr 2018 12:03:26 -0700
Subject: [PATCH v3 2/3] ARM64: dts: meson-axg: add an 32K alt aoclk
In-Reply-To: <20180328030130.240336-3-yixun.lan@amlogic.com> (Yixun Lan's
 message of "Wed, 28 Mar 2018 11:01:29 +0800")
References: <20180328030130.240336-1-yixun.lan@amlogic.com>
 <20180328030130.240336-3-yixun.lan@amlogic.com>
Message-ID: <7hmuxo1ngh.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yixun Lan <yixun.lan@amlogic.com> writes:

> The ao_clk81 in AO domain have two clock source,
> one from a 32K alt crystal we name it as ao_alt_clk,
> another is the clk81 signal from EE domain.
>
> Acked-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

As this one is a stanadlone, I've applied it to v4.18/dt64,

Thanks,

Kevin

> ---
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index b0eff7d7f771..40ca49fb94a6 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -108,6 +108,13 @@
>  		#clock-cells = <0>;
>  	};
>  
> +	ao_alt_xtal: ao_alt_xtal-clk {
> +		compatible = "fixed-clock";
> +		clock-frequency = <32000000>;
> +		clock-output-names = "ao_alt_xtal";
> +		#clock-cells = <0>;
> +	};
> +
>  	soc {
>  		compatible = "simple-bus";
>  		#address-cells = <2>;
