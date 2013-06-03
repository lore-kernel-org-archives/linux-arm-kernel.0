From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 3 Jun 2013 09:29:41 +0800
Subject: [PATCH 2/4] ARM: imx: clk-imx6q: per1_bch's parent is wrong
In-Reply-To: <1370034115-24006-2-git-send-email-b20788@freescale.com>
References: <1370034115-24006-1-git-send-email-b20788@freescale.com>
 <1370034115-24006-2-git-send-email-b20788@freescale.com>
Message-ID: <20130603012939.GB13970@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 31, 2013 at 05:01:53PM -0400, Anson Huang wrote:
> per1_bch is sourced from ahb, previous parent
> info is incorrect.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

Applied, thanks.

> ---
>  arch/arm/mach-imx/clk-imx6q.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> index dfb77c1..c501947 100644
> --- a/arch/arm/mach-imx/clk-imx6q.c
> +++ b/arch/arm/mach-imx/clk-imx6q.c
> @@ -518,7 +518,7 @@ int __init mx6q_clocks_init(void)
>  	clk[openvg_axi]   = imx_clk_gate2("openvg_axi",    "axi",               base + 0x74, 30);
>  	clk[pcie_axi]     = imx_clk_gate2("pcie_axi",      "pcie_axi_sel",      base + 0x78, 0);
>  	clk[mx6fast1]     = imx_clk_gate2("mx6fast1",      "ahb",               base + 0x78, 8);
> -	clk[per1_bch]     = imx_clk_gate2("per1_bch",      "usdhc3",            base + 0x78, 12);
> +	clk[per1_bch]     = imx_clk_gate2("per1_bch",      "ahb",               base + 0x78, 12);
>  	clk[per2_main]    = imx_clk_gate2("per2_main",     "ahb",               base + 0x78, 14);
>  	clk[pwm1]         = imx_clk_gate2("pwm1",          "ipg_per",           base + 0x78, 16);
>  	clk[pwm2]         = imx_clk_gate2("pwm2",          "ipg_per",           base + 0x78, 18);
> -- 
> 1.7.9.5
> 
> 
