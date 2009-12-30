From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 30 Dec 2009 13:13:13 -0500
Subject: [PATCH] ep93xx: use pr_fmt in dma-m2p.c
Message-ID: <BD79186B4FD85F4B8E60E381CAEE19090200F63A@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use pr_fmt to prefix kernel output with the module name.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>

---

diff --git a/arch/arm/mach-ep93xx/dma-m2p.c b/arch/arm/mach-ep93xx/dma-m2p.c
index dbcac9c..8904ca4 100644
--- a/arch/arm/mach-ep93xx/dma-m2p.c
+++ b/arch/arm/mach-ep93xx/dma-m2p.c
@@ -28,6 +28,8 @@
  * with this implementation.
  */
 
+#define pr_fmt(fmt) "ep93xx " KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/clk.h>
 #include <linux/err.h>
@@ -173,7 +175,7 @@ static irqreturn_t m2p_irq(int irq, void *dev_id)
 
 	switch (m2p_channel_state(ch)) {
 	case STATE_IDLE:
-		pr_crit("m2p_irq: dma interrupt without a dma buffer\n");
+		pr_crit("dma interrupt without a dma buffer\n");
 		BUG();
 		break;
 
@@ -197,7 +199,7 @@ static irqreturn_t m2p_irq(int irq, void *dev_id)
 		break;
 
 	case STATE_NEXT:
-		pr_crit("m2p_irq: dma interrupt while next\n");
+		pr_crit("dma interrupt while next\n");
 		BUG();
 		break;
 	} 
