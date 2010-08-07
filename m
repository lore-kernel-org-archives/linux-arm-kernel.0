From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat,  7 Aug 2010 09:51:51 +0200
Subject: [PATCH] atmel_macb Kconfig: remove long dependency line
Message-ID: <1281167511-3038-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many Atmel SOC are embedding a MACB controller. This patch removes the long
dependency line for this Atmel MACB ethernet driver configuration entry.
The HAVE_NET_MACB configuration option is located in the net Kconfig file
as it may be setup by ARM/AT91 and AVR32 chips.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: David Miller <davem@davemloft.net>
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Andrew Victor <linux@maxim.org.za>
---
 arch/arm/mach-at91/Kconfig |    4 ++++
 arch/avr32/Kconfig         |    1 +
 drivers/net/Kconfig        |    5 ++++-
 3 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 841eaf8..72a9edf 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -33,6 +33,7 @@ config ARCH_AT91SAM9260
 	select HAVE_AT91_USART3
 	select HAVE_AT91_USART4
 	select HAVE_AT91_USART5
+	select HAVE_NET_MACB
 
 config ARCH_AT91SAM9261
 	bool "AT91SAM9261"
@@ -51,6 +52,7 @@ config ARCH_AT91SAM9263
 	select CPU_ARM926T
 	select GENERIC_CLOCKEVENTS
 	select HAVE_FB_ATMEL
+	select HAVE_NET_MACB
 
 config ARCH_AT91SAM9RL
 	bool "AT91SAM9RL"
@@ -66,6 +68,7 @@ config ARCH_AT91SAM9G20
 	select HAVE_AT91_USART3
 	select HAVE_AT91_USART4
 	select HAVE_AT91_USART5
+	select HAVE_NET_MACB
 
 config ARCH_AT91SAM9G45
 	bool "AT91SAM9G45"
@@ -73,6 +76,7 @@ config ARCH_AT91SAM9G45
 	select GENERIC_CLOCKEVENTS
 	select HAVE_AT91_USART3
 	select HAVE_FB_ATMEL
+	select HAVE_NET_MACB
 
 config ARCH_AT91CAP9
 	bool "AT91CAP9"
diff --git a/arch/avr32/Kconfig b/arch/avr32/Kconfig
index f2b3193..3dcd321 100644
--- a/arch/avr32/Kconfig
+++ b/arch/avr32/Kconfig
@@ -93,6 +93,7 @@ config PLATFORM_AT32AP
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_ALLOCATOR
 	select HAVE_FB_ATMEL
+	select HAVE_NET_MACB
 
 #
 # CPU types
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index ce2fcdd..19e1be8 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -2,6 +2,9 @@
 # Network device configuration
 #
 
+config HAVE_NET_MACB
+	bool
+
 menuconfig NETDEVICES
 	default y if UML
 	depends on NET
@@ -221,7 +224,7 @@ config MII
 
 config MACB
 	tristate "Atmel MACB support"
-	depends on AVR32 || ARCH_AT91SAM9260 || ARCH_AT91SAM9263 || ARCH_AT91SAM9G20 || ARCH_AT91SAM9G45 || ARCH_AT91CAP9
+	depend on HAVE_NET_MACB
 	select PHYLIB
 	help
 	  The Atmel MACB ethernet interface is found on many AT32 and AT91
-- 
1.7.1
