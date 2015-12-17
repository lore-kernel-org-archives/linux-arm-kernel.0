From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Thu, 17 Dec 2015 18:13:06 +0100
Subject: [PATCH 22/24] crypto: atmel-aes: change the DMA threshold
In-Reply-To: <cover.1450366831.git.cyrille.pitchen@atmel.com>
References: <cover.1450366831.git.cyrille.pitchen@atmel.com>
Message-ID: <4b6dbda450970ac204c1b561278396d02b27dc7f.1450366831.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Increase the DMA threshold to 256: PIO accesses offer better performances
than the DMA when processing small amounts of data.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 drivers/crypto/atmel-aes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
index a34919f6b7d7..ea645b4ee997 100644
--- a/drivers/crypto/atmel-aes.c
+++ b/drivers/crypto/atmel-aes.c
@@ -76,7 +76,7 @@
 
 #define ATMEL_AES_QUEUE_LENGTH	50
 
-#define ATMEL_AES_DMA_THRESHOLD		16
+#define ATMEL_AES_DMA_THRESHOLD		256
 
 
 struct atmel_aes_caps {
-- 
1.8.2.2
