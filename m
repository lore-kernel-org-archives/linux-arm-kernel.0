From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Mon,  8 Feb 2010 16:11:30 -0800
Subject: [PATCH 09/14] ARM: LPC32XX: Arch config menu supoport and makefiles
In-Reply-To: <1265674295-23996-1-git-send-email-wellsk40@gmail.com>
References: <1265674295-23996-1-git-send-email-wellsk40@gmail.com>
Message-ID: <1265674295-23996-10-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>


Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/Kconfig       |   33 +++++++++++++++++++++++++++++++++
 arch/arm/mach-lpc32xx/Makefile      |    8 ++++++++
 arch/arm/mach-lpc32xx/Makefile.boot |    4 ++++
 3 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/Kconfig b/arch/arm/mach-lpc32xx/Kconfig
new file mode 100644
index 0000000..fde6635
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/Kconfig
@@ -0,0 +1,33 @@
+if ARCH_LPC32XX
+
+menu "Individual UART enable selections"
+
+config ARCH_LPC32XX_UART3_SELECT
+	bool "Add support for standard UART3"
+	help
+	 Adds support for standard UART 3 when the 8250 serial support
+	 is enabled.
+
+config ARCH_LPC32XX_UART4_SELECT
+	bool "Add support for standard UART4"
+	help
+	 Adds support for standard UART 4 when the 8250 serial support
+	 is enabled.
+
+config ARCH_LPC32XX_UART5_SELECT
+	bool "Add support for standard UART5"
+	default y
+	help
+	 Adds support for standard UART 5 when the 8250 serial support
+	 is enabled.
+
+config ARCH_LPC32XX_UART6_SELECT
+	bool "Add support for standard UART6"
+	help
+	 Adds support for standard UART 6 when the 8250 serial support
+	 is enabled.
+
+endmenu
+
+endif
+
diff --git a/arch/arm/mach-lpc32xx/Makefile b/arch/arm/mach-lpc32xx/Makefile
new file mode 100644
index 0000000..a5fc5d0
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/Makefile
@@ -0,0 +1,8 @@
+#
+# Makefile for the linux kernel.
+#
+
+obj-y	:= timer.o irq.o common.o serial.o clock.o
+obj-y	+= gpiolib.o pm.o suspend.o
+obj-y	+= phy3250.o
+
diff --git a/arch/arm/mach-lpc32xx/Makefile.boot b/arch/arm/mach-lpc32xx/Makefile.boot
new file mode 100644
index 0000000..b796b41
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/Makefile.boot
@@ -0,0 +1,4 @@
+   zreladdr-y	:= 0x80008000
+params_phys-y	:= 0x80000100
+initrd_phys-y	:= 0x82000000
+
-- 
1.6.6
