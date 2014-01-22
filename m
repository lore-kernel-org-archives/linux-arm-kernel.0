From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 22 Jan 2014 22:36:26 +0100
Subject: [PATCH v2 4/5] ARM: sun5i: dt: Add bindings for USB clocks
In-Reply-To: <1390426587-16287-1-git-send-email-hdegoede@redhat.com>
References: <1390426587-16287-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1390426587-16287-5-git-send-email-hdegoede@redhat.com>
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
index 9591959..44235e7 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -255,6 +255,15 @@
 			clock-output-names = "ir0";
 		};
 
+		usb_clk: clk at 01c200cc {
+			#clock-cells = <1>;
+		        #reset-cells = <1>;
+			compatible = "allwinner,sun5i-a13-usb-gates-clk";
+			reg = <0x01c200cc 0x4>;
+			clocks = <&pll6 1>;
+			clock-output-names = "usb_ohci0", "usb_phy";
+		};
+
 		mbus_clk: clk at 01c2015c {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-mod0-clk";
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index f6f2c81..4193fdf 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -252,6 +252,15 @@
 			clock-output-names = "ir0";
 		};
 
+		usb_clk: clk at 01c200cc {
+			#clock-cells = <1>;
+		        #reset-cells = <1>;
+			compatible = "allwinner,sun5i-a13-usb-gates-clk";
+			reg = <0x01c200cc 0x4>;
+			clocks = <&pll6 1>;
+			clock-output-names = "usb_ohci0", "usb_phy";
+		};
+
 		mbus_clk: clk at 01c2015c {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-mod0-clk";
-- 
1.8.5.3
