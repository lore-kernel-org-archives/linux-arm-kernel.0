From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Wed, 14 May 2014 19:31:05 +0530
Subject: [PATCH v6 3/8] ARM: dts: exynos5250: Enable support for generic USB
 DRD phy
In-Reply-To: <1400076070-12456-1-git-send-email-gautam.vivek@samsung.com>
References: <1400076070-12456-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1400076070-12456-4-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree node for new usbdrd-phy driver, which
is based on generic phy framework.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 2fa6345..8303a42 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -574,6 +574,15 @@
 		};
 	};
 
+	usbdrd_phy: phy at 12100000 {
+		compatible = "samsung,exynos5250-usbdrd-phy";
+		reg = <0x12100000 0x100>;
+		clocks = <&clock CLK_USB3>, <&clock CLK_FIN_PLL>;
+		clock-names = "phy", "ref";
+		samsung,pmu-syscon = <&pmu_system_controller>;
+		#phy-cells = <1>;
+	};
+
 	usb at 12110000 {
 		compatible = "samsung,exynos4210-ehci";
 		reg = <0x12110000 0x100>;
-- 
1.7.10.4
