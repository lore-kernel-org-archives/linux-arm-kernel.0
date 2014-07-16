From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 16 Jul 2014 16:20:16 +0200
Subject: [PATCH 2/3] ARM: EXYNOS: Remove unneeded __ref annotation for cpu_die
 function
In-Reply-To: <1405520417-15027-1-git-send-email-k.kozlowski@samsung.com>
References: <1405520417-15027-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1405520417-15027-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The __ref annotation for exynos_cpu_die() is not needed because the
function does not reference any __init/__exit symbol or call.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/mach-exynos/platsmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index b0679b6d5161..6a0de7591f73 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -306,7 +306,7 @@ static void __init exynos_smp_prepare_cpus(unsigned int max_cpus)
  *
  * Called with IRQs disabled
  */
-static void __ref exynos_cpu_die(unsigned int cpu)
+static void exynos_cpu_die(unsigned int cpu)
 {
 	int spurious = 0;
 
-- 
1.9.1
