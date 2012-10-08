From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 08 Oct 2012 09:54:31 +0200
Subject: [PATCH v2 2/5] clk: exynos4: register clocks using common clock
 framework
In-Reply-To: <1349629855-4962-3-git-send-email-thomas.abraham@linaro.org>
References: <1349629855-4962-1-git-send-email-thomas.abraham@linaro.org>
 <1349629855-4962-3-git-send-email-thomas.abraham@linaro.org>
Message-ID: <3056568.RZOfOW29pM@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

The whole series looks much better now. Although there is still one more 
thing from my comments to previous version unresolved, see the inline 
comment.

On Monday 08 of October 2012 02:10:52 Thomas Abraham wrote:
> For legacy Exynos4 platforms, the available clocks are statically
> listed and then registered using the common clock framework. On device
> tree enabled exynos platfotms, the device tree is searched and all
> clock nodes found are registered. Support for Exynos4210 and
> Exynos4x12 platforms is included.
> 
> Cc: Mike Turquette <mturquette@ti.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  drivers/clk/samsung/Makefile      |    1 +
>  drivers/clk/samsung/clk-exynos4.c |  647
> +++++++++++++++++++++++++++++++++++++ 2 files changed, 648
> insertions(+), 0 deletions(-)
>  create mode 100644 drivers/clk/samsung/clk-exynos4.c
> 
[snip]
> +			EXYNOS4_CLKSRC_MASK_CAM, 28, "sclk_csis"),
> +	GATECLK(NULL, "sclk_cam0", "div_cam0", 0,
> +			EXYNOS4_CLKSRC_MASK_CAM, 16, NULL),
> +	GATECLK(NULL, "sclk_cam1", "div_cam1", 0,
> +			EXYNOS4_CLKSRC_MASK_CAM, 20, NULL),
> +	GATECLK("exynos4-fimc.0", "sclk_fimc", "div_fimc0", 0,
> +			EXYNOS4_CLKSRC_MASK_CAM, 0, "sclk_fimc"),
> +	GATECLK("exynos4-fimc.1", "sclk_fimc", "div_fimc1", 0,
> +			EXYNOS4_CLKSRC_MASK_CAM, 4, "sclk_fimc"),
> +	GATECLK("exynos4-fimc.2", "sclk_fimc", "div_fimc2", 0,
> +			EXYNOS4_CLKSRC_MASK_CAM, 8, "sclk_fimc"),
> +	GATECLK("exynos4-fimc.3", "sclk_fimc", "div_fimc3", 0,
> +			EXYNOS4_CLKSRC_MASK_CAM, 12, "sclk_fimc"),

You cannot register more than one clock with the same platform name 
(sclk_fimc). Shouldn't these names be appended with an index, just like 
with div_fimc{0,1,2,3}?

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
