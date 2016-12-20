From: andrew@aj.id.au (Andrew Jeffery)
Date: Tue, 20 Dec 2016 17:45:34 +1030
Subject: [PATCH v4 4/5] mfd: dt: Add bindings for the Aspeed LPC Host
 Controller (LHC)
In-Reply-To: <20161220071535.27542-1-andrew@aj.id.au>
References: <20161220071535.27542-1-andrew@aj.id.au>
Message-ID: <20161220071535.27542-5-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LPC bus pinmux configuration on fifth generation Aspeed SoCs depends
on bits in both the System Control Unit and the LPC Host Controller.

The Aspeed LPC Host Controller is described as a child node of the
LPC host-range syscon device for arbitration of access by the host
controller and pinmux drivers.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---

Linus: I've retained your r-b tag I don't think the addition of the ast2400
compatible string will fuss you. Please let me know if you feel this is
inappropriate.

 .../devicetree/bindings/mfd/aspeed-lpc.txt         | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
index a97131aba446..514d82ced95b 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
+++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
@@ -109,3 +109,29 @@ lpc: lpc at 1e789000 {
 	};
 };
 
+Host Node Children
+==================
+
+LPC Host Controller
+-------------------
+
+The Aspeed LPC Host Controller configures the Low Pin Count (LPC) bus behaviour
+between the host and the baseboard management controller. The registers exist
+in the "host" portion of the Aspeed LPC controller, which must be the parent of
+the LPC host controller node.
+
+Required properties:
+
+- compatible:	One of:
+		"aspeed,ast2400-lhc";
+		"aspeed,ast2500-lhc";
+
+- reg:		contains offset/length values of the LHC memory regions. In the
+		AST2400 and AST2500 there are two regions.
+
+Example:
+
+lhc: lhc at 20 {
+	compatible = "aspeed,ast2500-lhc";
+	reg = <0x20 0x24 0x48 0x8>;
+};
-- 
2.9.3
