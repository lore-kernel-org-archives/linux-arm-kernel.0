From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 10 Oct 2017 11:30:19 +0200
Subject: [PATCH] clk: samsung: exynos5433: mark PM functions as
 __maybe_unused
In-Reply-To: <20171010091522.2286344-1-arnd@arndb.de>
References: <CGME20171010091530epcas3p2e03b0e52f91e7dc2ab0dd9fea687d891@epcas3p2.samsung.com>
 <20171010091522.2286344-1-arnd@arndb.de>
Message-ID: <66c87919-60a7-b1de-a880-90b007c7efe4@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 2017-10-10 11:15, Arnd Bergmann wrote:
> The suspend/resume functions are referenced conditionally, causing
> a harmless warning when CONFIG_PM is disabled:
>
> drivers/clk/samsung/clk-exynos5433.c:5476:12: error: 'exynos5433_cmu_resume' defined but not used [-Werror=unused-function]
> drivers/clk/samsung/clk-exynos5433.c:5453:12: error: 'exynos5433_cmu_suspend' defined but not used [-Werror=unused-function]
>
> This marks both as __maybe_unused to shut up the warning.
>
> Fixes: 523d3de41f02 ("clk: samsung: exynos5433: Add support for runtime PM")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   drivers/clk/samsung/clk-exynos5433.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
> index cd9337613dd8..db270908037a 100644
> --- a/drivers/clk/samsung/clk-exynos5433.c
> +++ b/drivers/clk/samsung/clk-exynos5433.c
> @@ -5450,7 +5450,7 @@ struct exynos5433_cmu_data {
>   	struct samsung_clk_provider ctx;
>   };
>   
> -static int exynos5433_cmu_suspend(struct device *dev)
> +static int __maybe_unused exynos5433_cmu_suspend(struct device *dev)
>   {
>   	struct exynos5433_cmu_data *data = dev_get_drvdata(dev);
>   	int i;
> @@ -5473,7 +5473,7 @@ static int exynos5433_cmu_suspend(struct device *dev)
>   	return 0;
>   }
>   
> -static int exynos5433_cmu_resume(struct device *dev)
> +static int __maybe_unused exynos5433_cmu_resume(struct device *dev)
>   {
>   	struct exynos5433_cmu_data *data = dev_get_drvdata(dev);
>   	int i;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
