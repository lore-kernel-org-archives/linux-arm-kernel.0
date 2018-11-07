From: contact@paulk.fr (Paul Kocialkowski)
Date: Wed,  7 Nov 2018 19:18:35 +0100
Subject: [PATCH v3 0/8] BL035-RGB-002 3.5" LCD sunxi DRM support
Message-ID: <20181107181843.27628-1-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series adds support for the BL035-RGB-002 LCD panel and the required
device-tree bindings for using it on the BananaPi M1.

Only the changes related to the DRM driver and the panel are submitted
for merge, which does not include the two final commits.

Changes since v2:
* Split the commit using the encoder instead of panel;
* Mentionned that the lemaker prefix was already used;
* Included all properties in the panel binding documentation;
* Fixed panel binding in BananaPi device-tree;
* Switched backlight levels to a 1.8-gamma-corrected table.

Changes since v1:
* Rebased on drm-misc next;
* Used the full name of the panel for dt bindings;
* Removed helper to match flags in order to only retrieve the connector
  once, as it was already done.
* Made the bus flags checking possible without a panel;

Paul Kocialkowski (8):
  drm/sun4i: tcon: Pass encoder to RGB setup function
  drm/sun4i: tcon: Get the connector from the encoder in RGB setup
  drm/sun4i: tcon: Support an active-low DE signal with RGB interface
  dt-bindings: Add vendor prefix for LeMaker
  dt-bindings: Add bindings for the LeMaker BL035-RGB-002 LCD panel
  drm/panel: simple: Add support for the LeMaker BL035-RGB-002 3.5" LCD
  ARM: dts: sun7i: Add pinmux configuration for LCD0 RGB888 pins
  ARM: dts: sun7i-a20-bananapi: Add bindings for the LeMaker 3.5" LCD

 .../display/panel/lemaker,bl035-rgb-002.txt   | 12 ++++
 .../devicetree/bindings/vendor-prefixes.txt   |  1 +
 arch/arm/boot/dts/sun7i-a20-bananapi.dts      | 71 +++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi              | 11 +++
 drivers/gpu/drm/panel/panel-simple.c          | 27 +++++++
 drivers/gpu/drm/sun4i/sun4i_tcon.c            | 29 ++++----
 drivers/gpu/drm/sun4i/sun4i_tcon.h            |  1 +
 7 files changed, 138 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lemaker,bl035-rgb-002.txt

-- 
2.19.1
