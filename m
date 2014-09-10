From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 10 Sep 2014 10:42:35 -0700
Subject: [PATCH] clk: rockchip: also protect hclk_peri as critical
In-Reply-To: <1950006.Th78Z9O4lJ@diego>
References: <1950006.Th78Z9O4lJ@diego>
Message-ID: <20140910174235.19023.4888@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Heiko St?bner (2014-09-10 08:52:02)
> The dwc2 usb controller also uses agressive clock gating, which in this
> case leads to hclk_peri getting disabled and hanging the system.
> Therefore move it to the critical clocks until we also control that
> part of the system.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Applied to clk-next.

Regards,
Mike

> ---
>  drivers/clk/rockchip/clk-rk3188.c | 1 +
>  drivers/clk/rockchip/clk-rk3288.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
> index 1892c66..9f9937e 100644
> --- a/drivers/clk/rockchip/clk-rk3188.c
> +++ b/drivers/clk/rockchip/clk-rk3188.c
> @@ -602,6 +602,7 @@ static struct rockchip_clk_branch rk3188_clk_branches[] __initdata = {
>  static const char *rk3188_critical_clocks[] __initconst = {
>         "aclk_cpu",
>         "aclk_peri",
> +       "hclk_peri",
>  };
>  
>  static void __init rk3188_common_clk_init(struct device_node *np)
> diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
> index 43e0ad0..c76b16d 100644
> --- a/drivers/clk/rockchip/clk-rk3288.c
> +++ b/drivers/clk/rockchip/clk-rk3288.c
> @@ -683,6 +683,7 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
>  static const char *rk3288_critical_clocks[] __initconst = {
>         "aclk_cpu",
>         "aclk_peri",
> +       "hclk_peri",
>  };
>  
>  static void __init rk3288_clk_init(struct device_node *np)
> -- 
> 2.0.1
> 
> 
