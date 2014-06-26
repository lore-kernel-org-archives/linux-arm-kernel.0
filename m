From: r.sricharan@ti.com (Sricharan R)
Date: Thu, 26 Jun 2014 12:40:33 +0530
Subject: [PATCH V4 15/16] documentation: dt: omap: crossbar: Add description
 for interrupt consumer
In-Reply-To: <1403766634-18543-1-git-send-email-r.sricharan@ti.com>
References: <1403766634-18543-1-git-send-email-r.sricharan@ti.com>
Message-ID: <1403766634-18543-16-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nishanth Menon <nm@ti.com>

The current crossbar description does not include the description
required for the consumer of the crossbar, a.k.a devices whoes events
pass through the crossbar into the GIC interrupt controller.

So, provide documentation for the same.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sricharan R <r.sricharan@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 .../devicetree/bindings/arm/omap/crossbar.txt      |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/omap/crossbar.txt b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
index 6923531..35356b6 100644
--- a/Documentation/devicetree/bindings/arm/omap/crossbar.txt
+++ b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
@@ -36,3 +36,20 @@ Examples:
 			ti,irqs-reserved = <0 1 2 3 5 6 131 132 139 140>;
 			ti,irqs-skip = <10 133 139 140>;
 		};
+
+Consumer:
+========
+See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt and
+Documentation/devicetree/bindings/arm/gic.txt for further details.
+
+An interrupt consumer on an SoC using crossbar will use:
+	interrupts = <GIC_SPI request_number interrupt_level>
+request number shall be between 0 to that described by
+"ti,max-crossbar-sources"
+
+Example:
+	device_x at 0x4a023000 {
+		/* Crossbar 8 used */
+		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+		...
+	};
-- 
1.7.9.5
