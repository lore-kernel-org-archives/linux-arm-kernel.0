From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 26 Aug 2014 14:09:48 +0200
Subject: [PATCH 7/7] ARM: DTS: exynos4412-odroid*: enable MFC device
In-Reply-To: <1409054988-32758-1-git-send-email-m.szyprowski@samsung.com>
References: <1409054988-32758-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1409054988-32758-8-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for Multimedia Codec (MFC) device for all Exynos4412-based
Odroid boards.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index adadaf97ac01..3728c667e7ec 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -11,6 +11,24 @@
 #include "exynos4412.dtsi"
 
 / {
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		mfc_left: region at 77000000 {
+			compatible = "shared-dma-pool";
+			reusable;
+			reg = <0x77000000 0x1000000>;
+		};
+
+		mfc_right: region at 78000000 {
+			compatible = "shared-dma-pool";
+			reusable;
+			reg = <0x78000000 0x1000000>;
+		};
+	};
+
 	firmware at 0204F000 {
 		compatible = "samsung,secure-firmware";
 		reg = <0x0204F000 0x1000>;
@@ -367,6 +385,12 @@
 	ehci: ehci at 12580000 {
 		status = "okay";
 	};
+
+	codec at 13400000 {
+		status = "okay";
+		memory-region = <&mfc_left>, <&mfc_right>;
+		memory-region-names = "left", "right";
+	};
 };
 
 &pinctrl_1 {
-- 
1.9.2
