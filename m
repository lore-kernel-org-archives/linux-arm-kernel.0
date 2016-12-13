From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 13 Dec 2016 11:09:14 +0100
Subject: [PATCH v7 0/5] ARM: dts: da850: tilcdc related DT changes
Message-ID: <1481623759-12786-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains the last DT changes required for LCDC support
on da850-lcdk. The first one adds the dumb-vga-dac nodes, the second
limits the maximum pixel clock rate.

v1 -> v2:
- drop patch 3/3 (already merged)
- use max-pixelclock instead of max-bandwidth for display mode limiting

v2 -> v3:
- make the commit message in patch [2/2] more detailed
- move the max-pixelclock property to da850.dtsi as the limit
  affects all da850-based boards

v3 -> v4:
- remove the input port from the display node
- move the display ports node to da850-lcdk.dts
- rename the vga_bridge node to vga-bridge
- move the LCDC pins to the LCDC node (from the vga bridge node)

v4 -> v5:
- rename the display label to lcdc
- instead of using the 'dumb-vga-dac' compatible, add bindings for
  ti,ths8135 and use it as the vga-bridge node compatible

v5 -> v6:
- drop the endpoint numbers for nodes with single endpoints
- split patch 2/4 from v5 into two separate patches: one adding DT
  bindings and one adding actual support for ths8135

v6 -> v7:
- simplified patch 4/5 by removing unnecessary properties from ports
  and endpoints nodes

Bartosz Golaszewski (5):
  ARM: dts: da850: rename the display node label
  drm: bridge: add DT bindings for TI ths8135
  drm: bridge: add support for TI ths8135
  ARM: dts: da850-lcdk: add the vga-bridge node
  ARM: dts: da850: specify the maximum pixel clock rate for tilcdc

 .../bindings/display/bridge/ti,ths8135.txt         | 46 +++++++++++++++++++
 arch/arm/boot/dts/da850-lcdk.dts                   | 51 ++++++++++++++++++++++
 arch/arm/boot/dts/da850.dtsi                       |  3 +-
 drivers/gpu/drm/bridge/dumb-vga-dac.c              |  1 +
 4 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,ths8135.txt

-- 
2.9.3
