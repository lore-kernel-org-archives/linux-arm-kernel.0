From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Fri,  9 May 2014 18:53:04 +0530
Subject: [PATCH v2 4/4] ARM: dts: Add usb 2.0 support on exynos5420
In-Reply-To: <1399641784-10833-1-git-send-email-gautam.vivek@samsung.com>
References: <1399641784-10833-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1399641784-10833-5-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add required device node for ehci and ohci controllers to
enable USB 2.0 support.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---

Changes from v1:
 - Removed 'phy-names' property from the 'port'.
 - Added node references for the nodes.

 arch/arm/boot/dts/exynos5420.dtsi |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index ddd09a3..77ccefd 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -745,6 +745,36 @@
 		samsung,power-domain = <&g2d_pd>;
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
1.7.10.4
