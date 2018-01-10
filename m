From: stefan@agner.ch (Stefan Agner)
Date: Wed, 10 Jan 2018 22:04:49 +0100
Subject: [PATCH v2 3/7] ARM: dts: imx6ull: add additional pinfunc defines for
 i.MX 6ULL
In-Reply-To: <20180110210453.19264-1-stefan@agner.ch>
References: <20180110210453.19264-1-stefan@agner.ch>
Message-ID: <20180110210453.19264-3-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bai Ping <ping.bai@nxp.com>

On i.MX 6ULL, the pin MUX and CTRL register of BOOT_MODEx and TAMPERx
pins are available through IOMUXC_SNVS. Add additional pinfunc defines.

Signed-off-by: Bai Ping <ping.bai@nxp.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 arch/arm/boot/dts/imx6ull-pinfunc-snvs.h | 27 +++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6ull.dtsi           |  1 +
 2 files changed, 28 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ull-pinfunc-snvs.h

diff --git a/arch/arm/boot/dts/imx6ull-pinfunc-snvs.h b/arch/arm/boot/dts/imx6ull-pinfunc-snvs.h
new file mode 100644
index 000000000000..fa900c15405d
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-pinfunc-snvs.h
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright (C) 2017 NXP
+ */
+
+#ifndef __DTS_IMX6ULL_PINFUNC_SNVS_H
+#define __DTS_IMX6ULL_PINFUNC_SNVS_H
+/*
+ * The pin function ID is a tuple of
+ * <mux_reg conf_reg input_reg mux_mode input_val>
+ */
+#define MX6ULL_PAD_BOOT_MODE0__GPIO5_IO10                          0x0000 0x0044 0x0000 0x5 0x0
+#define MX6ULL_PAD_BOOT_MODE1__GPIO5_IO11                          0x0004 0x0048 0x0000 0x5 0x0
+#define MX6ULL_PAD_SNVS_TAMPER0__GPIO5_IO00                        0x0008 0x004C 0x0000 0x5 0x0
+#define MX6ULL_PAD_SNVS_TAMPER1__GPIO5_IO01                        0x000C 0x0050 0x0000 0x5 0x0
+#define MX6ULL_PAD_SNVS_TAMPER2__GPIO5_IO02                        0x0010 0x0054 0x0000 0x5 0x0
+#define MX6ULL_PAD_SNVS_TAMPER3__GPIO5_IO03                        0x0014 0x0058 0x0000 0x5 0x0
+#define MX6ULL_PAD_SNVS_TAMPER4__GPIO5_IO04                        0x0018 0x005C 0x0000 0x5 0x0
+#define MX6ULL_PAD_SNVS_TAMPER5__GPIO5_IO05                        0x001C 0x0060 0x0000 0x5 0x0
+#define MX6ULL_PAD_SNVS_TAMPER6__GPIO5_IO06                        0x0020 0x0064 0x0000 0x5 0x0
+#define MX6ULL_PAD_SNVS_TAMPER7__GPIO5_IO07                        0x0024 0x0068 0x0000 0x5 0x0
+#define MX6ULL_PAD_SNVS_TAMPER8__GPIO5_IO08                        0x0028 0x006C 0x0000 0x5 0x0
+#define MX6ULL_PAD_SNVS_TAMPER9__GPIO5_IO09                        0x002C 0x0070 0x0000 0x5 0x0
+
+#endif /* __DTS_IMX6ULL_PINFUNC_SNVS_H */
+
diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dtsi
index 0c182917b863..a58c01dc15c3 100644
--- a/arch/arm/boot/dts/imx6ull.dtsi
+++ b/arch/arm/boot/dts/imx6ull.dtsi
@@ -41,3 +41,4 @@
 
 #include "imx6ul.dtsi"
 #include "imx6ull-pinfunc.h"
+#include "imx6ull-pinfunc-snvs.h"
-- 
2.15.1
