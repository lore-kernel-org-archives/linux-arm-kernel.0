From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Fri, 29 Jul 2016 17:04:07 +0800
Subject: [PATCH 0/7] drm/mediatek: cleaning up and refine
Message-ID: <1469783054-54567-1-git-send-email-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches based on 4.7-rc1 to clean up unused function & variable
and use drm core function instead.

The following patches are needed to cleanly apply on top of v4.7-rc1:
 - https://patchwork.kernel.org/patch/8044001/
   (drm: Deal with rotation in drm_plane_helper_check_update())
 - https://patchwork.kernel.org/patch/9248373/
   (drm: Warn about negative sizes when calculating scale factor)
 - https://patchwork.kernel.org/patch/9248371/
   (drm: Store clipped src/dst coordinatee in drm_plane_state)
 - https://patchwork.kernel.org/patch/9248363/
   (drm/plane-helper: Add drm_plane_helper_check_state())
 - https://patchwork.kernel.org/patch/9248361/
   (drm/mediatek: Use drm_plane_helper_check_state())

Bibby Hsieh (2):
  drm/mediatek: Use drm_atomic destroy_state helpers
  drm/mediatek: Fix mtk_atomic_complete for runtime_pm

Daniel Kurtz (5):
  drm/mediatek: Remove mtk_drm_crtc_check_flush
  drm/mediatek: plane: Remove plane zpos/index
  drm/mediatek: Remove mtk_drm_plane
  drm/mediatek: plane: Merge mtk_plane_enable into
    mtk_plane_atomic_update
  drm/mediatek: plane: Use FB's format's cpp to compute x offset

 drivers/gpu/drm/mediatek/mtk_drm_crtc.c  |   21 ++++----
 drivers/gpu/drm/mediatek/mtk_drm_crtc.h  |    1 -
 drivers/gpu/drm/mediatek/mtk_drm_drv.c   |   17 ++++++-
 drivers/gpu/drm/mediatek/mtk_drm_plane.c |   80 +++++++++++-------------------
 drivers/gpu/drm/mediatek/mtk_drm_plane.h |   15 +-----
 5 files changed, 56 insertions(+), 78 deletions(-)

-- 
1.7.9.5
