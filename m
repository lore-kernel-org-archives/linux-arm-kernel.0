From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 11 Apr 2013 13:09:22 -0700
Subject: [PATCH] clk: tegra: fix enum tegra114_clk to match binding
In-Reply-To: <1365118274-5823-1-git-send-email-swarren@wwwdotorg.org>
References: <1365118274-5823-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130411200922.7915.95842@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Warren (2013-04-04 16:31:13)
> From: Stephen Warren <swarren@nvidia.com>
> 
> A gap exists in the binding's clock ID definitions. Fix the clock driver
> to be consistent. This allows pclk to be looked up through device tree
> and prevents:
> 
> ERROR: could not get clock /pmc:pclk(0)
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Acked-by: Mike Turquette <mturquette@linaro.org>

> ---
> I have already applied this to Tegra's for-3.10/clk branch, since it's
> such a trivial fix.
> 
>  drivers/clk/tegra/clk-tegra114.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
> index 0db81dd..d78e16e 100644
> --- a/drivers/clk/tegra/clk-tegra114.c
> +++ b/drivers/clk/tegra/clk-tegra114.c
> @@ -760,7 +760,7 @@ enum tegra114_clk {
>         pll_re_vco, pll_re_out, pll_e_out0, spdif_in_sync, i2s0_sync,
>         i2s1_sync, i2s2_sync, i2s3_sync, i2s4_sync, vimclk_sync, audio0,
>         audio1, audio2, audio3, audio4, spdif, clk_out_1, clk_out_2, clk_out_3,
> -       blink, xusb_host_src, xusb_falcon_src, xusb_fs_src, xusb_ss_src,
> +       blink, xusb_host_src = 252, xusb_falcon_src, xusb_fs_src, xusb_ss_src,
>         xusb_dev_src, xusb_dev, xusb_hs_src, sclk, hclk, pclk, cclk_g, cclk_lp,
>  
>         /* Mux clocks */
> -- 
> 1.7.10.4
