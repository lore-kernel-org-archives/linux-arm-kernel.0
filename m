From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Tue,  8 Apr 2014 20:06:40 +0530
Subject: [PATCH v4 2/5] dt: exynos5420: Enable support for USB 3.0 PHY
 controller
In-Reply-To: <1396967803-28868-1-git-send-email-gautam.vivek@samsung.com>
References: <1396967803-28868-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1396967803-28868-3-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree nodes for USB 3.0 PHY present alongwith
USB 3.0 controller Exynos 5420 SoC. This phy driver is
based on generic phy framework.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 8db792b..a6efb52 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -652,4 +652,24 @@
 		clocks = <&clock 319>, <&clock 318>;
 		clock-names = "tmu_apbif", "tmu_triminfo_apbif";
 	};
+
+	usbdrd_phy0: phy at 12100000 {
+		compatible = "samsung,exynos5420-usbdrd-phy";
+		reg = <0x12100000 0x100>;
+		clocks = <&clock 366>, <&clock 1>, <&clock 152>;
+		clock-names = "phy", "ref", "usb30_sclk_100m";
+		samsung,syscon-phandle = <&pmu_system_controller>;
+		samsung,pmu-offset = <0x704>;
+		#phy-cells = <1>;
+	};
+
+	usbdrd_phy1: phy at 12500000 {
+		compatible = "samsung,exynos5420-usbdrd-phy";
+		reg = <0x12500000 0x100>;
+		clocks = <&clock 367>, <&clock 1>, <&clock 153>;
+		clock-names = "phy", "ref", "usb30_sclk_100m";
+		samsung,syscon-phandle = <&pmu_system_controller>;
+		samsung,pmu-offset = <0x708>;
+		#phy-cells = <1>;
+	};
 };
-- 
1.7.10.4
