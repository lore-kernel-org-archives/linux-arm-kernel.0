From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 11 May 2015 10:27:26 +0900
Subject: [PATCH v3 2/2] ARM: EXYNOS: Use of_machine_is_compatible instead of
 soc_is_exynos4
In-Reply-To: <1431307646-10779-1-git-send-email-k.kozlowski@samsung.com>
References: <1431307646-10779-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1431307646-10779-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_machine_is_compatible() seems to be preferred over soc_is_exynos4().

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---
Changes since v2:
1. New patch, requested by Kukjin Kim.
---
 arch/arm/mach-exynos/exynos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index c3bfbba3006d..5917a30eee33 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -179,7 +179,7 @@ static void __init exynos_init_io(void)
  */
 void exynos_set_delayed_reset_assertion(bool enable)
 {
-	if (soc_is_exynos4()) {
+	if (of_machine_is_compatible("samsung,exynos4")) {
 		unsigned int tmp, core_id;
 
 		for (core_id = 0; core_id < num_possible_cpus(); core_id++) {
-- 
1.9.1
