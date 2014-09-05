From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 05 Sep 2014 14:34:54 +0200
Subject: [PATCH v5 RESEND 2/3] ARM: EXYNOS: Remove unneeded __ref annotation
 for cpu_die function
In-Reply-To: <1409920495-16533-1-git-send-email-k.kozlowski@samsung.com>
References: <1409920495-16533-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1409920495-16533-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The __ref annotation for exynos_cpu_die() is not needed because the
function does not reference any __init/__exit symbol or call.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>

---
Changes since v4:
1. Rebase on linux-next-20140804.
2. Add Reviewed-by Tomasz Figa.
---
 arch/arm/mach-exynos/platsmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index a809f76c8160..83b20a38a598 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -373,7 +373,7 @@ static void __init exynos_smp_prepare_cpus(unsigned int max_cpus)
  *
  * Called with IRQs disabled
  */
-static void __ref exynos_cpu_die(unsigned int cpu)
+static void exynos_cpu_die(unsigned int cpu)
 {
 	int spurious = 0;
 
-- 
1.9.1
