From: l.majewski@samsung.com (Lukasz Majewski)
Date: Thu, 09 Oct 2014 18:38:45 +0200
Subject: [PATCH 09/21] thermal: dts: Provide bindings and enable TMU at
 Exynos4x12 devices
In-Reply-To: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
Message-ID: <1412872737-624-10-git-send-email-l.majewski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds necessary bindings for enabling TMU IP block on the
Exynos4412 Odroid U3 device.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |  5 +++++
 arch/arm/boot/dts/exynos4x12.dtsi               | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 5364f1a..5d4ecc3 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -374,6 +374,11 @@
 	ehci: ehci at 12580000 {
 		status = "okay";
 	};
+
+	tmu at 100C0000 {
+		vtmu-supply = <&ldo10_reg>;
+		status = "okay";
+	};
 };
 
 &pinctrl_1 {
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 861bb91..c12890c 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -271,4 +271,14 @@
 		compatible = "samsung,exynos4x12-usb2-phy";
 		samsung,sysreg-phandle = <&sys_reg>;
 	};
+
+	tmu at 100C0000 {
+		compatible = "samsung,exynos4412-tmu";
+		interrupt-parent = <&combiner>;
+		reg = <0x100C0000 0x100>;
+		interrupts = <2 4>;
+		clocks = <&clock 383>;
+		clock-names = "tmu_apbif";
+		status = "disabled";
+	};
 };
-- 
2.0.0.rc2
