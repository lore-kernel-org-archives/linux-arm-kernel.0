From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Sun,  1 Nov 2015 07:46:15 +0000
Subject: [PATCH v6 1/3] percpu: remove PERCPU_ENOUGH_ROOM which is stale
 definition
In-Reply-To: <1446363977-23656-1-git-send-email-jungseoklee85@gmail.com>
References: <1446363977-23656-1-git-send-email-jungseoklee85@gmail.com>
Message-ID: <1446363977-23656-2-git-send-email-jungseoklee85@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As pure cleanup, this patch removes PERCPU_ENOUGH_ROOM which is not
used any more. That is, no code refers to the definition.

Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
---
 include/linux/percpu.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index caebf2a..4bc6daf 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -18,12 +18,6 @@
 #define PERCPU_MODULE_RESERVE		0
 #endif
 
-#ifndef PERCPU_ENOUGH_ROOM
-#define PERCPU_ENOUGH_ROOM						\
-	(ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES) +	\
-	 PERCPU_MODULE_RESERVE)
-#endif
-
 /* minimum unit size, also is the maximum supported allocation size */
 #define PCPU_MIN_UNIT_SIZE		PFN_ALIGN(32 << 10)
 
-- 
2.5.0
