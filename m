From: marek@goldelico.com (Marek Belisko)
Date: Mon,  3 Nov 2014 22:59:24 +0100
Subject: [PATCH 0/4] omapdss: Add video output support for gta04 board
Message-ID: <1415051968-4878-1-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add support for video output on gta04 board. It consist
from opa362 video amplifier driver + DT bindings, adding venc -> opa362 -> svideo-connecor
setup in DT and finally static setup for tvbypass anc acbias bin in devconf1 register
via pinctrl subsystem.

Marek Belisko (4):
  video: omapdss: Add opa362 driver
  Documentation: DT: Add documentation for ti,opa362 bindings
  arm: dts: omap3-gta04: Add handling for tv output
  arm: dts: omap3-gta04: Add static configuration for devconf1 register

 .../devicetree/bindings/video/ti,opa362.txt        |  38 +++
 arch/arm/boot/dts/omap3-gta04.dtsi                 |  70 +++++
 drivers/video/fbdev/omap2/displays-new/Kconfig     |   6 +
 drivers/video/fbdev/omap2/displays-new/Makefile    |   1 +
 .../fbdev/omap2/displays-new/amplifier-opa362.c    | 347 +++++++++++++++++++++
 5 files changed, 462 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/ti,opa362.txt
 create mode 100644 drivers/video/fbdev/omap2/displays-new/amplifier-opa362.c

-- 
1.9.1
