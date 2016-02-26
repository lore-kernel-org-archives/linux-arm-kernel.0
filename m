From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Feb 2016 13:54:09 +0100
Subject: [PATCH 1/2] orangefs: remove unused 'diff' function
Message-ID: <1456491255-1111319-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

orangefs contains a helper function to calculate the difference
between two timeval structures. We are trying to remove all
instances of timespec from the kernel, and this one is not
used at all, so let's remove it now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/orangefs/orangefs-kernel.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
index 6290c24d8270..9d92c4fc7dbd 100644
--- a/fs/orangefs/orangefs-kernel.h
+++ b/fs/orangefs/orangefs-kernel.h
@@ -675,15 +675,4 @@ static inline void orangefs_i_size_write(struct inode *inode, loff_t i_size)
 #endif
 }
 
-static inline unsigned int diff(struct timeval *end, struct timeval *begin)
-{
-	if (end->tv_usec < begin->tv_usec) {
-		end->tv_usec += 1000000;
-		end->tv_sec--;
-	}
-	end->tv_sec -= begin->tv_sec;
-	end->tv_usec -= begin->tv_usec;
-	return (end->tv_sec * 1000000) + end->tv_usec;
-}
-
 #endif /* __ORANGEFSKERNEL_H */
-- 
2.7.0
