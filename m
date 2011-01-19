From: davidb@codeaurora.org (David Brown)
Date: Wed, 19 Jan 2011 12:25:37 -0800
Subject: [PATCH v2 01/11] msm: Add CPU queries
In-Reply-To: <1295468747-22796-1-git-send-email-davidb@codeaurora.org>
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<1295468747-22796-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1295468747-22796-2-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create runtime queries to distinguish the various MSM targets.
Although these would probably be better named soc_is..., use
cpu_is... to match convention in the rest of the kernel.

Hard code the tests based on config options for now.  When runtime
device detection is implemented, these can be made dynamic.

Signed-off-by: David Brown <davidb@codeaurora.org>
---
 arch/arm/mach-msm/include/mach/cpu.h |   48 ++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-msm/include/mach/cpu.h

diff --git a/arch/arm/mach-msm/include/mach/cpu.h b/arch/arm/mach-msm/include/mach/cpu.h
new file mode 100644
index 0000000..e1ba9db
--- /dev/null
+++ b/arch/arm/mach-msm/include/mach/cpu.h
@@ -0,0 +1,48 @@
+/* Copyright (c) 2011, Code Aurora Forum. All rights reserved.
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
+ */
+
+#ifndef __ARCH_ARM_MACH_MSM_CPU_H__
+#define __ARCH_ARM_MACH_MSM_CPU_H__
+
+/* TODO: For now, only one CPU can be compiled at a time. */
+
+#define cpu_is_msm7x01()	0
+#define cpu_is_msm7x30()	0
+#define cpu_is_qsd8x50()	0
+#define cpu_is_msm8x60()	0
+
+#ifdef CONFIG_ARCH_MSM7X00A
+# undef cpu_is_msm7x01
+# define cpu_is_msm7x01()	1
+#endif
+
+#ifdef CONFIG_ARCH_MSM7X30
+# undef cpu_is_msm7x30
+# define cpu_is_msm7x30()	1
+#endif
+
+#ifdef CONFIG_ARCH_QSD8X50
+# undef cpu_is_qsd8x50
+# define cpu_is_qsd8x50()	1
+#endif
+
+#ifdef CONFIG_ARCH_MSM8X60
+# undef cpu_is_msm8x60
+# define cpu_is_msm8x60()	1
+#endif
+
+#endif
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
