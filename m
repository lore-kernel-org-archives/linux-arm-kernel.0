From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 26 Jan 2012 18:22:01 +0200
Subject: [PATCH v1 1/3] ARM: tegra: definitions for flow controller
In-Reply-To: <1327594923-21822-1-git-send-email-pdeschrijver@nvidia.com>
References: <1327594923-21822-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1327594923-21822-2-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce some definitions for the tegra flow contoller. This will be
used by the code which controls entering and leaving LP3.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/mach-tegra/flowctrl.h |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-tegra/flowctrl.h

diff --git a/arch/arm/mach-tegra/flowctrl.h b/arch/arm/mach-tegra/flowctrl.h
new file mode 100644
index 0000000..74c6efb
--- /dev/null
+++ b/arch/arm/mach-tegra/flowctrl.h
@@ -0,0 +1,37 @@
+/*
+ * arch/arm/mach-tegra/flowctrl.h
+ *
+ * functions and macros to control the flowcontroller
+ *
+ * Copyright (c) 2010-2012, NVIDIA Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __MACH_TEGRA_FLOWCTRL_H
+#define __MACH_TEGRA_FLOWCTRL_H
+
+#define FLOW_CTRL_HALT_CPU0_EVENTS	0x0
+#define FLOW_CTRL_WAITEVENT		(2 << 29)
+#define FLOW_CTRL_WAIT_FOR_INTERRUPT	(4 << 29)
+#define FLOW_CTRL_JTAG_RESUME		(1 << 28)
+#define FLOW_CTRL_HALT_CPU_IRQ		(1 << 10)
+#define	FLOW_CTRL_HALT_CPU_FIQ		(1 << 8)
+#define FLOW_CTRL_CPU0_CSR		0x8
+#define	FLOW_CTRL_CSR_INTR_FLAG		(1 << 15)
+#define FLOW_CTRL_CSR_EVENT_FLAG	(1 << 14)
+#define FLOW_CTRL_CSR_ENABLE		(1 << 0)
+#define FLOW_CTRL_HALT_CPU1_EVENTS	0x14
+#define FLOW_CTRL_CPU1_CSR		0x18
+
+#endif
-- 
1.7.7.rc0.72.g4b5ea.dirty
