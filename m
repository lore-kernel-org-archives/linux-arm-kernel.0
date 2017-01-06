From: andi.shyti@samsung.com (Andi Shyti)
Date: Fri, 06 Jan 2017 22:43:50 +0900
Subject: [PATCH v5 5/5] arm64: dts: exynos: Add tm2 touchkey node
In-Reply-To: <20170106134350.32428-1-andi.shyti@samsung.com>
References: <20170106134350.32428-1-andi.shyti@samsung.com>
 <CGME20170106134356epcas1p1aee9f715c58b50f6056bf0b43b849497@epcas1p1.samsung.com>
Message-ID: <20170106134350.32428-6-andi.shyti@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jaechul Lee <jcsing.lee@samsung.com>

Add DT node support for TM2 touchkey device.

Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
Signed-off-by: Jaechul Lee <jcsing.lee@samsung.com>
Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
index 2449266b268f..92fcc4ec8319 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
@@ -18,6 +18,19 @@
 	compatible = "samsung,tm2", "samsung,exynos5433";
 };
 
+&hsi2c_9 {
+	status = "okay";
+
+	touchkey at 20 {
+		compatible = "samsung,tm2-touchkey";
+		reg = <0x20>;
+		interrupt-parent = <&gpa3>;
+		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+		vcc-supply = <&ldo32_reg>;
+		vdd-supply = <&ldo33_reg>;
+	};
+};
+
 &ldo31_reg {
 	regulator-name = "TSP_VDD_1.85V_AP";
 	regulator-min-microvolt = <1850000>;
-- 
2.11.0
