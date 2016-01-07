From: ykk@rock-chips.com (Yakir Yang)
Date: Thu,  7 Jan 2016 16:53:31 +0800
Subject: [RFC PATCH v2 0/4] Add RK3229 HDMI support
Message-ID: <1452156811-18150-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


RK3229 have integrated an DesignedWare HDMI controller and an INNO HDMI phy,
so we can still reuse the dw-hdmi driver for RK3229 HDMI controller, but
we need to create an separate driver for RK3229 HDMI PHY.

This series is based on Mark Yao's drm-next branch
[https://github.com/markyzq/kernel-drm-rockchip/tree/drm-rockchip-next-2015-12-28]

After picking my "Add RK3229 vop support" series, HDMI monitor could light up
normally on RK3229 SDK board.


Changes in v2:
- Split some dw-hdmi driver changes into separate patches [01/04] & [02/04]

Yakir Yang (4):
  drm: dw-hdmi: make it easy to recovery the platform data for platform
    driver
  drm: dw-hdmi: passing the "plat_data" when calling platform mode_valid
  drm: rockchip: hdmi: add RK3229 HDMI support
  dt-bindings: add document for rk3229-hdmi

 .../bindings/display/rockchip/dw_hdmi-rockchip.txt |   4 +-
 drivers/gpu/drm/bridge/dw-hdmi.c                   |  32 +-
 drivers/gpu/drm/imx/dw_hdmi-imx.c                  |  17 +-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        | 376 +++++++++++++++++++--
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.h        | 137 ++++++++
 include/drm/bridge/dw_hdmi.h                       |   5 +-
 6 files changed, 529 insertions(+), 42 deletions(-)
 create mode 100644 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.h

-- 
2.1.2
