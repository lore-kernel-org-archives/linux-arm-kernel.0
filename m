From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 25 Jun 2013 17:38:25 +0200
Subject: [PATCH 3/4] ARM: dts: exynos4: Add nodes for USB PHY block
In-Reply-To: <1372174706-5459-1-git-send-email-t.figa@samsung.com>
References: <1372174706-5459-1-git-send-email-t.figa@samsung.com>
Message-ID: <1372174706-5459-4-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree nodes for USB OTG PHYs of Exynos4210 and
Exynos4x12 SoCs.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4210.dtsi | 15 +++++++++++++++
 arch/arm/boot/dts/exynos4x12.dtsi | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 54710de..3c71ea5 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -114,6 +114,21 @@
 		interrupts = <2 4>;
 	};
 
+	usbphy at 125B0000 {
+		compatible = "samsung,exynos4210-usb2phy";
+		reg = <0x125B0000 0x100>;
+		clocks = <&clock 305>;
+		clock-names = "otg";
+		status = "disabled";
+		ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		usbphy-sys {
+			reg = <0x10020704 0x8>;
+		};
+	};
+
 	g2d at 12800000 {
 		compatible = "samsung,s5pv210-g2d";
 		reg = <0x12800000 0x1000>;
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index e3380a7..267ed95 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -79,4 +79,19 @@
 		interrupts = <0 89 0>;
 		status = "disabled";
 	};
+
+	usbphy at 125B0000 {
+		compatible = "samsung,exynos4x12-usb2phy";
+		reg = <0x125B0000 0x100>;
+		clocks = <&clock 305>;
+		clock-names = "otg";
+		status = "disabled";
+		ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		usbphy-sys {
+			reg = <0x10020704 0x8>;
+		};
+	};
 };
-- 
1.8.2.1
