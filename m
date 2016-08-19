From: minghsiu.tsai@mediatek.com (Minghsiu Tsai)
Date: Fri, 19 Aug 2016 19:39:24 +0800
Subject: [PATCH v4 1/4] VPU: mediatek: Add mdp support
In-Reply-To: <1471606767-3218-1-git-send-email-minghsiu.tsai@mediatek.com>
References: <1471606767-3218-1-git-send-email-minghsiu.tsai@mediatek.com>
Message-ID: <1471606767-3218-2-git-send-email-minghsiu.tsai@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VPU driver add mdp support

Signed-off-by: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
---
 drivers/media/platform/mtk-vpu/mtk_vpu.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/mtk-vpu/mtk_vpu.h b/drivers/media/platform/mtk-vpu/mtk_vpu.h
index f457479..291ae46 100644
--- a/drivers/media/platform/mtk-vpu/mtk_vpu.h
+++ b/drivers/media/platform/mtk-vpu/mtk_vpu.h
@@ -53,6 +53,8 @@ typedef void (*ipi_handler_t) (void *data,
 			 handle H264 video encoder job, and vice versa.
  * @IPI_VENC_VP8:	 The interrupt fro vpu is to notify kernel to
 			 handle VP8 video encoder job,, and vice versa.
+ * @IPI_MDP:		 The interrupt from vpu is to notify kernel to
+			 handle MDP (Media Data Path) job, and vice versa.
  * @IPI_MAX:		 The maximum IPI number
  */
 
@@ -63,6 +65,7 @@ enum ipi_id {
 	IPI_VDEC_VP9,
 	IPI_VENC_H264,
 	IPI_VENC_VP8,
+	IPI_MDP,
 	IPI_MAX,
 };
 
@@ -71,11 +74,13 @@ enum ipi_id {
  *
  * @VPU_RST_ENC: encoder reset id
  * @VPU_RST_DEC: decoder reset id
+ * @VPU_RST_MDP: MDP (Media Data Path) reset id
  * @VPU_RST_MAX: maximum reset id
  */
 enum rst_id {
 	VPU_RST_ENC,
 	VPU_RST_DEC,
+	VPU_RST_MDP,
 	VPU_RST_MAX,
 };
 
-- 
1.7.9.5
