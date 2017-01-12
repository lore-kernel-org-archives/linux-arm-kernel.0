From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 12 Jan 2017 09:58:40 +0100
Subject: [PATCH v5 0/4] drm/dp: Implement CRC debugfs API
Message-ID: <20170112085844.19878-1-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series builds up on the API for exposing captured CRCs through
debugfs.

It adds new DP helpers for starting and stopping CRC capture and gets
the Rockchip driver to use it.

Also had to add a connector backpointer to the drm_dp_aux struct so we could
wait for the right vblank and store the CRCs afterwards, I will be glad
to hear about better alternatives.

With these patches, tests in IGT such as kms_pipe_crc_basic and
kms_plane do pass on RK3288.

In this v5, "drm/dp: add helpers for capture of frame CRCs" has gone
back to the more explicit way of just retrying once.

Also, I have left the connector back pointer in the AUX structure, as on
IRC nor danvet nor me could find a good reason to change it.

Thanks,

Tomeu


Tomeu Vizoso (4):
  drm/bridge: analogix_dp: set connector to drm_dp_aux
  drm/dp: add helpers for capture of frame CRCs
  drm/bridge: analogix_dp: add helpers for capture of frame CRCs
  drm/rockchip: Implement CRC debugfs API

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  34 ++++--
 drivers/gpu/drm/drm_dp_helper.c                    | 124 +++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  42 +++++++
 include/drm/bridge/analogix_dp.h                   |   3 +
 include/drm/drm_dp_helper.h                        |   7 ++
 5 files changed, 202 insertions(+), 8 deletions(-)

-- 
2.9.3
