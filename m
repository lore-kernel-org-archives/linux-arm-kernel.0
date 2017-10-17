From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Tue, 17 Oct 2017 18:16:16 +0800
Subject: [RFC PATCH v4 0/8] rockchip: kevin: Enable edp display
Message-ID: <20171017101624.12506-1-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Make edp display works on chromebook kevin(at least for boot animation).

Also solve some issues i meet during the bringup.

Changes in v4:
Fix compile warning.

Changes in v3:
Assign orphan pwms to dummy pwmchip instead of adding device link in the
customer driver.

Changes in v2:
Use device link to correct the suspend/resume and shutdown ordering,
instead of converting rockchip spi's suspend/resume PM callbacks to
late suspend/resume PM callbacks.

Jeffy Chen (7):
  arm64: dts: rockchip: Enable edp disaplay on kevin
  drm/rockchip: analogix_dp: Fix error handling path
  drm/rockchip: dw-mipi-dsi: Fix error handling path
  drm/rockchip: dw_hdmi: Fix error handling path
  drm/rockchip: inno_hdmi: Fix error handling path
  pwm: Add dummy pwmchip for orphan pwms
  drm/rockchip: Add device links for master and components

Tomasz Figa (1):
  drm/bridge/analogix: Do not use device's drvdata

 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts  | 29 ++++++++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       | 16 +++++
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 50 ++++++-------
 drivers/gpu/drm/exynos/exynos_dp.c                 | 26 ++++---
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    | 57 +++++++++------
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c             | 17 +++--
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        |  4 +-
 drivers/gpu/drm/rockchip/inno_hdmi.c               | 20 ++++--
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        | 24 ++++++-
 drivers/pwm/core.c                                 | 81 ++++++++++++++++++++--
 include/drm/bridge/analogix_dp.h                   | 19 ++---
 11 files changed, 254 insertions(+), 89 deletions(-)

-- 
2.11.0
