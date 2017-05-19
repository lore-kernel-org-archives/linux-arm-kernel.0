From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Fri, 19 May 2017 08:53:25 +0200
Subject: [PATCH v2 3/9] crypto: ixp4xx - Use IPAD/OPAD constant
In-Reply-To: <20170519065331.27670-1-clabbe.montjoie@gmail.com>
References: <20170519065331.27670-1-clabbe.montjoie@gmail.com>
Message-ID: <20170519065331.27670-4-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch simply replace all occurrence of HMAC IPAD/OPAD value by their
define.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/crypto/ixp4xx_crypto.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/ixp4xx_crypto.c b/drivers/crypto/ixp4xx_crypto.c
index 771dd26c7076..427cbe012729 100644
--- a/drivers/crypto/ixp4xx_crypto.c
+++ b/drivers/crypto/ixp4xx_crypto.c
@@ -23,6 +23,7 @@
 #include <crypto/ctr.h>
 #include <crypto/des.h>
 #include <crypto/aes.h>
+#include <crypto/hmac.h>
 #include <crypto/sha.h>
 #include <crypto/algapi.h>
 #include <crypto/internal/aead.h>
@@ -90,8 +91,6 @@
 #define CTL_FLAG_PERFORM_AEAD	0x0008
 #define CTL_FLAG_MASK		0x000f
 
-#define HMAC_IPAD_VALUE   0x36
-#define HMAC_OPAD_VALUE   0x5C
 #define HMAC_PAD_BLOCKLEN SHA1_BLOCK_SIZE
 
 #define MD5_DIGEST_SIZE   16
-- 
2.13.0
