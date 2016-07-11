From: ykk@rock-chips.com (Yakir Yang)
Date: Mon, 11 Jul 2016 19:04:39 +0800
Subject: [PATCH v1 0/6] Add RK3399 HDMI Support
Message-ID: <1468235079-29152-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

RK3399 and RK3288 shared the same HDMI IP controller, only some
light difference with GRF configure, and an external VPLL clock
need to configure.

Thanks,
- Yakir


Douglas Anderson (2):
  drm/rockchip: dw_hdmi: Set cur_ctr to 0 always
  drm/rockchip: dw_hdmi: Use auto-generated tables

Yakir Yang (4):
  drm/rockchip: dw_hdmi: adjust cklvl & txlvl for RF/EMI
  drm/rockchip: dw_hdmi: add RK3399 HDMI support
  drm/rockchip: dw_hdmi: introduce the VPLL clock setting
  drm/rockchip: dw_hdmi: introduce the pclk for grf

 .../devicetree/bindings/display/bridge/dw_hdmi.txt |   1 +
 .../bindings/display/rockchip/dw_hdmi-rockchip.txt |   7 +-
 drivers/gpu/drm/bridge/dw-hdmi.c                   |   2 +-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        | 238 +++++++++++++--------
 include/drm/bridge/dw_hdmi.h                       |   6 +
 5 files changed, 167 insertions(+), 87 deletions(-)

-- 
1.9.1
