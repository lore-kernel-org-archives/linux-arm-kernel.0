From: amitoj1606@gmail.com (Amitoj Kaur Chawla)
Date: Wed, 20 Jul 2016 14:10:01 +0530
Subject: [PATCH] ARM: sa1111: Use clk_disable_unprepare
Message-ID: <20160720084000.GA27003@amitoj-Inspiron-3542>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace clk_disable and clk_unprepare with clk_disable_unprepare.

The Coccinelle semantic patch used to make this change is as follows:
@@
expression e;
@@

- clk_disable(e);
- clk_unprepare(e);
+ clk_disable_unprepare(e);

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 arch/arm/common/sa1111.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 3d22494..368d571 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -831,8 +831,7 @@ static void __sa1111_remove(struct sa1111 *sachip)
 	sa1111_writel(0, irqbase + SA1111_WAKEEN0);
 	sa1111_writel(0, irqbase + SA1111_WAKEEN1);
 
-	clk_disable(sachip->clk);
-	clk_unprepare(sachip->clk);
+	clk_disable_unprepare(sachip->clk);
 
 	if (sachip->irq != NO_IRQ) {
 		irq_set_chained_handler_and_data(sachip->irq, NULL, NULL);
-- 
1.9.1
