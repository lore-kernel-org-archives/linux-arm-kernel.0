From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Dec 2015 14:49:29 +0100
Subject: [PATCH] orangefs: fix typo in ornagefs_inode_lock
Message-ID: <1450705769-17712-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Orangefs fails to build on 32-bit SMP configurations due to a simple
misspelling, this does the obvious fix.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 575e946125f7 ("Orangefs: change pvfs2 filenames to orangefs")
---
 fs/orangefs/orangefs-kernel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
index 0b7ba0496aa3..fe8284045a40 100644
--- a/fs/orangefs/orangefs-kernel.h
+++ b/fs/orangefs/orangefs-kernel.h
@@ -770,7 +770,7 @@ do {									\
 static inline void orangefs_i_size_write(struct inode *inode, loff_t i_size)
 {
 #if BITS_PER_LONG == 32 && defined(CONFIG_SMP)
-	ornagefs_inode_lock(inode);
+	orangefs_inode_lock(inode);
 #endif
 	i_size_write(inode, i_size);
 #if BITS_PER_LONG == 32 && defined(CONFIG_SMP)
-- 
2.1.0.rc2
