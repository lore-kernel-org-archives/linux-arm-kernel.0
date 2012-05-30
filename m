From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 30 May 2012 12:47:31 +0800
Subject: [PATCH 13/22] ARM: ux500: Allow PRCMU regulator to be probed during a
 DT enabled boot
In-Reply-To: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1338353260-10097-14-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the correct compatible string for use during Device Tree
population. Without it the DB8500 PRCMU regulators would be processed
when DT is enabled.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 6b3fef5..353d381 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -845,6 +845,7 @@ static const struct of_device_id u8500_local_bus_nodes[] = {
 	/* only create devices below soc node */
 	{ .compatible = "stericsson,db8500", },
 	{ .compatible = "stericsson,db8500-prcmu", },
+	{ .compatible = "stericsson,db8500-prcmu-regulator", },
 	{ .compatible = "stericsson,ab8500", },
 	{ .compatible = "stericsson,ab8500-regulator", },
 	{ .compatible = "simple-bus"},
-- 
1.7.9.5
