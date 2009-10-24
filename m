From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 24 Oct 2009 22:01:08 +0200
Subject: staging/dream: remove wakelock support from smd_rpcrouter.h
Message-ID: <20091024200108.GA23703@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


wakelocks are power optimalization, not supported in mainline. Remove
them so that code compiles on mainline.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

--- a/drivers/staging/dream/smd/smd_rpcrouter.h
+++ b/drivers/staging/dream/smd/smd_rpcrouter.h
@@ -22,7 +22,6 @@
 #include <linux/list.h>
 #include <linux/cdev.h>
 #include <linux/platform_device.h>
-#include <linux/wakelock.h>
 
 #include <mach/msm_smd.h>
 #include <mach/msm_rpcrouter.h>
@@ -144,7 +143,6 @@ struct msm_rpc_endpoint {
 	/* complete packets waiting to be read */
 	struct list_head read_q;
 	spinlock_t read_q_lock;
-	struct wake_lock read_q_wake_lock;
 	wait_queue_head_t wait_q;
 	unsigned flags;
 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
