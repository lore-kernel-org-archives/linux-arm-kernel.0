From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 25 Feb 2014 00:43:27 -0800
Subject: [PATCH v8 06/14] CLK: TI: OMAP3: Get rid of unused USB Host dummy
 clocks
In-Reply-To: <1392896409-5101-7-git-send-email-rogerq@ti.com>
References: <1392896409-5101-1-git-send-email-rogerq@ti.com>
 <1392896409-5101-7-git-send-email-rogerq@ti.com>
Message-ID: <20140225084327.22529.86075@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Roger Quadros (2014-02-20 03:40:01)
> The OMAP USB Host MFD driver no longer expects these non-existing
> clocks from the OMAP3 platform, so get rid of them.

Looks good to me.

Regards,
Mike

> 
> CC: Tero Kristo <t-kristo@ti.com>
> CC: Mike Turquette <mturquette@linaro.org>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/mach-omap2/cclock3xxx_data.c | 4 ----
>  drivers/clk/ti/clk-3xxx.c             | 4 ----
>  2 files changed, 8 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c b/arch/arm/mach-omap2/cclock3xxx_data.c
> index 3b05aea..4299a55 100644
> --- a/arch/arm/mach-omap2/cclock3xxx_data.c
> +++ b/arch/arm/mach-omap2/cclock3xxx_data.c
> @@ -3495,10 +3495,6 @@ static struct omap_clk omap3xxx_clks[] = {
>         CLK(NULL,       "dss_tv_fck",   &dss_tv_fck),
>         CLK(NULL,       "dss_96m_fck",  &dss_96m_fck),
>         CLK(NULL,       "dss2_alwon_fck",       &dss2_alwon_fck),
> -       CLK(NULL,       "utmi_p1_gfclk",        &dummy_ck),
> -       CLK(NULL,       "utmi_p2_gfclk",        &dummy_ck),
> -       CLK(NULL,       "xclk60mhsp1_ck",       &dummy_ck),
> -       CLK(NULL,       "xclk60mhsp2_ck",       &dummy_ck),
>         CLK(NULL,       "init_60m_fclk",        &dummy_ck),
>         CLK(NULL,       "gpt1_fck",     &gpt1_fck),
>         CLK(NULL,       "aes2_ick",     &aes2_ick),
> diff --git a/drivers/clk/ti/clk-3xxx.c b/drivers/clk/ti/clk-3xxx.c
> index d323023..0d1750a 100644
> --- a/drivers/clk/ti/clk-3xxx.c
> +++ b/drivers/clk/ti/clk-3xxx.c
> @@ -130,10 +130,6 @@ static struct ti_dt_clk omap3xxx_clks[] = {
>         DT_CLK(NULL, "dss_tv_fck", "dss_tv_fck"),
>         DT_CLK(NULL, "dss_96m_fck", "dss_96m_fck"),
>         DT_CLK(NULL, "dss2_alwon_fck", "dss2_alwon_fck"),
> -       DT_CLK(NULL, "utmi_p1_gfclk", "dummy_ck"),
> -       DT_CLK(NULL, "utmi_p2_gfclk", "dummy_ck"),
> -       DT_CLK(NULL, "xclk60mhsp1_ck", "dummy_ck"),
> -       DT_CLK(NULL, "xclk60mhsp2_ck", "dummy_ck"),
>         DT_CLK(NULL, "init_60m_fclk", "dummy_ck"),
>         DT_CLK(NULL, "gpt1_fck", "gpt1_fck"),
>         DT_CLK(NULL, "aes2_ick", "aes2_ick"),
> -- 
> 1.8.3.2
> 
