From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  2 May 2014 17:57:24 +0200
Subject: [PATCH v10 10/15] ARM: dts: sun6i: Add mmc controller nodes
In-Reply-To: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1399046249-19472-11-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes for the 4 mmc controllers found on A31 SoCs to
arch/arm/boot/dts/sun6i-a31.dtsi.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index f2bb07c..d97721d 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -277,6 +277,50 @@
 		#size-cells = <1>;
 		ranges;
 
+		mmc0: mmc at 01c0f000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c0f000 0x1000>;
+			clocks = <&ahb1_gates 8>, <&mmc0_clk>;
+			clock-names = "ahb", "mmc";
+			resets = <&ahb1_rst 8>;
+			reset-names = "ahb";
+			interrupts = <0 60 4>;
+			status = "disabled";
+		};
+
+		mmc1: mmc at 01c10000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c10000 0x1000>;
+			clocks = <&ahb1_gates 9>, <&mmc1_clk>;
+			clock-names = "ahb", "mmc";
+			resets = <&ahb1_rst 9>;
+			reset-names = "ahb";
+			interrupts = <0 61 4>;
+			status = "disabled";
+		};
+
+		mmc2: mmc at 01c11000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c11000 0x1000>;
+			clocks = <&ahb1_gates 10>, <&mmc2_clk>;
+			clock-names = "ahb", "mmc";
+			resets = <&ahb1_rst 10>;
+			reset-names = "ahb";
+			interrupts = <0 62 4>;
+			status = "disabled";
+		};
+
+		mmc3: mmc at 01c12000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c12000 0x1000>;
+			clocks = <&ahb1_gates 11>, <&mmc3_clk>;
+			clock-names = "ahb", "mmc";
+			resets = <&ahb1_rst 11>;
+			reset-names = "ahb";
+			interrupts = <0 63 4>;
+			status = "disabled";
+		};
+
 		nmi_intc: interrupt-controller at 01f00c0c {
 			compatible = "allwinner,sun6i-a31-sc-nmi";
 			interrupt-controller;
-- 
1.9.0
