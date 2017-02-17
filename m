From: adanhawthorn@gmail.com (Nathan Howard)
Date: Fri, 17 Feb 2017 15:16:20 -0500
Subject: [PATCH 4/5] staging: bcm2835-audio: bcm2835.h: fix volatile coding
 style issue
In-Reply-To: <1487362603-15967-1-git-send-email-adanhawthorn@gmail.com>
References: <1487362603-15967-1-git-send-email-adanhawthorn@gmail.com>
Message-ID: <1487362603-15967-4-git-send-email-adanhawthorn@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix checkpatch.pl warning of the form "WARNING: Use of volatile is
usually wrong: see Documentation/process/volatile-considered-harmful.rst."

Signed-off-by: Nathan Howard <adanhawthorn@gmail.com>
---
 drivers/staging/bcm2835-audio/bcm2835.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/bcm2835-audio/bcm2835.h b/drivers/staging/bcm2835-audio/bcm2835.h
index 2f9d1c9..08f7ad6 100644
--- a/drivers/staging/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/bcm2835-audio/bcm2835.h
@@ -125,8 +125,8 @@ struct bcm2835_alsa_stream {
 	struct semaphore buffers_update_sem;
 	struct semaphore control_sem;
 	spinlock_t lock;
-	volatile unsigned int control;
-	volatile unsigned int status;
+	unsigned int control;
+	unsigned int status;
 
 	int open;
 	int running;
-- 
2.7.4
