From: ahaslam@baylibre.com (ahaslam at baylibre.com)
Date: Fri,  7 Oct 2016 18:42:57 +0200
Subject: [PATCH/RFT 12/12] ARM: dts: da850-lcdk: enable ohci usb
In-Reply-To: <1475858577-10366-1-git-send-email-ahaslam@baylibre.com>
References: <1475858577-10366-1-git-send-email-ahaslam@baylibre.com>
Message-ID: <1475858577-10366-13-git-send-email-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Axel Haslam <ahaslam@baylibre.com>

This enables the ohci usb controller for the lcdk board.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index 7b8ab21..6da9d843 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -86,6 +86,15 @@
 	};
 };
 
+&usb_phy {
+	status = "okay";
+};
+
+&usb11 {
+	status = "okay";
+	power-on-delay = <3>;
+};
+
 &serial2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&serial2_rxtx_pins>;
-- 
2.7.1
