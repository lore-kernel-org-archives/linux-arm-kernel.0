From: artem.savkov@gmail.com (Artem Savkov)
Date: Tue,  6 Feb 2018 22:20:21 +0100
Subject: [PATCH 1/2] sun4i_ss_prng: fix return value of sun4i_ss_prng_generate
In-Reply-To: <20180206212022.1309-1-artem.savkov@gmail.com>
References: <20180206212022.1309-1-artem.savkov@gmail.com>
Message-ID: <20180206212022.1309-2-artem.savkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to crypto/rng.h generate function should return 0 on success
and < 0 on error.

Fixes: b8ae5c7387ad ("crypto: sun4i-ss - support the Security System PRNG")
Signed-off-by: Artem Savkov <artem.savkov@gmail.com>
---
 drivers/crypto/sunxi-ss/sun4i-ss-prng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-prng.c b/drivers/crypto/sunxi-ss/sun4i-ss-prng.c
index 0d01d1624252..5754e0b92fb0 100644
--- a/drivers/crypto/sunxi-ss/sun4i-ss-prng.c
+++ b/drivers/crypto/sunxi-ss/sun4i-ss-prng.c
@@ -52,5 +52,5 @@ int sun4i_ss_prng_generate(struct crypto_rng *tfm, const u8 *src,
 
 	writel(0, ss->base + SS_CTL);
 	spin_unlock(&ss->slock);
-	return dlen;
+	return 0;
 }
-- 
2.15.1
