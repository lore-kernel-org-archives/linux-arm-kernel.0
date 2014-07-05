From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 05 Jul 2014 11:38:48 +0100
Subject: [PATCH RFC 11/15] drm/armada: update Armada 510 (Dove) to use
 "ext_ref_clk1" as the clock
In-Reply-To: <20140705103724.GN21766@n2100.arm.linux.org.uk>
References: <20140705103724.GN21766@n2100.arm.linux.org.uk>
Message-ID: <E1X3NMm-0000AQ-7P@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the underscore between "clk" and "1" so that we match the name
of the clock given in the documentation.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/armada/armada_510.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/armada/armada_510.c b/drivers/gpu/drm/armada/armada_510.c
index 1bcf1a8c1915..ad3d2ebf95c9 100644
--- a/drivers/gpu/drm/armada/armada_510.c
+++ b/drivers/gpu/drm/armada/armada_510.c
@@ -19,7 +19,7 @@ static int armada510_crtc_init(struct armada_crtc *dcrtc, struct device *dev)
 {
 	struct clk *clk;
 
-	clk = devm_clk_get(dev, "ext_ref_clk_1");
+	clk = devm_clk_get(dev, "ext_ref_clk1");
 	if (IS_ERR(clk))
 		return PTR_ERR(clk) == -ENOENT ? -EPROBE_DEFER : PTR_ERR(clk);
 
-- 
1.8.3.1
