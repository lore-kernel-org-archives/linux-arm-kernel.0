From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 24 Jun 2013 20:05:50 +0200
Subject: [PATCH v2 7/8] ARM: dts: Add AK8975 device node for Exynos4412 TRATS2
 board
In-Reply-To: <1372097151-18122-1-git-send-email-s.nawrocki@samsung.com>
References: <1372097151-18122-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1372097151-18122-8-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jacek Anaszewski <j.anaszewski@samsung.com>

This patch adds AK8975 magnetometer node and corresponding
i2c-gpio bus node for TRATS2 board.

Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v1:
 - added node alias for i2c-gpio at 0 I2C controller node.
---
 arch/arm/boot/dts/exynos4412-trats2.dts |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 056b835..b9de3b5 100644
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
+	i2c_ak8975: i2c-gpio at 0 {
+		compatible = "i2c-gpio";
+		gpios = <&gpy2 4 0>, <&gpy2 5 0>;
+		i2c-gpio,delay-us = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+
+		ak8975 at 0c {
+			compatible = "asahi-kasei,ak8975";
+			reg = <0x0c>;
+			gpios = <&gpj0 7 0>;
+		};
+	};
 };
--
1.7.9.5
