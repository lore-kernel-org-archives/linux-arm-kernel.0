From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 22 Oct 2015 19:30:14 +0200
Subject: [PATCH 5/6] ARM: dts: sunxi: Add Allwinner H3 DTSI
In-Reply-To: <1445444428-4652-2-git-send-email-jenskuske@gmail.com>
References: <1445444428-4652-1-git-send-email-jenskuske@gmail.com>
 <1445444428-4652-2-git-send-email-jenskuske@gmail.com>
Message-ID: <20151022193014.59dde965@OPI2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 21 Oct 2015 18:20:27 +0200
Jens Kuske <jenskuske@gmail.com> wrote:

> The Allwinner H3 is a home entertainment system oriented SoC with
> four Cortex-A7 cores and a Mali-400MP2 GPU.
> 
> Signed-off-by: Jens Kuske <jenskuske@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi | 499 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 499 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun8i-h3.dtsi
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> new file mode 100644
> index 0000000..4114e17
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -0,0 +1,499 @@
	[snip]
> +		pll6: clk at 01c20028 {
> +			#clock-cells = <1>;
> +			compatible = "allwinner,sun6i-a31-pll6-clk";
> +			reg = <0x01c20028 0x4>;
> +			clocks = <&osc24M>;
> +			clock-output-names = "pll6", "pll6x2", "pll6d2";
> +		};
> +
> +		pll8: clk at 01c20044 {
> +			#clock-cells = <0>;

Should be <1>

> +			compatible = "allwinner,sun6i-a31-pll6-clk";
> +			reg = <0x01c20044 0x4>;
> +			clocks = <&osc24M>;
> +			clock-output-names = "pll8", "pll8x2";
> +		};
> +
> +		cpu: cpu_clk at 01c20050 {
> +			#clock-cells = <0>;
> +			compatible = "allwinner,sun4i-a10-cpu-clk";
> +			reg = <0x01c20050 0x4>;
> +			clocks = <&osc32k>, <&osc24M>, <&pll1>, <&pll1>;
> +			clock-output-names = "cpu";
> +		};
	[snip]

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
