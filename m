From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Wed,  6 Oct 2010 00:42:48 -0700
Subject: [PATCH 09/20 v2] msm: clock: add dummy clock driver
In-Reply-To: <1286350979-19328-1-git-send-email-johlstei@codeaurora.org>
References: <1286350979-19328-1-git-send-email-johlstei@codeaurora.org>
Message-ID: <1286350979-19328-10-git-send-email-johlstei@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Need to add this until real clock support for 8x60 goes in, or else some
drivers won't compile.

Signed-off-by: Jeff Ohlstein <johlstei@codeaurora.org>
---
 arch/arm/mach-msm/Makefile      |    1 +
 arch/arm/mach-msm/clock-dummy.c |   54 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-msm/clock-dummy.c

diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
index 4995d77..f7df564 100644
--- a/arch/arm/mach-msm/Makefile
+++ b/arch/arm/mach-msm/Makefile
@@ -7,6 +7,7 @@ else
 obj-y += irq.o
 endif
 
+obj-$(CONFIG_ARCH_MSM8X60) += clock-dummy.o
 obj-$(CONFIG_MSM_PROC_COMM) += proc_comm.o clock-pcom.o vreg.o
 obj-$(CONFIG_MSM_PROC_COMM) += clock.o gpio.c
 obj-$(CONFIG_ARCH_QSD8X50) += sirc.o
diff --git a/arch/arm/mach-msm/clock-dummy.c b/arch/arm/mach-msm/clock-dummy.c
new file mode 100644
index 0000000..1250d22
--- /dev/null
+++ b/arch/arm/mach-msm/clock-dummy.c
@@ -0,0 +1,54 @@
+/* Copyright (c) 2010, Code Aurora Forum. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA.
+ *
+ */
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/module.h>
+
+struct clk *clk_get(struct device *dev, const char *id)
+{
+	return ERR_PTR(-ENOENT);
+}
+EXPORT_SYMBOL(clk_get);
+
+int clk_enable(struct clk *clk)
+{
+	return -ENOENT;
+}
+EXPORT_SYMBOL(clk_enable);
+
+void clk_disable(struct clk *clk)
+{
+}
+EXPORT_SYMBOL(clk_disable);
+
+unsigned long clk_get_rate(struct clk *clk)
+{
+	return 0;
+}
+EXPORT_SYMBOL(clk_get_rate);
+
+int clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	return -ENOENT;
+}
+EXPORT_SYMBOL(clk_set_rate);
+
+void clk_put(struct clk *clk)
+{
+}
+EXPORT_SYMBOL(clk_put);
-- 
1.7.2.1

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
