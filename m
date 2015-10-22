From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 22 Oct 2015 11:19:29 +0200
Subject: [PATCH 4/4] arm: dts: Add omap4-hwspinlock support in dm816x
Message-ID: <5628AA21.5070801@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dm816x DT entries for omap4-hwspinlock support as hwmod spinbox.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/dm816x.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
index 51ad4a9..f655ce1 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -227,6 +227,13 @@
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
