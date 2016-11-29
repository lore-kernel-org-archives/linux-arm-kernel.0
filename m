From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 29 Nov 2016 12:57:02 +0100
Subject: [PATCH v3 0/2] ARM: dts: da850: tilcdc related DT changes
Message-ID: <1480420624-23544-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

his series contains the last DT changes required for LCDC support
on da850-lcdk. The first one adds the dumb-vga-dac nodes, the second
limits the maximum pixel clock rate.

v1 -> v2:
- drop patch 3/3 (already merged)
- use max-pixelclock instead of max-bandwidth for display mode limiting

v2 -> v3:
- make the commit message in patch [2/2] more detailed
- move the max-pixelclock property to da850.dtsi as the limit
  affects all da850-based boards

Bartosz Golaszewski (2):
  ARM: dts: da850-lcdk: add the dumb-vga-dac node
  ARM: dts: da850: specify the maximum pixel clock rate for tilcdc

 arch/arm/boot/dts/da850-lcdk.dts | 58 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/da850.dtsi     | 18 +++++++++++++
 2 files changed, 76 insertions(+)

-- 
2.9.3
