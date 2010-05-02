From: saeed@marvell.com (Saeed Bishara)
Date: Sun,  2 May 2010 17:22:40 +0300
Subject: [PATCH 3/5] USB: add clk structure for systems that support clkdev
	framework
In-Reply-To: <1272810162-14858-3-git-send-email-saeed@marvell.com>
References: <1272810162-14858-1-git-send-email-saeed@marvell.com>
	<1272810162-14858-2-git-send-email-saeed@marvell.com>
	<1272810162-14858-3-git-send-email-saeed@marvell.com>
Message-ID: <1272810162-14858-4-git-send-email-saeed@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 drivers/usb/core/hcd.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/core/hcd.h b/drivers/usb/core/hcd.h
index a3cdb09..24ce9fe 100644
--- a/drivers/usb/core/hcd.h
+++ b/drivers/usb/core/hcd.h
@@ -22,6 +22,7 @@
 #ifdef __KERNEL__
 
 #include <linux/rwsem.h>
+#include <linux/clk.h>
 
 #define MAX_TOPO_LEVEL		6
 
@@ -110,6 +111,9 @@ struct usb_hcd {
 	u64			rsrc_start;	/* memory/io resource start */
 	u64			rsrc_len;	/* memory/io resource length */
 	unsigned		power_budget;	/* in mA, 0 = no limit */
+#if defined(CONFIG_HAVE_CLK)
+	struct clk		*clk;
+#endif
 
 	/* bandwidth_mutex should be taken before adding or removing
 	 * any new bus bandwidth constraints:
-- 
1.6.0.4
