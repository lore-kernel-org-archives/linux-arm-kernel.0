From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Fri,  4 Apr 2014 18:31:26 +0200
Subject: [PATCH 2/3] Documentation: dt: socfpga: add reset-cells property
In-Reply-To: <1396629087-23727-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1396629087-23727-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1396629087-23727-3-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To be able to use the reset-controller framework, the property
	#reset-cells
is mandatory.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 Documentation/devicetree/bindings/arm/altera/socfpga-reset.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-reset.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-reset.txt
index ecdb57d..32c1c8b 100644
--- a/Documentation/devicetree/bindings/arm/altera/socfpga-reset.txt
+++ b/Documentation/devicetree/bindings/arm/altera/socfpga-reset.txt
@@ -3,9 +3,11 @@ Altera SOCFPGA Reset Manager
 Required properties:
 - compatible : "altr,rst-mgr"
 - reg : Should contain 1 register ranges(address and length)
+- #reset-cells: 1
 
 Example:
 	 rstmgr at ffd05000 {
+		#reset-cells = <1>;
 		compatible = "altr,rst-mgr";
 		reg = <0xffd05000 0x1000>;
 	};
-- 
1.9.1
