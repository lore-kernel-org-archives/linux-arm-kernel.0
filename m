From: zmarkovic@sierrawireless.com (Zoran Markovic)
Date: Thu, 22 Dec 2016 12:05:39 -0800
Subject: [RFC PATCH 4/4] dt-bindings: wp8548: Add on-board NAND flash
In-Reply-To: <1482437139-29329-1-git-send-email-zmarkovic@sierrawireless.com>
References: <1482437139-29329-1-git-send-email-zmarkovic@sierrawireless.com>
Message-ID: <1482437139-29329-5-git-send-email-zmarkovic@sierrawireless.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add description of NAND flash on Sierra Wireless WP8548 module
(and MangOH board).

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
 arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi |   50 ++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi b/arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi
index 7869898..a4d1158 100644
--- a/arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi
@@ -54,6 +54,56 @@
 	};
 };
 
+&nand0 {
+	nandcs at 0 {
+		compatible = "qcom,nandcs";
+		reg = <0>;
+
+		linux,mtd-name = "micron,mt29f4g08";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		nand-ecc-strength = <4>;
+		nand-ecc-step-size = <512>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			bootloader at 0x051c0000 {
+				reg = <0x51c0000 0x100000>;
+				read-only;
+			};
+
+			kernel at 0x052c0000 {
+				reg = <0x52c0000 0x1400000>;
+				read-only;
+			};
+
+			rootfs at 0x066c0000 {
+				reg = <0x66c0000 0x3140000>;
+				read-only;
+			};
+
+			user0 at 0x09800000 {
+				reg = <0x9800000 0x2780000>;
+			};
+
+			user1 at 0x0bf80000 {
+				reg = <0xbf80000 0x8B80000>;
+			};
+
+			user2 at 0x14b00000 {
+				reg = <0x14b00000 0x500000>;
+			};
+
+			user3 at 0x15000000 {
+				reg = <0x15000000 0x200000>;
+			};
+		};
+	};
+};
+
 &msmgpio {
 	pinctrl-0 = <&reset_out_pins>;
 	pinctrl-names = "default";
-- 
1.7.9.5
