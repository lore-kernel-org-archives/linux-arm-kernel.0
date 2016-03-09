From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  9 Mar 2016 11:24:15 +0100
Subject: [PATCH v2 13/18] arm: Add new mach-oxnas
In-Reply-To: <1457519060-6038-1-git-send-email-narmstrong@baylibre.com>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
 <1457519060-6038-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1457519060-6038-14-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add mach-oxnas directory containing Kconfig.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/mach-oxnas/Kconfig  | 25 +++++++++++++++++++++++++
 arch/arm/mach-oxnas/Makefile |  1 +
 2 files changed, 26 insertions(+)
 create mode 100644 arch/arm/mach-oxnas/Kconfig
 create mode 100644 arch/arm/mach-oxnas/Makefile

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
diff --git a/arch/arm/mach-oxnas/Makefile b/arch/arm/mach-oxnas/Makefile
new file mode 100644
index 0000000..d98d860
--- /dev/null
+++ b/arch/arm/mach-oxnas/Makefile
@@ -0,0 +1 @@
+# Nothing Yet
-- 
1.9.1
