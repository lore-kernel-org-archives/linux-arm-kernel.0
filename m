From: dianders@chromium.org (Doug Anderson)
Date: Tue, 19 Mar 2013 09:51:39 -0700
Subject: [PATCH 1/2] arm: exynos: Remove hardcode wakeup unmask for EINT_0
In-Reply-To: <1363711900-25560-1-git-send-email-dianders@chromium.org>
References: <1363711900-25560-1-git-send-email-dianders@chromium.org>
Message-ID: <1363711900-25560-2-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonathan Kliegman <kliegs@chromium.org>

For legacy reasons EINT_0 was being forced on for all
exynos systems as a wake interrupt.  For boards that need
EINT_0 they should probably enable it with enable_irq_wake

Signed-off-by: Jonathan Kliegman <kliegs@chromium.org>
Signed-off-by: Doug Anderson <dianders@chromium.org>
Reviewed-by: Doug Anderson <dianders@chromium.org>
Reviewed-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/mach-exynos/include/mach/pm-core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/include/mach/pm-core.h b/arch/arm/mach-exynos/include/mach/pm-core.h
index a67ecfa..9d8da51e3 100644
--- a/arch/arm/mach-exynos/include/mach/pm-core.h
+++ b/arch/arm/mach-exynos/include/mach/pm-core.h
@@ -33,7 +33,7 @@ static inline void s3c_pm_arch_prepare_irqs(void)
 	__raw_writel(tmp, S5P_WAKEUP_MASK);
 
 	__raw_writel(s3c_irqwake_intmask, S5P_WAKEUP_MASK);
-	__raw_writel(s3c_irqwake_eintmask & 0xFFFFFFFE, S5P_EINT_WAKEUP_MASK);
+	__raw_writel(s3c_irqwake_eintmask, S5P_EINT_WAKEUP_MASK);
 }
 
 static inline void s3c_pm_arch_stop_clocks(void)
-- 
1.8.1.3
