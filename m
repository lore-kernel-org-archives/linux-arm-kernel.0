From: lho@apm.com (Loc Ho)
Date: Fri, 22 Jan 2016 13:47:03 -0700
Subject: [PATCH v3 1/3] Documentation: Update the APM X-Gene SoC EDAC DTS
 binding for missing RB
In-Reply-To: <1453495625-28006-1-git-send-email-lho@apm.com>
References: <1453495625-28006-1-git-send-email-lho@apm.com>
Message-ID: <1453495625-28006-2-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the APM X-Gene SoC EDAC documentation binding to
reference the missing register bus for the SoC EDAC.

Signed-off-by: Loc Ho <lho@apm.com>
---
 .../devicetree/bindings/edac/apm-xgene-edac.txt    |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt b/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
index 78e2a31..1006b04 100644
--- a/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
+++ b/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
@@ -16,6 +16,10 @@ Required properties:
 - regmap-mcba		: Regmap of the MCB-A (memory bridge) resource.
 - regmap-mcbb		: Regmap of the MCB-B (memory bridge) resource.
 - regmap-efuse		: Regmap of the PMD efuse resource.
+- regmap-rb		: Regmap of the register bus resource. This property
+			  is optional only for compatibility. If the RB
+			  error conditions are not cleared, it will
+			  continuously generate interrupt.
 - reg			: First resource shall be the CPU bus (PCP) resource.
 - interrupts            : Interrupt-specifier for MCU, PMD, L3, or SoC error
 			  IRQ(s).
@@ -64,6 +68,11 @@ Example:
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
@@ -73,6 +82,7 @@ Example:
 		regmap-mcba = <&mcba>;
 		regmap-mcbb = <&mcbb>;
 		regmap-efuse = <&efuse>;
+		regmap-rb = <&rb>;
 		reg = <0x0 0x78800000 0x0 0x100>;
 		interrupts = <0x0 0x20 0x4>,
 			     <0x0 0x21 0x4>,
-- 
1.7.1
