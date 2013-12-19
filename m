From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 19 Dec 2013 11:37:08 -0800
Subject: [PATCH Resend 1/1] clk: exynos5250: Add CLK_SET_RATE_PARENT flag
 to mout_apll
In-Reply-To: <1387442019-2445-1-git-send-email-sachin.kamat@linaro.org>
References: <1387442019-2445-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <20131219193708.18119.53403@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sachin Kamat (2013-12-19 00:33:39)
> Add CLK_SET_RATE_PARENT flag to mout_apll clock. This will let us set the
> clock rate in the cpufreq driver.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Ack.

Regards,
Mike

> ---
>  drivers/clk/samsung/clk-exynos5250.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
> index 80f652053cb5..11178b1ad735 100644
> --- a/drivers/clk/samsung/clk-exynos5250.c
> +++ b/drivers/clk/samsung/clk-exynos5250.c
> @@ -303,7 +303,8 @@ static struct samsung_mux_clock exynos5250_mux_clks[] __initdata = {
>         /*
>          * CMU_CPU
>          */
> -       MUX_A(none, "mout_apll", mout_apll_p, SRC_CPU, 0, 1, "mout_apll"),
> +       MUX_FA(none, "mout_apll", mout_apll_p, SRC_CPU, 0, 1,
> +                                       CLK_SET_RATE_PARENT, 0, "mout_apll"),
>         MUX_A(none, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1, "mout_cpu"),
>  
>         /*
> -- 
> 1.7.9.5
> 
