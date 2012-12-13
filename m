From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 13 Dec 2012 17:24:04 +0530
Subject: [PATCH 3/3] arm: exynos: skip wakeup interrupt registration for
 exynos5250 if pinctrl is enabled
In-Reply-To: <1355399644-29417-1-git-send-email-thomas.abraham@linaro.org>
References: <1355399644-29417-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1355399644-29417-4-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Skip the wakeup interrupt registration for Exynos5250 if pinctrl support
is enabled for Exynos5250.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/common.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 73b940f..7ad5011 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -1019,6 +1019,7 @@ static int __init exynos_init_irq_eint(void)
 	static const struct of_device_id exynos_pinctrl_ids[] = {
 		{ .compatible = "samsung,pinctrl-exynos4210", },
 		{ .compatible = "samsung,pinctrl-exynos4x12", },
+		{ .compatible = "samsung,pinctrl-exynos5250", },
 	};
 	struct device_node *pctrl_np, *wkup_np;
 	const char *wkup_compat = "samsung,exynos4210-wakeup-eint";
-- 
1.6.6.rc2
