From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Tue, 13 Jan 2015 18:46:53 +0100
Subject: [PATCH] ARM i.MX6q: unmap memory mapped at
 imx6q_opp_check_speed_grading()
Message-ID: <1421171213-19159-1-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx6q_opp_check_speed_grading() remaps memory to the base variable and
never unmaps it. I can't see how this can be of any use later so here I
unmap it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/mach-imx/mach-imx6q.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 5057d61298b7..4ad6e473cf83 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -329,7 +329,7 @@ static void __init imx6q_opp_check_speed_grading(struct device *cpu_dev)
 			if (dev_pm_opp_disable(cpu_dev, 852000000))
 				pr_warn("failed to disable 852 MHz OPP\n");
 	}
-
+	iounmap(base);
 put_node:
 	of_node_put(np);
 }
-- 
2.1.4
