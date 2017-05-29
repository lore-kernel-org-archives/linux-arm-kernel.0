From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 29 May 2017 22:27:30 +0200
Subject: [PATCH v2 04/12] crypto: sun4i-ss: cannot use DMA is the request is 0
 length
In-Reply-To: <20170529202738.2167-1-antoine.tenart@free-electrons.com>
References: <20170529202738.2167-1-antoine.tenart@free-electrons.com>
Message-ID: <20170529202738.2167-5-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do not use DMA is the request is 0 length.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/crypto/sunxi-ss/sun4i-ss-hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-hash.c b/drivers/crypto/sunxi-ss/sun4i-ss-hash.c
index e53c3127b743..bc3cbde07219 100644
--- a/drivers/crypto/sunxi-ss/sun4i-ss-hash.c
+++ b/drivers/crypto/sunxi-ss/sun4i-ss-hash.c
@@ -250,7 +250,7 @@ static int sun4i_hash(struct ahash_request *areq)
 			i = 0;
 		in_sg = sg_next(in_sg);
 	}
-	if (i == 1 && !op->len)
+	if (i == 1 && !op->len && areq->nbytes)
 		dev_dbg(ss->dev, "We can DMA\n");
 
 	i = 0;
-- 
2.9.4
