From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 19 May 2015 10:55:07 -0600
Subject: [PATCH 02/16] coresight: etm: print what version of ETM/PTM is
 detected
In-Reply-To: <1432054521-24807-1-git-send-email-mathieu.poirier@linaro.org>
References: <1432054521-24807-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1432054521-24807-3-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Helpfully report a bit more about the hardware found in the
silicon when matching the AMBA device IDs by using the associated
.data pointer in the AMBA match.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index d78fcc23c4e0..e8316d5aa459 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -1859,7 +1859,7 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 		goto err_arch_supported;
 	}
 
-	dev_info(dev, "ETM initialized\n");
+	dev_info(dev, "%s initialized\n", (char *)id->data);
 
 	if (boot_enable) {
 		coresight_enable(drvdata->csdev);
@@ -1890,18 +1890,22 @@ static struct amba_id etm_ids[] = {
 	{	/* ETM 3.3 */
 		.id	= 0x0003b921,
 		.mask	= 0x0003ffff,
+		.data	= "ETM 3.3",
 	},
 	{	/* ETM 3.5 */
 		.id	= 0x0003b956,
 		.mask	= 0x0003ffff,
+		.data	= "ETM 3.5",
 	},
 	{	/* PTM 1.0 */
 		.id	= 0x0003b950,
 		.mask	= 0x0003ffff,
+		.data	= "PTM 1.0",
 	},
 	{	/* PTM 1.1 */
 		.id	= 0x0003b95f,
 		.mask	= 0x0003ffff,
+		.data	= "PTM 1.1",
 	},
 	{ 0, 0},
 };
-- 
1.9.1
