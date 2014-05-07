From: zhangwm@marvell.com (Neil Zhang)
Date: Wed, 7 May 2014 13:50:23 +0800
Subject: [PATCH] ARM: remove redundant code in machine_halt
Message-ID: <1399441823-9907-1-git-send-email-zhangwm@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to call local_irq_disable twice.

Signed-off-by: Neil Zhang <zhangwm@marvell.com>
---
 arch/arm/kernel/process.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 81ef686..18cfce4 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -195,7 +195,6 @@ void machine_halt(void)
 	local_irq_disable();
 	smp_send_stop();
 
-	local_irq_disable();
 	while (1);
 }
 
-- 
1.7.9.5
