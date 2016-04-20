From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 19 Apr 2016 18:36:55 -0700
Subject: [PATCH] vexpress/spc: Remove CLK_IS_ROOT
Message-ID: <1461116215-1517-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This flag is a no-op now (see commit 47b0eeb3dc8a "clk: Deprecate
CLK_IS_ROOT", 2016-02-02) so remove it.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-vexpress/spc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
index 5766ce2be32b..8409cab3f760 100644
--- a/arch/arm/mach-vexpress/spc.c
+++ b/arch/arm/mach-vexpress/spc.c
@@ -547,7 +547,7 @@ static struct clk *ve_spc_clk_register(struct device *cpu_dev)
 
 	init.name = dev_name(cpu_dev);
 	init.ops = &clk_spc_ops;
-	init.flags = CLK_IS_ROOT | CLK_GET_RATE_NOCACHE;
+	init.flags = CLK_GET_RATE_NOCACHE;
 	init.num_parents = 0;
 
 	return devm_clk_register(cpu_dev, &spc->hw);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
