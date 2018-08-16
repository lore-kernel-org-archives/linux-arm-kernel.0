From: wendy.liang@xilinx.com (Wendy Liang)
Date: Thu, 16 Aug 2018 00:06:25 -0700
Subject: [PATCH 2/7] firmware: xlnx-zynqmp: Add request ack enums
In-Reply-To: <1534403190-28523-1-git-send-email-jliang@xilinx.com>
References: <1534403190-28523-1-git-send-email-jliang@xilinx.com>
Message-ID: <1534403190-28523-3-git-send-email-jliang@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add firmware request ack enums which will be used in firmware
request calls.

Signed-off-by: Wendy Liang <jliang@xilinx.com>
---
 include/linux/firmware/xlnx-zynqmp.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 9c4258f..e3b7292 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -32,6 +32,12 @@
 /* Number of 32bits values in payload */
 #define PAYLOAD_ARG_CNT	4U
 
+enum zynqmp_pm_request_ack {
+	ZYNQMP_PM_REQUEST_ACK_NO = 1,
+	ZYNQMP_PM_REQUEST_ACK_BLOCKING,
+	ZYNQMP_PM_REQUEST_ACK_NON_BLOCKING,
+};
+
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
 	PM_IOCTL = 34,
-- 
2.7.4
