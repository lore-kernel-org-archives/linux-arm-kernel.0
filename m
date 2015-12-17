From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Thu, 17 Dec 2015 18:13:01 +0100
Subject: [PATCH 17/24] crypto: atmel-aes: use SIZE_IN_WORDS() helper macro
In-Reply-To: <cover.1450366831.git.cyrille.pitchen@atmel.com>
References: <cover.1450366831.git.cyrille.pitchen@atmel.com>
Message-ID: <d0bee31dc217a559cbef2326ba17c006c7619578.1450366831.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a dummy cosmetic patch.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 drivers/crypto/atmel-aes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
index 9ef38eca4ae7..176ab3878583 100644
--- a/drivers/crypto/atmel-aes.c
+++ b/drivers/crypto/atmel-aes.c
@@ -689,10 +689,10 @@ static void atmel_aes_write_ctrl(struct atmel_aes_dev *dd, bool use_dma,
 	atmel_aes_write(dd, AES_MR, valmr);
 
 	atmel_aes_write_n(dd, AES_KEYWR(0), dd->ctx->key,
-						dd->ctx->keylen >> 2);
+			  SIZE_IN_WORDS(dd->ctx->keylen));
 
 	if (iv && (valmr & AES_MR_OPMOD_MASK) != AES_MR_OPMOD_ECB)
-		atmel_aes_write_n(dd, AES_IVR(0), iv, 4);
+		atmel_aes_write_block(dd, AES_IVR(0), iv);
 }
 
 static int atmel_aes_handle_queue(struct atmel_aes_dev *dd,
-- 
1.8.2.2
