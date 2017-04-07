From: youlin.pei@mediatek.com (Youlin Pei)
Date: Fri, 7 Apr 2017 16:06:37 +0800
Subject: [PATCH v4 3/3] ARM: dts: mt2701: Add mtk-cirq node for mt2701
In-Reply-To: <1491552397-7893-1-git-send-email-youlin.pei@mediatek.com>
References: <1491552397-7893-1-git-send-email-youlin.pei@mediatek.com>
Message-ID: <1491552397-7893-4-git-send-email-youlin.pei@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit add mtk-cirq node to mt2701 dtsi.

Signed-off-by: Youlin Pei <youlin.pei@mediatek.com>
---
 arch/arm/boot/dts/mt2701.dtsi |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index 8037210..5daacfe 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -22,7 +22,7 @@
 
 / {
 	compatible = "mediatek,mt2701";
-	interrupt-parent = <&sysirq>;
+	interrupt-parent = <&cirq>;
 
 	cpus {
 		#address-cells = <1>;
@@ -210,6 +210,16 @@
 		reg = <0 0x10200100 0 0x1c>;
 	};
 
+	cirq: interrupt-controller at 10204000 {
+		compatible = "mediatek,mt2701-cirq",
+			     "mediatek,mtk-cirq";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		interrupt-parent = <&sysirq>;
+		reg = <0 0x10204000 0 0x400>;
+		mediatek,ext-irq-range = <32 200>;
+	};
+
 	iommu: mmsys_iommu at 10205000 {
 		compatible = "mediatek,mt2701-m4u";
 		reg = <0 0x10205000 0 0x1000>;
-- 
1.7.9.5
