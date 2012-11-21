From: dianders@chromium.org (Doug Anderson)
Date: Wed, 21 Nov 2012 08:54:25 -0800
Subject: [PATCH v2] ARM: exynos: add UART3 to DEBUG_LL ports
In-Reply-To: <1353451739-6317-1-git-send-email-dianders@chromium.org>
References: <1353451739-6317-1-git-send-email-dianders@chromium.org>
Message-ID: <1353516865-2502-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Olof Johansson <olof@lixom.net>

Add support for using UART3 for DEBUG_LL on exynos.

[dianders: added depend on ARCH_EXYNOS.]

Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Doug Anderson <dianders@chromium.org>

---
Changes in v2:
- Matched Olof's commit message.
- Added ARCH_EXYNOS to depend list.

 arch/arm/Kconfig.debug        |   11 +++++++++++
 arch/arm/plat-samsung/Kconfig |    1 +
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 33a8930..f54f170 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -355,6 +355,17 @@ choice
 		  The uncompressor code port configuration is now handled
 		  by CONFIG_S3C_LOWLEVEL_UART_PORT.
 
+	config DEBUG_S3C_UART3
+		depends on PLAT_SAMSUNG && ARCH_EXYNOS
+		bool "Use S3C UART 3 for low-level debug"
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to UART 3. The port must have been initialised
+		  by the boot-loader before use.
+
+		  The uncompressor code port configuration is now handled
+		  by CONFIG_S3C_LOWLEVEL_UART_PORT.
+
 	config DEBUG_SOCFPGA_UART
 		depends on ARCH_SOCFPGA
 		bool "Use SOCFPGA UART for low-level debug"
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 59401e1..d342ed0 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -502,5 +502,6 @@ config DEBUG_S3C_UART
 	default "0" if DEBUG_S3C_UART0
 	default "1" if DEBUG_S3C_UART1
 	default "2" if DEBUG_S3C_UART2
+	default "3" if DEBUG_S3C_UART3
 
 endif
-- 
1.7.7.3
