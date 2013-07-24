From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 24 Jul 2013 15:17:19 +0200
Subject: [PATCH v4 07/13] ARM: dts: Add AK8975 device node for Exynos4412
 TRATS2 board
In-Reply-To: <1374671845-30373-1-git-send-email-s.nawrocki@samsung.com>
References: <1374671845-30373-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1374671845-30373-8-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jacek Anaszewski <j.anaszewski@samsung.com>

This patch adds AK8975 magnetometer node and corresponding
i2c-gpio bus node for TRATS2 board.

Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
Changes since v3:
 - s/i2c-gpio at 0/i2c-gpio-0, changed compatible string to "ak,ak8975".
---
 arch/arm/boot/dts/exynos4412-trats2.dts |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 056b835..cab4c0e 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -19,6 +19,10 @@
 	model = "Samsung Trats 2 based on Exynos4412";
 	compatible = "samsung,trats2", "samsung,exynos4412";
 
+	aliases {
+		i2c8 = &i2c_ak8975;
+	};
+
 	memory {
 		reg =  <0x40000000 0x40000000>;
 	};
@@ -453,4 +457,19 @@
 	serial at 13830000 {
 		status = "okay";
 	};
+
+	i2c_ak8975: i2c-gpio-0 {
+		compatible = "i2c-gpio";
+		gpios = <&gpy2 4 0>, <&gpy2 5 0>;
+		i2c-gpio,delay-us = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+
+		ak8975 at 0c {
+			compatible = "ak,ak8975";
+			reg = <0x0c>;
+			gpios = <&gpj0 7 0>;
+		};
+	};
 };
-- 
1.7.9.5
