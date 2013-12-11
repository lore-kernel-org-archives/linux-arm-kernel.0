From: p.wilczek@samsung.com (Piotr Wilczek)
Date: Wed, 11 Dec 2013 14:07:32 +0100
Subject: [PATCH 1/8] registers: add write u8 type
In-Reply-To: <1386767259-15693-1-git-send-email-p.wilczek@samsung.com>
References: <1386767259-15693-1-git-send-email-p.wilczek@samsung.com>
Message-ID: <1386767259-15693-2-git-send-email-p.wilczek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Piotr Wilczek <p.wilczek@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 register.c |   10 ++++++++++
 register.h |    3 +++
 types.h    |    1 +
 3 files changed, 14 insertions(+)

diff --git a/register.c b/register.c
index dfbe145..af992ec 100644
--- a/register.c
+++ b/register.c
@@ -1,5 +1,15 @@
 #include "types.h"
 
+inline void writeb(u8 val, u32 addr)
+{
+	*(volatile u32 *)addr = val;
+}
+
+inline u8 readb(u32 addr)
+{
+	return *(volatile u32 *)addr;
+}
+
 inline void writel(u32 val, u32 addr)
 {
 	*(volatile u32 *) addr = val;
diff --git a/register.h b/register.h
index b7831eb..5a89802 100644
--- a/register.h
+++ b/register.h
@@ -3,6 +3,9 @@
 
 #include "types.h"
 
+void writeb(u8, u32);
+u8 readb(u32);
+
 void writel(u32, u32);
 u32 readl(u32);
 
diff --git a/types.h b/types.h
index 1e6c56a..636f95b 100644
--- a/types.h
+++ b/types.h
@@ -1,6 +1,7 @@
 #ifndef _TYPES_H
 #define _TYPES_H
 
+typedef unsigned char u8;
 typedef unsigned int u32;
 typedef unsigned long long u64;
 #define NULL	((void *) 0)
-- 
1.7.9.5
