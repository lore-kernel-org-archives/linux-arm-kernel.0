From: alexandre.torgue@gmail.com (Alexandre TORGUE)
Date: Mon, 29 Feb 2016 17:29:36 +0100
Subject: [PATCH 3/3] ARM: dts: stm32f429: Enable Ethernet on Eval board
In-Reply-To: <1456763376-21457-1-git-send-email-alexandre.torgue@gmail.com>
References: <1456763376-21457-1-git-send-email-alexandre.torgue@gmail.com>
Message-ID: <1456763376-21457-4-git-send-email-alexandre.torgue@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MAC is connected to a PHY in MII mode.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@gmail.com>

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 1ae57fa..e345459 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -87,6 +87,21 @@
 	clock-frequency = <25000000>;
 };
 
+&ethernet0 {
+	status = "okay";
+	pinctrl-0	= <&ethernet0_mii>;
+	pinctrl-names	= "default";
+	phy-mode	= "mii-id";
+	mdio0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dwmac-mdio";
+			phy1: ethernet-phy at 1 {
+				reg = <1>;
+			};
+		};
+};
+
 &usart1 {
 	pinctrl-0 = <&usart1_pins_a>;
 	pinctrl-names = "default";
-- 
1.9.1
