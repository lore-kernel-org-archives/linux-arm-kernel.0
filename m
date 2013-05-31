From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Fri, 31 May 2013 12:44:23 +0200
Subject: [PATCH 4/4] ARM: imx: clk-imx6q: correct some clocks' initial
 enable_count
In-Reply-To: <1370034115-24006-4-git-send-email-b20788@freescale.com>
References: <1370034115-24006-1-git-send-email-b20788@freescale.com>
 <1370034115-24006-4-git-send-email-b20788@freescale.com>
Message-ID: <51A87F07.3080402@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31.05.2013 23:01, Anson Huang wrote:
> Those always-on clocks need to be added into init_on array, this
> is to avoid confusion when we dump the clock tree, the result
> shows that some clocks are on but their enabled_count is 0.
>
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
>   arch/arm/mach-imx/clk-imx6q.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> index 390950e..66831a6 100644
> --- a/arch/arm/mach-imx/clk-imx6q.c
> +++ b/arch/arm/mach-imx/clk-imx6q.c
> @@ -247,7 +247,7 @@ static struct clk *clk[clk_max];
>   static struct clk_onecell_data clk_data;
>
>   static enum mx6q_clks const clks_init_on[] __initconst = {
> -	mmdc_ch0_axi, rom, pll1_sys,
> +	mmdc_ch0_axi, rom, pll1_sys, ckil, ocram, axi, ipg_per, mx6fast1, per2_main, aips_tz1, aips_tz2, mmdc_ch0_ipg, mmdc_ch1_ipg,


All clocks added with patch 1/4 but not listed here will be disabled by 
the kernel, then? Is this intended? I just ask because it might change 
the boards behavior in case the boot loader touches one of the clocks 
from 1/4 and now they are disabled by the kernel.

Best regards

Dirk
