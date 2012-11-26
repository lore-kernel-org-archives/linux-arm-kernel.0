From: chlrbgh0@gmail.com (chlrbgh0 at gmail.com)
Date: Mon, 26 Nov 2012 20:32:18 +0900
Subject: [PATCH] ARM: dts: add initial dts file for ORIGEN4QUAD
Message-ID: <1353929538-24173-1-git-send-email-kh.choi@insignal.co.kr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyuho Choi <kh.choi@insignal.co.kr>

This patch adds initial dts file for ORIGEN4QUAD board.
ORIGEN4QUAD board based on Samsung EXYNOS4412 SoC.
More properties will be added later.

Signed-off-by: Kyuho Choi <kh.choi@insignal.co.kr>
---
 arch/arm/boot/dts/exynos4412-origen4quad.dts |   45 ++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos4412-origen4quad.dts

diff --git a/arch/arm/boot/dts/exynos4412-origen4quad.dts b/arch/arm/boot/dts/exynos4412-origen4quad.dts
new file mode 100644
index 0000000..390a2ab
--- /dev/null
+++ b/arch/arm/boot/dts/exynos4412-origen4quad.dts
@@ -0,0 +1,45 @@
+/*
+ * Samsung's Exynos4412 based Origen4Quad board device tree source
+ *
+ * Copyright (c) 2012-2013 Isnignal Co., Ltd.
+ *		http://www.insignal.co.kr
+ *
+ * Device tree source file for Insignal's Origen4Quad board which is based on
+ * Samsung's Exynos4412 SoC.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/dts-v1/;
+/include/ "exynos4412.dtsi"
+
+/ {
+	model = "Insignal Origen4Quad board based on Exynos4412";
+	compatible = "insignal,origen4quad", "samsung,exynos4412";
+
+	memory {
+		reg = <0x40000000 0x40000000>;
+	};
+
+	chosen {
+		bootargs ="root=/dev/ram0 rw ramdisk=32768 initrd=0x41000000,32M console=ttySAC2,115200 init=/linuxrc";
+	};
+
+	serial at 13800000 {
+		status = "okay";
+	};
+
+	serial at 13810000 {
+		status = "okay";
+	};
+
+	serial at 13820000 {
+		status = "okay";
+	};
+
+	serial at 13830000 {
+		status = "okay";
+	};
+};
-- 
1.7.5.4
