From: m-karicheri2@ti.com (Murali Karicheri)
Date: Tue, 19 Nov 2013 19:43:17 -0500
Subject: [PATCH v2 4/4] keystone: dts: add paclk divider clock node
In-Reply-To: <1384908197-4324-1-git-send-email-m-karicheri2@ti.com>
References: <1384908197-4324-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1384908197-4324-5-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PA subsystem has a fixed factor clock at the input which is
input clock divided by 3. This patch adds this clock node to dts

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 arch/arm/boot/dts/keystone-clocks.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-clocks.dtsi b/arch/arm/boot/dts/keystone-clocks.dtsi
index 2a2f247..2363593 100644
--- a/arch/arm/boot/dts/keystone-clocks.dtsi
+++ b/arch/arm/boot/dts/keystone-clocks.dtsi
@@ -124,6 +124,15 @@ clocks {
 		clock-output-names = "chipclk13";
 	};
 
+	paclk13: paclk13 {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&papllclk>;
+		clock-div = <3>;
+		clock-mult = <1>;
+		clock-output-names = "paclk13";
+	};
+
 	chipclk14: chipclk14 {
 		#clock-cells = <0>;
 		compatible = "fixed-factor-clock";
-- 
1.7.9.5
