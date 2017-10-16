From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Mon, 16 Oct 2017 18:06:35 +0800
Subject: [RESEND PATCH v2 0/5] rockchip: kevin: Enable edp display
Message-ID: <20171016100640.26575-1-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Make edp display works on chromebook kevin(at least for boot animation).

Also solve some issues i meet during the bringup.

Changes in v2:
Use device link to correct the suspend/resume and shutdown ordering,
instead of converting rockchip spi's suspend/resume PM callbacks to
late suspend/resume PM callbacks.

Jeffy Chen (4):
  arm64: dts: rockchip: Enable edp disaplay on kevin
  backlight: pwm_bl: Add device link for pwm_bl and pwm
  drm/rockchip: Fix error handling path in rockchip_dp_bind()
  drm/rockchip: Add device links for master and components

Tomasz Figa (1):
  drm/bridge/analogix: Do not use device's drvdata

 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts  | 29 +++++++++++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       | 16 ++++++
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 50 ++++++++-----------
 drivers/gpu/drm/exynos/exynos_dp.c                 | 26 +++++-----
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    | 57 ++++++++++++++--------
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        | 24 +++++++--
 drivers/video/backlight/pwm_bl.c                   |  2 +
 include/drm/bridge/analogix_dp.h                   | 19 +++++---
 8 files changed, 151 insertions(+), 72 deletions(-)

-- 
2.11.0
