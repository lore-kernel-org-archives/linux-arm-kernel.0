From: tony@atomide.com (Tony Lindgren)
Date: Fri, 23 Oct 2015 18:21:49 -0700
Subject: [PATCH 2/4] clk: ti816x: Add missing dmtimer clkdev entries
In-Reply-To: <5628A9F7.9090105@baylibre.com>
References: <5628A9F7.9090105@baylibre.com>
Message-ID: <20151024012148.GB3078@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Neil Armstrong <narmstrong@baylibre.com> [151022 02:19]:
> Add missing clkdev dmtimer related entries for dm816x.
> 32Khz and ext sources were missing.
> 
> Cc: Brian Hutchinson <b.hutchman@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Tero should queue this one:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  drivers/clk/ti/clk-816x.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/ti/clk-816x.c b/drivers/clk/ti/clk-816x.c
> index 1dfad0c..2a5d84f 100644
> --- a/drivers/clk/ti/clk-816x.c
> +++ b/drivers/clk/ti/clk-816x.c
> @@ -20,6 +20,8 @@ static struct ti_dt_clk dm816x_clks[] = {
>  	DT_CLK(NULL, "sys_clkin", "sys_clkin_ck"),
>  	DT_CLK(NULL, "timer_sys_ck", "sys_clkin_ck"),
>  	DT_CLK(NULL, "sys_32k_ck", "sys_32k_ck"),
> +	DT_CLK(NULL, "timer_32k_ck", "sysclk18_ck"),
> +	DT_CLK(NULL, "timer_ext_ck", "tclkin_ck"),
>  	DT_CLK(NULL, "mpu_ck", "mpu_ck"),
>  	DT_CLK(NULL, "timer1_fck", "timer1_fck"),
>  	DT_CLK(NULL, "timer2_fck", "timer2_fck"),
> -- 
> 1.9.1
