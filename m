From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 29 Nov 2016 15:57:08 -0800
Subject: [PATCH v4 0/4] davinci: VPIF: add DT support
Message-ID: <20161129235712.29846-1-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT support, including getting subdevs from DT ports/endpoints.

Tested video capture to memory on da850-lcdk board using composite
input.

Changes since v3:
- move to a single VPIF node, DT binding updated accordingly
- misc fixes/updates based on reviews from Sakari

Changes since v2:
- DT binding doc: fix example to use correct compatible

Changes since v1:
- more specific compatible strings, based on SoC: ti,da850-vpif*
- fix locking bug when unlocking over subdev s_stream


Kevin Hilman (4):
  [media] davinci: vpif_capture: don't lock over s_stream
  [media] davinci: VPIF: add basic support for DT init
  [media] davinci: vpif_capture: get subdevs from DT
  [media] dt-bindings: add TI VPIF documentation

 .../devicetree/bindings/media/ti,da850-vpif.txt    |  67 ++++++++++
 drivers/media/platform/davinci/vpif.c              |  48 ++++++-
 drivers/media/platform/davinci/vpif_capture.c      | 147 ++++++++++++++++++++-
 drivers/media/platform/davinci/vpif_display.c      |   6 +
 include/media/davinci/vpif_types.h                 |   9 +-
 5 files changed, 270 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/ti,da850-vpif.txt

-- 
2.9.3
