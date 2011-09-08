From: deepthy.ravi@ti.com (Deepthy Ravi)
Date: Thu, 8 Sep 2011 19:07:26 +0530
Subject: [PATCH 7/8] omap3evm: camera: Configure BT656 interface
Message-ID: <1315489046-16332-1-git-send-email-deepthy.ravi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vaibhav Hiremath <hvaibhav@ti.com>

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Deepthy Ravi <deepthy.ravi@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm-camera.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm-camera.c b/arch/arm/mach-omap2/board-omap3evm-camera.c
index 718dd6d..e92fb13 100644
--- a/arch/arm/mach-omap2/board-omap3evm-camera.c
+++ b/arch/arm/mach-omap2/board-omap3evm-camera.c
@@ -141,9 +141,14 @@ static struct isp_v4l2_subdevs_group omap3evm_camera_subdevs[] = {
 		.interface      = ISP_INTERFACE_PARALLEL,
 		.bus            = {
 			.parallel       = {
-				.data_lane_shift        = 1,
-				.clk_pol                = 0,
-				.bridge                 = 0,
+				.width			= 8,
+				.data_lane_shift	= 1,
+				.clk_pol		= 0,
+				.hs_pol			= 0,
+				.vs_pol			= 1,
+				.fldmode		= 1,
+				.bridge			= 0,
+				.is_bt656		= 1,
 			},
 		}
 	},
-- 
1.7.0.4
