From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Fri, 31 May 2013 14:42:21 +0200
Subject: [PATCH 3/4] ARM: dts: AM33XX: Specific pinctrl header
In-Reply-To: <1370004142-30506-1-git-send-email-florian.vaussard@epfl.ch>
References: <1370004142-30506-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <1370004142-30506-4-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pinctrl IP inside the AM33XX family differs slightly from
what is found on OMAP2+. Define a specific header to take account
of the differences.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 include/dt-bindings/pinctrl/am33xx.h |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/am33xx.h

diff --git a/include/dt-bindings/pinctrl/am33xx.h b/include/dt-bindings/pinctrl/am33xx.h
new file mode 100644
index 0000000..9ffb6c2
--- /dev/null
+++ b/include/dt-bindings/pinctrl/am33xx.h
@@ -0,0 +1,19 @@
+/*
+ * This header provides constants specific to AM33XX pinctrl bindings.
+ */
+
+#include <include/dt-bindings/pinctrl/omap.h>
+
+/* am33xx specific mux bit defines */
+#undef  INPUT_EN
+#define INPUT_EN		(1 << 5)
+#define SLEWCTRL_FAST		(1 << 6)
+
+/* update macro depending on INPUT_EN */
+#undef  PIN_INPUT
+#undef  PIN_INPUT_PULLUP
+#undef  PIN_INPUT_PULLDOWN
+#define PIN_INPUT		INPUT_EN
+#define PIN_INPUT_PULLUP	(PULL_ENA | INPUT_EN | PULL_UP)
+#define PIN_INPUT_PULLDOWN	(PULL_ENA | INPUT_EN)
+
-- 
1.7.5.4
