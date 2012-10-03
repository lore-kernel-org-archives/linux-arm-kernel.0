From: prabhakar.csengg@gmail.com (Prabhakar)
Date: Wed,  3 Oct 2012 12:02:53 +0530
Subject: [PATCH] davinci: vpbe: replace V4L2_OUT_CAP_CUSTOM_TIMINGS with
 V4L2_OUT_CAP_DV_TIMINGS
Message-ID: <1349245973-7377-1-git-send-email-prabhakar.lad@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lad, Prabhakar <prabhakar.lad@ti.com>

This patch replaces V4L2_OUT_CAP_CUSTOM_TIMINGS macro with
V4L2_OUT_CAP_DV_TIMINGS. As V4L2_OUT_CAP_CUSTOM_TIMINGS is being phased
out.

Signed-off-by: Lad, Prabhakar <prabhakar.lad@ti.com>
Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Hans Verkuil <hansverk@cisco.com>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
---
 arch/arm/mach-davinci/board-dm644x-evm.c |    2 +-
 drivers/media/platform/davinci/vpbe.c    |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 3baf56d..a79dc1e 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -699,7 +699,7 @@ static struct vpbe_output dm644xevm_vpbe_outputs[] = {
 			.index		= 1,
 			.name		= "Component",
 			.type		= V4L2_OUTPUT_TYPE_ANALOG,
-			.capabilities	= V4L2_OUT_CAP_CUSTOM_TIMINGS,
+			.capabilities	= V4L2_OUT_CAP_DV_TIMINGS,
 		},
 		.subdev_name	= VPBE_VENC_SUBDEV_NAME,
 		.default_mode	= "480p59_94",
diff --git a/drivers/media/platform/davinci/vpbe.c b/drivers/media/platform/davinci/vpbe.c
index d03f452..9b623bc 100644
--- a/drivers/media/platform/davinci/vpbe.c
+++ b/drivers/media/platform/davinci/vpbe.c
@@ -340,7 +340,7 @@ static int vpbe_s_dv_timings(struct vpbe_device *vpbe_dev,
 
 
 	if (!(cfg->outputs[out_index].output.capabilities &
-	    V4L2_OUT_CAP_CUSTOM_TIMINGS))
+	    V4L2_OUT_CAP_DV_TIMINGS))
 		return -EINVAL;
 
 	for (i = 0; i < output->num_modes; i++) {
@@ -408,7 +408,7 @@ static int vpbe_enum_dv_timings(struct vpbe_device *vpbe_dev,
 	int j = 0;
 	int i;
 
-	if (!(output->output.capabilities & V4L2_OUT_CAP_CUSTOM_TIMINGS))
+	if (!(output->output.capabilities & V4L2_OUT_CAP_DV_TIMINGS))
 		return -EINVAL;
 
 	for (i = 0; i < output->num_modes; i++) {
-- 
1.7.4.1
