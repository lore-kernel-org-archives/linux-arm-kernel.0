From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 17 Nov 2016 12:40:41 -0300
Subject: [PATCH] ARM: Drop fixed 200 Hz timer requirement from Exynos
 platforms
In-Reply-To: <1479148025-469-1-git-send-email-krzk@kernel.org>
References: <1479148025-469-1-git-send-email-krzk@kernel.org>
Message-ID: <6f15ef88-aa9e-4a3c-4a75-1d3216d734d5@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 11/14/2016 03:27 PM, Krzysztof Kozlowski wrote:
> All Samsung platforms, including the Exynos, are selecting HZ_FIXED with
> 200 Hz.  Unfortunately in case of multiplatform image this affects also
> other platforms when Exynos is selected.
> 
> This looks like an very old legacy code, dating back to initial
> upstreaming of S3C24xx.  Probably it was required for s3c24xx timer
> driver, which was removed in commit ad38bdd15d5b ("ARM: SAMSUNG: Remove
> unused plat-samsung/time.c").
> 
> Since then, this fixed 200 Hz spread everywhere, including out-of-tree
> Samsung kernels (SoC vendor's and Tizen's).  I believe this choice
> was rather an effect of coincidence instead of conscious choice.  In
> fact Exynos can work with different timers.
> 
> Few perf mem and sched tests on Odroid XU3 board (Exynos5422, 4x Cortex
> A7, 4x Cortex A15) show no regressions when switching from 200 Hz to
> other values.
> 
> Reported-by: Lee Jones <lee.jones@linaro.org>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Testing on other Exynos platforms would be appreciated.

I tested this patch on an Exynos5800 Peach Pi Chromebook with different
HZ values (100/200/250/300/500/1000), and found no issues.

Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
