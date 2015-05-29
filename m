From: lho@apm.com (Loc Ho)
Date: Fri, 29 May 2015 16:04:33 -0600
Subject: [PATCH 1/3] Documentation: Update the APM X-Gene SoC EDAC DTS binding
 for L3/SoC subnodes
In-Reply-To: <1432937075-16558-1-git-send-email-lho@apm.com>
References: <1432937075-16558-1-git-send-email-lho@apm.com>
Message-ID: <1432937075-16558-2-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates documentation for the APM X-Gene SoC EDAC DTS binding
for L3/SoC subnodes.

Signed-off-by: Loc Ho <lho@apm.com>
---
 .../devicetree/bindings/edac/apm-xgene-edac.txt    |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt b/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
index 480911c..0aa4bd3 100644
--- a/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
+++ b/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
@@ -29,6 +29,14 @@ Required properties for PMD subnode:
 - reg			: First resource shall be the PMD resource.
 - pmd-controller	: Instance number of the PMD controller.
 
+Required properties for L3 subnode:
+- compatible		: Shall be "apm,xgene-edac-l3".
+- reg			: First resource shall be the L3 resource.
+
+Required properties for SoC subnode:
+- compatible		: Shall be "apm,xgene-edac-soc".
+- reg			: First resource shall be the SoC resource.
+
 Example:
 	csw: csw at 7e200000 {
 		compatible = "apm,xgene-csw", "syscon";
@@ -75,4 +83,14 @@ Example:
 			reg = <0x0 0x7c000000 0x0 0x200000>;
 			pmd-controller = <0>;
 		};
+
+		edacl3 at 7e600000 {
+			compatible = "apm,xgene-edac-l3";
+			reg = <0x0 0x7e600000 0x0 0x1000>;
+		};
+
+		edacsoc at 7e930000 {
+			compatible = "apm,xgene-edac-soc";
+			reg = <0x0 0x7e930000 0x0 0x1000>;
+		};
 	};
-- 
1.7.1
