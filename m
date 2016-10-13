From: youlin.pei@mediatek.com (Youlin Pei)
Date: Thu, 13 Oct 2016 13:06:34 +0800
Subject: [PATCH 3/3] ARM: dts: mt2701: Add mtk-cirq node for mt2701
In-Reply-To: <1476335194-26604-1-git-send-email-youlin.pei@mediatek.com>
References: <1476335194-26604-1-git-send-email-youlin.pei@mediatek.com>
Message-ID: <1476335194-26604-4-git-send-email-youlin.pei@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit add mtk-cirq node to mt2701 dtsi.

Signed-off-by: Youlin Pei <youlin.pei@mediatek.com>
---
 arch/arm/boot/dts/mt2701.dtsi |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index 7eab6f4..a314df9 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -21,7 +21,7 @@
 
 / {
 	compatible = "mediatek,mt2701";
-	interrupt-parent = <&sysirq>;
+	interrupt-parent = <&cirq>;
 
 	cpus {
 		#address-cells = <1>;
@@ -158,6 +158,15 @@
 		reg = <0 0x10200100 0 0x1c>;
 	};
 
+	cirq: interrupt-controller at 10204000 {
+		compatible = "mediatek,mt2701-cirq";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		interrupt-parent = <&sysirq>;
+		reg = <0 0x10204000 0 0x4000>;
+		mediatek,ext-irq-start = <32>;
+	};
+
 	apmixedsys: syscon at 10209000 {
 		compatible = "mediatek,mt2701-apmixedsys", "syscon";
 		reg = <0 0x10209000 0 0x1000>;
-- 
1.7.9.5
