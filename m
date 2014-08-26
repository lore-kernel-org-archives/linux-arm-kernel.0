From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 26 Aug 2014 16:10:26 +0200
Subject: [PATCH v3 3/5] ARM: dts: exynos4412-trats2: Keep eMMC regulators
 soft-disabled
In-Reply-To: <1409062228-14690-1-git-send-email-t.figa@samsung.com>
References: <1409062228-14690-1-git-send-email-t.figa@samsung.com>
Message-ID: <1409062228-14690-4-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In MAX77686 PMIC two regulators dedicated for eMMC memory can be
controlled both by I2C interface and a GPIO pin, with the resulting
regulator state being a logical OR of both. Since the GPIO control is
used both by the kernel and the lowest level bootloader at reset, the
regulator should be disabled by I2C control to allow it to be turned off
by GPIO control.

This patch removes regulator-always-on properties from both regulators
and, while at it, also unsupported regulator-mem-off.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/boot/dts/exynos4412-trats2.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 5e066cd..a75034c 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -399,8 +399,6 @@
 					regulator-name = "VMEM_VDD_2.8V";
 					regulator-min-microvolt = <2800000>;
 					regulator-max-microvolt = <2800000>;
-					regulator-always-on;
-					regulator-mem-off;
 				};
 
 				ldo23_reg: ldo23 {
@@ -503,8 +501,6 @@
 					regulator-name = "VMEM_VDDF_3.0V";
 					regulator-min-microvolt = <2850000>;
 					regulator-max-microvolt = <2850000>;
-					regulator-always-on;
-					regulator-mem-off;
 				};
 
 				buck9_reg: buck9 {
-- 
2.0.4
