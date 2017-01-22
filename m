From: jacobchen110@gmail.com (Jacob Chen)
Date: Sun, 22 Jan 2017 17:02:17 +0800
Subject: [PATCH v2 3/3] clk: rockchip: rk3288: make all niu clocks critical
In-Reply-To: <1484718161-27702-3-git-send-email-jacob-chen@iotwrt.com>
References: <1484718161-27702-1-git-send-email-jacob-chen@iotwrt.com>
 <1484718161-27702-3-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <CAFLEztTwyjqz0-2LriDp2WAyPR-g28RZT3VPA5vfSK5SSHTx8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-01-18 13:42 GMT+08:00 Jacob Chen <jacob-chen@iotwrt.com>:
> NIU clocks are related to the interconnect and it's important to other blocks.
> Since we don't have a driver to handle it, we should always enable it to avoid
> casually close.
>
> Make all of them critical,so that we don't have to each clock on its own
> once things break.
>
> Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
> ---
>  drivers/clk/rockchip/clk-rk3288.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
> index 3d02aa2..c50386c 100644
> --- a/drivers/clk/rockchip/clk-rk3288.c
> +++ b/drivers/clk/rockchip/clk-rk3288.c
> @@ -808,8 +808,15 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
>  static const char *const rk3288_critical_clocks[] __initconst = {
>         "aclk_cpu",
>         "aclk_peri",
> +       "aclk_peri_niu",
> +       "aclk_vio0_niu",
> +       "aclk_vio1_niu",
> +       "aclk_rga_niu",
>         "hclk_peri",
> +       "hclk_vio_niu",
> +       "pclk_alive_niu",
>         "pclk_pd_pmu",
> +       "pclk_pmu_niu",
>  };
>
>  static void __iomem *rk3288_cru_base;
> --
> 2.7.4
>

I just got an another bug that caused by closed niu clock.
Making niu clock always enabled is really useful, it could save me a
lot of time.....

I just wonder why we don't do that before.  Would it have great impact
on power consumption?
