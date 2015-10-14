From: kapilh@broadcom.com (Kapil Hali)
Date: Wed, 14 Oct 2015 13:46:59 -0400
Subject: [PATCH 2/3] ARM: dts: add SMP support for Broadcom NSP
In-Reply-To: <1444844820-24290-1-git-send-email-kapilh@broadcom.com>
References: <1444844820-24290-1-git-send-email-kapilh@broadcom.com>
Message-ID: <1444844820-24290-3-git-send-email-kapilh@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree changes required for providing SMP support
for Broadcom Northstar Plus SoC.

Signed-off-by: Kapil Hali <kapilh@broadcom.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 58aca27..d1875d9 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -40,24 +40,33 @@
 	model = "Broadcom Northstar Plus SoC";
 	interrupt-parent = <&gic>;
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		enable-method = "brcm,bcm-nsp-smp";
+		secondary-boot-reg = <0xffff042c>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			next-level-cache = <&L2>;
+			reg = <0x0>;
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			next-level-cache = <&L2>;
+			reg = <0x1>;
+		};
+	};
+
 	mpcore {
 		compatible = "simple-bus";
 		ranges = <0x00000000 0x19020000 0x00003000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 
-		cpus {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			cpu at 0 {
-				device_type = "cpu";
-				compatible = "arm,cortex-a9";
-				next-level-cache = <&L2>;
-				reg = <0x0>;
-			};
-		};
-
 		L2: l2-cache {
 			compatible = "arm,pl310-cache";
 			reg = <0x2000 0x1000>;
-- 
2.1.0
