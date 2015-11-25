From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Wed, 25 Nov 2015 08:39:40 +0200
Subject: [PATCH 08/18] ARM: am57xx: cl-som-am57x: dts: add USB support
In-Reply-To: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1448433590-1399-9-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add USB support.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index a838ea4..eba12a4 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -477,3 +477,19 @@
 	pinctrl-0 = <&davinci_mdio_pins_default>;
 	pinctrl-1 = <&davinci_mdio_pins_sleep>;
 };
+
+&usb2_phy1 {
+	phy-supply = <&ldousb_reg>;
+};
+
+&usb2_phy2 {
+	phy-supply = <&ldousb_reg>;
+};
+
+&usb1 {
+	dr_mode = "host";
+};
+
+&usb2 {
+	dr_mode = "peripheral";
+};
-- 
1.9.1
