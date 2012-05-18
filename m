From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 18 May 2012 09:39:07 +0100
Subject: [PATCH 08/16] ARM: ux500: Allow PRCMU regulator to be probed during a
 DT enabled boot
In-Reply-To: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
References: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1337330355-17747-9-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the correct compatible string for use during Device Tree
population. Without it the DB8500 PRCMU regulators would be processed
when DT is enabled.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index faa46b1..33d47e1 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -771,6 +771,7 @@ static const struct of_device_id u8500_local_bus_nodes[] = {
 	/* only create devices below soc node */
 	{ .compatible = "stericsson,db8500", },
 	{ .compatible = "stericsson,db8500-prcmu", },
+	{ .compatible = "stericsson,db8500-prcmu-regulator", },
 	{ .compatible = "stericsson,ab8500", },
 	{ .compatible = "stericsson,ab8500-regulator", },
 	{ .compatible = "simple-bus"},
-- 
1.7.9.5
