From: mjourdan@baylibre.com (Maxime Jourdan)
Date: Mon,  5 Nov 2018 11:45:06 +0100
Subject: [PATCH 0/2] drm/meson: Allow using optional canvas provider
Message-ID: <20181105104508.23090-1-mjourdan@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The meson DRM driver currently uses constant, static canvas indexes.

This is not optimal and could conflict with other drivers also using
canvases.

This patch series allows the driver to optionnally use a canvas provider
module that is able to dispatch canvases, on demand and free of conflict.

In the future, the current way of doing things will be deprecated.

Maxime Jourdan (2):
  dt-bindings: display: amlogic, meson-vpu: Add optional canvas provider
    node
  drm/meson: Use optional canvas provider

 .../bindings/display/amlogic,meson-vpu.txt    |  2 +
 drivers/gpu/drm/meson/Kconfig                 |  1 +
 drivers/gpu/drm/meson/meson_crtc.c            | 14 ++++--
 drivers/gpu/drm/meson/meson_drv.c             | 46 ++++++++++++-------
 drivers/gpu/drm/meson/meson_drv.h             |  4 ++
 drivers/gpu/drm/meson/meson_plane.c           |  8 +++-
 6 files changed, 53 insertions(+), 22 deletions(-)

-- 
2.19.1
