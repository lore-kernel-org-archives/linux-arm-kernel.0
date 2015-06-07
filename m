From: linux.amoon@gmail.com (Anand Moon)
Date: Sun,  7 Jun 2015 21:23:47 +0930
Subject: [RESEND] ARM: dts: odroidxu3: Enable USB3 regulators
Message-ID: <1433678028-8441-1-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable regulator for usbdrd3_0 and usbdrd3_1.
Looking at the schematic pin diagram for MAX77802
USB3_0 and USB3_1 is regulated by LDO9 and LD011.

Fix the boot message of failed.
[    3.503539] exynos-dwc3 usb at 12000000: Looking up vdd33-supply from device tree
[    3.503556] exynos-dwc3 usb at 12000000: Looking up vdd33-supply property in node /usb at 12000000 failed
[    3.503568] usb at 12000000 supply vdd33 not found, using dummy regulator
[    3.509154] exynos-dwc3 usb at 12000000: Looking up vdd10-supply from device tree
[    3.509170] exynos-dwc3 usb at 12000000: Looking up vdd10-supply property in node /usb at 12000000 failed
[    3.509181] usb at 12000000 supply vdd10 not found, using dummy regulator
[    3.917548] exynos-dwc3 usb at 12400000: Looking up vdd33-supply from device tree
[    3.917565] exynos-dwc3 usb at 12400000: Looking up vdd33-supply property in node /usb at 12400000 failed
[    3.917578] usb at 12400000 supply vdd33 not found, using dummy regulator
[    3.922731] exynos-dwc3 usb at 12400000: Looking up vdd10-supply from device tree
[    3.922747] exynos-dwc3 usb at 12400000: Looking up vdd10-supply property in node /usb at 12400000 failed

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 8adf455..deb8d78 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -477,3 +477,13 @@
 &usbdrd_dwc3_1 {
 	dr_mode = "otg";
 };
+
+&usbdrd3_0 {
+	vdd33-supply = <&ldo9_reg>;
+	vdd10-supply = <&ldo11_reg>;
+};
+
+&usbdrd3_1 {
+	vdd33-supply = <&ldo9_reg>;
+	vdd10-supply = <&ldo11_reg>;
+};
-- 
2.4.3
