From: wuchengli@chromium.org (Wu-Cheng Li)
Date: Wed,  8 Mar 2017 11:40:57 +0800
Subject: [PATCH v3 0/1] mtk-vcodec: check the vp9 decoder buffer index from VPU
Message-ID: <20170308034058.99886-1-wuchengli@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wu-Cheng Li <wuchengli@google.com>

v2: also check the result of vdec_if_decode in mtk_vdec_worker.
v3: set buffer status to VB2_BUF_STATE_ERROR. Move printk out of lock.

Wu-Cheng Li (1):
  mtk-vcodec: check the vp9 decoder buffer index from VPU.

 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c | 33 +++++++++++++++++-----
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.h |  2 ++
 .../media/platform/mtk-vcodec/vdec/vdec_vp9_if.c   | 26 +++++++++++++++++
 drivers/media/platform/mtk-vcodec/vdec_drv_if.h    |  2 ++
 4 files changed, 56 insertions(+), 7 deletions(-)

-- 
2.12.0.246.ga2ecc84866-goog
