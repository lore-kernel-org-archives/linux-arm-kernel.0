From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 18 May 2016 16:46:26 +0300
Subject: [PATCH 04/14] mfd: twl6040: The chip does not support bulk access
In-Reply-To: <1463579196-5484-1-git-send-email-peter.ujfalusi@ti.com>
References: <1463579196-5484-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1463579196-5484-5-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bulk access is not working with twl6040, we need to use single register
access. Bulk access would happen when we try to sync the regcache after
power on.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mfd/twl6040.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index f3dcf3a85e84..2596546553aa 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -608,6 +608,7 @@ static const struct regmap_config twl6040_regmap_config = {
 	.writeable_reg = twl6040_writeable_reg,
 
 	.cache_type = REGCACHE_RBTREE,
+	.use_single_rw = true,
 };
 
 static const struct regmap_irq twl6040_irqs[] = {
-- 
2.8.2
