From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  6 Nov 2018 10:39:59 +0100
Subject: [PATCH 0/3] drm/meson: Add support for Overlay and OSD Plane scaling
Message-ID: <1541497202-20570-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This serie adds support for :
- Overlay Plane blended with the primary plane, we can describe as "behind"
- Primary Plane up-scaling up to 5x factor to support the OSD plane being
  upscaled from 1920x1080 when the display mode is set as 3840x2160.

These patches depends on the "drm/meson: Allow using optional canvas provider"
patchset from Maxime Jourdan at [1]

[1] https://patchwork.kernel.org/project/linux-amlogic/list/?series=38355

Neil Armstrong (3):
  drm/meson: Support Overlay plane for video rendering
  drm/meson: move OSD scaler management into plane atomic update
  drm/meson: Add primary plane scaling

 drivers/gpu/drm/meson/Makefile          |   2 +-
 drivers/gpu/drm/meson/meson_canvas.c    |   7 +-
 drivers/gpu/drm/meson/meson_canvas.h    |  11 +-
 drivers/gpu/drm/meson/meson_crtc.c      | 251 +++++++++++++-
 drivers/gpu/drm/meson/meson_drv.c       |  29 +-
 drivers/gpu/drm/meson/meson_drv.h       |  62 ++++
 drivers/gpu/drm/meson/meson_overlay.c   | 586 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/meson/meson_overlay.h   |  14 +
 drivers/gpu/drm/meson/meson_plane.c     | 177 ++++++++--
 drivers/gpu/drm/meson/meson_registers.h |   3 +
 drivers/gpu/drm/meson/meson_viu.c       |  15 +
 drivers/gpu/drm/meson/meson_vpp.c       |  90 +++--
 12 files changed, 1156 insertions(+), 91 deletions(-)
 create mode 100644 drivers/gpu/drm/meson/meson_overlay.c
 create mode 100644 drivers/gpu/drm/meson/meson_overlay.h

-- 
2.7.4
