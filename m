From: thommycheck@gmx.de (Thomas Kunze)
Date: Tue, 10 Feb 2009 14:54:57 +0100
Subject: [PATCH 3/9] move drivers/mfd/*.h to include/linux/mfd
Message-ID: <mailman.54.1254846767.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So drivers like collie_battery driver can use
those files easier.

Signed-off-by: Thomas Kunze <thommycheck@gmx.de>
---
 drivers/mfd/mcp-core.c                   |    2 +-
 drivers/mfd/mcp-sa11x0.c                 |    2 +-
 drivers/mfd/ucb1x00-assabet.c            |    2 +-
 drivers/mfd/ucb1x00-core.c               |    2 +-
 drivers/mfd/ucb1x00-ts.c                 |    2 +-
 {drivers => include/linux}/mfd/mcp.h     |    2 ++
 {drivers => include/linux}/mfd/ucb1x00.h |    4 ++--
 7 files changed, 9 insertions(+), 7 deletions(-)
 rename {drivers => include/linux}/mfd/mcp.h (98%)
 rename {drivers => include/linux}/mfd/ucb1x00.h (99%)

diff --git a/drivers/mfd/mcp-core.c b/drivers/mfd/mcp-core.c
index 57271cb..84815f9 100644
--- a/drivers/mfd/mcp-core.c
+++ b/drivers/mfd/mcp-core.c
@@ -17,11 +17,11 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/mfd/mcp.h>
 
 #include <mach/dma.h>
 #include <asm/system.h>
 
-#include "mcp.h"
 
 #define to_mcp(d)		container_of(d, struct mcp, attached_device)
 #define to_mcp_driver(d)	container_of(d, struct mcp_driver, drv)
diff --git a/drivers/mfd/mcp-sa11x0.c b/drivers/mfd/mcp-sa11x0.c
index 62b32da..2121898 100644
--- a/drivers/mfd/mcp-sa11x0.c
+++ b/drivers/mfd/mcp-sa11x0.c
@@ -19,6 +19,7 @@
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
+#include <linux/mfd/mcp.h>
 
 #include <mach/dma.h>
 #include <mach/hardware.h>
@@ -28,7 +29,6 @@
 
 #include <mach/assabet.h>
 
-#include "mcp.h"
 
 struct mcp_sa11x0 {
 	u32	mccr0;
diff --git a/drivers/mfd/ucb1x00-assabet.c b/drivers/mfd/ucb1x00-assabet.c
index 86fed48..cea9da6 100644
--- a/drivers/mfd/ucb1x00-assabet.c
+++ b/drivers/mfd/ucb1x00-assabet.c
@@ -14,10 +14,10 @@
 #include <linux/fs.h>
 #include <linux/proc_fs.h>
 #include <linux/device.h>
+#include <linux/mfd/ucb1x00.h>
 
 #include <mach/dma.h>
 
-#include "ucb1x00.h"
 
 #define UCB1X00_ATTR(name,input)\
 static ssize_t name##_show(struct device *dev, struct device_attribute *attr, \
diff --git a/drivers/mfd/ucb1x00-core.c b/drivers/mfd/ucb1x00-core.c
index fea9085..61f3933 100644
--- a/drivers/mfd/ucb1x00-core.c
+++ b/drivers/mfd/ucb1x00-core.c
@@ -24,11 +24,11 @@
 #include <linux/interrupt.h>
 #include <linux/device.h>
 #include <linux/mutex.h>
+#include <linux/mfd/ucb1x00.h>
 
 #include <mach/dma.h>
 #include <mach/hardware.h>
 
-#include "ucb1x00.h"
 
 static DEFINE_MUTEX(ucb1x00_mutex);
 static LIST_HEAD(ucb1x00_drivers);
diff --git a/drivers/mfd/ucb1x00-ts.c b/drivers/mfd/ucb1x00-ts.c
index 61b7d3e..000cb41 100644
--- a/drivers/mfd/ucb1x00-ts.c
+++ b/drivers/mfd/ucb1x00-ts.c
@@ -30,12 +30,12 @@
 #include <linux/freezer.h>
 #include <linux/slab.h>
 #include <linux/kthread.h>
+#include <linux/mfd/ucb1x00.h>
 
 #include <mach/dma.h>
 #include <mach/collie.h>
 #include <asm/mach-types.h>
 
-#include "ucb1x00.h"
 
 
 struct ucb1x00_ts {
diff --git a/drivers/mfd/mcp.h b/include/linux/mfd/mcp.h
similarity index 98%
rename from drivers/mfd/mcp.h
rename to include/linux/mfd/mcp.h
index c093a93..be95e09 100644
--- a/drivers/mfd/mcp.h
+++ b/include/linux/mfd/mcp.h
@@ -10,6 +10,8 @@
 #ifndef MCP_H
 #define MCP_H
 
+#include <mach/dma.h>
+
 struct mcp_ops;
 
 struct mcp {
diff --git a/drivers/mfd/ucb1x00.h b/include/linux/mfd/ucb1x00.h
similarity index 99%
rename from drivers/mfd/ucb1x00.h
rename to include/linux/mfd/ucb1x00.h
index a8ad8a0..eac3463 100644
--- a/drivers/mfd/ucb1x00.h
+++ b/include/linux/mfd/ucb1x00.h
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/mfd/ucb1x00.h
+ *  linux/include/mfd/ucb1x00.h
  *
  *  Copyright (C) 2001 Russell King, All Rights Reserved.
  *
@@ -10,6 +10,7 @@
 #ifndef UCB1200_H
 #define UCB1200_H
 
+#include <linux/mfd/mcp.h>
 #define UCB_IO_DATA	0x00
 #define UCB_IO_DIR	0x01
 
@@ -100,7 +101,6 @@
 #define UCB_MODE_DYN_VFLAG_ENA	(1 << 12)
 #define UCB_MODE_AUD_OFF_CAN	(1 << 13)
 
-#include "mcp.h"
 
 struct ucb1x00_irq {
 	void *devid;
-- 
1.6.0.4


--------------080106070900050803030700
Content-Type: text/x-diff;
 name="0006-add-gpiolib-support-to-ucb1x00.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0006-add-gpiolib-support-to-ucb1x00.patch"
