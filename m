From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 24 Nov 2015 11:37:01 +0200
Subject: [PATCH v2 2/4] clk: ti816x: Add missing dmtimer clkdev entries
In-Reply-To: <56461006.5080309@baylibre.com>
References: <56461006.5080309@baylibre.com>
Message-ID: <56542FBD.8090404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/13/2015 06:29 PM, Neil Armstrong wrote:
> Add missing clkdev dmtimer related entries for dm816x.
> 32Khz and ext sources were missing.
>
> Cc: Brian Hutchinson <b.hutchman@gmail.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Your own sign-off should be at the top of the list, fixed this locally 
myself.

Queued for 4.4-rc-fixes, thanks.

-Tero

> ---
>   drivers/clk/ti/clk-816x.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/clk/ti/clk-816x.c b/drivers/clk/ti/clk-816x.c
> index 1dfad0c..2a5d84f 100644
> --- a/drivers/clk/ti/clk-816x.c
> +++ b/drivers/clk/ti/clk-816x.c
> @@ -20,6 +20,8 @@ static struct ti_dt_clk dm816x_clks[] = {
>   	DT_CLK(NULL, "sys_clkin", "sys_clkin_ck"),
>   	DT_CLK(NULL, "timer_sys_ck", "sys_clkin_ck"),
>   	DT_CLK(NULL, "sys_32k_ck", "sys_32k_ck"),
> +	DT_CLK(NULL, "timer_32k_ck", "sysclk18_ck"),
> +	DT_CLK(NULL, "timer_ext_ck", "tclkin_ck"),
>   	DT_CLK(NULL, "mpu_ck", "mpu_ck"),
>   	DT_CLK(NULL, "timer1_fck", "timer1_fck"),
>   	DT_CLK(NULL, "timer2_fck", "timer2_fck"),
>
