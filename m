From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Wed, 18 Oct 2017 20:09:35 +0800
Subject: [PATCH v5 0/9] rockchip: kevin: Enable edp display
Message-ID: <20171018120944.7819-1-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Make edp display works on chromebook kevin(at least for boot animation).

Also solve some issues i meet during the bringup.

Changes in v5:
Call the destroy hook in the error handling path like in unbind().
Call the destroy hook in the error handling path like in unbind().
Update cleanup order in unbind().
Add disable to unbind(), and inline clk_prepare_enable() with bind().

Jeffy Chen (9):
  arm64: dts: rockchip: Enable edp disaplay on kevin
  drm/rockchip: analogix_dp: Remove unnecessary init code
  drm/bridge: analogix: Do not use device's drvdata
  drm/bridge: analogix_dp: Fix connector & encoder cleanup
  drm/rockchip: dw-mipi-dsi: Fix error handling path
  drm/rockchip: inno_hdmi: Fix error handling path
  drm/bridge/synopsys: dw-hdmi: Add missing bridge detach
  drm/bridge/synopsys: dw-hdmi: Do not use device's drvdata
  drm/rockchip: dw_hdmi: Fix error handling path

 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts  | 29 ++++++++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       | 16 ++++
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 52 +++++--------
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          | 53 ++++++-------
 drivers/gpu/drm/exynos/exynos_dp.c                 | 29 +++++---
 drivers/gpu/drm/imx/dw_hdmi-imx.c                  | 22 +++---
 drivers/gpu/drm/meson/meson_dw_hdmi.c              | 20 +++--
 drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c             | 14 +++-
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    | 87 ++++++++++------------
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c             | 21 ++++--
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        | 39 +++++-----
 drivers/gpu/drm/rockchip/inno_hdmi.c               | 22 ++++--
 include/drm/bridge/analogix_dp.h                   | 19 +++--
 include/drm/bridge/dw_hdmi.h                       | 17 +++--
 14 files changed, 257 insertions(+), 183 deletions(-)

-- 
2.11.0
