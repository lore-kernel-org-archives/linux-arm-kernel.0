From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 13 Mar 2018 21:54:20 +0100
Subject: [PATCH v4 0/5] drm/blend: Support generic plane-wide alpha
Message-ID: <cover.b32b447321f6e04da30ed8099fbef2f00fc27fbc.1520974361.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This serie aims at enhancing the support for plane-wide alpha in the
drivers that are implementing it at the moment, by turning it into a
generic property and converting the drivers (rcar-du and atmel-hclcdc). It
also introduces support for it in the sun4i driver.

Let me know what you think,
Maxime

Changes from v3:
  - Rebased on current drm-misc-next

  - Made the alpha property a 16 bits property, and have the drivers
    drop the lowest 8 bits
  - Removed the csv documentation, and documented it in the doc instead

Changes from v2:
  - Rebased on current drm-misc-next
  - Removed the patches already applied
  - Split the patch implementing the automatic pipe assignment in two

Changes from v1:
  - Document the behaviour on concurrent usage of the alpha property and an
    alpha component in the format
  - Allowed for higher alpha values
  - Moved the alpha value from a helper to the struct drm_format_info
  - Collected tags
  - Rebased on current drm-misc-next

Maxime Ripard (5):
  drm/blend: Add a generic alpha property
  drm/atmel-hclcdc: Convert to the new generic alpha property
  drm/rcar-du: Convert to the new generic alpha property
  drm/sun4i: Add support for plane alpha
  drm/docs: Remove the rcar alpha from the csv file

 Documentation/gpu/kms-properties.csv            |  1 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h    | 13 +---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 89 ++----------------
 drivers/gpu/drm/drm_atomic.c                    |  4 +-
 drivers/gpu/drm/drm_atomic_helper.c             |  4 +-
 drivers/gpu/drm/drm_blend.c                     | 38 ++++++++-
 drivers/gpu/drm/rcar-du/rcar_du_drv.h           |  1 +-
 drivers/gpu/drm/rcar-du/rcar_du_kms.c           |  5 +-
 drivers/gpu/drm/rcar-du/rcar_du_plane.c         | 15 +--
 drivers/gpu/drm/rcar-du/rcar_du_plane.h         |  2 +-
 drivers/gpu/drm/rcar-du/rcar_du_vsp.c           | 42 +--------
 drivers/gpu/drm/rcar-du/rcar_du_vsp.h           |  2 +-
 drivers/gpu/drm/sun4i/sun4i_backend.c           | 16 ++-
 drivers/gpu/drm/sun4i/sun4i_backend.h           |  3 +-
 drivers/gpu/drm/sun4i/sun4i_layer.c             |  2 +-
 include/drm/drm_blend.h                         |  3 +-
 include/drm/drm_plane.h                         |  6 +-
 17 files changed, 96 insertions(+), 150 deletions(-)

base-commit: 9c936b12f15019b38edb5f8bae77bb5b0046d1b7
-- 
git-series 0.9.1
