From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 May 2013 11:44:58 +0200
Subject: [PATCH 21/21] arm: kirkwood: openblocks-a6: add support for Init
 button
In-Reply-To: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1369388699-25975-22-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kirkwood-based PlatHome OpenBlocks A6 board has an Init button
connected to MPP pin 38. This commit adds support for this button.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
index 56e3161..38dc851 100644
--- a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
+++ b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
@@ -151,4 +151,18 @@
 			gpios = <&gpio1 11 1>;
 		};
         };
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		pinctrl-0 = <&pmx_gpio_init>;
+		pinctrl-names = "default";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		button at 1 {
+			label = "Init Button";
+			linux,code = <116>;
+			gpios = <&gpio1 6 0>;
+		};
+	};
 };
-- 
1.7.9.5
