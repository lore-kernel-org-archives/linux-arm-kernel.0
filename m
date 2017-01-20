From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Fri, 20 Jan 2017 12:22:04 +0100
Subject: [PATCH v5 13/14] ARM: dts: da850: add the SATA node
In-Reply-To: <1484911325-23425-1-git-send-email-bgolaszewski@baylibre.com>
References: <1484911325-23425-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1484911325-23425-14-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the SATA node to the da850 device tree.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 104155d..3b5fd41e 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -403,6 +403,12 @@
 			phy-names = "usb-phy";
 			status = "disabled";
 		};
+		sata: sata at 218000 {
+			compatible = "ti,da850-ahci";
+			reg = <0x218000 0x2000>, <0x22c018 0x4>;
+			interrupts = <67>;
+			status = "disabled";
+		};
 		mdio: mdio at 224000 {
 			compatible = "ti,davinci_mdio";
 			#address-cells = <1>;
-- 
2.9.3
