From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 1 Jun 2016 11:56:04 +0300
Subject: [PATCH 03/28] crypto: omap-sham: change queue size from 1 to 10
In-Reply-To: <1464771389-10640-1-git-send-email-t-kristo@ti.com>
References: <1464771389-10640-1-git-send-email-t-kristo@ti.com>
Message-ID: <1464771389-10640-4-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change crypto queue size from 1 to 10 for omap SHA driver. This should
allow clients to enqueue requests more effectively to avoid serializing
whole crypto sequences, giving extra performance.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/crypto/omap-sham.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index bd0258f..71eac5c 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -173,7 +173,7 @@ struct omap_sham_ctx {
 	struct omap_sham_hmac_ctx base[0];
 };
 
-#define OMAP_SHAM_QUEUE_LENGTH	1
+#define OMAP_SHAM_QUEUE_LENGTH	10
 
 struct omap_sham_algs_info {
 	struct ahash_alg	*algs_list;
-- 
1.9.1
