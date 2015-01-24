From: balbi@ti.com (Felipe Balbi)
Date: Fri, 23 Jan 2015 20:25:57 -0600
Subject: [PATCH 3/4] clk: ti: 43xx: add debugss clocks to DT_CLK() table
In-Reply-To: <1422054704-14915-4-git-send-email-balbi@ti.com>
References: <1422054704-14915-1-git-send-email-balbi@ti.com>
 <1422054704-14915-4-git-send-email-balbi@ti.com>
Message-ID: <20150124022557.GA16649@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 23, 2015 at 05:11:43PM -0600, Felipe Balbi wrote:
> without these entries, omap_hwmod will not be
> able to find debugss clocks.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/clk/ti/clk-43xx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clk/ti/clk-43xx.c b/drivers/clk/ti/clk-43xx.c
> index 3795fce8a830..46a597c815c9 100644
> --- a/drivers/clk/ti/clk-43xx.c
> +++ b/drivers/clk/ti/clk-43xx.c
> @@ -83,6 +83,12 @@ static struct ti_dt_clk am43xx_clks[] = {
>  	DT_CLK(NULL, "gfx_fck_div_ck", "gfx_fck_div_ck"),
>  	DT_CLK(NULL, "timer_32k_ck", "clkdiv32k_ick"),
>  	DT_CLK(NULL, "timer_sys_ck", "sys_clkin_ck"),
> +	DT_CLK(NULL, "trace_clk_div_ck", "trace_clk_div_ck"),
> +	DT_CLK(NULL, "trace_pm_clk_mux_ck", "trace_pm_clk_mux_ck"),

hmmm, this should be trace_pmd_clk_mux_ck. How did this even work ? I'll
fix and retest.

Won't resend until tomorrow though.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150123/9bbb28bf/attachment.sig>
