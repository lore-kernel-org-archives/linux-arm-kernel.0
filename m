From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue,  1 Mar 2016 00:44:25 +0100
Subject: [PATCH 8/8] ARM64: dts: amlogic: Add arch timer node for Meson GXBaby
In-Reply-To: <1456789465-2962-1-git-send-email-afaerber@suse.de>
References: <1456789465-2962-1-git-send-email-afaerber@suse.de>
Message-ID: <1456789465-2962-9-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 5088ae3ff653..a029da976a27 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -101,6 +101,18 @@
 		migrate = <0xc4000005>;
 	};
 
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13
+			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_EDGE_RISING)>,
+			     <GIC_PPI 14
+			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_EDGE_RISING)>,
+			     <GIC_PPI 11
+			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_EDGE_RISING)>,
+			     <GIC_PPI 10
+			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_EDGE_RISING)>;
+	};
+
 	xtal: xtal-clk {
 		compatible = "fixed-clock";
 		clock-frequency = <24000000>;
-- 
2.6.2
