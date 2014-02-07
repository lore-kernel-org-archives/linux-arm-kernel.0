From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  7 Feb 2014 16:21:52 +0100
Subject: [PATCH v4 4/5] ARM: sun5i: dt: Add bindings for USB clocks
In-Reply-To: <1391786513-20780-1-git-send-email-hdegoede@redhat.com>
References: <1391786513-20780-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1391786513-20780-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roman Byshko <rbyshko@gmail.com>

Signed-off-by: Roman Byshko <rbyshko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 9 +++++++++
 arch/arm/boot/dts/sun5i-a13.dtsi  | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 38d01bd..2ed7429 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -264,6 +264,15 @@
 			clock-output-names = "ir0";
 		};
 
+		usb_clk: clk at 01c200cc {
+			#clock-cells = <1>;
+		        #reset-cells = <1>;
+			compatible = "allwinner,sun5i-a13-usb-clk";
+			reg = <0x01c200cc 0x4>;
+			clocks = <&pll6 1>;
+			clock-output-names = "usb_ohci0", "usb_phy";
+		};
+
 		mbus_clk: clk at 01c2015c {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-mod0-clk";
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index ddd39d3..30ece67 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -261,6 +261,15 @@
 			clock-output-names = "ir0";
 		};
 
+		usb_clk: clk at 01c200cc {
+			#clock-cells = <1>;
+		        #reset-cells = <1>;
+			compatible = "allwinner,sun5i-a13-usb-clk";
+			reg = <0x01c200cc 0x4>;
+			clocks = <&pll6 1>;
+			clock-output-names = "usb_ohci0", "usb_phy";
+		};
+
 		mbus_clk: clk at 01c2015c {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-mod0-clk";
-- 
1.8.4.2
