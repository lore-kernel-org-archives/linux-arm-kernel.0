From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 22 May 2013 14:06:35 +0100
Subject: [PATCH] ARM: ux500: regulators: Remove misleading comment
Message-ID: <1369227995-17142-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes a comment which explains that the ab8505 platform
uses the same initialisation settings as the ab8500. Well when this
changed and the ab8505 started using its own set of initialisation
values, someone forgot to remove it.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-regulators.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-ux500/board-mop500-regulators.c b/arch/arm/mach-ux500/board-mop500-regulators.c
index 33c353b..b34441b 100644
--- a/arch/arm/mach-ux500/board-mop500-regulators.c
+++ b/arch/arm/mach-ux500/board-mop500-regulators.c
@@ -996,7 +996,6 @@ struct ab8500_regulator_platform_data ab8500_regulator_plat_data = {
 	.num_ext_regulator      = ARRAY_SIZE(ab8500_ext_regulators),
 };
 
-/* Use the AB8500 init settings for AB8505 as they are the same right now */
 struct ab8500_regulator_platform_data ab8505_regulator_plat_data = {
 	.reg_init               = ab8505_reg_init,
 	.num_reg_init           = ARRAY_SIZE(ab8505_reg_init),
-- 
1.7.10.4
