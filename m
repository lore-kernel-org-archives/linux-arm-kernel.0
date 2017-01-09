From: jcsing.lee@samsung.com (Jaechul Lee)
Date: Mon, 09 Jan 2017 16:22:15 +0900
Subject: [PATCH v6 3/3] arm64: dts: exynos: Add tm2 touchkey node
In-Reply-To: <1483946535-4703-1-git-send-email-jcsing.lee@samsung.com>
References: <1483946535-4703-1-git-send-email-jcsing.lee@samsung.com>
 <CGME20170109072219epcas5p2b1dd8d38c4ae6bd5727e68c4ecaf7f24@epcas5p2.samsung.com>
Message-ID: <1483946535-4703-4-git-send-email-jcsing.lee@samsung.com>
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
index 2449266..ddba2f8 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
@@ -18,6 +18,19 @@
 	compatible = "samsung,tm2", "samsung,exynos5433";
 };
 
+&hsi2c_9 {
+	status = "okay";
+
+	touchkey at 20 {
+		compatible = "cypress,tm2-touchkey";
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
2.7.4
