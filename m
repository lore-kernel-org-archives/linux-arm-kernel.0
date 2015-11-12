From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 12 Nov 2015 15:07:49 +0100
Subject: [PATCH v2 5/5] arm: dts: Add omap4-hwspinlock support in dm816x
Message-ID: <56449D35.1040104@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dm816x DT entries for omap4-hwspinlock support as hwmod spinbox.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/dm816x.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
index b9feeea..eb9bea1 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -226,6 +226,13 @@
 			};
 		};

+		spinbox: spinbox at 480ca000 {
+			compatible = "ti,omap4-hwspinlock";
+			reg = <0x480ca000 0x2000>;
+			ti,hwmods = "spinbox";
+			#hwlock-cells = <1>;
+		};
+
 		mdio: mdio at 4a100800 {
 			compatible = "ti,davinci_mdio";
 			#address-cells = <1>;
-- 
1.9.1
