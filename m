From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  2 May 2013 21:43:22 +0200
Subject: [PATCH] ARM: kirkwood: add button for OpenBlock A6
Message-ID: <1367523802-16372-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OpenBlocks A6 board has one software-controlled button on the
front side, labeled "INIT", so we add minimal support for this button
in the kernel.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
index d27f724..627d8d0 100644
--- a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
+++ b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
@@ -209,4 +209,17 @@
 			gpios = <&gpio1 11 1>;
 		};
         };
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+			button at 1 {
+			label = "Init Button";
+			linux,code = <116>;
+			gpios = <&gpio1 6 0>;
+		};
+	};
+
 };
-- 
1.7.9.5
