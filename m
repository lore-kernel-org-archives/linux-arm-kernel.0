From: philippe.cornu@st.com (Philippe CORNU)
Date: Mon, 10 Jul 2017 11:02:10 +0200
Subject: [PATCH v2 0/3] Add support for the otm8009a dsi panel
Message-ID: <1499677333-10571-1-git-send-email-philippe.cornu@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Version 2:
- panel-orisetech-otm8009a.c: Add Manufacturer Command Set defines,
  add new macro for handling address shifting, improve reset
  sequence, use more mipi dcs helpers (Andrzej Hajda)
- dt-bindings/display/panel/orisetech,otm8009a.txt: Fix reset gpio
  active level in the example (Andrzej Hajda), Add an "Optional
  Properties" section (Rob Herring).

Version 1:
- Initial commit

The purpose of this patch is to add support for the Orise Tech
otm8009a 3.97" 480x800 TFT LCD panel (MIPI-DSI video mode).
This LCD panel is used in several STM32 boards.

Philippe CORNU (3):
  dt-bindings: Add vendor prefix for Orise Technology
  dt-bindings: display: panel: Add support for Orise Tech otm8009a dsi
    panel
  drm/panel: Add support for otm8009a panel driver

 .../bindings/display/panel/orisetech,otm8009a.txt  |  21 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/gpu/drm/panel/Kconfig                      |   9 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c   | 489 +++++++++++++++++++++
 5 files changed, 521 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt
 create mode 100755 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c

-- 
1.9.1
