From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon,  5 May 2014 14:56:48 +0530
Subject: [PATCH 1/1] ARM: EXYNOS: Fix compilation warning
Message-ID: <1399282008-9738-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_get_flat_dt_prop return type is now const.
Fixes the following compilation warning introduced by commit 9d0c4dfedd96
("of/fdt: update of_get_flat_dt_prop in prep for libfdt")

arch/arm/mach-exynos/exynos.c:259:6: warning:
assignment discards ?const? qualifier from pointer target type [enabled by default]

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Rob Herring <robh@kernel.org>
---
Based on linux-next (20140505)
---
 arch/arm/mach-exynos/exynos.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 77293d39dfc9..f356c67a1fa9 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -249,7 +249,7 @@ static int __init exynos_fdt_map_chipid(unsigned long node, const char *uname,
 					int depth, void *data)
 {
 	struct map_desc iodesc;
-	__be32 *reg;
+	const __be32 *reg;
 	int len;
 
 	if (!of_flat_dt_is_compatible(node, "samsung,exynos4210-chipid") &&
-- 
1.7.9.5
