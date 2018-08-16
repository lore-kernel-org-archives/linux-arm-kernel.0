From: wendy.liang@xilinx.com (Wendy Liang)
Date: Thu, 16 Aug 2018 00:06:24 -0700
Subject: [PATCH 1/7] firmware: xlnx-zynqmp: Add RPU ioctl enums
In-Reply-To: <1534403190-28523-1-git-send-email-jliang@xilinx.com>
References: <1534403190-28523-1-git-send-email-jliang@xilinx.com>
Message-ID: <1534403190-28523-2-git-send-email-jliang@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ZynqMP firmware ioctl enums for RPU configuration.

Signed-off-by: Wendy Liang <jliang@xilinx.com>
---
 include/linux/firmware/xlnx-zynqmp.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index a3ef7d6..9c4258f 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -59,6 +59,10 @@ enum pm_ret_status {
 };
 
 enum pm_ioctl_id {
+	IOCTL_GET_RPU_OPER_MODE = 0,
+	IOCTL_SET_RPU_OPER_MODE,
+	IOCTL_RPU_BOOT_ADDR_CONFIG,
+	IOCTL_TCM_COMB_CONFIG,
 	IOCTL_SET_PLL_FRAC_MODE = 8,
 	IOCTL_GET_PLL_FRAC_MODE,
 	IOCTL_SET_PLL_FRAC_DATA,
@@ -75,6 +79,21 @@ enum pm_query_id {
 	PM_QID_CLOCK_GET_NUM_CLOCKS = 12,
 };
 
+enum rpu_oper_mode {
+	PM_RPU_MODE_LOCKSTEP,
+	PM_RPU_MODE_SPLIT,
+};
+
+enum rpu_boot_mem {
+	PM_RPU_BOOTMEM_LOVEC,
+	PM_RPU_BOOTMEM_HIVEC,
+};
+
+enum rpu_tcm_comb {
+	PM_RPU_TCM_SPLIT,
+	PM_RPU_TCM_COMB,
+};
+
 /**
  * struct zynqmp_pm_query_data - PM query data
  * @qid:	query ID
-- 
2.7.4
