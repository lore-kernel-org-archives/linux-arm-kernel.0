From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Fri, 17 Jun 2016 09:58:12 +0800
Subject: [PATCH v2 0/2] drm/mediatek: MT8173 gamma & dither support
Message-ID: <1466128694-11208-1-git-send-email-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is MT8173 gamma & dither support PATCH v2, based on 4.7-rc1.

Changes since v1:
 -According to the suggestion from Daniel,
  we used the new atomic color management.
 -Applied gamma function at GAMMA engine (path 2).
 -Made dithering function support hardware mirroring well.
 -Removed the bpc variable from mtk_drm_crtc struct.

Bibby Hsieh (2):
  drm/mediatek: Add gamma correction
  drm/mediatek: set mt8173 dithering function

 drivers/gpu/drm/mediatek/mtk_disp_ovl.c     |    3 +-
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c    |    3 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c     |   26 ++++-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.h     |    1 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |  147 ++++++++++++++++++++++++++-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |   16 ++-
 6 files changed, 184 insertions(+), 12 deletions(-)

-- 
1.7.9.5
