From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Wed,  8 Nov 2017 22:09:28 +0100
Subject: [PATCH 0/4] Fixes for omapdrm on OpenPandora and GTA04
Message-ID: <cover.1510175371.git.hns@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set fixes vendor names of the panels
and fixes a problem on omapdrm with enabling
VDD_DSI for OMAP3 which is needed for displaying
the Red and Green channel on OMAP3530 (Pandora).

H. Nikolaus Schaller (4):
  omapdrm: fix compatible string for td028ttec1
  DTS: GTA04: fix panel compatibility string
  DTS: Pandora: fix panel compatibility string
  omapdss: fix problem enabling VDDS_DSI on OMAP3530 (OpenPandora)

 .../display/panel/{toppoly,td028ttec1.txt => tpo,td028ttec1.txt}      | 4 ++--
 arch/arm/boot/dts/omap3-gta04.dtsi                                    | 2 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi                           | 2 +-
 drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c               | 4 ++--
 drivers/gpu/drm/omapdrm/dss/dpi.c                                     | 3 +--
 drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c      | 4 ++--
 6 files changed, 9 insertions(+), 10 deletions(-)
 rename Documentation/devicetree/bindings/display/panel/{toppoly,td028ttec1.txt => tpo,td028ttec1.txt} (84%)

-- 
2.12.2
