From: luis@debethencourt.com (Luis de Bethencourt)
Date: Fri, 28 Aug 2015 18:44:03 +0200
Subject: [PATCH 2/3] crypto: picoxcell: Fix module autoload for OF platform
 driver
Message-ID: <20150828164403.GA5083@goodgumbo.baconseed.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
---
 drivers/crypto/picoxcell_crypto.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/picoxcell_crypto.c b/drivers/crypto/picoxcell_crypto.c
index 4f56f36..b6ec2a4 100644
--- a/drivers/crypto/picoxcell_crypto.c
+++ b/drivers/crypto/picoxcell_crypto.c
@@ -1673,6 +1673,7 @@ static const struct of_device_id spacc_of_id_table[] = {
 	{ .compatible = "picochip,spacc-l2" },
 	{}
 };
+MODULE_DEVICE_TABLE(of, spacc_of_id_table);
 #endif /* CONFIG_OF */
 
 static bool spacc_is_compatible(struct platform_device *pdev,
-- 
2.4.6
