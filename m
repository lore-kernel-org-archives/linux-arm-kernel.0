From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 31 Aug 2018 16:28:26 +0300
Subject: [PATCHv2 1/2] ARM: dts: ti: add support for building Texas
 Instruments specific overlays
In-Reply-To: <1535722107-13767-1-git-send-email-t-kristo@ti.com>
References: <1535722107-13767-1-git-send-email-t-kristo@ti.com>
Message-ID: <1535722107-13767-2-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for TI specific DT subdir, along with support for building
DT overlays. Right now, no DT files are specified in this directory,
those are to be added later.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/Makefile    | 1 +
 arch/arm/boot/dts/ti/Makefile | 9 +++++++++
 2 files changed, 10 insertions(+)
 create mode 100644 arch/arm/boot/dts/ti/Makefile

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b5bd3de..59a4b63 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -755,6 +755,7 @@ dtb-$(CONFIG_SOC_DRA7XX) += \
 	dra72-evm-revc.dtb \
 	dra71-evm.dtb \
 	dra76-evm.dtb
+subdir-$(CONFIG_SOC_DRA7XX) += ti
 dtb-$(CONFIG_ARCH_ORION5X) += \
 	orion5x-kuroboxpro.dtb \
 	orion5x-lacie-d2-network.dtb \
diff --git a/arch/arm/boot/dts/ti/Makefile b/arch/arm/boot/dts/ti/Makefile
new file mode 100644
index 0000000..e0203ba
--- /dev/null
+++ b/arch/arm/boot/dts/ti/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Make file to build device tree binaries for boards based on
+# Texas Instruments Inc processors
+#
+# Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
+#
+
+DTC_FLAGS += -@
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
