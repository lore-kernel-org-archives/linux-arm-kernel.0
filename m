From: zmarkovic@sierrawireless.com (Zoran Markovic)
Date: Thu, 22 Dec 2016 12:05:38 -0800
Subject: [RFC PATCH 3/4] dt-bindings: mdm9615: Add NAND controller
In-Reply-To: <1482437139-29329-1-git-send-email-zmarkovic@sierrawireless.com>
References: <1482437139-29329-1-git-send-email-zmarkovic@sierrawireless.com>
Message-ID: <1482437139-29329-4-git-send-email-zmarkovic@sierrawireless.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dt description of NAND controller on MDM9615.

Cc: Andy Gross <andy.gross@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-msm at vger.kernel.org
Cc: linux-soc at vger.kernel.org
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Zoran Markovic <zmarkovic@sierrawireless.com>
---
 arch/arm/boot/dts/qcom-mdm9615.dtsi |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
index fbc7d68..6d42ff3 100644
--- a/arch/arm/boot/dts/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
@@ -373,6 +373,22 @@
 			qcom,ee = <0>;
 		};
 
+		nand0: nand at 1b400000 {
+			compatible = "qcom,ipq806x-nand";
+			reg = <0x1b400000 0x800>;
+			clocks = <&gcc EBI2_CLK>,
+				 <&gcc EBI2_AON_CLK>;
+			clock-names = "core", "aon";
+
+			dmas = <&adm_dma 3>;
+			dma-names = "rxtx";
+			qcom,cmd-crci = <15>;
+			qcom,data-crci = <3>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		amba {
 			compatible = "arm,amba-bus";
 			#address-cells = <1>;
-- 
1.7.9.5
