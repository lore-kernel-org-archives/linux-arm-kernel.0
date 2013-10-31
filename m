From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Thu, 31 Oct 2013 13:15:43 +0530
Subject: [PATCH 3/4] dt: exynos5420: Enable support for USB 3.0 PHY controller
In-Reply-To: <1383205544-32244-1-git-send-email-gautam.vivek@samsung.com>
References: <1383205544-32244-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1383205544-32244-4-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree nodes for USB 3.0 PHY present alongwith
USB 3.0 controller Exynos 5420 SoC. This phy driver is
based on generic phy framework.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index d537cd7..5df3308 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -235,4 +235,20 @@
 		io-channel-ranges;
 		status = "disabled";
 	};
+
+	usbphy at 12100000 {
+		compatible = "samsung,exynos5420-usb3phy";
+		reg = <0x12100000 0x100 0x10040704 0x4>;
+		clocks = <&clock 366>, <&clock 1>, <&clock 152>;
+		clock-names = "phy", "usb3drd", "sclk_usbphy30";
+		#phy-cells = <0>;
+	};
+
+	usbphy at 12500000 {
+		compatible = "samsung,exynos5420-usb3phy";
+		reg = <0x12500000 0x100 0x10040708 0x4>;
+		clocks = <&clock 367>, <&clock 1>, <&clock 153>;
+		clock-names = "phy", "usb3drd", "sclk_usbphy30";
+		#phy-cells = <0>;
+	};
 };
-- 
1.7.6.5
