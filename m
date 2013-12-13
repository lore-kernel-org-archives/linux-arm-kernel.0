From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:31:06 +0900
Subject: [PATCH 32/69] ARM: shmobile: r8a7778: add HSPI suppport on DTSI
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <a50da08569b2d9804575c0cf9d0b67db049afa81.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 698809f..819b194 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -25,6 +25,12 @@
 		};
 	};
 
+	aliases {
+		spi0 = &hspi0;
+		spi1 = &hspi1;
+		spi2 = &hspi2;
+	};
+
 	gic: interrupt-controller at fe438000 {
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
@@ -234,4 +240,28 @@
 		interrupts = <0 77 0x4>;
 		status = "disabled";
 	};
+
+	hspi0: spi at fffc7000 {
+		compatible = "renesas,hspi";
+		reg = <0xfffc7000 0x18>;
+		interrupt-controller = <&gic>;
+		interrupts = <0 63 4>;
+		status = "disabled";
+	};
+
+	hspi1: spi at fffc8000 {
+		compatible = "renesas,hspi";
+		reg = <0xfffc8000 0x18>;
+		interrupt-controller = <&gic>;
+		interrupts = <0 84 4>;
+		status = "disabled";
+	};
+
+	hspi2: spi at fffc6000 {
+		compatible = "renesas,hspi";
+		reg = <0xfffc6000 0x18>;
+		interrupt-controller = <&gic>;
+		interrupts = <0 85 4>;
+		status = "disabled";
+	};
 };
-- 
1.8.4
