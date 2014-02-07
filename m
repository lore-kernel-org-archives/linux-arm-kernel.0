From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  7 Feb 2014 15:32:31 +0100
Subject: [PATCH v3 3/5] ARM: sun4i: dt: Add bindings for USB clocks
In-Reply-To: <1391783553-8096-1-git-send-email-hdegoede@redhat.com>
References: <1391783553-8096-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1391783553-8096-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roman Byshko <rbyshko@gmail.com>

Signed-off-by: Roman Byshko <rbyshko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index ebb4cd0..c57df3e 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -301,6 +301,15 @@
 			clock-output-names = "ir1";
 		};
 
+		usb_clk: clk at 01c200cc {
+			#clock-cells = <1>;
+		        #reset-cells = <1>;
+			compatible = "allwinner,sun4i-usb-clk";
+			reg = <0x01c200cc 0x4>;
+			clocks = <&pll6 1>;
+			clock-output-names = "usb_ohci0", "usb_ohci1", "usb_phy";
+		};
+
 		spi3_clk: clk at 01c200d4 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-mod0-clk";
-- 
1.8.4.2
