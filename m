From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 19 May 2015 10:55:08 -0600
Subject: [PATCH 03/16] coresight: support the TPIU version found in Ux500
In-Reply-To: <1432054521-24807-1-git-send-email-mathieu.poirier@linaro.org>
References: <1432054521-24807-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1432054521-24807-4-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The Ux500 has a PrimeCell version 4B instead of the 3B as
supported by the driver, extend the match table to cover
this version.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tpiu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 3b33af2416bb..88b6b0c32538 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -188,6 +188,10 @@ static struct amba_id tpiu_ids[] = {
 		.id	= 0x0003b912,
 		.mask	= 0x0003ffff,
 	},
+	{
+		.id	= 0x0004b912,
+		.mask	= 0x0007ffff,
+	},
 	{ 0, 0},
 };
 
-- 
1.9.1
