From: jcsing.lee@samsung.com (Jaechul Lee)
Date: Fri, 06 Jan 2017 12:59:09 +0900
Subject: [PATCH v3 5/5] arm64: dts: exynos: Add tm2 touchkey node
In-Reply-To: <1483675149-32598-1-git-send-email-jcsing.lee@samsung.com>
References: <1483675149-32598-1-git-send-email-jcsing.lee@samsung.com>
 <CGME20170106035914epcas5p2bd9b2358c41d32f7a677d75afba95144@epcas5p2.samsung.com>
Message-ID: <1483675149-32598-6-git-send-email-jcsing.lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT node support for TM2 touchkey device.

Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
Signed-off-by: Jaechul Lee <jcsing.lee@samsung.com>
Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
index d30b45a..15bdc2e 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
@@ -18,6 +18,19 @@
 	compatible = "samsung,tm2e", "samsung,exynos5433";
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
 &regulators {
 	ldo31_reg: LDO31 {
 		regulator-name = "TSP_VDD_1.85V_AP";
-- 
2.7.4
