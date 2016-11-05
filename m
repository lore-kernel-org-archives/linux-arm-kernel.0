From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 5 Nov 2016 17:05:07 +0800
Subject: [PATCH 3/3] clk: imx: clk-imx6ul: add clk support for imx6ull
In-Reply-To: <1477969343-19887-4-git-send-email-peter.chen@nxp.com>
References: <1477969343-19887-1-git-send-email-peter.chen@nxp.com>
 <1477969343-19887-4-git-send-email-peter.chen@nxp.com>
Message-ID: <20161105090506.GH5597@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 01, 2016 at 11:02:23AM +0800, Peter Chen wrote:
> From: Bai Ping <ping.bai@nxp.com>
> 
> imx6ull is the derived SoC from imx6ul
> 
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> ---
>  drivers/clk/imx/clk-imx6ul.c             | 74 +++++++++++++++++++++++++++-----
>  include/dt-bindings/clock/imx6ul-clock.h | 15 ++++++-
>  2 files changed, 77 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
> index d1d7787..ceb99a7 100644
> --- a/drivers/clk/imx/clk-imx6ul.c
> +++ b/drivers/clk/imx/clk-imx6ul.c
> @@ -64,6 +64,11 @@ static const char *perclk_sels[] = { "ipg", "osc", };
>  static const char *lcdif_sels[] = { "lcdif_podf", "ipp_di0", "ipp_di1", "ldb_di0", "ldb_di1", };
>  static const char *csi_sels[] = { "osc", "pll2_pfd2_396m", "pll3_120m", "pll3_pfd1_540m", };
>  static const char *sim_sels[] = { "sim_podf", "ipp_di0", "ipp_di1", "ldb_di0", "ldb_di1", };
> +/* epdc_pre_sels, epdc_sels, esai_sels only exists on i.MX6ULL */
> +static const char *epdc_pre_sels[] = { "pll2_bus", "pll3_usb_otg", "pll5_video_div", "pll2_pfd0_352m", "pll2_pfd2_396m", "pll3_pfd2_508m", };
> +static const char *esai_sels[] = { "pll4_audio_div", "pll3_pfd2_508m", "pll5_video_div", "pll3_usb_otg", };
> +static const char *epdc_sels[] = { "epdc_podf", "ipp_di0", "ipp_di1", "ldb_di0", "ldb_di1", };
> +

The new line is not needed.  There is already one below.

>  
>  static struct clk *clks[IMX6UL_CLK_END];
>  static struct clk_onecell_data clk_data;

<snip>

> diff --git a/include/dt-bindings/clock/imx6ul-clock.h b/include/dt-bindings/clock/imx6ul-clock.h
> index fd8aee8..563fd5b 100644
> --- a/include/dt-bindings/clock/imx6ul-clock.h
> +++ b/include/dt-bindings/clock/imx6ul-clock.h
> @@ -236,6 +236,19 @@
>  #define IMX6UL_CLK_PLL3_120M		223
>  #define IMX6UL_CLK_KPP			224
>  
> -#define IMX6UL_CLK_END			225
> +/* For i.MX6ULL */
> +#define IMX6UL_CLK_ESAI_PRED		225
> +#define IMX6UL_CLK_ESAI_PODF		226
> +#define IMX6UL_CLK_ESAI_EXTAL		227
> +#define IMX6UL_CLK_ESAI_MEM		228
> +#define IMX6UL_CLK_ESAI_IPG		229
> +#define IMX6UL_CLK_DCP_CLK		230
> +#define IMX6UL_CLK_EPDC_PRE_SEL		231
> +#define IMX6UL_CLK_EPDC_SEL		232
> +#define IMX6UL_CLK_EPDC_PODF		233
> +#define IMX6UL_CLK_EPDC_ACLK		234
> +#define IMX6UL_CLK_EPDC_PIX		235
> +#define IMX6UL_CLK_ESAI_SEL		236

Can we have these imx6ull only clocks named after IMX6ULL_xxx?

Shawn

> +#define IMX6UL_CLK_END			237
>  
>  #endif /* __DT_BINDINGS_CLOCK_IMX6UL_H */
> -- 
> 2.7.4
> 
