From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Sep 2015 09:47:12 +0900
Subject: [PATCH 10/19] ARM: shmobile: r8a7794: add VIN DT support
In-Reply-To: <cover.1442536920.git.horms+renesas@verge.net.au>
References: <cover.1442536920.git.horms+renesas@verge.net.au>
Message-ID: <1afe77ca7846489fff3d1675b82bd2116a56474a.1442536920.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define the generic R8A7794 part of the VIN[01] device nodes. Add aliases for
the VIN[01] device nodes.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 7384db2a3992..e54f3dea2d70 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -27,6 +27,8 @@
 		i2c4 = &i2c4;
 		i2c5 = &i2c5;
 		spi0 = &qspi;
+		vin0 = &vin0;
+		vin1 = &vin1;
 	};
 
 	cpus {
@@ -628,6 +630,24 @@
 		status = "disabled";
 	};
 
+	vin0: video at e6ef0000 {
+		compatible = "renesas,vin-r8a7794";
+		reg = <0 0xe6ef0000 0 0x1000>;
+		interrupts = <0 188 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp8_clks R8A7794_CLK_VIN0>;
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	vin1: video at e6ef1000 {
+		compatible = "renesas,vin-r8a7794";
+		reg = <0 0xe6ef1000 0 0x1000>;
+		interrupts = <0 189 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp8_clks R8A7794_CLK_VIN1>;
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.1.4
