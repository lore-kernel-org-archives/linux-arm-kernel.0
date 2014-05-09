From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Fri,  9 May 2014 18:53:03 +0530
Subject: [PATCH v2 3/4] ARM: dts: Add usb2phy support on exynos5420
In-Reply-To: <1399641784-10833-1-git-send-email-gautam.vivek@samsung.com>
References: <1399641784-10833-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1399641784-10833-4-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add required device node for usb2phy to let enable USB 2.0
support.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---

Changes from v1:
 - Added node references for the phy node.

 arch/arm/boot/dts/exynos5420.dtsi |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 5d5d6e3..ddd09a3 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -744,4 +744,14 @@
 		clock-names = "secss";
 		samsung,power-domain = <&g2d_pd>;
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
1.7.10.4
