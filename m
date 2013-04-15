From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 15 Apr 2013 16:42:00 +0200
Subject: [PATCH v2 1/3] ARM: dts: exynos4: Add node for PWM device
In-Reply-To: <1366036922-4103-1-git-send-email-t.figa@samsung.com>
References: <1366036922-4103-1-git-send-email-t.figa@samsung.com>
Message-ID: <1366036922-4103-2-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree node for PWM block present on Exynos 4 SoCs.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index d73eaa1..d7058c1 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -333,6 +333,14 @@
 		status = "disabled";
 	};
 
+	pwm at 139D0000 {
+		compatible = "samsung,exynos4210-pwm";
+		reg = <0x139D0000 0x1000>;
+		interrupts = <0 37 0>, <0 38 0>, <0 39 0>, <0 40 0>, <0 41 0>;
+		#pwm-cells = <2>;
+		status = "disabled";
+	};
+
 	amba {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.8.1.5
