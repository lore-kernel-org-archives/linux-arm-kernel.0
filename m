From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 29 May 2017 22:27:33 +0200
Subject: [PATCH v2 07/12] crypto: sun4i-ss: simplify the appended bit
 assignment
In-Reply-To: <20170529202738.2167-1-antoine.tenart@free-electrons.com>
References: <20170529202738.2167-1-antoine.tenart@free-electrons.com>
Message-ID: <20170529202738.2167-8-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A bit is appended at the end of the input buffer for sha1. Simplify the
code assigning it.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/crypto/sunxi-ss/sun4i-ss-hash.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-hash.c b/drivers/crypto/sunxi-ss/sun4i-ss-hash.c
index 59d9b4412aca..0c2efc88bc0a 100644
--- a/drivers/crypto/sunxi-ss/sun4i-ss-hash.c
+++ b/drivers/crypto/sunxi-ss/sun4i-ss-hash.c
@@ -392,12 +392,8 @@ static int sun4i_hash(struct ahash_request *areq)
 	}
 
 	/* write the remaining bytes of the nbw buffer */
-	if (nbw) {
-		wb |= ((1 << 7) << (nbw * 8));
-		bf[j++] = wb;
-	} else {
-		bf[j++] = 1 << 7;
-	}
+	wb |= ((1 << 7) << (nbw * 8));
+	bf[j++] = wb;
 
 	/*
 	 * number of space to pad to obtain 64o minus 8(size) minus 4 (final 1)
-- 
2.9.4
