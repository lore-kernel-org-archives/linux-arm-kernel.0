From: khilman@ti.com (Kevin Hilman)
Date: Wed,  1 Jun 2011 17:19:44 -0700
Subject: [PATCH v4 18/18] I2C: OMAP1/OMAP2+: prepend I2C IP version to probed
	version shown in dev_info
In-Reply-To: <1306973984-15165-1-git-send-email-khilman@ti.com>
References: <1306973984-15165-1-git-send-email-khilman@ti.com>
Message-ID: <1306973984-15165-19-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andy Green <andy@warmcat.com>

The IP version is prepended to the existing printed probed
version as an "epoch" version.

Cc: patches at linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index c997c55..d53cd61 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1093,8 +1093,8 @@ omap_i2c_probe(struct platform_device *pdev)
 		goto err_unuse_clocks;
 	}
 
-	dev_info(dev->dev, "bus %d rev%d.%d at %d kHz\n",
-		 pdev->id, dev->rev >> 4, dev->rev & 0xf, dev->speed);
+	dev_info(dev->dev, "bus %d rev%d.%d.%d at %d kHz\n", pdev->id,
+		 pdata->rev, dev->rev >> 4, dev->rev & 0xf, dev->speed);
 
 	omap_i2c_idle(dev);
 
-- 
1.7.4
