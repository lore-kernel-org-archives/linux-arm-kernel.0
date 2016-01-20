From: lho@apm.com (Loc Ho)
Date: Tue, 19 Jan 2016 17:46:50 -0700
Subject: [PATCH v2 1/3] Documentation: Update the APM X-Gene SoC EDAC DTS
 binding for missing RB
In-Reply-To: <1453250812-15097-1-git-send-email-lho@apm.com>
References: <1453250812-15097-1-git-send-email-lho@apm.com>
Message-ID: <1453250812-15097-2-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the APM X-Gene SoC EDAC documentation binding to
reference the missing register bus for the the SoC EDAC.

Signed-off-by: Loc Ho <lho@apm.com>
---
 .../devicetree/bindings/edac/apm-xgene-edac.txt    |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt b/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
index 78e2a31..17b29af 100644
--- a/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
+++ b/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
@@ -20,6 +20,12 @@ Required properties:
 - interrupts            : Interrupt-specifier for MCU, PMD, L3, or SoC error
 			  IRQ(s).
 
+Optional property:
+- regmap-rb		: Regmap of the register bus resource. This properity
+			  is optional only for compatibility. If the RB
+			  erorr conditions are not cleared, it will
+			  continuously generates interrupt.
+
 Required properties for memory controller subnode:
 - compatible		: Shall be "apm,xgene-edac-mc".
 - reg			: First resource shall be the memory controller unit
@@ -64,6 +70,11 @@ Example:
 		reg = <0x0 0x1054a000 0x0 0x20>;
 	};
 
+	rb: rb at 7e000000 {
+		compatible = "apm,xgene-rb", "syscon";
+		reg = <0x0 0x7e000000 0x0 0x10>;
+	};
+
 	edac at 78800000 {
 		compatible = "apm,xgene-edac";
 		#address-cells = <2>;
@@ -73,6 +84,7 @@ Example:
 		regmap-mcba = <&mcba>;
 		regmap-mcbb = <&mcbb>;
 		regmap-efuse = <&efuse>;
+		regmap-rb = <&rb>;
 		reg = <0x0 0x78800000 0x0 0x100>;
 		interrupts = <0x0 0x20 0x4>,
 			     <0x0 0x21 0x4>,
-- 
1.7.1
