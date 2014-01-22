From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 22 Jan 2014 22:36:27 +0100
Subject: [PATCH v2 5/5] ARM: sun7i: dt: Add bindings for USB clocks
In-Reply-To: <1390426587-16287-1-git-send-email-hdegoede@redhat.com>
References: <1390426587-16287-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1390426587-16287-6-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roman Byshko <rbyshko@gmail.com>

Signed-off-by: Roman Byshko <rbyshko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 57f1fc9..a44b3b3 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -280,6 +280,15 @@
 			clock-output-names = "ir1";
 		};
 
+		usb_clk: clk at 01c200cc {
+			#clock-cells = <1>;
+		        #reset-cells = <1>;
+			compatible = "allwinner,sun4i-usb-gates-clk";
+			reg = <0x01c200cc 0x4>;
+			clocks = <&pll6 1>;
+			clock-output-names = "usb_ohci0", "usb_ohci1", "usb_phy";
+		};
+
 		spi3_clk: clk at 01c200d4 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-mod0-clk";
-- 
1.8.5.3
