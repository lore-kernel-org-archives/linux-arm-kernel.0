From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 17 Mar 2016 11:11:39 +0000
Subject: [PATCH] ARM: Rockchip: Fix use of plain integer as NULL pointer
Message-ID: <1458213099-13786-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the following sparse build warning
mach-rockchip/platsmp.c:68:43: Using plain integer as NULL pointer

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/mach-rockchip/platsmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
index d42a07e..4d827a0 100644
--- a/arch/arm/mach-rockchip/platsmp.c
+++ b/arch/arm/mach-rockchip/platsmp.c
@@ -65,7 +65,7 @@ static struct reset_control *rockchip_get_core_reset(int cpu)
 	if (dev)
 		np = dev->of_node;
 	else
-		np = of_get_cpu_node(cpu, 0);
+		np = of_get_cpu_node(cpu, NULL);
 
 	return of_reset_control_get(np, NULL);
 }
-- 
1.9.1
