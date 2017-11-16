From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Thu, 16 Nov 2017 09:50:15 +0100
Subject: [PATCH v2 0/4] Fixes for omapdrm on OpenPandora and GTA04
Message-ID: <cover.1510822218.git.hns@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

V2:
* replaced patch to fix DSI VDDS for OMAP3 by equivalent patch from Laurent Pinchart
* keep previous compatibility option in panel driver to handle older device tree binaries

2017-11-08 22:09:36:
This patch set fixes vendor names of the panels
and fixes a problem on omapdrm with enabling
VDD_DSI for OMAP3 which is needed for displaying
the Red and Green channel on OMAP3530 (Pandora).

H. Nikolaus Schaller (3):
  omapdrm: fix compatible string for td028ttec1
  DTS: GTA04: fix panel compatibility string
  DTS: Pandora: fix panel compatibility string

Laurent Pinchart (1):
  drm: omapdrm: Fix DPI on platforms using the DSI VDDS

 .../display/panel/{toppoly,td028ttec1.txt => tpo,td028ttec1.txt}      | 4 ++--
 arch/arm/boot/dts/omap3-gta04.dtsi                                    | 2 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi                           | 2 +-
 drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c               | 4 ++--
 drivers/gpu/drm/omapdrm/dss/dpi.c                                     | 4 ++--
 drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c      | 4 +++-
 6 files changed, 11 insertions(+), 9 deletions(-)
 rename Documentation/devicetree/bindings/display/panel/{toppoly,td028ttec1.txt => tpo,td028ttec1.txt} (84%)

-- 
2.12.2
