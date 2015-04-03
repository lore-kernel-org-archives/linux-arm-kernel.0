From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 03 Apr 2015 18:13:13 +0100
Subject: [PATCH 10/14] ARM: orion: use clkdev_create()
In-Reply-To: <20150403171149.GC13898@n2100.arm.linux.org.uk>
References: <20150403171149.GC13898@n2100.arm.linux.org.uk>
Message-ID: <E1Ye59d-0001BZ-Sv@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clkdev_create() is a shorter way to write clkdev_alloc() followed by
clkdev_add().  Use this instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/plat-orion/common.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index f5b00f41c4f6..2235081a04ee 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -28,11 +28,7 @@
 void __init orion_clkdev_add(const char *con_id, const char *dev_id,
 			     struct clk *clk)
 {
-	struct clk_lookup *cl;
-
-	cl = clkdev_alloc(clk, con_id, dev_id);
-	if (cl)
-		clkdev_add(cl);
+	clkdev_create(clk, con_id, "%s", dev_id);
 }
 
 /* Create clkdev entries for all orion platforms except kirkwood.
-- 
1.8.3.1
