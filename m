From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 23 Oct 2013 05:19:41 -0400
Subject: [PATCH 2/8] ARM: imx: add clocking support code for the IMX50 SoC
In-Reply-To: <1382076260-6422-3-git-send-email-gerg@uclinux.org>
References: <1382076260-6422-1-git-send-email-gerg@uclinux.org>
 <1382076260-6422-3-git-send-email-gerg@uclinux.org>
Message-ID: <20131023091941.GE24520@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg,

On Fri, Oct 18, 2013 at 04:04:14PM +1000, gerg at uclinux.org wrote:
> From: Greg Ungerer <gerg@uclinux.org>
> 
> Add code to support the specific clock tree of the Freescale IMX50 SoC.
> It can use much of the common IMX51/IMX53 clocking code.
> 
> Signed-off-by: Greg Ungerer <gerg@uclinux.org>
> ---
>  arch/arm/mach-imx/clk-imx51-imx53.c | 79 +++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-imx/common.h          |  3 ++
>  2 files changed, 82 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
> index 7c0dc45..ea4523a 100644
> --- a/arch/arm/mach-imx/clk-imx51-imx53.c
> +++ b/arch/arm/mach-imx/clk-imx51-imx53.c
> @@ -363,6 +363,80 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
>  	clk_prepare_enable(clk[tmax3]); /* esdhc1, esdhc4 */
>  }
>  
> +int __init mx50_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
> +			unsigned long rate_ckih1, unsigned long rate_ckih2)
> +{
> +	int i;
> +	unsigned long r;
> +	struct device_node *np;
> +
> +	clk[pll1_sw] = imx_clk_pllv2("pll1_sw", "osc", MX53_DPLL1_BASE);
> +	clk[pll2_sw] = imx_clk_pllv2("pll2_sw", "osc", MX53_DPLL2_BASE);
> +	clk[pll3_sw] = imx_clk_pllv2("pll3_sw", "osc", MX53_DPLL3_BASE);

What about the apll and it's derivatives?

thx,

Jason.
