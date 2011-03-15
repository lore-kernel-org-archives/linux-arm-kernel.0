From: andy@warmcat.com (Andy Green)
Date: Tue, 15 Mar 2011 19:58:04 +0000
Subject: [PATCH 3 18/18] I2C: OMAP1/OMAP2+: prepend I2C IP version to probed
	version shown in dev_info
In-Reply-To: <20110315195147.30000.86184.stgit@otae.warmcat.com>
References: <20110315195147.30000.86184.stgit@otae.warmcat.com>
Message-ID: <20110315195804.30000.70399.stgit@otae.warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IP version is prepended to the existing printed probed
version as an "epoch" version.

Cc: patches at linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
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
 
