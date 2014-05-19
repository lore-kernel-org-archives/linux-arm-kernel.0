From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Mon, 19 May 2014 16:49:15 +0530
Subject: [PATCH V3 3/4] ARM: dts: Add usb2phy support on exynos5420
In-Reply-To: <1400498356-26803-1-git-send-email-vikas.sajjan@samsung.com>
References: <1400498356-26803-1-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <1400498356-26803-4-git-send-email-vikas.sajjan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vivek Gautam <gautam.vivek@samsung.com>

Add required device node for usb2phy to let enable USB 2.0
support.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index f9b051b..2eb00cb 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -838,4 +838,14 @@
 		samsung,pmu-syscon = <&pmu_system_controller>;
 		#phy-cells = <1>;
 	};
+
+	usb2_phy: phy at 12130000 {
+		compatible = "samsung,exynos5250-usb2-phy";
+		reg = <0x12130000 0x100>;
+		clocks = <&clock CLK_USBH20>, <&clock CLK_SCLK_USBPHY300>;
+		clock-names = "phy", "ref";
+		#phy-cells = <1>;
+		samsung,sysreg-phandle = <&sysreg_system_controller>;
+		samsung,pmureg-phandle = <&pmu_system_controller>;
+	};
 };
-- 
1.7.9.5
