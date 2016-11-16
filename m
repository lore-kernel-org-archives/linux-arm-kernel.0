From: abailon@baylibre.com (Alexandre Bailon)
Date: Wed, 16 Nov 2016 12:07:35 +0100
Subject: [PATCH v5 1/2] ARM: dts: da850: Add the usb otg device node
In-Reply-To: <1479294456-7942-1-git-send-email-abailon@baylibre.com>
References: <1479294456-7942-1-git-send-email-abailon@baylibre.com>
Message-ID: <1479294456-7942-2-git-send-email-abailon@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the device tree node for the usb otg
controller present in the da850 family of SoC's.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 2534aab..ddf4c6e 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -383,6 +383,16 @@
 			dma-names = "rx", "tx";
 			status = "disabled";
 		};
+		usb0: usb at 200000 {
+			compatible = "ti,da830-musb";
+			reg = <0x200000 0x10000>;
+			interrupts = <58>;
+			interrupt-names = "mc";
+			dr_mode = "otg";
+			phys = <&usb_phy 0>;
+			phy-names = "usb-phy";
+			status = "disabled";
+		};
 		mdio: mdio at 224000 {
 			compatible = "ti,davinci_mdio";
 			#address-cells = <1>;
-- 
2.7.3
