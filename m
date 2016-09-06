From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 06 Sep 2016 15:50:57 +0200
Subject: [PATCH] mfd: exynos-lpass: mark PM functions as __maybe_unused
In-Reply-To: <20160906132432.2083493-1-arnd@arndb.de>
References: <20160906132432.2083493-1-arnd@arndb.de>
Message-ID: <85bba0e5-cd64-a8e8-b576-acc094003004@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/2016 03:24 PM, Arnd Bergmann wrote:
> The newly added exynos lpass driver produces a build warning when
> CONFIG_PM is disabled since the only callers of exynos_lpass_disable
> are under an #ifdef:
> 
> drivers/mfd/exynos-lpass.c:93:13: error: 'exynos_lpass_disable' defined but not used [-Werror=unused-function]
>  static void exynos_lpass_disable(struct exynos_lpass *lpass)
> 
> This removes the #ifdef and replaces it with __maybe_unused annotations
> so the compiler can leave out the unused code silently with less
> room for mistakes.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 36c26760bba8 ("mfd: Add Samsung Exynos Low Power Audio Subsystem driver")

Thanks for fixing this,

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
