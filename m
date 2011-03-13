From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 13 Mar 2011 15:53:28 +0200
Subject: [PATCH 1/2] i2c-pxa2xx: Fix register offsets
Message-ID: <1300024409-32587-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix regression that was introduced by dynamic register layout.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/i2c/busses/i2c-pxa.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index a90739b..312d369 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -66,18 +66,18 @@ enum pxa_i2c_types {
 static struct pxa_reg_layout pxa_reg_layout[] = {
 	[REGS_PXA2XX] = {
 		.ibmr =	0x00,
-		.idbr =	0x10,
-		.icr =	0x20,
-		.isr =	0x30,
-		.isar =	0x40,
-	},
-	[REGS_PXA3XX] = {
-		.ibmr =	0x00,
 		.idbr =	0x08,
 		.icr =	0x10,
 		.isr =	0x18,
 		.isar =	0x20,
 	},
+	[REGS_PXA3XX] = {
+		.ibmr =	0x00,
+		.idbr =	0x04,
+		.icr =	0x08,
+		.isr =	0x0c,
+		.isar =	0x10,
+	},
 	[REGS_CE4100] = {
 		.ibmr =	0x14,
 		.idbr =	0x0c,
-- 
1.7.4.1
