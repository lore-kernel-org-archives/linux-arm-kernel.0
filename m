From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue, 26 Sep 2017 14:17:20 +0200
Subject: [PATCH v2 10/10] ARM: dts: sun8i: bananapi-m3: include axp813 dtsi
In-Reply-To: <cover.1c314f4154a6d27354625f03d0a5269eee55a9c5.1506428208.git-series.quentin.schulz@free-electrons.com>
References: <cover.1c314f4154a6d27354625f03d0a5269eee55a9c5.1506428208.git-series.quentin.schulz@free-electrons.com>
Message-ID: <594364dbd6b11b76f4cb1c5eaa28b9f1bf17cd9b.1506428208.git-series.quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This board has an AXP813 PMIC so let's include its dtsi.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
index 2bafd7e..0bf04a3 100644
--- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
@@ -91,7 +91,7 @@
 &r_rsb {
 	status = "okay";
 
-	axp81x: pmic at 3a3 {
+	axp813: pmic at 3a3 {
 		compatible = "x-powers,axp813";
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
@@ -123,6 +123,8 @@
 	};
 };
 
+#include "axp813.dtsi"
+
 &reg_usb1_vbus {
 	gpio = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
 	status = "okay";
-- 
git-series 0.9.1
