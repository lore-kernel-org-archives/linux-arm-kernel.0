From: lho@apm.com (Loc Ho)
Date: Tue, 17 Mar 2015 00:30:19 -0600
Subject: [PATCH v6 3/5] Documentation: Add documentation for the APM X-Gene
 SoC EDAC DTS binding
In-Reply-To: <1426573821-1937-3-git-send-email-lho@apm.com>
References: <1426573821-1937-1-git-send-email-lho@apm.com>
 <1426573821-1937-2-git-send-email-lho@apm.com>
 <1426573821-1937-3-git-send-email-lho@apm.com>
Message-ID: <1426573821-1937-4-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds documentation for the APM X-Gene SoC EDAC DTS binding.

Signed-off-by: Feng Kan <fkan@apm.com>
Signed-off-by: Loc Ho <lho@apm.com>
---
 .../devicetree/bindings/edac/apm-xgene-edac.txt    |   82 ++++++++++++++++++++
 1 files changed, 82 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/edac/apm-xgene-edac.txt

diff --git a/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt b/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
new file mode 100644
index 0000000..db8c1c4
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
@@ -0,0 +1,82 @@
+* APM X-Gene SoC EDAC nodes
+
+EDAC nodes are defined to describe on-chip error detection and correction.
+There are four types of EDAC:
+
+  memory controller	- Memory controller
+  PMD (L1/L2)		- Processor module unit (PMD) L1/L2 cache
+  L3			- CPU L3 cache
+  SoC			- SoC IP such as SATA, Ethernet, and etc
+
+The following section describes the memory controller DT node binding.
+
+Required properties:
+- compatible		: Shall be "apm,xgene-edac-mc".
+- reg			: First resource shall be the PCP resource.
+			  Second resource shall be the CSW resource.
+			  Third resource shall be the MCB-A resource.
+			  Fourth resource shall be the MCB-B resource.
+			  Fifth resource shall be the MCU resource.
+- interrupts            : Interrupt-specifier for MCU error IRQ(s).
+
+The following section describes the L1/L2 DT node binding.
+
+- compatible		: Shall be "apm,xgene-edac-pmd".
+- reg			: First resource shall be the PCP resource.
+			  Second resource shall be the PMD resource.
+			  Third resource shall be the PMD efuse resource.
+- interrupts            : Interrupt-specifier for PMD error IRQ(s).
+
+The following section describes the L3 DT node binding.
+
+- compatible		: Shall be "apm,xgene-edac-l3".
+- reg			: First resource shall be the PCP resource.
+			  Second resource shall be the L3 resource.
+- interrupts            : Interrupt-specifier for L3 error IRQ(s).
+
+The following section describes the SoC DT node binding.
+
+- compatible		: Shall be "apm,xgene-edac-soc"".
+- reg			: First resource shall be the PCP resource.
+			  Second resource shall be the SoC resource.
+			  Third resource shall be the register bus resource.
+- interrupts		: Interrupt-specifier for SoC error IRQ(s).
+
+Example:
+	edacmc0: edacmc0 at 7e800000 {
+		compatible = "apm,xgene-edac-mc";
+		reg = <0x0 0x78800000 0x0 0x1000>,
+		      <0x0 0x7e200000 0x0 0x1000>,
+		      <0x0 0x7e700000 0x0 0x1000>,
+		      <0x0 0x7e720000 0x0 0x1000>,
+		      <0x0 0x7e800000 0x0 0x1000>;
+		interrupts = <0x0 0x20 0x4>,
+			     <0x0 0x21 0x4>;
+	};
+
+	edacl3: edacl3 at 7e600000 {
+		compatible = "apm,xgene-edac-l3";
+		reg = <0x0 0x78800000 0x0 0x1000>,
+		      <0x0 0x7e600000 0x0 0x1000>;
+		interrupts = <0x0 0x20 0x4>,
+			     <0x0 0x21 0x4>;
+	};
+
+	edacpmd0: edacpmd0 at 7c000000 {
+		compatible = "apm,xgene-edac-pmd";
+		reg = <0x0 0x78800000 0x0 0x1000>,
+		      <0x0 0x7c000000 0x0 0x200000>,
+		      <0x0 0x1054a000 0x0 0x10>;
+		interrupts = <0x0 0x20 0x4>,
+			     <0x0 0x21 0x4>;
+	};
+
+	edacsoc: edacsoc at 7e930000 {
+		compatible = "apm,xgene-edac-soc";
+		reg = <0x0 0x78800000 0x0 0x1000>,
+		      <0x0 0x7e930000 0x0 0x1000>,
+		      <0x0 0x7e000000 0x0 0x1000>;
+		interrupts = <0x0 0x20 0x4>,
+			     <0x0 0x21 0x4>,
+			     <0x0 0x27 0x4>;
+	};
--
1.7.1
