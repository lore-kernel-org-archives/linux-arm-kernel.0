From: nm@ti.com (Nishanth Menon)
Date: Thu, 17 Apr 2014 15:49:19 -0500
Subject: [PATCH V2 03/19] bus: omap_l3_noc: remove iclk from omap_l3 struct
In-Reply-To: <1397767775-10965-1-git-send-email-nm@ti.com>
References: <1397492726-17203-1-git-send-email-nm@ti.com>
 <1397767775-10965-1-git-send-email-nm@ti.com>
Message-ID: <1397767775-10965-4-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

we do not use iclk directly anymore. And, even if we had to, we
should be using pm_runtime APIs to do the same to be completely SoC
independent.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
V2: no change, just reorder
V1: https://patchwork.kernel.org/patch/3984161/
 drivers/bus/omap_l3_noc.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bus/omap_l3_noc.h b/drivers/bus/omap_l3_noc.h
index b3c81f2..31984cf 100644
--- a/drivers/bus/omap_l3_noc.h
+++ b/drivers/bus/omap_l3_noc.h
@@ -159,7 +159,6 @@ static u32 *l3_targ[L3_MODULES] = {
 
 struct omap_l3 {
 	struct device *dev;
-	struct clk *ick;
 
 	/* memory base */
 	void __iomem *l3_base[L3_MODULES];
-- 
1.7.9.5
