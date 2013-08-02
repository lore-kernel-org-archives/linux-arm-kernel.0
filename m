From: jason@lakedaemon.net (Jason Cooper)
Date: Fri,  2 Aug 2013 15:51:12 +0000
Subject: [RFC PATCH V2 5/9] directly include needed headers
In-Reply-To: <cover.1375457714.git.jason@lakedaemon.net>
References: <cover.1375457714.git.jason@lakedaemon.net>
Message-ID: <7497c62ab2ea3f5373f9fe9ea99b1ccbc833821c.1375457714.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 atags.h | 2 ++
 board.h | 3 +++
 print.h | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/atags.h b/atags.h
index 30e6ee7..83f93a1 100644
--- a/atags.h
+++ b/atags.h
@@ -1,6 +1,8 @@
 #ifndef _ATAG_H
 #define _ATAG_H
 
+#include "types.h"
+
 #define ATAG_NONE       0x00000000
 
 struct tag_header {
diff --git a/board.h b/board.h
index 5146db0..af64e94 100644
--- a/board.h
+++ b/board.h
@@ -1,6 +1,9 @@
 #ifndef _BOARD_H
 #define _BOARD_H
 
+#include "types.h"
+#include "atags.h"
+
 struct board {
 	__u32		machid;
 	__u32		system_rev;
diff --git a/print.h b/print.h
index 402def6..5320727 100644
--- a/print.h
+++ b/print.h
@@ -1,6 +1,8 @@
 #ifndef _PRINT_H
 #define _PRINT_H
 
+#include "types.h"
+
 void putch(char c);
 void printhex(__u32 u);
 void putstr(const char *s);
-- 
1.8.3.2
