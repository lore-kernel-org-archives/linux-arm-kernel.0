From: ykk@rock-chips.com (Yakir Yang)
Date: Thu,  7 Jan 2016 12:34:48 +0800
Subject: [RFC PATCH v1 0/2] Add RK3229 HDMI support
Message-ID: <1452141288-9292-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


RK3229 have integrated an DesignedWare HDMI controller and an INNO HDMI phy,
so we can still reuse the dw-hdmi driver for RK3229 HDMI controller, but
we need to create an separate driver for RK3229 HDMI PHY.


Yakir Yang (2):
  drm: rockchip: hdmi: add RK3229 HDMI support
  dt-bindings: add document for rk3229-hdmi

 .../bindings/display/rockchip/dw_hdmi-rockchip.txt |   4 +-
 drivers/gpu/drm/bridge/dw-hdmi.c                   |  33 +-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        | 380 +++++++++++++++++++--
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.h        | 137 ++++++++
 include/drm/bridge/dw_hdmi.h                       |   5 +-
 5 files changed, 519 insertions(+), 40 deletions(-)
 create mode 100644 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.h

-- 
2.1.2
