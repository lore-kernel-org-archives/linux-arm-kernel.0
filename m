From: mchehab@s-opensource.com (Mauro Carvalho Chehab)
Date: Wed, 29 Nov 2017 07:08:08 -0500
Subject: [PATCH 5/7] media: venc: don't use kernel-doc for undescribed enums
In-Reply-To: <c73fcbc4af259923feac19eda4bb5e996b6de0fd.1511952403.git.mchehab@s-opensource.com>
References: <c73fcbc4af259923feac19eda4bb5e996b6de0fd.1511952403.git.mchehab@s-opensource.com>
Message-ID: <a4070956e83a5bd5cac48e07e11ed7aa45bb8ade.1511952403.git.mchehab@s-opensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are no descriptions for some enums, with produces lots
of warnings:

    drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c:55: warning: Enum value 'VENC_VP8_VPU_WORK_BUF_LUMA' not described in enum 'venc_vp8_vpu_work_buf'
    drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c:55: warning: Enum value 'VENC_VP8_VPU_WORK_BUF_LUMA2' not described in enum 'venc_vp8_vpu_work_buf'
    drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c:55: warning: Enum value 'VENC_VP8_VPU_WORK_BUF_LUMA3' not described in enum 'venc_vp8_vpu_work_buf'
    drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c:55: warning: Enum value 'VENC_VP8_VPU_WORK_BUF_CHROMA' not described in enum 'venc_vp8_vpu_work_buf'
    drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c:55: warning: Enum value 'VENC_VP8_VPU_WORK_BUF_CHROMA2' not described in enum 'venc_vp8_vpu_work_buf'
    drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c:55: warning: Enum value 'VENC_VP8_VPU_WORK_BUF_CHROMA3' not described in enum 'venc_vp8_vpu_work_buf'
    drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c:55: warning: Enum value 'VENC_VP8_VPU_WORK_BUF_MV_INFO' not described in enum 'venc_vp8_vpu_work_buf'
    drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c:55: warning: Enum value 'VENC_VP8_VPU_WORK_BUF_BS_HEADER' not described in enum 'venc_vp8_vpu_work_buf'
    drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c:55: warning: Enum value 'VENC_VP8_VPU_WORK_BUF_PROB_BUF' not described in enum 'venc_vp8_vpu_work_buf'
    drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c:55: warning: Enum value 'VENC_VP8_VPU_WORK_BUF_RC_INFO' not described in enum 'venc_vp8_vpu_work_buf'
    drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c:55: warning: Enum value 'VENC_VP8_VPU_WORK_BUF_RC_CODE' not described in enum 'venc_vp8_vpu_work_buf'
    drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c:55: warning: Enum value 'VENC_VP8_VPU_WORK_BUF_RC_CODE2' not described in enum 'venc_vp8_vpu_work_buf'
    drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c:55: warning: Enum value 'VENC_VP8_VPU_WORK_BUF_RC_CODE3' not described in enum 'venc_vp8_vpu_work_buf'
    drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c:55: warning: Enum value 'VENC_VP8_VPU_WORK_BUF_MAX' not described in enum 'venc_vp8_vpu_work_buf'
    drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c:51: warning: Enum value 'VENC_H264_VPU_WORK_BUF_RC_INFO' not described in enum 'venc_h264_vpu_work_buf'
    drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c:51: warning: Enum value 'VENC_H264_VPU_WORK_BUF_RC_CODE' not described in enum 'venc_h264_vpu_work_buf'
    drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c:51: warning: Enum value 'VENC_H264_VPU_WORK_BUF_REC_LUMA' not described in enum 'venc_h264_vpu_work_buf'
    drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c:51: warning: Enum value 'VENC_H264_VPU_WORK_BUF_REC_CHROMA' not described in enum 'venc_h264_vpu_work_buf'
    drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c:51: warning: Enum value 'VENC_H264_VPU_WORK_BUF_REF_LUMA' not described in enum 'venc_h264_vpu_work_buf'
    drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c:51: warning: Enum value 'VENC_H264_VPU_WORK_BUF_REF_CHROMA' not described in enum 'venc_h264_vpu_work_buf'
    drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c:51: warning: Enum value 'VENC_H264_VPU_WORK_BUF_MV_INFO_1' not described in enum 'venc_h264_vpu_work_buf'
    drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c:51: warning: Enum value 'VENC_H264_VPU_WORK_BUF_MV_INFO_2' not described in enum 'venc_h264_vpu_work_buf'
    drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c:51: warning: Enum value 'VENC_H264_VPU_WORK_BUF_SKIP_FRAME' not described in enum 'venc_h264_vpu_work_buf'
    drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c:51: warning: Enum value 'VENC_H264_VPU_WORK_BUF_MAX' not described in enum 'venc_h264_vpu_work_buf'
    drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c:60: warning: Enum value 'H264_BS_MODE_SPS' not described in enum 'venc_h264_bs_mode'
    drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c:60: warning: Enum value 'H264_BS_MODE_PPS' not described in enum 'venc_h264_bs_mode'
    drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c:60: warning: Enum value 'H264_BS_MODE_FRAME' not described in enum 'venc_h264_bs_mode'

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c | 4 ++--
 drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c b/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c
index 4eb3be37ba14..6cf31b366aad 100644
--- a/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c
+++ b/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c
@@ -34,7 +34,7 @@ static const char h264_filler_marker[] = {0x0, 0x0, 0x0, 0x1, 0xc};
 #define H264_FILLER_MARKER_SIZE ARRAY_SIZE(h264_filler_marker)
 #define VENC_PIC_BITSTREAM_BYTE_CNT 0x0098
 
-/**
+/*
  * enum venc_h264_vpu_work_buf - h264 encoder buffer index
  */
 enum venc_h264_vpu_work_buf {
@@ -50,7 +50,7 @@ enum venc_h264_vpu_work_buf {
 	VENC_H264_VPU_WORK_BUF_MAX,
 };
 
-/**
+/*
  * enum venc_h264_bs_mode - for bs_mode argument in h264_enc_vpu_encode
  */
 enum venc_h264_bs_mode {
diff --git a/drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c b/drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c
index acb639c4abd2..957420dd60de 100644
--- a/drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c
+++ b/drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c
@@ -34,7 +34,7 @@
 /* This ac_tag is vp8 frame tag. */
 #define MAX_AC_TAG_SIZE 10
 
-/**
+/*
  * enum venc_vp8_vpu_work_buf - vp8 encoder buffer index
  */
 enum venc_vp8_vpu_work_buf {
-- 
2.14.3
