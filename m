From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 21 Aug 2016 15:09:59 +0000
Subject: [PATCH V3 1/5] ARM: dts: bcm283x: Add missing USB clock
In-Reply-To: <1471792204-21908-1-git-send-email-stefan.wahren@i2se.com>
References: <1471792204-21908-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1471792204-21908-2-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the DWC2 binding an appropriate clock is required.
This clock isn't handled by bcm2835 clock driver, so add a fixed
clock to the bcm283x DT.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/bcm283x.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 445624a..46d46d8 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -290,6 +290,8 @@
 			interrupts = <1 9>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			clocks = <&clk_usb>;
+			clock-names = "otg";
 		};
 
 		v3d: v3d at 7ec00000 {
@@ -317,5 +319,12 @@
 			clock-frequency = <19200000>;
 		};
 
+		clk_usb: clock at 4 {
+			compatible = "fixed-clock";
+			reg = <4>;
+			#clock-cells = <0>;
+			clock-output-names = "otg";
+			clock-frequency = <480000000>;
+		};
 	};
 };
-- 
1.7.9.5
