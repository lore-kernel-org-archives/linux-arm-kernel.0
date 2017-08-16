From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 16 Aug 2017 02:38:44 +0200
Subject: [PATCH 2/5] arm64: dts: realtek: Add RTD1295 reset controller nodes
In-Reply-To: <20170816003847.6208-1-afaerber@suse.de>
References: <20170816003847.6208-1-afaerber@suse.de>
Message-ID: <20170816003847.6208-3-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes for the Realtek RTD1295 reset controllers.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm64/boot/dts/realtek/rtd1295.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/realtek/rtd1295.dtsi b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
index 43da91fce2b1..9f1dcd1fa8b3 100644
--- a/arch/arm64/boot/dts/realtek/rtd1295.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
@@ -87,6 +87,36 @@
 		/* Exclude up to 2 GiB of RAM */
 		ranges = <0x80000000 0x80000000 0x80000000>;
 
+		reset1: reset-controller at 98000000 {
+			compatible = "realtek,rtd1295-reset";
+			reg = <0x98000000 0x4>;
+			#reset-cells = <1>;
+		};
+
+		reset2: reset-controller at 98000004 {
+			compatible = "realtek,rtd1295-reset";
+			reg = <0x98000004 0x4>;
+			#reset-cells = <1>;
+		};
+
+		reset3: reset-controller at 98000008 {
+			compatible = "realtek,rtd1295-reset";
+			reg = <0x98000008 0x4>;
+			#reset-cells = <1>;
+		};
+
+		reset4: reset-controller at 98000050 {
+			compatible = "realtek,rtd1295-reset";
+			reg = <0x98000050 0x4>;
+			#reset-cells = <1>;
+		};
+
+		iso_reset: reset-controller at 98007088 {
+			compatible = "realtek,rtd1295-reset";
+			reg = <0x98007088 0x4>;
+			#reset-cells = <1>;
+		};
+
 		uart0: serial at 98007800 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x98007800 0x400>;
-- 
2.12.3
