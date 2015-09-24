From: lho@apm.com (Loc Ho)
Date: Wed, 23 Sep 2015 17:40:58 -0700
Subject: [PATCH v5 1/4] Documentation: Update the APM X-Gene SoC EDAC DTS
 binding for L3/SoC subnodes
In-Reply-To: <1443055261-8613-1-git-send-email-lho@apm.com>
References: <1443055261-8613-1-git-send-email-lho@apm.com>
Message-ID: <1443055261-8613-2-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update documentation for the APM X-Gene SoC EDAC DTS binding for L3/SoC
subnodes.

Signed-off-by: Loc Ho <lho@apm.com>
---
 .../devicetree/bindings/edac/apm-xgene-edac.txt    |   23 ++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt b/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
index 78edb80..78e2a31 100644
--- a/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
+++ b/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
@@ -5,6 +5,8 @@ The follow error types are supported:

   memory controller	- Memory controller
   PMD (L1/L2)		- Processor module unit (PMD) L1/L2 cache
+  L3			- L3 cache controller
+  SoC			- SoC IP's such as Ethernet, SATA, and etc

 The following section describes the EDAC DT node binding.

@@ -30,6 +32,17 @@ Required properties for PMD subnode:
 - reg			: First resource shall be the PMD resource.
 - pmd-controller	: Instance number of the PMD controller.

+Required properties for L3 subnode:
+- compatible		: Shall be "apm,xgene-edac-l3" or
+                          "apm,xgene-edac-l3-v2".
+- reg			: First resource shall be the L3 EDAC resource.
+
+Required properties for SoC subnode:
+- compatible		: Shall be "apm,xgene-edac-soc-v1" for revision 1 or
+                          "apm,xgene-edac-l3-soc" for general value reporting
+                          only.
+- reg			: First resource shall be the SoC EDAC resource.
+
 Example:
 	csw: csw at 7e200000 {
 		compatible = "apm,xgene-csw", "syscon";
@@ -76,4 +89,14 @@ Example:
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
+			compatible = "apm,xgene-edac-soc-v1";
+			reg = <0x0 0x7e930000 0x0 0x1000>;
+		};
 	};
--
1.7.1
