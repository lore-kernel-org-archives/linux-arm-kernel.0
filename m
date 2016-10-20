From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 20 Oct 2016 11:43:36 +0800
Subject: [PATCH v2 0/8] drm/sun4i: Support first display pipeline on sun6i
Message-ID: <20161020034344.14154-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series adds support for the first display pipeline found on the
A31 and A31s SoCs, with output through the RGB LCD interface.

This has been tested on the Sinlinx SinA31s development board, with
its included 7" LCD panel, and the Merrii Hummingbird A31 development
board, with its dumb VGA DAC bridge.

Changes since v1:

  - Made quirk structures static

  - Dropped unused/unsupported quirks

  - Dropped dotclock max frequency quirk patch.
    The check for maximum PLL clock will be moved to the clk driver.

  - Changed is_sun5i quirk to has_unknown_mux

  - Dropped SinA31s LCD patch

  - Added patch to support enable pin GPIO for dumb VGA DACs

  - Added patch to enable VGA output via dumb VGA DAC on Hummingbird
    A31 board


Regards
ChenYu


Chen-Yu Tsai (8):
  drm/bridge: rgb-to-vga: Support an enable GPIO
  drm/sun4i: sun6i-drc: Support DRC on A31 and A31s
  drm/sun4i: tcon: Move SoC specific quirks to a DT matched data
    structure
  drm/sun4i: Add compatible string for A31/A31s TCON (timing controller)
  drm/sun4i: Add compatible strings for A31/A31s display pipelines
  ARM: dts: sun6i: Add device nodes for first display pipeline
  ARM: dts: sun6i: Add A31 LCD0 RGB888 pins
  ARM: dts: sun6i: hummingbird-a31: Enable display output through VGA
    bridge

 .../bindings/display/bridge/dumb-vga-dac.txt       |   2 +
 .../bindings/display/sunxi/sun4i-drm.txt           |  10 +-
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts        |  56 +++++++
 arch/arm/boot/dts/sun6i-a31.dtsi                   | 165 +++++++++++++++++++++
 arch/arm/boot/dts/sun6i-a31s.dtsi                  |   8 +
 drivers/gpu/drm/bridge/dumb-vga-dac.c              |  28 ++++
 drivers/gpu/drm/sun4i/sun4i_backend.c              |   1 +
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |   5 +
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |  43 ++++--
 drivers/gpu/drm/sun4i/sun4i_tcon.h                 |  11 +-
 drivers/gpu/drm/sun4i/sun6i_drc.c                  |   2 +
 11 files changed, 311 insertions(+), 20 deletions(-)

-- 
2.9.3
