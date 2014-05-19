From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Mon, 19 May 2014 16:49:16 +0530
Subject: [PATCH V3 4/4] ARM: dts: Add usb 2.0 support on exynos5420
In-Reply-To: <1400498356-26803-1-git-send-email-vikas.sajjan@samsung.com>
References: <1400498356-26803-1-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <1400498356-26803-5-git-send-email-vikas.sajjan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vivek Gautam <gautam.vivek@samsung.com>

Add required device node for ehci and ohci controllers to
enable USB 2.0 support.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 2eb00cb..921885a 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -839,6 +839,36 @@
 		#phy-cells = <1>;
 	};
 
+	usbhost2: usb at 12110000 {
+		compatible = "samsung,exynos4210-ehci";
+		reg = <0x12110000 0x100>;
+		interrupts = <0 71 0>;
+
+		clocks = <&clock CLK_USBH20>;
+		clock-names = "usbhost";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		port at 0 {
+			reg = <0>;
+			phys = <&usb2_phy 1>;
+		};
+	};
+
+	usbhost1: usb at 12120000 {
+		compatible = "samsung,exynos4210-ohci";
+		reg = <0x12120000 0x100>;
+		interrupts = <0 71 0>;
+
+		clocks = <&clock CLK_USBH20>;
+		clock-names = "usbhost";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		port at 0 {
+			reg = <0>;
+			phys = <&usb2_phy 1>;
+		};
+	};
+
 	usb2_phy: phy at 12130000 {
 		compatible = "samsung,exynos5250-usb2-phy";
 		reg = <0x12130000 0x100>;
-- 
1.7.9.5
