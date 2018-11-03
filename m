From: jagan@amarulasolutions.com (Jagan Teki)
Date: Sat,  3 Nov 2018 15:38:50 +0530
Subject: [PATCH 00/10] drm/sun4i: Allwinner MIPI-DSI Burst mode support
Message-ID: <20181103100900.30313-1-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series support MIPI-DSI Burst mode on Allwinner platform, which
is tested in burst supported panel in Pine64-LTS board.

Series depends on previous A64 MIPI-DSI series[1] and all changes are
available in [2] repo with WIPI-A64-DSI branch.

Any inputs,
Jagan.

[2] https://github.com/amarula/linux-amarula
[1] https://patchwork.kernel.org/cover/10657467/

Jagan Teki (10):
  drm/sun4i: sun6i_mipi_dsi: Compute burst mode loop N1 instruction
    delay
  drm/sun4i: sun6i_mipi_dsi: Support instruction loop selection
  drm/sun4i: sun6i_mipi_dsi: Setup burst mode timings
  drm/sun4i: sun6i_mipi_dsi: Setup burst mode
  drm/sun4i: sun6i_mipi_dsi: Enable burst mode
  drm/sun4i: sun6i_mipi_dsi: Enable 2byte trail for 4-lane burst mode
  drm/sun4i: sun6i_mipi_dsi: Enable burst mode HBP, HSA_HSE
  dt-bindings: panel: Add Feiyang FY07024DI26A30-D MIPI-DSI LCD panel
  drm/panel: Add Feiyang FY07024DI26A30-D MIPI-DSI LCD panel
  [DO NOT MERGE] arm64: allwinner: a64: pine64-lts: Enable Feiyang FY07024DI26A30-D DSI
    panel

 .../display/panel/feiyang,fy07024di26a30d.txt |  20 ++
 .../dts/allwinner/sun50i-a64-pine64-lts.dts   |  37 +++
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../drm/panel/panel-feiyang-fy07024di26a30d.c | 305 ++++++++++++++++++
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c        | 186 +++++++----
 6 files changed, 500 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
 create mode 100644 drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c

-- 
2.18.0.321.gffc6fa0e3
