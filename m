From: mark.yao@rock-chips.com (Mark Yao)
Date: Fri,  9 Jun 2017 10:41:10 +0800
Subject: [PATCH v2 0/4] Add RK3399 HDMI Support
Message-ID: <1496976070-29573-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RK3399 and RK3288 shared the same HDMI IP controller, only some
light difference with GRF configure, and an external VPLL clock
need to configure.

base on Yakir's v1 thread:
   http://lkml.iu.edu/hypermail/linux/kernel/1607.1/01468.html

Some Yakir's hdmi patches cause hdmi no display on my test,
so I remove them on this thread.

Tested on rk3399 evb board with kernel 4.12.0-rc1.

Changes in v2:
  rebase to newest uptream, reuse hdmi_phy_configure_dwc_hdmi_3d_tx

Mark Yao (2):
  drm: bridge: dw-hdmi: Export hdmi_phy_configure_dwc_hdmi_3d_tx
  drm/rockchip: dw_hdmi: add RK3399 HDMI support

Yakir Yang (2):
  drm/rockchip: dw_hdmi: introduce the VPLL clock setting
  drm/rockchip: dw_hdmi: introduce the pclk for grf

 .../bindings/display/rockchip/dw_hdmi-rockchip.txt |   3 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |   3 +-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        | 112 ++++++++++++++++++---
 include/drm/bridge/dw_hdmi.h                       |   3 +
 4 files changed, 107 insertions(+), 14 deletions(-)

-- 
1.9.1
