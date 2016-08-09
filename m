From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue,  9 Aug 2016 12:51:31 +0200
Subject: [PATCH v1 0/5] drm/rockchip: Implement CRC debugfs API
Message-ID: <1470739896-11088-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series builds up on the API for exposing captured CRCs through
debugfs and also on the refactoring to the analogix_dp driver for using
the DP helpers (so it depends on those not-yet merged series).

It adds new DP helpers for starting and stopping CRC capture and gets
the Rockchip driver to use it.

Also had to add a connector backpointer to the AUX struct so we could
wait for the right vblank and store the CRCs afterwards.

Thanks,

Tomeu


Tomeu Vizoso (5):
  drm/dp: add connector backpointer to drm_dp_aux
  drm/bridge: analogix_dp: set connector to drm_dp_aux
  drm/dp: add helpers for capture of frame CRCs
  drm/bridge: analogix_dp: add helpers for capture of frame CRCs
  drm/rockchip: Implement CRC debugfs API

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  34 ++++--
 drivers/gpu/drm/drm_dp_helper.c                    | 133 +++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  48 ++++++++
 include/drm/bridge/analogix_dp.h                   |   3 +
 include/drm/drm_dp_helper.h                        |   9 ++
 5 files changed, 219 insertions(+), 8 deletions(-)

-- 
2.7.4
