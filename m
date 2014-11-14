From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Fri, 14 Nov 2014 20:46:19 +0100
Subject: [PATCH] ARM: dts: Explicitly set dr_mode on exynos5250-snow
Message-ID: <1415994379-29165-1-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Explicitly set the dr_mode for the dwc3 controller on the
Snow board to host mode. This is required to ensure the
controller is initialized in the right mode if the kernel is
build with USB gadget support.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---
 arch/arm/boot/dts/exynos5250-snow.dts | 4 ++++
 arch/arm/boot/dts/exynos5250.dtsi     | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index e51fcef..60429ad 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -624,4 +624,8 @@
 	num-cs = <1>;
 };
 
+&usbdrd_dwc3 {
+	dr_mode = "host";
+};
+
 #include "cros-ec-keyboard.dtsi"
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index f21b9aa..d55c1a2 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -555,7 +555,7 @@
 		#size-cells = <1>;
 		ranges;
 
-		dwc3 {
+		usbdrd_dwc3: dwc3 {
 			compatible = "synopsys,dwc3";
 			reg = <0x12000000 0x10000>;
 			interrupts = <0 72 0>;
-- 
2.1.3
