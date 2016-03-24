From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 24 Mar 2016 17:50:10 +0100
Subject: [PATCH v3 13/18] arm: Add new mach-oxnas
In-Reply-To: <1458838215-23314-1-git-send-email-narmstrong@baylibre.com>
References: <1458838215-23314-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1458838215-23314-14-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add mach-oxnas directory containing Kconfig.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/mach-oxnas/Kconfig | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 arch/arm/mach-oxnas/Kconfig

diff --git a/arch/arm/mach-oxnas/Kconfig b/arch/arm/mach-oxnas/Kconfig
new file mode 100644
index 0000000..63cba044
--- /dev/null
+++ b/arch/arm/mach-oxnas/Kconfig
@@ -0,0 +1,25 @@
+menuconfig ARCH_OXNAS
+	bool "PLX Technology OXNAS Family SoCs"
+	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_HAS_RESET_CONTROLLER
+	select PINCTRL
+	depends on ARCH_MULTI_V5
+	help
+	  Support for OxNas SoC family developed by PLX Technology.
+	  (Formely Oxford Semiconductor)
+
+if ARCH_OXNAS
+
+config MACH_OX810SE
+	bool "Support OX810SE Based Products"
+	select ARM_TIMER_SP804
+	select COMMON_CLK_OXNAS
+	select CPU_ARM926T
+	select MFD_SYSCON
+	select PINCTRL_OXNAS
+	select RESET_OXNAS
+	select VERSATILE_FPGA_IRQ
+	help
+	  Include Support for the Oxford Semiconductor OX810SE SoC Based Products.
+
+endif
-- 
1.9.1
