From: colin.king@canonical.com (Colin King)
Date: Wed,  1 Feb 2017 11:57:11 +0000
Subject: [PATCH] staging: bcm2835-audio: use | instead of || otherwise result
 is just boolean 1
Message-ID: <20170201115711.17360-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

The incorrect or operator is being used resulting in cookies being
set to 1 (true) rather than the intended hex value.  Fix this by
using | instead of ||.

Issue found with static analysis with cppcheck

Fixes: 0cec463e391e05b807a ("staging: bcm2835-audio: Simplify callback structure for write data")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/bcm2835-audio/bcm2835-vchiq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/bcm2835-audio/bcm2835-vchiq.c
index e8fd9c7..280028d 100644
--- a/drivers/staging/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/bcm2835-audio/bcm2835-vchiq.c
@@ -100,9 +100,9 @@ bcm2835_vchi_msg_queue(VCHI_SERVICE_HANDLE_T handle,
 			      size);
 }
 
-static const u32 BCM2835_AUDIO_WRITE_COOKIE1 = ('B' << 24 | 'C' << 16 ||
+static const u32 BCM2835_AUDIO_WRITE_COOKIE1 = ('B' << 24 | 'C' << 16 |
 						'M' << 8  | 'A');
-static const u32 BCM2835_AUDIO_WRITE_COOKIE2 = ('D' << 24 | 'A' << 16 ||
+static const u32 BCM2835_AUDIO_WRITE_COOKIE2 = ('D' << 24 | 'A' << 16 |
 						'T' << 8  | 'A');
 
 struct bcm2835_audio_work {
-- 
2.10.2
