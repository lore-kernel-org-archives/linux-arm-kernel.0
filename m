From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 14 Mar 2017 12:14:14 +0100
Subject: [PATCH v2 3/4] ARM: dts: dm8168-evm: add SATA node
In-Reply-To: <1489490055-2318-1-git-send-email-bgolaszewski@baylibre.com>
References: <1489490055-2318-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1489490055-2318-4-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the SATA controller node to the dm8168-evm device tree.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/dm8168-evm.dts | 4 ++++
 arch/arm/boot/dts/dm816x.dtsi    | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/dm8168-evm.dts b/arch/arm/boot/dts/dm8168-evm.dts
index c6fabfc..1865976 100644
--- a/arch/arm/boot/dts/dm8168-evm.dts
+++ b/arch/arm/boot/dts/dm8168-evm.dts
@@ -179,3 +179,7 @@
 	pinctrl-0 = <&usb1_pins>;
 	mentor,multipoint = <0>;
 };
+
+&sata {
+	clocks = <&sysclk5_ck>, <&sata_refclk>;
+};
diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
index 276211e..59cbf95 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -293,6 +293,13 @@
 			phy-handle = <&phy1>;
 		};
 
+		sata: sata at 4a140000 {
+			compatible = "ti,dm816-ahci";
+			reg = <0x4a140000 0x10000>;
+			interrupts = <16>;
+			ti,hwmods = "sata";
+		};
+
 		mcspi1: spi at 48030000 {
 			compatible = "ti,omap4-mcspi";
 			reg = <0x48030000 0x1000>;
-- 
2.9.3
