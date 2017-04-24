From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon, 24 Apr 2017 16:16:27 +0200
Subject: [PATCH 7/9] crypto: qat - Use IPAD/OPAD constant
In-Reply-To: <20170424141629.27155-1-clabbe.montjoie@gmail.com>
References: <20170424141629.27155-1-clabbe.montjoie@gmail.com>
Message-ID: <20170424141629.27155-7-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch simply replace all occurrence of HMAC IPAD/OPAD value by their
define.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/crypto/qat/qat_common/qat_algs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/qat_algs.c b/drivers/crypto/qat/qat_common/qat_algs.c
index 20f35df..6843fe2 100644
--- a/drivers/crypto/qat/qat_common/qat_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_algs.c
@@ -178,8 +178,8 @@ static int qat_alg_do_precomputes(struct icp_qat_hw_auth_algo_blk *hash,
 	for (i = 0; i < block_size; i++) {
 		char *ipad_ptr = ipad + i;
 		char *opad_ptr = opad + i;
-		*ipad_ptr ^= 0x36;
-		*opad_ptr ^= 0x5C;
+		*ipad_ptr ^= HMAC_IPAD_VALUE;
+		*opad_ptr ^= HMAC_OPAD_VALUE;
 	}
 
 	if (crypto_shash_init(shash))
-- 
2.10.2
