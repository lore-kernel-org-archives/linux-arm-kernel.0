From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Wed, 24 Sep 2014 09:57:43 +0200
Subject: [PATCH 1/3 v4] ARM: dts: exynos: Explicitly set dr_mode on peach-pit
 and peach-pi
In-Reply-To: <1411545465-12930-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <542199F4.3090601@samsung.com>
 <1411545465-12930-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <1411545465-12930-2-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case the optional dr_mode property isn't set in the dwc3 nodes the
the controller will go into OTG mode iff both USB host and USB gadget
functionality are enabled in the kernel configuration. Unfortunately this
results in USB not working on exynos5420-peach-pit and
exynos5800-peach-pi with such a kernel configuration unless manually
change the mode. To resolve that explicitly configure the dual role
mode as host

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Reviewed-by: Andreas F?rber <afaerber@suse.de>
---
Changes in v2: alphabetically sort the dts entries
Changes in v3: Fix typo in commit message
Changes in v4: Rebased on linux-samsung for-next

 arch/arm/boot/dts/exynos5420-peach-pit.dts | 8 ++++++++
 arch/arm/boot/dts/exynos5420.dtsi          | 4 ++--
 arch/arm/boot/dts/exynos5800-peach-pi.dts  | 8 ++++++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 17dae508..9a050e1 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -841,6 +841,14 @@
 	status = "okay";
 };
 
+&usbdrd_dwc3_0 {
+	dr_mode = "host";
+};
+
+&usbdrd_dwc3_1 {
+	dr_mode = "host";
+};
+
 &usbdrd_phy0 {
 	vbus-supply = <&usb300_vbus_reg>;
 };
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index bfe056d..8617a03 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -815,7 +815,7 @@
 		#size-cells = <1>;
 		ranges;
 
-		dwc3 {
+		usbdrd_dwc3_0: dwc3 {
 			compatible = "snps,dwc3";
 			reg = <0x12000000 0x10000>;
 			interrupts = <0 72 0>;
@@ -841,7 +841,7 @@
 		#size-cells = <1>;
 		ranges;
 
-		dwc3 {
+		usbdrd_dwc3_1: dwc3 {
 			compatible = "snps,dwc3";
 			reg = <0x12400000 0x10000>;
 			interrupts = <0 73 0>;
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 4d1492e..e8fdda8 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -829,6 +829,14 @@
 	status = "okay";
 };
 
+&usbdrd_dwc3_0 {
+	dr_mode = "host";
+};
+
+&usbdrd_dwc3_1 {
+	dr_mode = "host";
+};
+
 &usbdrd_phy0 {
 	vbus-supply = <&usb300_vbus_reg>;
 };
-- 
2.1.0
