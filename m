From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 30 Jun 2015 19:18:57 +0200
Subject: [PATCH v2 1/4] ARM: mvebu: Use __init for the PM initialization
 functions
In-Reply-To: <1435684740-24912-1-git-send-email-gregory.clement@free-electrons.com>
References: <1435684740-24912-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1435684740-24912-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mvebu_pm_init and mvebu_armada_pm_init are only called during boot, so
flag them with __init and save some memory.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pm-board.c | 2 +-
 arch/arm/mach-mvebu/pm.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/pm-board.c b/arch/arm/mach-mvebu/pm-board.c
index 0f471fad214a..acc69e369c8b 100644
--- a/arch/arm/mach-mvebu/pm-board.c
+++ b/arch/arm/mach-mvebu/pm-board.c
@@ -76,7 +76,7 @@ static void mvebu_armada_pm_enter(void __iomem *sdram_reg, u32 srcmd)
 		  [ackcmd] "r" (ackcmd), [gpio_ctrl] "r" (gpio_ctrl) : "r1");
 }
 
-static int mvebu_armada_pm_init(void)
+static int __init mvebu_armada_pm_init(void)
 {
 	struct device_node *np;
 	struct device_node *gpio_ctrl_np;
diff --git a/arch/arm/mach-mvebu/pm.c b/arch/arm/mach-mvebu/pm.c
index 90d85ef75d54..f249c8e04bd4 100644
--- a/arch/arm/mach-mvebu/pm.c
+++ b/arch/arm/mach-mvebu/pm.c
@@ -235,7 +235,7 @@ static const struct platform_suspend_ops mvebu_pm_ops = {
 	.valid = suspend_valid_only_mem,
 };
 
-int mvebu_pm_init(void (*board_pm_enter)(void __iomem *sdram_reg, u32 srcmd))
+int __init mvebu_pm_init(void (*board_pm_enter)(void __iomem *sdram_reg, u32 srcmd))
 {
 	struct device_node *np;
 	struct resource res;
-- 
2.1.0
