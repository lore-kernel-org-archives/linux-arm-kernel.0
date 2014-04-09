From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 09 Apr 2014 13:54:59 +0100
Subject: [PATCH 2/8] imx-drm: ipu-dc: Use usleep_range instead of msleep
In-Reply-To: <20140409125354.GP16119@n2100.arm.linux.org.uk>
References: <20140409125354.GP16119@n2100.arm.linux.org.uk>
Message-ID: <E1WXs1r-0002ao-F1@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>
To: linux-arm-kernel at lists.infradead.org

Since msleep(2) can sleep up to 20ms anyway, make this explicit by using
usleep_range(2000, 20000).

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/ipu-v3/ipu-dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-dc.c b/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
index d0e3bc3c53e7..d5de8bb5c803 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
@@ -262,7 +262,7 @@ void ipu_dc_disable_channel(struct ipu_dc *dc)
 
 	/* Wait for DC triple buffer to empty */
 	while ((readl(priv->dc_reg + DC_STAT) & val) != val) {
-		msleep(2);
+		usleep_range(2000, 20000);
 		timeout -= 2;
 		if (timeout <= 0)
 			break;
-- 
1.8.3.1
