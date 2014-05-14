From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 14 May 2014 12:04:06 +0300
Subject: [PATCH 09/10] ARM: dts: OMAP4: clk: Add clk node for DES IP
In-Reply-To: <1398466968-29506-10-git-send-email-joelf@ti.com>
References: <1398466968-29506-1-git-send-email-joelf@ti.com>
 <1398466968-29506-10-git-send-email-joelf@ti.com>
Message-ID: <53733186.1030306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/26/2014 02:02 AM, Joel Fernandes wrote:
> From: Lokesh Vutla <lokeshvutla@ti.com>
>
> DES IP already has main and interface clk as des_fck.
> Node for des_fck is missing in clk tree. Adding the same.
>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Joel Fernandes <joelf@ti.com>
> ---
>   arch/arm/boot/dts/omap44xx-clocks.dtsi |    8 ++++++++
>   drivers/clk/ti/clk-44xx.c              |    1 +
>   2 files changed, 9 insertions(+)
>
> diff --git a/arch/arm/boot/dts/omap44xx-clocks.dtsi b/arch/arm/boot/dts/omap44xx-clocks.dtsi
> index c821ff5..83cf189 100644
> --- a/arch/arm/boot/dts/omap44xx-clocks.dtsi
> +++ b/arch/arm/boot/dts/omap44xx-clocks.dtsi
> @@ -985,6 +985,14 @@
>   		reg = <0x15a8>;
>   	};
>
> +	des_fck: des_fck at 4a0095b0 {
> +	       #clock-cells = <0>;
> +	       compatible = "gate-clock";
> +	       clocks = <&l3_div_ck>;
> +	       bit-shift = <1>;
> +	       reg = <0x4a0095b0 0x4>;

NAK.

Obsolete compatible type used, also obsolete register format used.

-Tero

> +	};
> +
>   	dss_sys_clk: dss_sys_clk {
>   		#clock-cells = <0>;
>   		compatible = "ti,gate-clock";
> diff --git a/drivers/clk/ti/clk-44xx.c b/drivers/clk/ti/clk-44xx.c
> index 02517a8..85d97c3 100644
> --- a/drivers/clk/ti/clk-44xx.c
> +++ b/drivers/clk/ti/clk-44xx.c
> @@ -120,6 +120,7 @@ static struct ti_dt_clk omap44xx_clks[] = {
>   	DT_CLK(NULL, "syc_clk_div_ck", "syc_clk_div_ck"),
>   	DT_CLK(NULL, "aes1_fck", "aes1_fck"),
>   	DT_CLK(NULL, "aes2_fck", "aes2_fck"),
> +	DT_CLK(NULL, "des_fck", "des_fck"),
>   	DT_CLK(NULL, "dmic_sync_mux_ck", "dmic_sync_mux_ck"),
>   	DT_CLK(NULL, "func_dmic_abe_gfclk", "func_dmic_abe_gfclk"),
>   	DT_CLK(NULL, "dss_sys_clk", "dss_sys_clk"),
>
