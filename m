From: wsa-dev@sang-engineering.com (Wolfram Sang)
Date: Tue,  9 Aug 2016 13:35:15 +0200
Subject: [PATCH 3/4] media: platform: exynos4-is: fimc-is-i2c: don't print
 error when adding adapter fails
In-Reply-To: <1470742517-12774-1-git-send-email-wsa-dev@sang-engineering.com>
References: <1470742517-12774-1-git-send-email-wsa-dev@sang-engineering.com>
Message-ID: <1470742517-12774-4-git-send-email-wsa-dev@sang-engineering.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The core will do this for us now.

Signed-off-by: Wolfram Sang <wsa-dev@sang-engineering.com>
---
 drivers/media/platform/exynos4-is/fimc-is-i2c.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/media/platform/exynos4-is/fimc-is-i2c.c b/drivers/media/platform/exynos4-is/fimc-is-i2c.c
index 7521aa59b0649c..fd888ef447a903 100644
--- a/drivers/media/platform/exynos4-is/fimc-is-i2c.c
+++ b/drivers/media/platform/exynos4-is/fimc-is-i2c.c
@@ -56,11 +56,8 @@ static int fimc_is_i2c_probe(struct platform_device *pdev)
 	i2c_adap->class = I2C_CLASS_SPD;
 
 	ret = i2c_add_adapter(i2c_adap);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to add I2C bus %s\n",
-						node->full_name);
+	if (ret < 0)
 		return ret;
-	}
 
 	platform_set_drvdata(pdev, isp_i2c);
 
-- 
2.8.1
