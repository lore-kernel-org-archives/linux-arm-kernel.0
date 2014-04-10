From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu, 10 Apr 2014 10:21:01 +0200
Subject: [PATCH v2 2/4] Documentation: dt: socfpga: add reset-cells property
In-Reply-To: <1397118063-21619-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1397118063-21619-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1397118063-21619-2-git-send-email-s.trumtrar@pengutronix.de>
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
