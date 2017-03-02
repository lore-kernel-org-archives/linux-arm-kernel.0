From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Thu, 2 Mar 2017 14:22:10 +0800
Subject: [PATCH V3 4/4] serial: sprd: adjust TIMEOUT to a big value
In-Reply-To: <1488435730-6711-1-git-send-email-chunyan.zhang@spreadtrum.com>
References: <1488435730-6711-1-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <1488435730-6711-5-git-send-email-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Qiao <wei.qiao@spreadtrum.com>

SPRD_TIMEOUT was 256, which is too small to wait until the status
switched to workable in a while loop, so that the earlycon could
not work correctly.

Signed-off-by: Wei Qiao <wei.qiao@spreadtrum.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 drivers/tty/serial/sprd_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 699447a..cc1a55e 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -36,7 +36,7 @@
 #define SPRD_FIFO_SIZE		128
 #define SPRD_DEF_RATE		26000000
 #define SPRD_BAUD_IO_LIMIT	3000000
-#define SPRD_TIMEOUT		256
+#define SPRD_TIMEOUT		256000
 
 /* the offset of serial registers and BITs for them */
 /* data registers */
-- 
2.7.4
