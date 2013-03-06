From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  6 Mar 2013 16:29:26 +0100
Subject: [PATCH 4/5] ARM: sunxi: dt: Add A10 UARTs to the dtsi.
In-Reply-To: <1362583767-13862-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1362583767-13862-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1362583767-13862-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A10 SoC has 8 available UARTs, which is 6 more than on the
A13, so add the missing UARTs to the sun4i-a10 dtsi.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi |   51 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 703e7cb..0142ca0 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -57,5 +57,56 @@
 			clocks = <&osc>;
 			status = "disabled";
 		};
+
+		uart2: uart at 01c28800 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c28800 0x400>;
+			interrupts = <3>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&osc>;
+			status = "disabled";
+		};
+
+
+		uart4: uart at 01c29000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c29000 0x400>;
+			interrupts = <17>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&osc>;
+			status = "disabled";
+		};
+
+		uart5: uart at 01c29400 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c29400 0x400>;
+			interrupts = <18>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&osc>;
+			status = "disabled";
+		};
+
+		uart6: uart at 01c29800 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c29800 0x400>;
+			interrupts = <19>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&osc>;
+			status = "disabled";
+		};
+
+		uart7: uart at 01c29c00 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c29c00 0x400>;
+			interrupts = <20>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&osc>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.7.10.4
