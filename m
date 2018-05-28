From: m.purski@samsung.com (Maciej Purski)
Date: Mon, 28 May 2018 11:47:04 +0200
Subject: [PATCH 00/12] Add TOSHIBA TC358764 DSI/LVDS bridge driver
References: <CGME20180528094721eucas1p22b90fd838ce00f029fec7f5241cc06b5@eucas1p2.samsung.com>
Message-ID: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

this patchset is a next attempt to add the tc358764 driver.
The previous one can be found here:

https://lists.freedesktop.org/archives/dri-devel/2014-February/053705.html

Back then, TC358764 was added as a panel driver.

The bridge is supposed to be a DSI peripheral. Currently exynos_dsi accepts only panels
as its peripherals. Therefore, some logic in exynos_dsi had to be ammended. That is implemented
in first 4 patches.

Apart from the driver this patchset adds support for BOE HV070WSA-100 panel, which is used by
TC358764 and dts nodes to exynos5250.dtsi and exynos5250-arndale.dtsi.

Best regards,

Maciej Purski

Maciej Purski (12):
  drm/exynos: rename "bridge_node" to "mic_bridge_node"
  drm/exynos: move pm_runtime_get_sync() to exynos_dsi_init()
  drm/exynos: move connector creation to attach callback
  drm/exynos: add non-panel path to exynos_dsi_enable()
  panel/hv070wsa-100: add DT bindings
  drm/panel: add support for BOE HV070WSA-100 panel to simple-panel
  dt-bindings: tc358754: add DT bindings
  drm/bridge: tc358764: Add DSI to LVDS bridge driver
  ARM: dts: exynos5250: add mipi-phy node
  ARM: dts: exynos5250: add DSI node
  ARM: dts: exynos5250-arndale: add display regulators
  ARM: dts: exynos5250-arndale: add dsi and panel nodes

 .../bindings/display/bridge/toshiba,tc358764.txt   |  42 ++
 .../bindings/display/panel/boe,hv070wsa-100.txt    |   7 +
 arch/arm/boot/dts/exynos5250-arndale.dts           |  63 +++
 arch/arm/boot/dts/exynos5250.dtsi                  |  20 +
 drivers/gpu/drm/bridge/Kconfig                     |   7 +
 drivers/gpu/drm/bridge/Makefile                    |   1 +
 drivers/gpu/drm/bridge/tc358764.c                  | 547 +++++++++++++++++++++
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            |  84 ++--
 drivers/gpu/drm/panel/panel-simple.c               |  25 +
 9 files changed, 756 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt
 create mode 100644 drivers/gpu/drm/bridge/tc358764.c

-- 
2.7.4
