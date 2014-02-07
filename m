From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  7 Feb 2014 16:21:53 +0100
Subject: [PATCH v4 5/5] ARM: sun7i: dt: Add bindings for USB clocks
In-Reply-To: <1391786513-20780-1-git-send-email-hdegoede@redhat.com>
References: <1391786513-20780-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1391786513-20780-6-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roman Byshko <rbyshko@gmail.com>

Signed-off-by: Roman Byshko <rbyshko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 316cab8..14d9696 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -289,6 +289,15 @@
 			clock-output-names = "ir1";
 		};
 
+		usb_clk: clk at 01c200cc {
+			#clock-cells = <1>;
+		        #reset-cells = <1>;
+			compatible = "allwinner,sun4i-a10-usb-clk";
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
