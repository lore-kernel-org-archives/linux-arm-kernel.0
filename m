From: scott.shu@mediatek.com (Scott Shu)
Date: Tue, 4 Aug 2015 21:54:23 +0800
Subject: [PATCH v3 7/8] ARM: dts: mt6580: Add device nodes to the MT6580 dtsi
 file
In-Reply-To: <1438696464-59858-1-git-send-email-scott.shu@mediatek.com>
References: <1438696464-59858-1-git-send-email-scott.shu@mediatek.com>
Message-ID: <1438696464-59858-8-git-send-email-scott.shu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the SCPSYS device node to the MT6580 dtsi file.

Signed-off-by: Scott Shu <scott.shu@mediatek.com>
---
 arch/arm/boot/dts/mt6580.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/mt6580.dtsi b/arch/arm/boot/dts/mt6580.dtsi
index 06fdf6c..40957d3 100644
--- a/arch/arm/boot/dts/mt6580.dtsi
+++ b/arch/arm/boot/dts/mt6580.dtsi
@@ -67,6 +67,12 @@
 		#clock-cells = <0>;
 	};
 
+	scpsys: scpsys at 10006000 {
+		#power-domain-cells = <1>;
+		compatible = "mediatek,mt6580-scpsys";
+		reg = <0x10006000 0x1000>;
+	};
+
 	timer: timer at 10008000 {
 		compatible = "mediatek,mt6580-timer",
 			     "mediatek,mt6577-timer";
-- 
1.7.9.5
