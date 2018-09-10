From: jolly.shah@xilinx.com (Jolly Shah)
Date: Mon, 10 Sep 2018 13:01:33 -0700
Subject: [PATCH 2/3] firmware: xilinx: Move declaration of qdata to top of the
 function
In-Reply-To: <1536609694-7920-1-git-send-email-jollys@xilinx.com>
References: <1536609694-7920-1-git-send-email-jollys@xilinx.com>
Message-ID: <1536609694-7920-3-git-send-email-jollys@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Move structure declaration from switch case to the top of function
and drop the braces.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp-debug.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
index 4532bd0..ecbd599 100644
--- a/drivers/firmware/xilinx/zynqmp-debug.c
+++ b/drivers/firmware/xilinx/zynqmp-debug.c
@@ -87,6 +87,7 @@ static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
 	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 	u32 pm_api_version;
 	int ret;
+	struct zynqmp_pm_query_data qdata = {0};
 
 	if (!eemi_ops)
 		return -ENXIO;
@@ -107,9 +108,6 @@ static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
 				pm_api_ret[1]);
 		break;
 	case PM_QUERY_DATA:
-	{
-		struct zynqmp_pm_query_data qdata = {0};
-
 		qdata.qid = pm_api_arg[0];
 		qdata.arg1 = pm_api_arg[1];
 		qdata.arg2 = pm_api_arg[2];
@@ -131,7 +129,6 @@ static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
 				pm_api_ret[0], pm_api_ret[1],
 				pm_api_ret[2], pm_api_ret[3]);
 		break;
-	}
 	default:
 		sprintf(debugfs_buf, "Unsupported PM-API request\n");
 		ret = -EINVAL;
-- 
2.7.4
