From: jcsing.lee@samsung.com (Jaechul Lee)
Date: Tue, 03 Jan 2017 16:57:17 +0900
Subject: [PATCH 4/4] arm64: dts: exynos: Add tm2 touchkey node
In-Reply-To: <1483430237-26823-1-git-send-email-jcsing.lee@samsung.com>
References: <1483430237-26823-1-git-send-email-jcsing.lee@samsung.com>
 <CGME20170103075734epcas5p439b05860a3238ce638f683d9687786a3@epcas5p4.samsung.com>
Message-ID: <1483430237-26823-5-git-send-email-jcsing.lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT node support for TM2 touchkey device.

Signed-off-by: Jaechul Lee <jcsing.lee@samsung.com>
Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
index 887a1f1..ef7d21c 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
@@ -18,3 +18,15 @@
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
-- 
2.7.4
