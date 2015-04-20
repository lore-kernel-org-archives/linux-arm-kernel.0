From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 Apr 2015 14:58:55 +0200
Subject: [PATCH 02/13 v2] coresight: support the TPIU version found in Ux500
In-Reply-To: <1429534746-3068-1-git-send-email-linus.walleij@linaro.org>
References: <1429534746-3068-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1429534746-3068-2-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Ux500 has a PrimeCell version 4B instead of the 3B as
supported by the driver, extend the match table to cover
this version.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rebased on the coresight git tree.
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
1.9.3
