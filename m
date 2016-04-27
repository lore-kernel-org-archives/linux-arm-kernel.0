From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Wed, 27 Apr 2016 09:11:47 -0500
Subject: [PATCH 4/5] ARM: dts: keystone: Header file for pinctrl constants
In-Reply-To: <1461766308-27669-1-git-send-email-fcooper@ti.com>
References: <1461766308-27669-1-git-send-email-fcooper@ti.com>
Message-ID: <1461766308-27669-5-git-send-email-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lokesh Vutla <lokeshvutla@ti.com>

The pinctrl IP used in some of the Keystone 2 devices differ vs other
TI SoCs. Therefore, create a Keystone specific pinctrl header.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/keystone-k2g.dtsi    |  1 +
 include/dt-bindings/pinctrl/keystone.h | 39 ++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 include/dt-bindings/pinctrl/keystone.h

diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index b99e879..3372615 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -14,6 +14,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/pinctrl/keystone.h>
 #include "skeleton.dtsi"
 
 / {
diff --git a/include/dt-bindings/pinctrl/keystone.h b/include/dt-bindings/pinctrl/keystone.h
new file mode 100644
index 0000000..7f97d77
--- /dev/null
+++ b/include/dt-bindings/pinctrl/keystone.h
@@ -0,0 +1,39 @@
+/*
+ * This header provides constants for Keystone pinctrl bindings.
+ *
+ * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _DT_BINDINGS_PINCTRL_KEYSTONE_H
+#define _DT_BINDINGS_PINCTRL_KEYSTONE_H
+
+#define MUX_MODE0	0
+#define MUX_MODE1	1
+#define MUX_MODE2	2
+#define MUX_MODE3	3
+#define MUX_MODE4	4
+#define MUX_MODE5	5
+
+#define BUFFER_CLASS_B	(0 << 19)
+#define BUFFER_CLASS_C	(1 << 19)
+#define BUFFER_CLASS_D	(2 << 19)
+#define BUFFER_CLASS_E	(3 << 19)
+
+#define PULL_DISABLE	(1 << 16)
+#define PIN_PULLUP	(1 << 17)
+#define PIN_PULLDOWN	(0 << 17)
+
+#define KEYSTONE_IOPAD_OFFSET(pa, offset) (((pa) & 0xffff) - (offset))
+
+#define K2G_CORE_IOPAD(pa) KEYSTONE_IOPAD_OFFSET((pa), 0x1000)
+
+#endif
-- 
2.7.0
