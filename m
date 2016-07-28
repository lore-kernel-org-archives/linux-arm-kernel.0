From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Thu, 28 Jul 2016 10:22:51 +0800
Subject: [PATCH v4 0/4] drm/mediatek: MT8173 gamma & dither support
Message-ID: <1469672575-5847-1-git-send-email-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is MT8173 gamma & dither support PATCH v4, based on 4.7-rc1.

Changes since v3:
 -Split the GAMMA patch into 3 patches.
   --AAL engine basic function
   --GAMMA engine basic function
   --GAMMA correction config function
 -Align the all definition to 4 digits.
 -Remove HW constrain check from calculate bpc.
 -Use symbol to replace magic number.
 -Add a function "mtk_dither_set".

Changes since v2:
 -Modify defines to match the register field names in the MT8173 datasheet
 -Made dithering function support hardware mirroring well on two monitor.

Changes since v1:
 -According to the suggestion from Daniel,
  we used the new atomic color management.
 -Applied gamma function at GAMMA engine (path 2).
 -Made dithering function support hardware mirroring well.
 -Removed the bpc variable from mtk_drm_crtc struct.

Bibby Hsieh (4):
  drm/mediatek: Add AAL engine basic function
  drm/mediatek: Add GAMMA engine basic function
  drm/mediatek: Add gamma correction.
  drm/mediatek: set mt8173 dithering function

 drivers/gpu/drm/mediatek/mtk_disp_ovl.c     |    3 +-
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c    |    3 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c     |   29 ++++-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.h     |    3 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |  151 +++++++++++++++++++++++++--
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |   18 +++-
 6 files changed, 189 insertions(+), 18 deletions(-)

-- 
1.7.9.5
