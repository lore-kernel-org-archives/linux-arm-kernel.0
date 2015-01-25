From: jenskuske@gmail.com (Jens Kuske)
Date: Sun, 25 Jan 2015 16:49:17 +0100
Subject: [PATCH 1/3] ARM: dts: sunxi: Add syscon node for controlling SRAM
 mapping
In-Reply-To: <1422200959-1717-1-git-send-email-jenskuske@gmail.com>
References: <1422200959-1717-1-git-send-email-jenskuske@gmail.com>
Message-ID: <1422200959-1717-2-git-send-email-jenskuske@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chen-Yu Tsai <wens@csie.org>

Allwinner SoCs have a system controller module that controls whether
SRAM blocks are mapped to the CPU memory or specific peripherals.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
[jenskuske at gmail.com: duplicate syscon node to sun4i and sun5i]
Signed-off-by: Jens Kuske <jenskuske@gmail.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi  | 5 +++++
 arch/arm/boot/dts/sun5i-a10s.dtsi | 5 +++++
 arch/arm/boot/dts/sun5i-a13.dtsi  | 5 +++++
 arch/arm/boot/dts/sun7i-a20.dtsi  | 5 +++++
 4 files changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 380f914..8a90e48 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -339,6 +339,11 @@
 		#size-cells = <1>;
 		ranges;
 
+		syscon: syscon at 01c00000 {
+			compatible = "allwinner,sun4i-a10-syscon", "syscon";
+			reg = <0x01c00000 0x8>;
+		};
+
 		dma: dma-controller at 01c02000 {
 			compatible = "allwinner,sun4i-a10-dma";
 			reg = <0x01c02000 0x1000>;
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 531272c..21df7b4 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -300,6 +300,11 @@
 		#size-cells = <1>;
 		ranges;
 
+		syscon: syscon at 01c00000 {
+			compatible = "allwinner,sun4i-a10-syscon", "syscon";
+			reg = <0x01c00000 0x8>;
+		};
+
 		dma: dma-controller at 01c02000 {
 			compatible = "allwinner,sun4i-a10-dma";
 			reg = <0x01c02000 0x1000>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index b131068..b69b7b1 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -298,6 +298,11 @@
 		#size-cells = <1>;
 		ranges;
 
+		syscon: syscon at 01c00000 {
+			compatible = "allwinner,sun4i-a10-syscon", "syscon";
+			reg = <0x01c00000 0x8>;
+		};
+
 		dma: dma-controller at 01c02000 {
 			compatible = "allwinner,sun4i-a10-dma";
 			reg = <0x01c02000 0x1000>;
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 82097c9..af9c7e6 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -451,6 +451,11 @@
 		#size-cells = <1>;
 		ranges;
 
+		syscon: syscon at 01c00000 {
+			compatible = "allwinner,sun4i-a10-syscon", "syscon";
+			reg = <0x01c00000 0x8>;
+		};
+
 		nmi_intc: interrupt-controller at 01c00030 {
 			compatible = "allwinner,sun7i-a20-sc-nmi";
 			interrupt-controller;
-- 
2.2.2
