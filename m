From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri,  4 Jul 2014 10:30:41 +0200
Subject: [PATCH 0/5] Iterate of_graph endpoints using a for_each_... style
 macro
Message-ID: <1404462646-1769-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

decrementing the reference count of the previous endpoint node parameter to
of_graph_get_next_endpoint allows to wrap the function in a for_each macro.

This series removes the remaining workaround in imx-drm, adds the macro
for_each_endpoint_of_node, and switches the current users to it. It builds
upon Russell's patches:
 "drm: add of_graph endpoint helper to find possible CRTCs" and
 "imx-drm: convert imx-drm to use the generic DRM OF helper"

regards
Philipp

Philipp Zabel (5):
  imx-drm: Drop imx_drm_of_get_next_endpoint wrapper
  of: Decrement refcount of previous endpoint in
    of_graph_get_next_endpoint
  of: Add for_each_endpoint_of_node helper macro
  drm: use for_each_endpoint_of_node macro in drm_of_find_possible_crtcs
  imx-drm: use for_each_endpoint_of_node macro in
    imx_drm_encoder_get_mux_id

 drivers/gpu/drm/drm_of.c               |  8 ++------
 drivers/of/base.c                      |  9 +--------
 drivers/staging/imx-drm/imx-drm-core.c | 17 +++--------------
 include/linux/of_graph.h               |  4 ++++
 4 files changed, 10 insertions(+), 28 deletions(-)

-- 
2.0.0
