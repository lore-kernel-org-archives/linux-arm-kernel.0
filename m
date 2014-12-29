From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 29 Dec 2014 14:14:25 +0300
Subject: [PATCH 21/30] ARM: shmobile: r8a7794: Add SDHI clocks to device
 tree
In-Reply-To: <8e181633e6ca960491ac502ccd4a4aac482c3ff9.1419812186.git.horms+renesas@verge.net.au>
References: <cover.1419812185.git.horms+renesas@verge.net.au>
 <8e181633e6ca960491ac502ccd4a4aac482c3ff9.1419812186.git.horms+renesas@verge.net.au>
Message-ID: <54A13791.2060201@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12/29/2014 4:43 AM, Simon Horman wrote:

> From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>

> Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> [horms: omitted device nodes; only add clock]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   arch/arm/boot/dts/r8a7794.dtsi            | 20 +++++++++++++++++++-
>   include/dt-bindings/clock/r8a7794-clock.h |  3 +++
>   2 files changed, 22 insertions(+), 1 deletion(-)

> diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
> index 728d719..c376676 100644
> --- a/arch/arm/boot/dts/r8a7794.dtsi
> +++ b/arch/arm/boot/dts/r8a7794.dtsi
> @@ -293,6 +293,21 @@
>   			clock-output-names = "main", "pll0", "pll1", "pll3",
>   					     "lb", "qspi", "sdh", "sd0", "z";
>   		};
> +		/* Variable factor clocks */
> +		sd1_clk: sd2_clk at e6150078 {

    So is it SD1 or SD2 clock?

> +			compatible = "renesas,r8a7794-div6-clock", "renesas,cpg-div6-clock";
> +			reg = <0 0xe6150078 0 4>;
> +			clocks = <&pll1_div2_clk>;
> +			#clock-cells = <0>;
> +			clock-output-names = "sd1";
> +		};
> +		sd2_clk: sd3_clk at e615007c {

    Same question...

> +			compatible = "renesas,r8a7794-div6-clock", "renesas,cpg-div6-clock";
> +			reg = <0 0xe615007c 0 4>;
> +			clocks = <&pll1_div2_clk>;
> +			#clock-cells = <0>;
> +			clock-output-names = "sd2";
> +		};
[...]

WBR, Sergei
