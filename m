From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 02 Mar 2011 18:34:47 +0100
Subject: [PATCH 1/3] ARM: S5P: Rename MIPI-CSIS header and update Copyright
In-Reply-To: <1299087289-29926-1-git-send-email-s.nawrocki@samsung.com>
References: <1299087289-29926-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1299087289-29926-2-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-s5p/dev-csis0.c              |    2 +-
 arch/arm/plat-s5p/dev-csis1.c              |    2 +-
 arch/arm/plat-s5p/include/plat/csis.h      |   28 ----------------------------
 arch/arm/plat-s5p/include/plat/mipi_csis.h |   28 ++++++++++++++++++++++++++++
 4 files changed, 30 insertions(+), 30 deletions(-)
 delete mode 100644 arch/arm/plat-s5p/include/plat/csis.h
 create mode 100644 arch/arm/plat-s5p/include/plat/mipi_csis.h

diff --git a/arch/arm/plat-s5p/dev-csis0.c b/arch/arm/plat-s5p/dev-csis0.c
index dfab1c8..882843b 100644
--- a/arch/arm/plat-s5p/dev-csis0.c
+++ b/arch/arm/plat-s5p/dev-csis0.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2010 Samsung Electronics
+ * Copyright (C) 2010-2011 Samsung Electronics Co., Ltd
  *
  * S5P series device definition for MIPI-CSIS channel 0
  *
diff --git a/arch/arm/plat-s5p/dev-csis1.c b/arch/arm/plat-s5p/dev-csis1.c
index e3053f2..77f5d25 100644
--- a/arch/arm/plat-s5p/dev-csis1.c
+++ b/arch/arm/plat-s5p/dev-csis1.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2010 Samsung Electronics
+ * Copyright (C) 2010-2011 Samsung Electronics Co., Ltd
  *
  * S5P series device definition for MIPI-CSIS channel 1
  *
diff --git a/arch/arm/plat-s5p/include/plat/csis.h b/arch/arm/plat-s5p/include/plat/csis.h
deleted file mode 100644
index 51e308c..0000000
--- a/arch/arm/plat-s5p/include/plat/csis.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * Copyright (C) 2010 Samsung Electronics
- *
- * S5P series MIPI CSI slave device support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef PLAT_S5P_CSIS_H_
-#define PLAT_S5P_CSIS_H_ __FILE__
-
-/**
- * struct s5p_platform_mipi_csis - platform data for MIPI-CSIS
- * @clk_rate: bus clock frequency
- * @lanes: number of data lanes used
- * @alignment: data alignment in bits
- * @hs_settle: HS-RX settle time
- */
-struct s5p_platform_mipi_csis {
-	unsigned long clk_rate;
-	u8 lanes;
-	u8 alignment;
-	u8 hs_settle;
-};
-
-#endif /* PLAT_S5P_CSIS_H_ */
diff --git a/arch/arm/plat-s5p/include/plat/mipi_csis.h b/arch/arm/plat-s5p/include/plat/mipi_csis.h
new file mode 100644
index 0000000..eb3beab
--- /dev/null
+++ b/arch/arm/plat-s5p/include/plat/mipi_csis.h
@@ -0,0 +1,28 @@
+/*
+ * Copyright (C) 2010-2011 Samsung Electronics, Co. Ltd
+ *
+ * S5P series MIPI CSI slave device support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef PLAT_S5P_MIPI_CSIS_H_
+#define PLAT_S5P_MIPI_CSIS_H_ __FILE__
+
+/**
+ * struct s5p_platform_mipi_csis - platform data for S5P MIPI-CSIS driver
+ * @clk_rate: bus clock frequency
+ * @lanes: number of data lanes used
+ * @alignment: data alignment in bits
+ * @hs_settle: HS-RX settle time
+ */
+struct s5p_platform_mipi_csis {
+	unsigned long clk_rate;
+	u8 lanes;
+	u8 alignment;
+	u8 hs_settle;
+};
+
+#endif /* PLAT_S5P_MIPI_CSIS_H_ */
-- 
1.7.4.1
