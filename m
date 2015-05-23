From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Fri, 22 May 2015 23:28:53 -0500
Subject: [PATCH 3/3] ARM: socfpga: dts: add enable-method property for cpu
 nodes
In-Reply-To: <1432355333-15515-1-git-send-email-dinguyen@opensource.altera.com>
References: <1432355333-15515-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <1432355333-15515-4-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Add the enable-method property for the cpu node on socfpga.dtsi and
socfpga_arria10.dtsi. This is for CPU_METHOD_OF_DECLARE to use to enable
the secondary core.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga.dtsi         | 1 +
 arch/arm/boot/dts/socfpga_arria10.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 9b653ed..80f924d 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -36,6 +36,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "altr,socfpga-smp";
 
 		cpu at 0 {
 			compatible = "arm,cortex-a9";
diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index d025f77..6ceb26e 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -24,6 +24,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "altr,socfpga-a10-smp";
 
 		cpu at 0 {
 			compatible = "arm,cortex-a9";
-- 
2.2.1
