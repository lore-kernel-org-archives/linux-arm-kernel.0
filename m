From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri,  2 Mar 2012 20:54:05 +0100
Subject: [PATCH 3/6] ARM: at91: always enable sam9 restart
In-Reply-To: <20120302192844.GB21255@game.jcrosoft.org>
References: <20120302192844.GB21255@game.jcrosoft.org>
Message-ID: <1330718048-9314-3-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is need for multiple SoC in the same kernel image and DT.
As we will chose the restart function via binding.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/Kconfig |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index e55cdcb..45db05d 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -20,9 +20,11 @@ config HAVE_AT91_USART5
 
 config AT91_SAM9_ALT_RESET
 	bool
+	default !ARCH_AT91X40
 
 config AT91_SAM9G45_RESET
 	bool
+	default !ARCH_AT91X40
 
 menu "Atmel AT91 System-on-Chip"
 
@@ -45,7 +47,6 @@ config ARCH_AT91SAM9260
 	select HAVE_AT91_USART4
 	select HAVE_AT91_USART5
 	select HAVE_NET_MACB
-	select AT91_SAM9_ALT_RESET
 
 config ARCH_AT91SAM9261
 	bool "AT91SAM9261"
@@ -53,7 +54,6 @@ config ARCH_AT91SAM9261
 	select GENERIC_CLOCKEVENTS
 	select HAVE_FB_ATMEL
 	select HAVE_AT91_DBGU0
-	select AT91_SAM9_ALT_RESET
 
 config ARCH_AT91SAM9G10
 	bool "AT91SAM9G10"
@@ -61,7 +61,6 @@ config ARCH_AT91SAM9G10
 	select GENERIC_CLOCKEVENTS
 	select HAVE_AT91_DBGU0
 	select HAVE_FB_ATMEL
-	select AT91_SAM9_ALT_RESET
 
 config ARCH_AT91SAM9263
 	bool "AT91SAM9263"
@@ -70,7 +69,6 @@ config ARCH_AT91SAM9263
 	select HAVE_FB_ATMEL
 	select HAVE_NET_MACB
 	select HAVE_AT91_DBGU1
-	select AT91_SAM9_ALT_RESET
 
 config ARCH_AT91SAM9RL
 	bool "AT91SAM9RL"
@@ -79,7 +77,6 @@ config ARCH_AT91SAM9RL
 	select HAVE_AT91_USART3
 	select HAVE_FB_ATMEL
 	select HAVE_AT91_DBGU0
-	select AT91_SAM9_ALT_RESET
 
 config ARCH_AT91SAM9G20
 	bool "AT91SAM9G20"
@@ -90,7 +87,6 @@ config ARCH_AT91SAM9G20
 	select HAVE_AT91_USART4
 	select HAVE_AT91_USART5
 	select HAVE_NET_MACB
-	select AT91_SAM9_ALT_RESET
 
 config ARCH_AT91SAM9G45
 	bool "AT91SAM9G45"
@@ -100,7 +96,6 @@ config ARCH_AT91SAM9G45
 	select HAVE_FB_ATMEL
 	select HAVE_NET_MACB
 	select HAVE_AT91_DBGU1
-	select AT91_SAM9G45_RESET
 
 config ARCH_AT91SAM9X5
 	bool "AT91SAM9x5 family"
@@ -109,7 +104,6 @@ config ARCH_AT91SAM9X5
 	select HAVE_FB_ATMEL
 	select HAVE_NET_MACB
 	select HAVE_AT91_DBGU0
-	select AT91_SAM9G45_RESET
 
 config ARCH_AT91X40
 	bool "AT91x40"
-- 
1.7.7
