From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Tue, 25 Jun 2013 10:54:45 +0200
Subject: [PATCH 2/6] crypto: ux500/hash: add missing static qualifiers
In-Reply-To: <1372150489-25594-1-git-send-email-fabio.baltieri@linaro.org>
References: <1372150489-25594-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <1372150489-25594-3-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing static qualifiers to hash_process_data and hash_hw_final.

Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 drivers/crypto/ux500/hash/hash_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/ux500/hash/hash_core.c b/drivers/crypto/ux500/hash/hash_core.c
index 154f437..dbf7b63 100644
--- a/drivers/crypto/ux500/hash/hash_core.c
+++ b/drivers/crypto/ux500/hash/hash_core.c
@@ -792,8 +792,7 @@ void hash_begin(struct hash_device_data *device_data, struct hash_ctx *ctx)
 	HASH_CLEAR_BITS(&device_data->base->str, HASH_STR_NBLW_MASK);
 }
 
-int hash_process_data(
-		struct hash_device_data *device_data,
+static int hash_process_data(struct hash_device_data *device_data,
 		struct hash_ctx *ctx, struct hash_req_ctx *req_ctx,
 		int msg_length, u8 *data_buffer, u8 *buffer, u8 *index)
 {
@@ -992,7 +991,7 @@ out:
  * hash_hw_final - The final hash calculation function
  * @req:	The hash request for the job.
  */
-int hash_hw_final(struct ahash_request *req)
+static int hash_hw_final(struct ahash_request *req)
 {
 	int ret = 0;
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-- 
1.8.2
