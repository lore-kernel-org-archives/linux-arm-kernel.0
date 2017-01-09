From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon,  9 Jan 2017 14:32:32 +0100
Subject: [PATCH v4 0/5] drm/dp: Implement CRC debugfs API
Message-ID: <20170109133237.17413-1-tomeu.vizoso@collabora.com>
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

In this v4, "drm/dp: add helpers for capture of frame CRCs" has been
modified to address some of the comments from Sean Paul.

Thanks,

Tomeu


Tomeu Vizoso (5):
  drm/dp: add connector backpointer to drm_dp_aux
  drm/bridge: analogix_dp: set connector to drm_dp_aux
  drm/dp: add helpers for capture of frame CRCs
  drm/bridge: analogix_dp: add helpers for capture of frame CRCs
  drm/rockchip: Implement CRC debugfs API

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  34 ++++--
 drivers/gpu/drm/drm_dp_helper.c                    | 129 +++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  42 +++++++
 include/drm/bridge/analogix_dp.h                   |   3 +
 include/drm/drm_dp_helper.h                        |   9 ++
 5 files changed, 209 insertions(+), 8 deletions(-)

-- 
2.9.3
