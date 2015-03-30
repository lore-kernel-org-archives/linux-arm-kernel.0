From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 30 Mar 2015 16:04:34 +0200
Subject: [PATCH 1/5] ARM: mvebu: Use __init for the PM initialization functions
In-Reply-To: <1427724278-12379-1-git-send-email-gregory.clement@free-electrons.com>
References: <1427724278-12379-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1427724278-12379-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mvebu_pm_init and mvebu_armada_xp_gp_pm_init are only called during
boot, so flag them with __init and save some memory.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pm-board.c | 2 +-
 arch/arm/mach-mvebu/pm.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/pm-board.c b/arch/arm/mach-mvebu/pm-board.c
index 6dfd4ab97b2a..e56782ac9fbe 100644
--- a/arch/arm/mach-mvebu/pm-board.c
+++ b/arch/arm/mach-mvebu/pm-board.c
@@ -73,7 +73,7 @@ static void mvebu_armada_xp_gp_pm_enter(void __iomem *sdram_reg, u32 srcmd)
 		  [ackcmd] "r" (ackcmd), [gpio_ctrl] "r" (gpio_ctrl) : "r1");
 }
 
-static int mvebu_armada_xp_gp_pm_init(void)
+static int __init mvebu_armada_xp_gp_pm_init(void)
 {
 	struct device_node *np;
 	struct device_node *gpio_ctrl_np;
diff --git a/arch/arm/mach-mvebu/pm.c b/arch/arm/mach-mvebu/pm.c
index 6573a8f11f70..36f28db6e3a1 100644
--- a/arch/arm/mach-mvebu/pm.c
+++ b/arch/arm/mach-mvebu/pm.c
@@ -177,7 +177,7 @@ static const struct platform_suspend_ops mvebu_pm_ops = {
 	.valid = suspend_valid_only_mem,
 };
 
-int mvebu_pm_init(void (*board_pm_enter)(void __iomem *sdram_reg, u32 srcmd))
+int __init mvebu_pm_init(void (*board_pm_enter)(void __iomem *sdram_reg, u32 srcmd))
 {
 	struct device_node *np;
 	struct resource res;
-- 
2.1.0
