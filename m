From: zyw@rock-chips.com (Chris Zhong)
Date: Mon, 16 Jan 2017 18:08:20 +0800
Subject: [PATCH v2 0/11] Rockchip dw-mipi-dsi driver
Message-ID: <1484561311-494-1-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all

This patch serial is for RK3399 MIPI DSI. The MIPI DSI controller of
RK3399 is almost the same as RK3288, except a little bit of difference
in phy clock controlling and port id selection register.

And these patches also fixes some driver bugs; add the power domain
support.

they have been tested on rk3399 and rk3288 evb board.


Chris Zhong (7):
  dt-bindings: add rk3399 support for dw-mipi-rockchip
  drm/rockchip/dsi: dw-mipi: support RK3399 mipi dsi
  drm/rockchip/dsi: remove mode_valid function
  dt-bindings: add power domain node for dw-mipi-rockchip
  drm/rockchip/dsi: add dw-mipi power domain support
  drm/rockchip/dsi: fix phy clk lane stop state timeout
  drm/rockchip/dsi: fix insufficient bandwidth of some panel

Mark Yao (2):
  drm/rockchip/dsi: return probe defer if attach panel failed
  drm/rockchip/dsi: fix mipi display can't found at init time

xubilv (2):
  drm/rockchip/dsi: fix the issue can not send commands
  drm/rockchip/dsi: decrease the value of Ths-prepare

 .../display/rockchip/dw_mipi_dsi_rockchip.txt      |   7 +-
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c             | 254 +++++++++++++--------
 2 files changed, 163 insertions(+), 98 deletions(-)

-- 
2.6.3
