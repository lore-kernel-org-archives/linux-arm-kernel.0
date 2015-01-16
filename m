From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Fri, 16 Jan 2015 19:33:39 +0530
Subject: [PATCH v4 3/5] ARM: sunxi: dts: Add PS2 nodes to dtsi for A10 and A20
In-Reply-To: <1421417021-3247-1-git-send-email-vishnupatekar0510@gmail.com>
References: <1421417021-3247-1-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <1421417021-3247-4-git-send-email-vishnupatekar0510@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: VishnuPatekar <vishnupatekar0510@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi |   16 ++++++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi |   16 ++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 7b4099f..2c31242 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -795,5 +795,21 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
+		ps20: ps2 at 01c2a000 {
+			compatible = "allwinner,sun4i-a10-ps2";
+			reg = <0x01c2a000 0x400>;
+			interrupts = <62>;
+			clocks = <&apb1_gates 6>;
+			status = "disabled";
+		};
+
+		ps21: ps2 at 01c2a400 {
+			compatible = "allwinner,sun4i-a10-ps2";
+			reg = <0x01c2a400 0x400>;
+			interrupts = <63>;
+			clocks = <&apb1_gates 7>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index e21ce59..f35c691 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -1093,5 +1093,21 @@
 			#interrupt-cells = <3>;
 			interrupts = <1 9 0xf04>;
 		};
+
+		ps20: ps2 at 01c2a000 {
+			compatible = "allwinner,sun4i-a10-ps2";
+			reg = <0x01c2a000 0x400>;
+			interrupts = <0 62 4>;
+			clocks = <&apb1_gates 6>;
+			status = "disabled";
+		};
+
+		ps21: ps2 at 01c2a400 {
+			compatible = "allwinner,sun4i-a10-ps2";
+			reg = <0x01c2a400 0x400>;
+			interrupts = <0 63 4>;
+			clocks = <&apb1_gates 7>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.7.9.5
