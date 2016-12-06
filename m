From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue,  6 Dec 2016 14:13:44 +0100
Subject: [PATCH v4 0/2] ARM: dts: da850: tilcdc related DT changes
Message-ID: <1481030026-7329-1-git-send-email-bgolaszewski@baylibre.com>
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

Bartosz Golaszewski (2):
  ARM: dts: da850-lcdk: add the dumb-vga-dac node
  ARM: dts: da850: specify the maximum pixel clock rate for tilcdc

 arch/arm/boot/dts/da850-lcdk.dts | 69 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/da850.dtsi     |  1 +
 2 files changed, 70 insertions(+)

-- 
2.9.3
