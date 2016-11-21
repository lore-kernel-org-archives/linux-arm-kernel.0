From: ahaslam@baylibre.com (Axel Haslam)
Date: Mon, 21 Nov 2016 17:59:20 +0100
Subject: [PATCH 2/2] ARM: dts: da850-lcdk: Enable ohci for omapl138 lcdk
In-Reply-To: <20161121165920.29809-1-ahaslam@baylibre.com>
References: <20161121165920.29809-1-ahaslam@baylibre.com>
Message-ID: <20161121165920.29809-3-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the usb1 controller (ohci) and phy for the lcdk board

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index 7b8ab21..a739603 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -86,6 +86,14 @@
 	};
 };
 
+&usb_phy {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
+
 &serial2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&serial2_rxtx_pins>;
-- 
2.9.3
