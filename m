From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue,  5 Apr 2016 13:25:07 -0600
Subject: [PATCH] ARM: tegra: fix naming in GPIO DT binding header
Message-ID: <1459884307-24043-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

According to the Tegra TRM, GPIOs are aggregated into /ports/ of 8 GPIOs,
not into /banks/. Fix <dt-bindings/gpio/tegra-gpio.h> to correctly reflect
this naming convention. While this seems like silly churn, it will become
slightly more important once we introduce the GPIO binding for upcoming
Tegra chips.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 include/dt-bindings/gpio/tegra-gpio.h | 68 +++++++++++++++++------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/include/dt-bindings/gpio/tegra-gpio.h b/include/dt-bindings/gpio/tegra-gpio.h
index 197dc28b676e..a1c09e88e80b 100644
--- a/include/dt-bindings/gpio/tegra-gpio.h
+++ b/include/dt-bindings/gpio/tegra-gpio.h
@@ -12,40 +12,40 @@
 
 #include <dt-bindings/gpio/gpio.h>
 
-#define TEGRA_GPIO_BANK_ID_A 0
-#define TEGRA_GPIO_BANK_ID_B 1
-#define TEGRA_GPIO_BANK_ID_C 2
-#define TEGRA_GPIO_BANK_ID_D 3
-#define TEGRA_GPIO_BANK_ID_E 4
-#define TEGRA_GPIO_BANK_ID_F 5
-#define TEGRA_GPIO_BANK_ID_G 6
-#define TEGRA_GPIO_BANK_ID_H 7
-#define TEGRA_GPIO_BANK_ID_I 8
-#define TEGRA_GPIO_BANK_ID_J 9
-#define TEGRA_GPIO_BANK_ID_K 10
-#define TEGRA_GPIO_BANK_ID_L 11
-#define TEGRA_GPIO_BANK_ID_M 12
-#define TEGRA_GPIO_BANK_ID_N 13
-#define TEGRA_GPIO_BANK_ID_O 14
-#define TEGRA_GPIO_BANK_ID_P 15
-#define TEGRA_GPIO_BANK_ID_Q 16
-#define TEGRA_GPIO_BANK_ID_R 17
-#define TEGRA_GPIO_BANK_ID_S 18
-#define TEGRA_GPIO_BANK_ID_T 19
-#define TEGRA_GPIO_BANK_ID_U 20
-#define TEGRA_GPIO_BANK_ID_V 21
-#define TEGRA_GPIO_BANK_ID_W 22
-#define TEGRA_GPIO_BANK_ID_X 23
-#define TEGRA_GPIO_BANK_ID_Y 24
-#define TEGRA_GPIO_BANK_ID_Z 25
-#define TEGRA_GPIO_BANK_ID_AA 26
-#define TEGRA_GPIO_BANK_ID_BB 27
-#define TEGRA_GPIO_BANK_ID_CC 28
-#define TEGRA_GPIO_BANK_ID_DD 29
-#define TEGRA_GPIO_BANK_ID_EE 30
-#define TEGRA_GPIO_BANK_ID_FF 31
+#define TEGRA_GPIO_PORT_A 0
+#define TEGRA_GPIO_PORT_B 1
+#define TEGRA_GPIO_PORT_C 2
+#define TEGRA_GPIO_PORT_D 3
+#define TEGRA_GPIO_PORT_E 4
+#define TEGRA_GPIO_PORT_F 5
+#define TEGRA_GPIO_PORT_G 6
+#define TEGRA_GPIO_PORT_H 7
+#define TEGRA_GPIO_PORT_I 8
+#define TEGRA_GPIO_PORT_J 9
+#define TEGRA_GPIO_PORT_K 10
+#define TEGRA_GPIO_PORT_L 11
+#define TEGRA_GPIO_PORT_M 12
+#define TEGRA_GPIO_PORT_N 13
+#define TEGRA_GPIO_PORT_O 14
+#define TEGRA_GPIO_PORT_P 15
+#define TEGRA_GPIO_PORT_Q 16
+#define TEGRA_GPIO_PORT_R 17
+#define TEGRA_GPIO_PORT_S 18
+#define TEGRA_GPIO_PORT_T 19
+#define TEGRA_GPIO_PORT_U 20
+#define TEGRA_GPIO_PORT_V 21
+#define TEGRA_GPIO_PORT_W 22
+#define TEGRA_GPIO_PORT_X 23
+#define TEGRA_GPIO_PORT_Y 24
+#define TEGRA_GPIO_PORT_Z 25
+#define TEGRA_GPIO_PORT_AA 26
+#define TEGRA_GPIO_PORT_BB 27
+#define TEGRA_GPIO_PORT_CC 28
+#define TEGRA_GPIO_PORT_DD 29
+#define TEGRA_GPIO_PORT_EE 30
+#define TEGRA_GPIO_PORT_FF 31
 
-#define TEGRA_GPIO(bank, offset) \
-	((TEGRA_GPIO_BANK_ID_##bank * 8) + offset)
+#define TEGRA_GPIO(port, offset) \
+	((TEGRA_GPIO_PORT_##port * 8) + offset)
 
 #endif
-- 
2.8.1
