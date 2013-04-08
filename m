From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 08 Apr 2013 16:23:53 +0900
Subject: [PATCH] ARM: dts: add device tree file for SD5v1 board
Message-ID: <2c9301ce342a$06432ea0$12c98be0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch adds SD5v1.dts file for supporting SD5v1(Exynos5440) board.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/boot/dts/Makefile             |    1 +
 arch/arm/boot/dts/exynos5440-sd5v1.dts |   39 ++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos5440-sd5v1.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d3cd880..11fef62 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -46,6 +46,7 @@ dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
 	exynos4412-smdk4412.dtb \
 	exynos4412-origen.dtb \
 	exynos5250-arndale.dtb \
+	exynos5440-sd5v1.dtb \
 	exynos5250-smdk5250.dtb \
 	exynos5250-snow.dtb \
 	exynos5440-ssdk5440.dtb
diff --git a/arch/arm/boot/dts/exynos5440-sd5v1.dts b/arch/arm/boot/dts/exynos5440-sd5v1.dts
new file mode 100644
index 0000000..ef747b5
--- /dev/null
+++ b/arch/arm/boot/dts/exynos5440-sd5v1.dts
@@ -0,0 +1,39 @@
+/*
+ * SAMSUNG SD5v1 board device tree source
+ *
+ * Copyright (c) 2013 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/dts-v1/;
+/include/ "exynos5440.dtsi"
+
+/ {
+	model = "SAMSUNG SD5v1 board based on EXYNOS5440";
+	compatible = "samsung,sd5v1", "samsung,exynos5440";
+
+	chosen {
+		bootargs = "root=/dev/sda2 rw rootwait ignore_loglevel early_printk no_console_suspend mem=2048M at 0x80000000
console=ttySAC0,115200";
+	};
+
+	fixed-rate-clocks {
+		xtal {
+			compatible = "samsung,clock-xtal";
+			clock-frequency = <50000000>;
+		};
+	};
+
+	gmac: ethernet at 00230000 {
+		fixed_phy;
+		phy_addr = <1>;
+	};
+
+	spi {
+		status = "disabled";
+	};
+
+};
-- 
1.7.10.4
