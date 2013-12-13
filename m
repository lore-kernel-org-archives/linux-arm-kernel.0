From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:31:27 +0900
Subject: [PATCH 01/69] ARM: shmobile: r8a7778: add I2C support on DTSI
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <3acb51b9215bd99da403ecf8200f8425176b1926.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778.dtsi | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index a6308a3..7a2c433 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -116,4 +116,44 @@
 		compatible = "renesas,pfc-r8a7778";
 		reg = <0xfffc000 0x118>;
 	};
+
+	i2c0: i2c at ffc70000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-r8a7778";
+		reg = <0xffc70000 0x1000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 67 0x4>;
+		status = "disabled";
+	};
+
+	i2c1: i2c at ffc71000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-r8a7778";
+		reg = <0xffc71000 0x1000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 78 0x4>;
+		status = "disabled";
+	};
+
+	i2c2: i2c at ffc72000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-r8a7778";
+		reg = <0xffc72000 0x1000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 76 0x4>;
+		status = "disabled";
+	};
+
+	i2c3: i2c at ffc73000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-r8a7778";
+		reg = <0xffc73000 0x1000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 77 0x4>;
+		status = "disabled";
+	};
 };
-- 
1.8.4
