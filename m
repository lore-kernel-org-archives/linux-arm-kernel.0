From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 29 May 2017 22:27:36 +0200
Subject: [PATCH v2 10/12] crypto: sun4i-ss: add the
 CRYPTO_ALG_KERN_DRIVER_ONLY flag
In-Reply-To: <20170529202738.2167-1-antoine.tenart@free-electrons.com>
References: <20170529202738.2167-1-antoine.tenart@free-electrons.com>
Message-ID: <20170529202738.2167-11-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CRYPTO_ALG_KERN_DRIVER_ONLY flag is set for hardware accelerated
ciphers accessible through a kernel driver only. This is the case for
ciphers exposed by the sun4i-ss driver. This patch sets this flag.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/crypto/sunxi-ss/sun4i-ss-core.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-core.c b/drivers/crypto/sunxi-ss/sun4i-ss-core.c
index f7b99974d1bb..02ad8256e900 100644
--- a/drivers/crypto/sunxi-ss/sun4i-ss-core.c
+++ b/drivers/crypto/sunxi-ss/sun4i-ss-core.c
@@ -96,7 +96,8 @@ static struct sun4i_ss_alg_template ss_algs[] = {
 			.cra_driver_name = "cbc-aes-sun4i-ss",
 			.cra_priority = 300,
 			.cra_blocksize = AES_BLOCK_SIZE,
-			.cra_flags = CRYPTO_ALG_TYPE_SKCIPHER,
+			.cra_flags = CRYPTO_ALG_TYPE_SKCIPHER |
+				     CRYPTO_ALG_KERN_DRIVER_ONLY,
 			.cra_ctxsize = sizeof(struct sun4i_tfm_ctx),
 			.cra_module = THIS_MODULE,
 			.cra_alignmask = 3,
@@ -117,7 +118,8 @@ static struct sun4i_ss_alg_template ss_algs[] = {
 			.cra_driver_name = "ecb-aes-sun4i-ss",
 			.cra_priority = 300,
 			.cra_blocksize = AES_BLOCK_SIZE,
-			.cra_flags = CRYPTO_ALG_TYPE_SKCIPHER,
+			.cra_flags = CRYPTO_ALG_TYPE_SKCIPHER |
+				     CRYPTO_ALG_KERN_DRIVER_ONLY,
 			.cra_ctxsize = sizeof(struct sun4i_tfm_ctx),
 			.cra_module = THIS_MODULE,
 			.cra_alignmask = 3,
@@ -138,7 +140,8 @@ static struct sun4i_ss_alg_template ss_algs[] = {
 			.cra_driver_name = "cbc-des-sun4i-ss",
 			.cra_priority = 300,
 			.cra_blocksize = DES_BLOCK_SIZE,
-			.cra_flags = CRYPTO_ALG_TYPE_SKCIPHER,
+			.cra_flags = CRYPTO_ALG_TYPE_SKCIPHER |
+				     CRYPTO_ALG_KERN_DRIVER_ONLY,
 			.cra_ctxsize = sizeof(struct sun4i_req_ctx),
 			.cra_module = THIS_MODULE,
 			.cra_alignmask = 3,
@@ -158,7 +161,8 @@ static struct sun4i_ss_alg_template ss_algs[] = {
 			.cra_driver_name = "ecb-des-sun4i-ss",
 			.cra_priority = 300,
 			.cra_blocksize = DES_BLOCK_SIZE,
-			.cra_flags = CRYPTO_ALG_TYPE_SKCIPHER,
+			.cra_flags = CRYPTO_ALG_TYPE_SKCIPHER |
+				     CRYPTO_ALG_KERN_DRIVER_ONLY,
 			.cra_ctxsize = sizeof(struct sun4i_req_ctx),
 			.cra_module = THIS_MODULE,
 			.cra_alignmask = 3,
@@ -179,7 +183,8 @@ static struct sun4i_ss_alg_template ss_algs[] = {
 			.cra_driver_name = "cbc-des3-sun4i-ss",
 			.cra_priority = 300,
 			.cra_blocksize = DES3_EDE_BLOCK_SIZE,
-			.cra_flags = CRYPTO_ALG_TYPE_SKCIPHER,
+			.cra_flags = CRYPTO_ALG_TYPE_SKCIPHER |
+				     CRYPTO_ALG_KERN_DRIVER_ONLY,
 			.cra_ctxsize = sizeof(struct sun4i_req_ctx),
 			.cra_module = THIS_MODULE,
 			.cra_alignmask = 3,
-- 
2.9.4
