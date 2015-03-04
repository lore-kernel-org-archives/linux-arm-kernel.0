From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  4 Mar 2015 20:33:10 +0100
Subject: [RFC PATCH 16/18] ARM: msm: make msm_smd.h global
In-Reply-To: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
References: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
Message-ID: <1425497592-1831064-17-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is one of several approaches to the problem of this
header file not being visible on ARCH_MULTIPLATFORM otherwise.

Signed-off-by: Arnd Bergmann <arnd@arnd@arndb.de>
---
 arch/arm/mach-msm/smd.c                                     | 6 +++---
 drivers/char/msm_smd_pkt.c                                  | 2 +-
 drivers/tty/serial/msm_smd_tty.c                            | 2 +-
 {arch/arm/mach-msm/include/mach => include/linux}/msm_smd.h | 0
 4 files changed, 5 insertions(+), 5 deletions(-)
 rename {arch/arm/mach-msm/include/mach => include/linux}/msm_smd.h (100%)

diff --git a/arch/arm/mach-msm/smd.c b/arch/arm/mach-msm/smd.c
index b87f183a86c5..b50b495ab281 100644
--- a/arch/arm/mach-msm/smd.c
+++ b/arch/arm/mach-msm/smd.c
@@ -29,7 +29,7 @@
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 
-#include <mach/msm_smd.h>
+#include <linux/msm_smd.h>
 
 #include "smd_private.h"
 #include "proc_comm.h"
@@ -59,14 +59,14 @@ enum {
 
 static int msm_smd_debug_mask;
 
-struct shared_info {
+struct msm_smd_shared_info {
 	int ready;
 	void __iomem *state;
 };
 
 static unsigned dummy_state[SMSM_STATE_COUNT];
 
-static struct shared_info smd_info = {
+static struct msm_smd_shared_info smd_info = {
 	/* FIXME: not a real __iomem pointer */
 	.state = &dummy_state,
 };
diff --git a/drivers/char/msm_smd_pkt.c b/drivers/char/msm_smd_pkt.c
index ba82a06d9684..2ee28ed77791 100644
--- a/drivers/char/msm_smd_pkt.c
+++ b/drivers/char/msm_smd_pkt.c
@@ -31,7 +31,7 @@
 #include <linux/workqueue.h>
 #include <linux/poll.h>
 
-#include <mach/msm_smd.h>
+#include <linux/msm_smd.h>
 
 #define NUM_SMD_PKT_PORTS 9
 #define DEVICE_NAME "smdpkt"
diff --git a/drivers/tty/serial/msm_smd_tty.c b/drivers/tty/serial/msm_smd_tty.c
index 1238ac370bff..246b81c316c0 100644
--- a/drivers/tty/serial/msm_smd_tty.c
+++ b/drivers/tty/serial/msm_smd_tty.c
@@ -24,7 +24,7 @@
 #include <linux/tty_driver.h>
 #include <linux/tty_flip.h>
 
-#include <mach/msm_smd.h>
+#include <linux/msm_smd.h>
 
 #define MAX_SMD_TTYS 32
 
diff --git a/arch/arm/mach-msm/include/mach/msm_smd.h b/include/linux/msm_smd.h
similarity index 100%
rename from arch/arm/mach-msm/include/mach/msm_smd.h
rename to include/linux/msm_smd.h
-- 
2.1.0.rc2
