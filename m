From: gilad@benyossef.com (Gilad Ben-Yossef)
Date: Thu, 24 May 2018 15:19:08 +0100
Subject: [PATCH v2 3/5] crypto: ccree: silence debug prints
In-Reply-To: <1527171551-21979-1-git-send-email-gilad@benyossef.com>
References: <1527171551-21979-1-git-send-email-gilad@benyossef.com>
Message-ID: <1527171551-21979-4-git-send-email-gilad@benyossef.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cache parameter register configuration was being too verbose.
Use dev_dbg() to only provide the information if needed.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 drivers/crypto/ccree/cc_driver.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/ccree/cc_driver.c b/drivers/crypto/ccree/cc_driver.c
index b266657..1e40e76 100644
--- a/drivers/crypto/ccree/cc_driver.c
+++ b/drivers/crypto/ccree/cc_driver.c
@@ -168,14 +168,14 @@ int init_cc_regs(struct cc_drvdata *drvdata, bool is_probe)
 	val = cc_ioread(drvdata, CC_REG(AXIM_CACHE_PARAMS));
 
 	if (is_probe)
-		dev_info(dev, "Cache params previous: 0x%08X\n", val);
+		dev_dbg(dev, "Cache params previous: 0x%08X\n", val);
 
 	cc_iowrite(drvdata, CC_REG(AXIM_CACHE_PARAMS), cache_params);
 	val = cc_ioread(drvdata, CC_REG(AXIM_CACHE_PARAMS));
 
 	if (is_probe)
-		dev_info(dev, "Cache params current: 0x%08X (expect: 0x%08X)\n",
-			 val, cache_params);
+		dev_dbg(dev, "Cache params current: 0x%08X (expect: 0x%08X)\n",
+			val, cache_params);
 
 	return 0;
 }
-- 
2.7.4
