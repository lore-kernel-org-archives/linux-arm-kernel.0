From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  2 May 2013 11:49:49 +0100
Subject: [PATCH 7/8] crypto: ux500/[cryp|hash] - Show successful start-up in
 the bootlog
In-Reply-To: <1367491790-9727-1-git-send-email-lee.jones@linaro.org>
References: <1367491790-9727-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1367491790-9727-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cryp driver is currently silent and the Hash driver prints the
name of its probe function unnecessarily. Let's just put a nice
descriptive one-liner there instead.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David S. Miller <davem@davemloft.net>
Cc: Andreas Westin <andreas.westin@stericsson.com>
Cc: linux-crypto at vger.kernel.org
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/crypto/ux500/cryp/cryp_core.c |    2 ++
 drivers/crypto/ux500/hash/hash_core.c |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/ux500/cryp/cryp_core.c b/drivers/crypto/ux500/cryp/cryp_core.c
index 4b90493..78d7463 100644
--- a/drivers/crypto/ux500/cryp/cryp_core.c
+++ b/drivers/crypto/ux500/cryp/cryp_core.c
@@ -1542,6 +1542,8 @@ static int ux500_cryp_probe(struct platform_device *pdev)
 		goto out_power;
 	}
 
+	dev_info(dev, "successfully registered\n");
+
 	return 0;
 
 out_power:
diff --git a/drivers/crypto/ux500/hash/hash_core.c b/drivers/crypto/ux500/hash/hash_core.c
index 5d8a7f3..ac606b6 100644
--- a/drivers/crypto/ux500/hash/hash_core.c
+++ b/drivers/crypto/ux500/hash/hash_core.c
@@ -1773,7 +1773,7 @@ static int ux500_hash_probe(struct platform_device *pdev)
 		goto out_power;
 	}
 
-	dev_info(dev, "[%s] successfully probed\n", __func__);
+	dev_info(dev, "successfully registered\n");
 	return 0;
 
 out_power:
-- 
1.7.10.4
