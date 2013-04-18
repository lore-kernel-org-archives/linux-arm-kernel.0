From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 18 Apr 2013 11:27:04 +0100
Subject: [PATCH 8/9] crypto: ux500/[cryp|hash] - Show successful start-up in
 the bootlog
In-Reply-To: <1366280825-31136-1-git-send-email-lee.jones@linaro.org>
References: <1366280825-31136-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1366280825-31136-9-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cryp driver is currently silent and the Hash driver prints the
name of its probe function unnecessarily. Let's just put a nice
descriptive one-liner there instead.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David S. Miller <davem@davemloft.net>
Cc: Andreas Westin <andreas.westin@stericsson.com>
Cc: linux-crypto at vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/crypto/ux500/cryp/cryp_core.c |    2 ++
 drivers/crypto/ux500/hash/hash_core.c |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/ux500/cryp/cryp_core.c b/drivers/crypto/ux500/cryp/cryp_core.c
index 6c4f872..7366910 100644
--- a/drivers/crypto/ux500/cryp/cryp_core.c
+++ b/drivers/crypto/ux500/cryp/cryp_core.c
@@ -1536,6 +1536,8 @@ static int ux500_cryp_probe(struct platform_device *pdev)
 		goto out_power;
 	}
 
+	dev_info(dev, "successfully registered\n");
+
 	return 0;
 
 out_power:
diff --git a/drivers/crypto/ux500/hash/hash_core.c b/drivers/crypto/ux500/hash/hash_core.c
index f9126f4..d3cbf5d 100644
--- a/drivers/crypto/ux500/hash/hash_core.c
+++ b/drivers/crypto/ux500/hash/hash_core.c
@@ -1767,7 +1767,7 @@ static int ux500_hash_probe(struct platform_device *pdev)
 		goto out_power;
 	}
 
-	dev_info(dev, "[%s] successfully probed\n", __func__);
+	dev_info(dev, "successfully registered\n");
 	return 0;
 
 out_power:
-- 
1.7.10.4
