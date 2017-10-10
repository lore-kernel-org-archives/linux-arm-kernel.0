From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 10 Oct 2017 12:41:20 +0200
Subject: [PATCH] clk: samsung: exynos5433: mark PM functions as
 __maybe_unused
In-Reply-To: <20171010091522.2286344-1-arnd@arndb.de>
References: <20171010091522.2286344-1-arnd@arndb.de>
Message-ID: <CAPDyKFozf1MfEgj2mCmogyJLzSmszoFXzg0Q=Ae-kv-itz+SGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 October 2017 at 11:15, Arnd Bergmann <arnd@arndb.de> wrote:
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

FWIW:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

[...]
