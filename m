From: albin.tonnerre@free-electrons.com (Albin Tonnerre)
Date: Sat, 15 Jan 2011 18:50:34 +0100
Subject: [RFC 1/2] AT91: Support SAM9260 and SAM9G20-based boards in the same
	kernel image
Message-ID: <1295113835-6776-1-git-send-email-albin.tonnerre@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nothing actually prevents support for boards based on these SoCs to be
compiled in the same kernel image, since the SAM9260 and SAM9G20 are
almost identical (AT91SAM9G20 adds some new features, but is otherwise
compatible with the AT91SAM9260).

Signed-off-by: Albin Tonnerre <albin.tonnerre@free-electrons.com>
---
 arch/arm/mach-at91/Kconfig |   31 +++++++++++++------------------
 1 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index c015b68..d1eda58 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -26,8 +26,8 @@ config ARCH_AT91RM9200
 	select GENERIC_CLOCKEVENTS
 	select HAVE_AT91_USART3
 
-config ARCH_AT91SAM9260
-	bool "AT91SAM9260 or AT91SAM9XE"
+config ARCH_AT91SAM9260_VARIANTS
+	bool "AT91SAM9260 / AT91SAM9XE and AT91SAM9G20"
 	select CPU_ARM926T
 	select GENERIC_CLOCKEVENTS
 	select HAVE_AT91_USART3
@@ -61,15 +61,6 @@ config ARCH_AT91SAM9RL
 	select HAVE_AT91_USART3
 	select HAVE_FB_ATMEL
 
-config ARCH_AT91SAM9G20
-	bool "AT91SAM9G20"
-	select CPU_ARM926T
-	select GENERIC_CLOCKEVENTS
-	select HAVE_AT91_USART3
-	select HAVE_AT91_USART4
-	select HAVE_AT91_USART5
-	select HAVE_NET_MACB
-
 config ARCH_AT91SAM9G45
 	bool "AT91SAM9G45"
 	select CPU_ARM926T
@@ -193,15 +184,19 @@ endif
 
 # ----------------------------------------------------------
 
-if ARCH_AT91SAM9260
+if ARCH_AT91SAM9260_VARIANTS
 
-comment "AT91SAM9260 Variants"
+menu "AT91SAM9260 Variants"
 
-config ARCH_AT91SAM9260_SAM9XE
-	bool "AT91SAM9XE"
-	help
-	  Select this if you are using Atmel's AT91SAM9XE System-on-Chip.
-	  They are basically AT91SAM9260s with various sizes of embedded Flash.
+config ARCH_AT91SAM9260
+	bool "AT91SAM9260 / AT91SAM9XE"
+	default y
+
+config ARCH_AT91SAM9G20
+	bool "AT91SAM9G20"
+	default y
+
+endmenu
 
 comment "AT91SAM9260 / AT91SAM9XE Board Type"
 
-- 
1.7.2.3
