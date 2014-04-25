From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 25 Apr 2014 18:34:14 +0100
Subject: [PATCH 3/3] arm64: Mark the Applied Micro X-Gene SATA controller as
 DMA coherent
In-Reply-To: <1398447254-18527-1-git-send-email-catalin.marinas@arm.com>
References: <1398447254-18527-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1398447254-18527-4-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the default DMA ops for arm64 are non-coherent, mark the X-Gene
controller explicitly as dma-coherent to avoid additional cache
maintenance.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Loc Ho <lho@apm.com>
---
 Documentation/devicetree/bindings/ata/apm-xgene.txt | 3 +++
 arch/arm64/boot/dts/apm-storm.dtsi                  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/apm-xgene.txt b/Documentation/devicetree/bindings/ata/apm-xgene.txt
index 7bcfbf59810e..a668f0e7d001 100644
--- a/Documentation/devicetree/bindings/ata/apm-xgene.txt
+++ b/Documentation/devicetree/bindings/ata/apm-xgene.txt
@@ -24,6 +24,7 @@ Required properties:
   * "sata-phy" for the SATA 6.0Gbps PHY
 
 Optional properties:
+- dma-coherent		: Present if dma operations are coherent
 - status		: Shall be "ok" if enabled or "disabled" if disabled.
 			  Default is "ok".
 
@@ -55,6 +56,7 @@ Example:
 			      <0x0 0x1f22e000 0x0 0x1000>,
 			      <0x0 0x1f227000 0x0 0x1000>;
 			interrupts = <0x0 0x87 0x4>;
+			dma-coherent;
 			status = "ok";
 			clocks = <&sataclk 0>;
 			phys = <&phy2 0>;
@@ -69,6 +71,7 @@ Example:
 			      <0x0 0x1f23e000 0x0 0x1000>,
 			      <0x0 0x1f237000 0x0 0x1000>;
 			interrupts = <0x0 0x88 0x4>;
+			dma-coherent;
 			status = "ok";
 			clocks = <&sataclk 0>;
 			phys = <&phy3 0>;
diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index 93f4b2dd9248..f8c40a66e65d 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -307,6 +307,7 @@
 			      <0x0 0x1f21e000 0x0 0x1000>,
 			      <0x0 0x1f217000 0x0 0x1000>;
 			interrupts = <0x0 0x86 0x4>;
+			dma-coherent;
 			status = "disabled";
 			clocks = <&sata01clk 0>;
 			phys = <&phy1 0>;
@@ -321,6 +322,7 @@
 			      <0x0 0x1f22e000 0x0 0x1000>,
 			      <0x0 0x1f227000 0x0 0x1000>;
 			interrupts = <0x0 0x87 0x4>;
+			dma-coherent;
 			status = "ok";
 			clocks = <&sata23clk 0>;
 			phys = <&phy2 0>;
@@ -334,6 +336,7 @@
 			      <0x0 0x1f23d000 0x0 0x1000>,
 			      <0x0 0x1f23e000 0x0 0x1000>;
 			interrupts = <0x0 0x88 0x4>;
+			dma-coherent;
 			status = "ok";
 			clocks = <&sata45clk 0>;
 			phys = <&phy3 0>;
