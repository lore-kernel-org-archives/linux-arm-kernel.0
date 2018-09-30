From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Sun, 30 Sep 2018 08:56:24 +0800
Subject: [PATCH V3 09/11] clk: imx: add common imx_clk_hw_fixed functions
In-Reply-To: <1538268986-24890-1-git-send-email-aisheng.dong@nxp.com>
References: <1538268986-24890-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1538268986-24890-10-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This may be used by both mmio and scu clks. So let's put it
into a common file.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/imx/clk-common.h  | 16 ++++++++++++++++
 drivers/clk/imx/scu/clk-scu.h |  2 ++
 2 files changed, 18 insertions(+)
 create mode 100644 drivers/clk/imx/clk-common.h

diff --git a/drivers/clk/imx/clk-common.h b/drivers/clk/imx/clk-common.h
new file mode 100644
index 0000000..e3634a5
--- /dev/null
+++ b/drivers/clk/imx/clk-common.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2018 NXP
+ */
+
+#ifndef __IMX_CLK_COMMON_H
+#define __IMX_CLK_COMMON_H
+
+#include <linux/clk-provider.h>
+
+static inline struct clk_hw *imx_clk_hw_fixed(const char *name, int rate)
+{
+	return clk_hw_register_fixed_rate(NULL, name, NULL, 0, rate);
+}
+
+#endif /* __IMX_CLK_COMMON_H */
diff --git a/drivers/clk/imx/scu/clk-scu.h b/drivers/clk/imx/scu/clk-scu.h
index fd36a98..27b19a6 100644
--- a/drivers/clk/imx/scu/clk-scu.h
+++ b/drivers/clk/imx/scu/clk-scu.h
@@ -11,6 +11,8 @@
 #include <linux/spinlock.h>
 #include <soc/imx/scu/sci.h>
 
+#include "../clk-common.h"
+
 extern spinlock_t imx_ccm_lock;
 extern struct imx_sc_ipc *ccm_ipc_handle;
 
-- 
2.7.4
