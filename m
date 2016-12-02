From: wuchengli@chromium.org (Wu-Cheng Li)
Date: Fri,  2 Dec 2016 10:38:33 +0800
Subject: [PATCH v1] mtk-vcodec: use V4L2_DEC_CMD_STOP to implement flush
Message-ID: <1480646314-75478-1-git-send-email-wuchengli@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wu-Cheng Li <wuchengli@google.com>

This patch uses V4L2_DEC_CMD_STOP to implement flush -- requesting
the remaining images to be returned to userspace. The old unofficial
way was to use a size-0 input buffer and the code is removed.

Tiffany Lin (1):
  mtk-vcodec: use V4L2_DEC_CMD_STOP to implement flush

 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c | 151 ++++++++++++++-------
 .../media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c |  14 ++
 drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h |   2 +
 3 files changed, 117 insertions(+), 50 deletions(-)

-- 
2.8.0.rc3.226.g39d4020
