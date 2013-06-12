From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 12 Jun 2013 09:41:07 -0700
Subject: [PATCH v2 2/3] arm: dt: zynq: Add support for the zc706 platform
In-Reply-To: <1371055268-32337-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1371055268-32337-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1371055268-32337-3-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a DT fragment for the zc706 Zynq platform and a corresponding
target to the Makefile.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 arch/arm/boot/dts/Makefile       |  3 ++-
 arch/arm/boot/dts/zynq-zc706.dts | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/zynq-zc706.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b9f7121..2aecf7e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -206,7 +206,8 @@ dtb-$(CONFIG_ARCH_VT8500) += vt8500-bv07.dtb \
 	wm8505-ref.dtb \
 	wm8650-mid.dtb \
 	wm8850-w70v2.dtb
-dtb-$(CONFIG_ARCH_ZYNQ) += zynq-zc702.dtb
+dtb-$(CONFIG_ARCH_ZYNQ) += zynq-zc702.dtb \
+	zynq-zc706.dtb
 
 targets += dtbs
 targets += $(dtb-y)
diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
new file mode 100644
index 0000000..16f9f91
--- /dev/null
+++ b/arch/arm/boot/dts/zynq-zc706.dts
@@ -0,0 +1,31 @@
+/*
+ *  Copyright (C) 2011 Xilinx
+ *  Copyright (C) 2012 National Instruments Corp.
+ *  Copyright (C) 2013 Xilinx
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
+/include/ "zynq-7000.dtsi"
+
+/ {
+	model = "Zynq ZC706 Development Board";
+	compatible = "xlnx,zynq-zc706", "xlnx,zynq-7000";
+
+	memory {
+		device_type = "memory";
+		reg = <0 0x40000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyPS1,115200 earlyprintk";
+	};
+
+};
-- 
1.8.3
