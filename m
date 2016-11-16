From: abailon@baylibre.com (Alexandre Bailon)
Date: Wed, 16 Nov 2016 12:07:36 +0100
Subject: [PATCH v5 2/2] ARM: dts: da850-lcdk: Enable the usb otg device node
In-Reply-To: <1479294456-7942-1-git-send-email-abailon@baylibre.com>
References: <1479294456-7942-1-git-send-email-abailon@baylibre.com>
Message-ID: <1479294456-7942-3-git-send-email-abailon@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the usb otg controller for the lcdk board.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index 7b8ab21..03f9bfd 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -158,6 +158,14 @@
 	rx-num-evt = <32>;
 };
 
+&usb_phy {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+};
+
 &aemif {
 	pinctrl-names = "default";
 	pinctrl-0 = <&nand_pins>;
-- 
2.7.3
