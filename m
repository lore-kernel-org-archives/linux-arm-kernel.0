From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 07 May 2015 09:04:43 +0900
Subject: [RFT PATCH v2 0/3] drm/exynos: Fix build breakage on !DRM_EXYNOS_FIMD
Message-ID: <1430957086-25005-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

Hi,

This is second try to fix the build breakage introduced in 1c363c7cccf6
("drm/exynos: Enable DP clock to fix display on Exynos5250 and other").

The fix is not trivial so I am kindly asking for testing on Chromebook
and other DP-enabled boards (I don't have Chromebook right now).

Tested on Exynos4412 Trats2 board.

Best regards,
Krzysztof



Krzysztof Kozlowski (3):
  drm/exynos: Fix build breakage on !DRM_EXYNOS_FIMD
  drm/exynos: Constify exynos_drm_crtc_ops
  drm/exynos: Consolidate return statements in fimd_bind()

 drivers/gpu/drm/exynos/exynos7_drm_decon.c |  2 +-
 drivers/gpu/drm/exynos/exynos_dp_core.c    | 11 +++++--
 drivers/gpu/drm/exynos/exynos_drm_crtc.c   |  2 +-
 drivers/gpu/drm/exynos/exynos_drm_crtc.h   |  2 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.h    |  7 ++++-
 drivers/gpu/drm/exynos/exynos_drm_fimd.c   | 46 +++++++++++++-----------------
 drivers/gpu/drm/exynos/exynos_drm_fimd.h   | 15 ----------
 drivers/gpu/drm/exynos/exynos_drm_vidi.c   |  2 +-
 drivers/gpu/drm/exynos/exynos_mixer.c      |  2 +-
 9 files changed, 39 insertions(+), 50 deletions(-)
 delete mode 100644 drivers/gpu/drm/exynos/exynos_drm_fimd.h

-- 
1.9.1
