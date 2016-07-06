From: mturquette@baylibre.com (Michael Turquette)
Date: Wed, 06 Jul 2016 15:23:20 -0700
Subject: [PATCH v2 1/2] clk: hi6220: Change syspll and media_syspll clk to
 1.19GHz
In-Reply-To: <1467189955-21694-1-git-send-email-guodong.xu@linaro.org>
References: <1467189955-21694-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <146784380027.73491.17727471600536823074@resonance>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Guodong Xu (2016-06-29 01:45:54)
> From: Xinliang Liu <xinliang.liu@linaro.org>
> 
> In the bootloader of HiKey/96boards, syspll and media_syspll clk
> was initialized to 1.19GHz. So, here changes it in kernel accordingly.
> 
> 1.19GHz was chosen over 1.2GHz because at 1.19GHz we get more precise
> HDMI pixel clock (1.19G/16 = 74.4MHz) for 1280x720p at 60Hz HDMI
> (74.25MHz required by standards). Closer pixel clock means better
> compatibility to HDMI monitors.
> 
> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
> Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>

Applied.

Regards,
Mike

> ---
>  drivers/clk/hisilicon/clk-hi6220.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/hisilicon/clk-hi6220.c b/drivers/clk/hisilicon/clk-hi6220.c
> index f02cb41..a36ffcb 100644
> --- a/drivers/clk/hisilicon/clk-hi6220.c
> +++ b/drivers/clk/hisilicon/clk-hi6220.c
> @@ -34,8 +34,8 @@ static struct hisi_fixed_rate_clock hi6220_fixed_rate_clks[] __initdata = {
>         { HI6220_PLL_BBP,       "bbppll0",      NULL, 0, 245760000, },
>         { HI6220_PLL_GPU,       "gpupll",       NULL, 0, 1000000000,},
>         { HI6220_PLL1_DDR,      "ddrpll1",      NULL, 0, 1066000000,},
> -       { HI6220_PLL_SYS,       "syspll",       NULL, 0, 1200000000,},
> -       { HI6220_PLL_SYS_MEDIA, "media_syspll", NULL, 0, 1200000000,},
> +       { HI6220_PLL_SYS,       "syspll",       NULL, 0, 1190400000,},
> +       { HI6220_PLL_SYS_MEDIA, "media_syspll", NULL, 0, 1190400000,},
>         { HI6220_DDR_SRC,       "ddr_sel_src",  NULL, 0, 1200000000,},
>         { HI6220_PLL_MEDIA,     "media_pll",    NULL, 0, 1440000000,},
>         { HI6220_PLL_DDR,       "ddrpll0",      NULL, 0, 1600000000,},
> -- 
> 1.9.1
> 
