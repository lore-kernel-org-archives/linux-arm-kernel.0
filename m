From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Fri, 19 May 2017 08:53:26 +0200
Subject: [PATCH v2 4/9] crypto: marvell - Use IPAD/OPAD constant
In-Reply-To: <20170519065331.27670-1-clabbe.montjoie@gmail.com>
References: <20170519065331.27670-1-clabbe.montjoie@gmail.com>
Message-ID: <20170519065331.27670-5-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch simply replace all occurrence of HMAC IPAD/OPAD value by their
define.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/crypto/marvell/hash.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/marvell/hash.c b/drivers/crypto/marvell/hash.c
index 77c0fb936f47..e61b08566093 100644
--- a/drivers/crypto/marvell/hash.c
+++ b/drivers/crypto/marvell/hash.c
@@ -12,6 +12,7 @@
  * by the Free Software Foundation.
  */
 
+#include <crypto/hmac.h>
 #include <crypto/md5.h>
 #include <crypto/sha.h>
 
@@ -1164,8 +1165,8 @@ static int mv_cesa_ahmac_pad_init(struct ahash_request *req,
 	memcpy(opad, ipad, blocksize);
 
 	for (i = 0; i < blocksize; i++) {
-		ipad[i] ^= 0x36;
-		opad[i] ^= 0x5c;
+		ipad[i] ^= HMAC_IPAD_VALUE;
+		opad[i] ^= HMAC_OPAD_VALUE;
 	}
 
 	return 0;
-- 
2.13.0
