From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 06 Mar 2013 16:48:32 +0530
Subject: [PATCH v2 3/3] arm: exynos: skip wakeup interrupt registration for
 exynos5250 if pinctrl is enabled
In-Reply-To: <1362568712-13586-1-git-send-email-thomas.abraham@linaro.org>
References: <1362568712-13586-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1362568712-13586-4-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Skip the wakeup interrupt registration for Exynos5250 if pinctrl support
is enabled for Exynos5250.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-exynos/common.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index d63d399..bdd9579 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -822,6 +822,7 @@ static int __init exynos_init_irq_eint(void)
 	static const struct of_device_id exynos_pinctrl_ids[] = {
 		{ .compatible = "samsung,exynos4210-pinctrl", },
 		{ .compatible = "samsung,exynos4x12-pinctrl", },
+		{ .compatible = "samsung,exynos5250-pinctrl", },
 	};
 	struct device_node *pctrl_np, *wkup_np;
 	const char *wkup_compat = "samsung,exynos4210-wakeup-eint";
-- 
1.6.6.rc2
