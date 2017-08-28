From: bhumirks@gmail.com (Bhumika Goyal)
Date: Mon, 28 Aug 2017 23:02:11 +0530
Subject: [PATCH] fpga: make xlnx_pr_decoupler_br_ops const
Message-ID: <1503941531-17977-1-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make this const as it is only passed to a const argument of the function
fpga_bridge_register.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/fpga/xilinx-pr-decoupler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
index e359930..0d77430 100644
--- a/drivers/fpga/xilinx-pr-decoupler.c
+++ b/drivers/fpga/xilinx-pr-decoupler.c
@@ -79,7 +79,7 @@ static int xlnx_pr_decoupler_enable_show(struct fpga_bridge *bridge)
 	return !status;
 }
 
-static struct fpga_bridge_ops xlnx_pr_decoupler_br_ops = {
+static const struct fpga_bridge_ops xlnx_pr_decoupler_br_ops = {
 	.enable_set = xlnx_pr_decoupler_enable_set,
 	.enable_show = xlnx_pr_decoupler_enable_show,
 };
-- 
1.9.1
