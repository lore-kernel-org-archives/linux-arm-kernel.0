From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Tue, 11 Aug 2015 19:09:06 +0900
Subject: [PATCH v2 3/3] ARM: dts: Fix power off method on exynos5422-odroidxu3
In-Reply-To: <1439287746-14034-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1439287746-14034-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1439287746-14034-4-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Odroid XU3 family boards have ACOKB pin of PMIC grounded, instead of
pulled up as usual. This means that PMIC must manually set PWRHOLD field
in its CTRL1 register to low before initiating power down.

This fixes Odroid XU3 powering off:
[   25.966053] reboot: Power down
[   25.967679] Power down.
[   26.070174] Power down failed, please power off system manually.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Reported-by: Anand Moon <linux.amoon@gmail.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

Changes since v1:
1. Add Javier's reviewed-by.
---
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 1565667e6f69..48cecc8cf26e 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -159,6 +159,7 @@
 		s2mps11,buck2-ramp-enable = <1>;
 		s2mps11,buck3-ramp-enable = <1>;
 		s2mps11,buck4-ramp-enable = <1>;
+		samsung,s2mps11-acokb-ground;
 
 		interrupt-parent = <&gpx0>;
 		interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
-- 
2.1.4
