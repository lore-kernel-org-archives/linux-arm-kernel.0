From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 16 May 2013 12:27:26 +0100
Subject: [PATCH 6/6] crypto: ux500/hash - Enable DT probing of the driver
In-Reply-To: <1368703646-26418-1-git-send-email-lee.jones@linaro.org>
References: <1368703646-26418-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1368703646-26418-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By providing an OF match table with a suitable compatible string, we
can ensure the ux500-hasht driver is probed by supplying an associated
DT node in a given platform's Device Tree.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto at vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/crypto/ux500/hash/hash_core.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/crypto/ux500/hash/hash_core.c b/drivers/crypto/ux500/hash/hash_core.c
index 9ca6fbb..f89fe8a 100644
--- a/drivers/crypto/ux500/hash/hash_core.c
+++ b/drivers/crypto/ux500/hash/hash_core.c
@@ -1981,6 +1981,11 @@ static int ux500_hash_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(ux500_hash_pm, ux500_hash_suspend, ux500_hash_resume);
 
+static const struct of_device_id ux500_hash_match[] = {
+        { .compatible = "stericsson,ux500-hash" },
+        { },
+};
+
 static struct platform_driver hash_driver = {
 	.probe  = ux500_hash_probe,
 	.remove = ux500_hash_remove,
@@ -1988,6 +1993,7 @@ static struct platform_driver hash_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
 		.name  = "hash1",
+		.of_match_table = ux500_hash_match,
 		.pm    = &ux500_hash_pm,
 	}
 };
-- 
1.7.10.4
