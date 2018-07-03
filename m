From: dkos@cadence.com (Damian Kos)
Date: Tue, 3 Jul 2018 11:02:11 +0100
Subject: [PATCH 00/12] drm: add support for Cadence MHDP DPI/DP bridge.
Message-ID: <1530612152-27555-1-git-send-email-dkos@cadence.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Damian Kos (3):
  dt-bindings: drm/bridge: Document Cadence MHDP bridge bindings
  drm/rockchip: added implementation for a few FW commands.
  drm/rockchip: add support for CDNS MHDP IP controller.

Quentin Schulz (9):
  HACK: increase timeout for drm_atomic_helper_wait_for_vblanks
  drm/dp: make dp_link_status and dp_get_lane_status usable from
    outside of the core
  drm/dp: add helpers for drm_dp_set_adjust_request_pre_emphasis and
    drm_dp_set_adjust_request_voltage
  drm/dp: fix training interval formula for DP 1.3+
  drm/dp: fix link probing for devices supporting DP 1.4+
  drm/dp: fix drm_dp_link_power_* for DP 1.2+
  drm/dp: fix drm_dp_link_train_clock_recovery_delay for DP 1.4
  drm/dp: add max number of lanes supported
  drm/dp: add pixel encoding and colorimetry format indicator field in
    MISC1

 .../bindings/display/bridge/cdns,mhdp.txt          |   39 +
 drivers/gpu/drm/drm_atomic_helper.c                |    2 +-
 drivers/gpu/drm/drm_dp_helper.c                    |   97 ++-
 drivers/gpu/drm/rockchip/cdn-dp-core.c             |  953 +++++++++++++++++++-
 drivers/gpu/drm/rockchip/cdn-dp-core.h             |   25 +
 drivers/gpu/drm/rockchip/cdn-dp-reg.c              |  167 ++++-
 drivers/gpu/drm/rockchip/cdn-dp-reg.h              |  147 +++-
 include/drm/drm_dp_helper.h                        |   14 +-
 8 files changed, 1400 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
