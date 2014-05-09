From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Fri,  9 May 2014 18:53:02 +0530
Subject: [PATCH v9 2/4] ARM: dts: Add usb2phy to Exynos 5250
In-Reply-To: <1399641784-10833-1-git-send-email-gautam.vivek@samsung.com>
References: <1399641784-10833-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1399641784-10833-3-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kamil Debski <k.debski@samsung.com>

Add support to PHY of USB2 of the Exynos 5250 SoC.

Signed-off-by: Kamil Debski <k.debski@samsung.com>
[gautam.vivek at samsung.com: Split the usb phy entries from
syscon entries from earlier patch: dts: Add usb2phy to Exynos 5250]
[gautam.vivek at samsung.com: Added phy entry for OHCI also along with EHCI]
Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---

Changes from v8:
 - Removed 'phy-names' property from the 'port'.
 - Dropped 'status' property, since default also takes status = okay.

 arch/arm/boot/dts/exynos5250.dtsi |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 70f0cd5..782c524 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -563,6 +563,12 @@
 
 		clocks = <&clock CLK_USB2>;
 		clock-names = "usbhost";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		port at 0 {
+			reg = <0>;
+			phys = <&usb2_phy_gen 1>;
+		};
 	};
 
 	usb at 12120000 {
@@ -572,6 +578,12 @@
 
 		clocks = <&clock CLK_USB2>;
 		clock-names = "usbhost";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		port at 0 {
+			reg = <0>;
+			phys = <&usb2_phy_gen 1>;
+		};
 	};
 
 	usb2_phy: usbphy at 12130000 {
@@ -589,6 +601,16 @@
 		};
 	};
 
+	usb2_phy_gen: phy at 12130000 {
+		compatible = "samsung,exynos5250-usb2-phy";
+		reg = <0x12130000 0x100>;
+		clocks = <&clock CLK_USB2>, <&clock CLK_FIN_PLL>;
+		clock-names = "phy", "ref";
+		#phy-cells = <1>;
+		samsung,sysreg-phandle = <&sysreg_system_controller>;
+		samsung,pmureg-phandle = <&pmu_system_controller>;
+	};
+
 	pwm: pwm at 12dd0000 {
 		compatible = "samsung,exynos4210-pwm";
 		reg = <0x12dd0000 0x100>;
-- 
1.7.10.4
