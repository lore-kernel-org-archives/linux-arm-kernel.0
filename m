From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Thu, 12 Feb 2015 01:55:12 +0100
Subject: [PATCH 4/5] ARM: dts: zynq: Split off Parallella Microserver device
 tree
In-Reply-To: <1423702513-4032-1-git-send-email-afaerber@suse.de>
References: <1423702513-4032-1-git-send-email-afaerber@suse.de>
Message-ID: <1423702513-4032-5-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Microserver edition has neither HDMI nor USB.

Cc: Ola Jeppsson <ola@adapteva.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/Makefile                        |  1 +
 arch/arm/boot/dts/zynq-parallella-microserver.dts | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 arch/arm/boot/dts/zynq-parallella-microserver.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a1c776b8dcec..42c75eeba584 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -606,6 +606,7 @@ dtb-$(CONFIG_ARCH_VT8500) += \
 	wm8850-w70v2.dtb
 dtb-$(CONFIG_ARCH_ZYNQ) += \
 	zynq-parallella.dtb \
+	zynq-parallella-microserver.dtb \
 	zynq-zc702.dtb \
 	zynq-zc706.dtb \
 	zynq-zed.dtb \
diff --git a/arch/arm/boot/dts/zynq-parallella-microserver.dts b/arch/arm/boot/dts/zynq-parallella-microserver.dts
new file mode 100644
index 000000000000..1f3bd2d27a93
--- /dev/null
+++ b/arch/arm/boot/dts/zynq-parallella-microserver.dts
@@ -0,0 +1,19 @@
+/*
+ * Copyright (c) 2014 SUSE LINUX Products GmbH
+ * Copyright (c) 2015 SUSE Linux GmbH
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+/dts-v1/;
+#include "zynq-parallella1.dtsi"
+
+/ {
+	model = "Adapteva Parallella Microserver Board";
+};
-- 
2.2.2
