From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 21 Jun 2013 14:50:23 +0200
Subject: [PATCH 7/8] ARM: dts: Add AK8975 device node for Exynos4412 TRATS2
 board
In-Reply-To: <1371819024-12596-1-git-send-email-s.nawrocki@samsung.com>
References: <1371819024-12596-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1371819024-12596-8-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jacek Anaszewski <j.anaszewski@samsung.com>

This patch adds AK8975 magnetometer node and corresponding
i2c-gpio bus node for TRATS2 board.

Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/boot/dts/exynos4412-trats2.dts |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 056b835..826e42e 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -453,4 +453,19 @@
 	serial at 13830000 {
 		status = "okay";
 	};
+
+	i2c-gpio-0 {
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
