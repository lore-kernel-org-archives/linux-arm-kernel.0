From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  7 Oct 2016 00:06:20 +0800
Subject: [PATCH 0/9] drm/sun4i: Support first display pipeline on sun6i
Message-ID: <20161006160629.11198-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series adds support for the first display pipeline found on the
A31 and A31s SoCs, with output through the RGB LCD interface.

This has been tested on the Sinlinx SinA31s development board, with
its included 7" LCD panel (see last patch), and the Merrii Hummingbird
A31 development board, with its RGB-VGA bridge using Maxime's dumb VGA
bridge patches. The Hummingbird A31 patches will be sent once Maxime's
patches are merged.

The last patch is only included for completeness. The LCD panel is
not exactly supported, and Maxime's previous attempt to add it was
postponed pending discussion.


Regards
ChenYu

Chen-Yu Tsai (9):
  drm/sun4i: sun6i-drc: Support DRC on A31 and A31s
  drm/sun4i: tcon: Move SoC specific quirks to a DT matched data
    structure
  drm/sun4i: Put dotclock range into tcon quirks and check against them
  drm/sun4i: Add compatible string for A31/A31s TCON (timing controller)
  drm/sun4i: Add compatible strings for A31/A31s display pipelines
  ARM: dts: sun6i: Sort pinmux setting nodes
  ARM: dts: sun6i: Add device nodes for first display pipeline
  ARM: dts: sun6i: Add A31 LCD0 RGB888 pins
  [DO NOT MERGE] ARM: dts: sun6i: Enable 7" LCD panel on Sinlinx SinA31s

 .../bindings/display/sunxi/sun4i-drm.txt           |  10 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                   | 247 +++++++++++++++++----
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts           |  30 +++
 arch/arm/boot/dts/sun6i-a31s.dtsi                  |   8 +
 drivers/gpu/drm/sun4i/sun4i_backend.c              |   1 +
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |   5 +
 drivers/gpu/drm/sun4i/sun4i_rgb.c                  |   8 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |  54 +++--
 drivers/gpu/drm/sun4i/sun4i_tcon.h                 |  16 +-
 drivers/gpu/drm/sun4i/sun6i_drc.c                  |   2 +
 10 files changed, 313 insertions(+), 68 deletions(-)

-- 
2.9.3
