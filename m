From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Fri, 8 Sep 2017 15:46:36 -0500
Subject: [PATCH 1/3] dt-bindings: spi: spi-davinci: Update binding for 66AK2Gx
 pwr dm property
In-Reply-To: <20170908204638.13149-1-fcooper@ti.com>
References: <20170908204638.13149-1-fcooper@ti.com>
Message-ID: <20170908204638.13149-2-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pm-domains property which is required for 66AK2Gx. Also document 66AK2G
unique clocks property usage.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 Documentation/devicetree/bindings/spi/spi-davinci.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-davinci.txt b/Documentation/devicetree/bindings/spi/spi-davinci.txt
index f5916c9..1925277 100644
--- a/Documentation/devicetree/bindings/spi/spi-davinci.txt
+++ b/Documentation/devicetree/bindings/spi/spi-davinci.txt
@@ -24,6 +24,16 @@ Required properties:
 	based on a specific SoC configuration.
 - interrupts: interrupt number mapped to CPU.
 - clocks: spi clk phandle
+          For 66AK2G this property should be set per binding,
+          Documentation/devicetree/bindings/clock/ti,sci-clk.txt
+
+SoC-specific Required Properties:
+
+The following are mandatory properties for Keystone 2 66AK2G SoCs only:
+
+- power-domains:	Should contain a phandle to a PM domain provider node
+			and an args specifier containing the SPI device id
+			value. This property is as per the binding,
 
 Optional:
 - cs-gpios: gpio chip selects
-- 
2.9.4.dirty
