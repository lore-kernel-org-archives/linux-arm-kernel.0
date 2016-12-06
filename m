From: andrew@aj.id.au (Andrew Jeffery)
Date: Tue,  6 Dec 2016 13:53:20 +1100
Subject: [PATCH v3 5/6] mfd: dt: Add bindings for the Aspeed SoC Display
 Controller (GFX)
In-Reply-To: <20161206025321.1792-1-andrew@aj.id.au>
References: <20161206025321.1792-1-andrew@aj.id.au>
Message-ID: <20161206025321.1792-6-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Aspeed SoC Display Controller is presented as a syscon device to
arbitrate access by display and pinmux drivers. Video pinmux
configuration on fifth generation SoCs depends on bits in both the
System Control Unit and the Display Controller.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mfd/syscon/aspeed-gfx.txt       | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/syscon/aspeed-gfx.txt

diff --git a/Documentation/devicetree/bindings/mfd/syscon/aspeed-gfx.txt b/Documentation/devicetree/bindings/mfd/syscon/aspeed-gfx.txt
new file mode 100644
index 000000000000..aea5370efd97
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/syscon/aspeed-gfx.txt
@@ -0,0 +1,17 @@
+* Device tree bindings for Aspeed SoC Display Controller (GFX)
+
+The Aspeed SoC Display Controller primarily does as its name suggests, but also
+participates in pinmux requests on the g5 SoCs. It is therefore considered a
+syscon device.
+
+Required properties:
+- compatible:		"aspeed,ast2500-gfx", "syscon"
+- reg:			contains offset/length value of the GFX memory
+			region.
+
+Example:
+
+gfx: display at 1e6e6000 {
+	compatible = "aspeed,ast2500-gfx", "syscon";
+	reg = <0x1e6e6000 0x1000>;
+};
-- 
2.9.3
