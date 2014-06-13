From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Jun 2014 18:01:16 +0200
Subject: [PATCH 14/14] ARM: EXYNOS: Fix compilation warning
In-Reply-To: <1402675276-538682-1-git-send-email-arnd@arndb.de>
References: <1402675276-538682-1-git-send-email-arnd@arndb.de>
Message-ID: <1402675276-538682-15-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sachin Kamat <sachin.kamat@linaro.org>

of_get_flat_dt_prop return type is now const.
Fixes the following compilation warning introduced by commit 9d0c4dfedd96
("of/fdt: update of_get_flat_dt_prop in prep for libfdt")

arch/arm/mach-exynos/exynos.c:259:6: warning:
assignment discards ?const? qualifier from pointer target type [enabled by default]

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Reviewed-by: Tushar Behera <tushar.behera@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-exynos/exynos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index fb1eadd..f38cf7c 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -220,7 +220,7 @@ static int __init exynos_fdt_map_chipid(unsigned long node, const char *uname,
 					int depth, void *data)
 {
 	struct map_desc iodesc;
-	__be32 *reg;
+	const __be32 *reg;
 	int len;
 
 	if (!of_flat_dt_is_compatible(node, "samsung,exynos4210-chipid") &&
-- 
1.8.3.2
