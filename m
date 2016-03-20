From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 20 Mar 2016 17:00:30 +0100
Subject: [PATCH 2/8] ARM: dts: sun8i: Add support for H3 usb clocks
In-Reply-To: <1458489636-2825-1-git-send-email-hdegoede@redhat.com>
References: <1458489636-2825-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1458489636-2825-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Reinder de Haan <patchesrdh@mveas.com>

Add a node describing the usb-clks found on the H3.

Signed-off-by: Reinder de Haan <patchesrdh@mveas.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index d1be2f5..3a2e6e2 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -269,6 +269,18 @@
 					     "mmc2_sample";
 		};
 
+		usb_clk: clk at 01c200cc {
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			compatible = "allwinner,sun8i-h3-usb-clk";
+			reg = <0x01c200cc 0x4>;
+			clocks = <&osc24M>;
+			clock-output-names = "usb_phy0", "usb_phy1",
+					     "usb_phy2", "usb_phy3",
+					     "usb_ohci0", "usb_ohci1",
+					     "usb_ohci2", "usb_ohci3";
+		};
+
 		mbus_clk: clk at 01c2015c {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun8i-a23-mbus-clk";
-- 
2.7.3
