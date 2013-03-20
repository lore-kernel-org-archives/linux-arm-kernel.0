From: rogerq@ti.com (Roger Quadros)
Date: Wed, 20 Mar 2013 17:44:58 +0200
Subject: [PATCH v4 19/21] ARM: dts: OMAP4: Add HS USB Host IP nodes
In-Reply-To: <1363794300-31526-1-git-send-email-rogerq@ti.com>
References: <1363794300-31526-1-git-send-email-rogerq@ti.com>
Message-ID: <1363794300-31526-20-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds device nodes for HS USB Host module, TLL module,
OHCI and EHCI controllers.

CC: Beno?t Cousson <b-cousson@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 739bb79..b7db1a2 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -529,5 +529,35 @@
 			ti,hwmods = "timer11";
 			ti,timer-pwm;
 		};
+
+		usbhstll: usbhstll at 4a062000 {
+			compatible = "ti,usbhs-tll";
+			reg = <0x4a062000 0x1000>;
+			interrupts = <0 78 0x4>;
+			ti,hwmods = "usb_tll_hs";
+		};
+
+		usbhshost: usbhshost at 4a064000 {
+			compatible = "ti,usbhs-host";
+			reg = <0x4a064000 0x800>;
+			ti,hwmods = "usb_host_hs";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			usbhsohci: ohci at 4a064800 {
+				compatible = "ti,ohci-omap3", "usb-ohci";
+				reg = <0x4a064800 0x400>;
+				interrupt-parent = <&gic>;
+				interrupts = <0 76 0x4>;
+			};
+
+			usbhsehci: ehci at 4a064c00 {
+				compatible = "ti,ehci-omap", "usb-ehci";
+				reg = <0x4a064c00 0x400>;
+				interrupt-parent = <&gic>;
+				interrupts = <0 77 0x4>;
+			};
+		};
 	};
 };
-- 
1.7.4.1
