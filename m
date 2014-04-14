From: chanho61.park@samsung.com (Chanho Park)
Date: Mon, 14 Apr 2014 21:48:18 +0900
Subject: [PATCH 2/4] ARM: dts: exynos4: add exynos_usbphy node
In-Reply-To: <1397479700-15864-1-git-send-email-chanho61.park@samsung.com>
References: <1397479700-15864-1-git-send-email-chanho61.park@samsung.com>
Message-ID: <1397479700-15864-3-git-send-email-chanho61.park@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables a exynos_usbphy node for exynos4 SoCs.
A exynos4x12 usb phy node is almost same with 4210's one
except compatible string and pmu syscon.

Cc: Tomasz Figa <t.figa@samsung.com>
Cc: Kamil Debski <k.debski@samsung.com>
Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi    | 10 ++++++++++
 arch/arm/boot/dts/exynos4x12.dtsi |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index e565b86..0e32d7f 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -278,6 +278,16 @@
 		status = "disabled";
 	};
 
+	exynos_usbphy: exynos-usbphy at 125B0000 {
+		compatible = "samsung,exynos4210-usb2-phy";
+		reg = <0x125B0000 0x100>;
+		samsung,pmureg-phandle = <&pmu_reg>;
+		clocks = <&clock 305>, <&clock 2>;
+		clock-names = "phy", "ref";
+		status = "disabled";
+		#phy-cells = <1>;
+	};
+
 	ehci at 12580000 {
 		compatible = "samsung,exynos4210-ehci";
 		reg = <0x12580000 0x100>;
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index c4a9306..3d77a40 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -243,4 +243,9 @@
 		clock-names = "biu", "ciu";
 		status = "disabled";
 	};
+
+	exynos-usbphy at 125B0000 {
+		compatible = "samsung,exynos4x12-usb2-phy";
+		samsung,sysreg-phandle = <&sys_reg>;
+	};
 };
-- 
1.8.3.2
