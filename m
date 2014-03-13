From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 13 Mar 2014 11:18:23 +0200
Subject: [PATCH 01/18] platform_data: edma: Be precise with the paRAM struct
In-Reply-To: <1394702320-21743-1-git-send-email-peter.ujfalusi@ti.com>
References: <1394702320-21743-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1394702320-21743-2-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The edmacc_param struct should follow the layout of the paRAM area in the
HW. Be explicit on the size of the fields (u32) and also mark the struct
as packed to avoid any padding on non 32bit architectures.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/linux/platform_data/edma.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/platform_data/edma.h b/include/linux/platform_data/edma.h
index f50821cb64be..923f8a3e4ce0 100644
--- a/include/linux/platform_data/edma.h
+++ b/include/linux/platform_data/edma.h
@@ -43,15 +43,15 @@
 
 /* PaRAM slots are laid out like this */
 struct edmacc_param {
-	unsigned int opt;
-	unsigned int src;
-	unsigned int a_b_cnt;
-	unsigned int dst;
-	unsigned int src_dst_bidx;
-	unsigned int link_bcntrld;
-	unsigned int src_dst_cidx;
-	unsigned int ccnt;
-};
+	u32 opt;
+	u32 src;
+	u32 a_b_cnt;
+	u32 dst;
+	u32 src_dst_bidx;
+	u32 link_bcntrld;
+	u32 src_dst_cidx;
+	u32 ccnt;
+} __packed;
 
 /* fields in edmacc_param.opt */
 #define SAM		BIT(0)
-- 
1.9.0
