From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue, 22 Aug 2017 10:08:12 +0200
Subject: [PATCH 05/11] crypto: atmel - Use GCM IV size constant
In-Reply-To: <20170822080818.12486-1-clabbe.montjoie@gmail.com>
References: <20170822080818.12486-1-clabbe.montjoie@gmail.com>
Message-ID: <20170822080818.12486-6-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replace GCM IV size value by their constant name.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/crypto/atmel-aes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
index 29e20c37f3a6..903fd43f23a5 100644
--- a/drivers/crypto/atmel-aes.c
+++ b/drivers/crypto/atmel-aes.c
@@ -36,6 +36,7 @@
 #include <crypto/scatterwalk.h>
 #include <crypto/algapi.h>
 #include <crypto/aes.h>
+#include <crypto/gcm.h>
 #include <crypto/xts.h>
 #include <crypto/internal/aead.h>
 #include <linux/platform_data/crypto-atmel.h>
@@ -1532,7 +1533,7 @@ static int atmel_aes_gcm_start(struct atmel_aes_dev *dd)
 	if (err)
 		return atmel_aes_complete(dd, err);
 
-	if (likely(ivsize == 12)) {
+	if (likely(ivsize == GCM_AES_IV_SIZE)) {
 		memcpy(ctx->j0, iv, ivsize);
 		ctx->j0[3] = cpu_to_be32(1);
 		return atmel_aes_gcm_process(dd);
@@ -1820,7 +1821,7 @@ static struct aead_alg aes_gcm_alg = {
 	.decrypt	= atmel_aes_gcm_decrypt,
 	.init		= atmel_aes_gcm_init,
 	.exit		= atmel_aes_gcm_exit,
-	.ivsize		= 12,
+	.ivsize		= GCM_AES_IV_SIZE,
 	.maxauthsize	= AES_BLOCK_SIZE,
 
 	.base = {
-- 
2.13.0
