From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Thu, 5 Dec 2013 16:14:06 +0530
Subject: [PATCH V3 1/4] ARM: tegra: Add header file for pinctrl constants
In-Reply-To: <1386240249-30786-1-git-send-email-ldewangan@nvidia.com>
References: <1386240249-30786-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1386240249-30786-2-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This new header file defines pincontrol constants for Tegra to
use from Tegra's DTS file for pincontrol properties option.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Reviewed-by: Thierry Reding <treding@nvidia.com>
---
Changes from V1:
- Get rid of lots of macro and converge it to TEGRA_PIN_ENABLE/DISABLE.
- Change macro name for PULL UP/DOWN/NONE.

Changes from V2:
- Convert TEGRA -> Tegra.
- Add comment on ENABLE/DSIABLE and remove from pulls.

 include/dt-bindings/pinctrl/pinctrl-tegra.h |   45 +++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/pinctrl-tegra.h

diff --git a/include/dt-bindings/pinctrl/pinctrl-tegra.h b/include/dt-bindings/pinctrl/pinctrl-tegra.h
new file mode 100644
index 0000000..ebafa49
--- /dev/null
+++ b/include/dt-bindings/pinctrl/pinctrl-tegra.h
@@ -0,0 +1,45 @@
+/*
+ * This header provides constants for Tegra pinctrl bindings.
+ *
+ * Copyright (c) 2013, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * Author: Laxman Dewangan <ldewangan@nvidia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#ifndef _DT_BINDINGS_PINCTRL_TEGRA_H
+#define _DT_BINDINGS_PINCTRL_TEGRA_H
+
+/*
+ * Enable/disable for diffeent dt properties. This is applicable for
+ * properties nvidia,enable-input, nvidia,tristate, nvidia,open-drain,
+ * nvidia,lock, nvidia,rcv-sel, nvidia,high-speed-mode, nvidia,schmitt.
+ */
+#define TEGRA_PIN_DISABLE				0
+#define TEGRA_PIN_ENABLE				1
+
+#define TEGRA_PIN_PULL_NONE				0
+#define TEGRA_PIN_PULL_DOWN				1
+#define TEGRA_PIN_PULL_UP				2
+
+/* Low power mode driver */
+#define TEGRA_PIN_LP_DRIVE_DIV_8			0
+#define TEGRA_PIN_LP_DRIVE_DIV_4			1
+#define TEGRA_PIN_LP_DRIVE_DIV_2			2
+#define TEGRA_PIN_LP_DRIVE_DIV_1			3
+
+/* Rising/Falling slew rate */
+#define TEGRA_PIN_SLEW_RATE_FASTEST			0
+#define TEGRA_PIN_SLEW_RATE_FAST			1
+#define TEGRA_PIN_SLEW_RATE_SLOW			2
+#define TEGRA_PIN_SLEW_RATE_SLOWEST			3
+
+#endif
-- 
1.7.1.1
