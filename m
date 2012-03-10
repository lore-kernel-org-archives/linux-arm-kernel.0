From: alan@signal11.us (Alan Ott)
Date: Sat, 10 Mar 2012 16:38:51 -0500
Subject: [PATCH v2 1/2] ARM: AT91: Add parameter for AT91_HAS_PATA
In-Reply-To: <1331415380-10928-1-git-send-email-alan@signal11.us>
References: <1331415380-10928-1-git-send-email-alan@signal11.us>
Message-ID: <1331415531-10961-1-git-send-email-alan@signal11.us>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not all at91 chips have PATA, this parameter will identify which
chips do. The determining of which chips support PATA was done
by Arnd Bergmann.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Alan Ott <alan@signal11.us>
CC: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-at91/Kconfig |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 71feb00..9eeeabe 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -24,6 +24,9 @@ config AT91_SAM9_ALT_RESET
 config AT91_SAM9G45_RESET
 	bool
 
+config AT91_HAS_PATA
+	bool
+
 menu "Atmel AT91 System-on-Chip"
 
 choice
@@ -46,6 +49,7 @@ config ARCH_AT91SAM9260
 	select HAVE_AT91_USART5
 	select HAVE_NET_MACB
 	select AT91_SAM9_ALT_RESET
+	select AT91_HAS_PATA
 
 config ARCH_AT91SAM9261
 	bool "AT91SAM9261"
@@ -54,6 +58,7 @@ config ARCH_AT91SAM9261
 	select HAVE_FB_ATMEL
 	select HAVE_AT91_DBGU0
 	select AT91_SAM9_ALT_RESET
+	select AT91_HAS_PATA
 
 config ARCH_AT91SAM9G10
 	bool "AT91SAM9G10"
@@ -62,6 +67,7 @@ config ARCH_AT91SAM9G10
 	select HAVE_AT91_DBGU0
 	select HAVE_FB_ATMEL
 	select AT91_SAM9_ALT_RESET
+	select AT91_HAS_PATA
 
 config ARCH_AT91SAM9263
 	bool "AT91SAM9263"
@@ -71,6 +77,7 @@ config ARCH_AT91SAM9263
 	select HAVE_NET_MACB
 	select HAVE_AT91_DBGU1
 	select AT91_SAM9_ALT_RESET
+	select AT91_HAS_PATA
 
 config ARCH_AT91SAM9RL
 	bool "AT91SAM9RL"
@@ -80,6 +87,7 @@ config ARCH_AT91SAM9RL
 	select HAVE_FB_ATMEL
 	select HAVE_AT91_DBGU0
 	select AT91_SAM9_ALT_RESET
+	select AT91_HAS_PATA
 
 config ARCH_AT91SAM9G20
 	bool "AT91SAM9G20"
@@ -91,6 +99,7 @@ config ARCH_AT91SAM9G20
 	select HAVE_AT91_USART5
 	select HAVE_NET_MACB
 	select AT91_SAM9_ALT_RESET
+	select AT91_HAS_PATA
 
 config ARCH_AT91SAM9G45
 	bool "AT91SAM9G45"
@@ -101,6 +110,7 @@ config ARCH_AT91SAM9G45
 	select HAVE_NET_MACB
 	select HAVE_AT91_DBGU1
 	select AT91_SAM9G45_RESET
+	select AT91_HAS_PATA
 
 config ARCH_AT91CAP9
 	bool "AT91CAP9"
@@ -110,6 +120,7 @@ config ARCH_AT91CAP9
 	select HAVE_NET_MACB
 	select HAVE_AT91_DBGU1
 	select AT91_SAM9G45_RESET
+	select AT91_HAS_PATA
 
 config ARCH_AT91X40
 	bool "AT91x40"
-- 
1.7.0.4
