From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 11 Oct 2017 11:07:33 +0200
Subject: [PATCH] clk: samsung: exynos5433: mark PM functions as
 __maybe_unused
In-Reply-To: <20171010091522.2286344-1-arnd@arndb.de>
References: <20171010091522.2286344-1-arnd@arndb.de>
 <CGME20171011090739epcas1p298f23646912d3ead6c30609fca199cf2@epcas1p2.samsung.com>
Message-ID: <08513173-6712-4156-4475-3600cde6b7ea@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/2017 11:15 AM, Arnd Bergmann wrote:
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

Applied, thanks.
