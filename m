From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 13 Feb 2013 14:33:16 -0700
Subject: [PATCH 7/9] ARM: tegra: create a DT header defining GPIO IDs
In-Reply-To: <1360791198-29462-1-git-send-email-swarren@wwwdotorg.org>
References: <1360791198-29462-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1360791198-29462-8-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

All Tegra GPIOs are named after the GPIO bank and GPIO number within
the bank. Define a macro to calculate the GPIO ID based on those
parameters. Make the macro available via all Tegra .dtsip files.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra-gpio.h   |   45 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/tegra114.dtsip |    1 +
 arch/arm/boot/dts/tegra20.dtsip  |    1 +
 arch/arm/boot/dts/tegra30.dtsip  |    1 +
 4 files changed, 48 insertions(+)
 create mode 100644 arch/arm/boot/dts/tegra-gpio.h

diff --git a/arch/arm/boot/dts/tegra-gpio.h b/arch/arm/boot/dts/tegra-gpio.h
new file mode 100644
index 0000000..aecc570
--- /dev/null
+++ b/arch/arm/boot/dts/tegra-gpio.h
@@ -0,0 +1,45 @@
+/*
+ * This header provides constants for binding nvidia,tegra*-gpio.
+ *
+ * The first cell in Tegra's GPIO specifier is the GPIO ID. The macros below
+ * provide names for this.
+ *
+ * The second cell contains standard flag values specified in gpio.h.
+ */
+
+#include "gpio.h"
+
+#define TEGRA_GPIO_BANK_ID_A 0
+#define TEGRA_GPIO_BANK_ID_B 1
+#define TEGRA_GPIO_BANK_ID_C 2
+#define TEGRA_GPIO_BANK_ID_D 3
+#define TEGRA_GPIO_BANK_ID_E 4
+#define TEGRA_GPIO_BANK_ID_F 5
+#define TEGRA_GPIO_BANK_ID_G 6
+#define TEGRA_GPIO_BANK_ID_H 7
+#define TEGRA_GPIO_BANK_ID_I 8
+#define TEGRA_GPIO_BANK_ID_J 9
+#define TEGRA_GPIO_BANK_ID_K 10
+#define TEGRA_GPIO_BANK_ID_L 11
+#define TEGRA_GPIO_BANK_ID_M 12
+#define TEGRA_GPIO_BANK_ID_N 13
+#define TEGRA_GPIO_BANK_ID_O 14
+#define TEGRA_GPIO_BANK_ID_P 15
+#define TEGRA_GPIO_BANK_ID_Q 16
+#define TEGRA_GPIO_BANK_ID_R 17
+#define TEGRA_GPIO_BANK_ID_S 18
+#define TEGRA_GPIO_BANK_ID_T 19
+#define TEGRA_GPIO_BANK_ID_U 20
+#define TEGRA_GPIO_BANK_ID_V 21
+#define TEGRA_GPIO_BANK_ID_W 22
+#define TEGRA_GPIO_BANK_ID_X 23
+#define TEGRA_GPIO_BANK_ID_Y 24
+#define TEGRA_GPIO_BANK_ID_Z 25
+#define TEGRA_GPIO_BANK_ID_AA 26
+#define TEGRA_GPIO_BANK_ID_BB 27
+#define TEGRA_GPIO_BANK_ID_CC 28
+#define TEGRA_GPIO_BANK_ID_DD 29
+#define TEGRA_GPIO_BANK_ID_EE 30
+
+#define TEGRA_GPIO(bank, offset) \
+	((TEGRA_GPIO_BANK_ID_##bank * 8) + offset)
diff --git a/arch/arm/boot/dts/tegra114.dtsip b/arch/arm/boot/dts/tegra114.dtsip
index d2150f0..356a8af 100644
--- a/arch/arm/boot/dts/tegra114.dtsip
+++ b/arch/arm/boot/dts/tegra114.dtsip
@@ -1,4 +1,5 @@
 #include "skeleton.dtsi"
+#include "tegra-gpio.h"
 
 / {
 	compatible = "nvidia,tegra114";
diff --git a/arch/arm/boot/dts/tegra20.dtsip b/arch/arm/boot/dts/tegra20.dtsip
index 917edd4..1caece9 100644
--- a/arch/arm/boot/dts/tegra20.dtsip
+++ b/arch/arm/boot/dts/tegra20.dtsip
@@ -1,4 +1,5 @@
 #include "skeleton.dtsi"
+#include "tegra-gpio.h"
 
 / {
 	compatible = "nvidia,tegra20";
diff --git a/arch/arm/boot/dts/tegra30.dtsip b/arch/arm/boot/dts/tegra30.dtsip
index d25975e..70b6ac7 100644
--- a/arch/arm/boot/dts/tegra30.dtsip
+++ b/arch/arm/boot/dts/tegra30.dtsip
@@ -1,4 +1,5 @@
 #include "skeleton.dtsi"
+#include "tegra-gpio.h"
 
 / {
 	compatible = "nvidia,tegra30";
-- 
1.7.10.4
