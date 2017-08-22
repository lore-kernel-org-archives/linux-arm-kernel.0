From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue, 22 Aug 2017 10:08:18 +0200
Subject: [PATCH 11/11] crypto: aesni - Use GCM IV size constant
In-Reply-To: <20170822080818.12486-1-clabbe.montjoie@gmail.com>
References: <20170822080818.12486-1-clabbe.montjoie@gmail.com>
Message-ID: <20170822080818.12486-12-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replace GCM IV size value by their constant name.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/x86/crypto/aesni-intel_glue.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index 5c15d6b57329..80664368bf14 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -28,6 +28,7 @@
 #include <crypto/cryptd.h>
 #include <crypto/ctr.h>
 #include <crypto/b128ops.h>
+#include <crypto/gcm.h>
 #include <crypto/xts.h>
 #include <asm/cpu_device_id.h>
 #include <asm/fpu/api.h>
@@ -1131,7 +1132,7 @@ static struct aead_alg aesni_aead_algs[] = { {
 	.setauthsize		= common_rfc4106_set_authsize,
 	.encrypt		= helper_rfc4106_encrypt,
 	.decrypt		= helper_rfc4106_decrypt,
-	.ivsize			= 8,
+	.ivsize			= GCM_RFC4106_IV_SIZE,
 	.maxauthsize		= 16,
 	.base = {
 		.cra_name		= "__gcm-aes-aesni",
@@ -1149,7 +1150,7 @@ static struct aead_alg aesni_aead_algs[] = { {
 	.setauthsize		= rfc4106_set_authsize,
 	.encrypt		= rfc4106_encrypt,
 	.decrypt		= rfc4106_decrypt,
-	.ivsize			= 8,
+	.ivsize			= GCM_RFC4106_IV_SIZE,
 	.maxauthsize		= 16,
 	.base = {
 		.cra_name		= "rfc4106(gcm(aes))",
@@ -1165,7 +1166,7 @@ static struct aead_alg aesni_aead_algs[] = { {
 	.setauthsize		= generic_gcmaes_set_authsize,
 	.encrypt		= generic_gcmaes_encrypt,
 	.decrypt		= generic_gcmaes_decrypt,
-	.ivsize			= 12,
+	.ivsize			= GCM_AES_IV_SIZE,
 	.maxauthsize		= 16,
 	.base = {
 		.cra_name		= "gcm(aes)",
-- 
2.13.0
