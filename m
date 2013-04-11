From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 11 Apr 2013 13:09:09 -0700
Subject: [PATCH] clk: tegra: Fix cdev1 and cdev2 IDs
In-Reply-To: <1365118019-5748-1-git-send-email-swarren@wwwdotorg.org>
References: <1365118019-5748-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130411200909.7915.45809@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Warren (2013-04-04 16:26:58)
> From: Prashant Gaikwad <pgaikwad@nvidia.com>
> 
> Correct IDs for cdev1 and cdev2 are 94 and 93 respectively.
> 
> Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
> [swarren: split into separate driver and device-tree patches]
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Acked-by: Mike Turquette <mturquette@linaro.org>

> ---
> I split this patch in two when applying it. Reposting just so everyone
> can see exactly what I applied. This is the patch from Tegra's
> for-3.10/clk branch.
> 
>  Documentation/devicetree/bindings/clock/nvidia,tegra20-car.txt |    4 ++--
>  drivers/clk/tegra/clk-tegra20.c                                |    2 +-
>  drivers/clk/tegra/clk-tegra30.c                                |    2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.txt
> index 0921fac..e885680 100644
> --- a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.txt
> +++ b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.txt
> @@ -120,8 +120,8 @@ Required properties :
>    90   clk_d
>    91   unassigned
>    92   sus
> -  93   cdev1
> -  94   cdev2
> +  93   cdev2
> +  94   cdev1
>    95   unassigned
>  
>    96   uart2
> diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
> index f87bd4a..a7dc0a9 100644
> --- a/drivers/clk/tegra/clk-tegra20.c
> +++ b/drivers/clk/tegra/clk-tegra20.c
> @@ -236,7 +236,7 @@ enum tegra20_clk {
>         dvc, dsi, mipi = 50, hdmi, csi, tvdac, i2c2, uartc, emc = 57, usb2,
>         usb3, mpe, vde, bsea, bsev, speedo, uartd, uarte, i2c3, sbc4, sdmmc3,
>         pex, owr, afi, csite, pcie_xclk, avpucq = 75, la, irama = 84, iramb,
> -       iramc, iramd, cram2, audio_2x, clk_d, csus = 92, cdev1, cdev2,
> +       iramc, iramd, cram2, audio_2x, clk_d, csus = 92, cdev2, cdev1,
>         uartb = 96, vfir, spdif_in, spdif_out, vi, vi_sensor, tvo, cve,
>         osc, clk_32k, clk_m, sclk, cclk, hclk, pclk, blink, pll_a, pll_a_out0,
>         pll_c, pll_c_out1, pll_d, pll_d_out0, pll_e, pll_m, pll_m_out1,
> diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
> index b8b241d..181a6ee 100644
> --- a/drivers/clk/tegra/clk-tegra30.c
> +++ b/drivers/clk/tegra/clk-tegra30.c
> @@ -330,7 +330,7 @@ enum tegra30_clk {
>         usb3, mpe, vde, bsea, bsev, speedo, uartd, uarte, i2c3, sbc4, sdmmc3,
>         pcie, owr, afi, csite, pciex, avpucq, la, dtv = 79, ndspeed, i2cslow,
>         dsib, irama = 84, iramb, iramc, iramd, cram2, audio_2x = 90, csus = 92,
> -       cdev1, cdev2, cpu_g = 96, cpu_lp, gr3d2, mselect, tsensor, i2s3, i2s4,
> +       cdev2, cdev1, cpu_g = 96, cpu_lp, gr3d2, mselect, tsensor, i2s3, i2s4,
>         i2c4, sbc5, sbc6, d_audio, apbif, dam0, dam1, dam2, hda2codec_2x,
>         atomics, audio0_2x, audio1_2x, audio2_2x, audio3_2x, audio4_2x,
>         spdif_2x, actmon, extern1, extern2, extern3, sata_oob, sata, hda,
> -- 
> 1.7.10.4
