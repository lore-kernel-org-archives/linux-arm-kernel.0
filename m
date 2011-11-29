From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 29 Nov 2011 18:52:39 +0100
Subject: [PATCH 3/6] ARM: at91: introduce AT91_SAM9_ALT_RESET to select the
 at91sam9 alternative reset
In-Reply-To: <20111129173514.GW15008@game.jcrosoft.org>
References: <20111129173514.GW15008@game.jcrosoft.org>
Message-ID: <1322589162-5212-3-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/Kconfig  |    9 +++++++++
 arch/arm/mach-at91/Makefile |   13 +++++++------
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 4f991f2..4275577 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -18,6 +18,9 @@ config HAVE_AT91_USART4
 config HAVE_AT91_USART5
 	bool
 
+config AT91_SAM9_ALT_RESET
+	bool
+
 menu "Atmel AT91 System-on-Chip"
 
 choice
@@ -39,6 +42,7 @@ config ARCH_AT91SAM9260
 	select HAVE_AT91_USART4
 	select HAVE_AT91_USART5
 	select HAVE_NET_MACB
+	select AT91_SAM9_ALT_RESET
 
 config ARCH_AT91SAM9261
 	bool "AT91SAM9261"
@@ -46,6 +50,7 @@ config ARCH_AT91SAM9261
 	select GENERIC_CLOCKEVENTS
 	select HAVE_FB_ATMEL
 	select HAVE_AT91_DBGU0
+	select AT91_SAM9_ALT_RESET
 
 config ARCH_AT91SAM9G10
 	bool "AT91SAM9G10"
@@ -53,6 +58,7 @@ config ARCH_AT91SAM9G10
 	select GENERIC_CLOCKEVENTS
 	select HAVE_AT91_DBGU0
 	select HAVE_FB_ATMEL
+	select AT91_SAM9_ALT_RESET
 
 config ARCH_AT91SAM9263
 	bool "AT91SAM9263"
@@ -61,6 +67,7 @@ config ARCH_AT91SAM9263
 	select HAVE_FB_ATMEL
 	select HAVE_NET_MACB
 	select HAVE_AT91_DBGU1
+	select AT91_SAM9_ALT_RESET
 
 config ARCH_AT91SAM9RL
 	bool "AT91SAM9RL"
@@ -69,6 +76,7 @@ config ARCH_AT91SAM9RL
 	select HAVE_AT91_USART3
 	select HAVE_FB_ATMEL
 	select HAVE_AT91_DBGU0
+	select AT91_SAM9_ALT_RESET
 
 config ARCH_AT91SAM9G20
 	bool "AT91SAM9G20"
@@ -79,6 +87,7 @@ config ARCH_AT91SAM9G20
 	select HAVE_AT91_USART4
 	select HAVE_AT91_USART5
 	select HAVE_NET_MACB
+	select AT91_SAM9_ALT_RESET
 
 config ARCH_AT91SAM9G45
 	bool "AT91SAM9G45"
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 242174f..e8e961b 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -8,15 +8,16 @@ obj-n		:=
 obj-		:=
 
 obj-$(CONFIG_AT91_PMC_UNIT)	+= clock.o
+obj-$(CONFIG_AT91_SAM9_ALT_RESET) += at91sam9_alt_reset.o
 
 # CPU-specific support
 obj-$(CONFIG_ARCH_AT91RM9200)	+= at91rm9200.o at91rm9200_time.o at91rm9200_devices.o
-obj-$(CONFIG_ARCH_AT91SAM9260)	+= at91sam9260.o at91sam926x_time.o at91sam9260_devices.o sam9_smc.o at91sam9_alt_reset.o
-obj-$(CONFIG_ARCH_AT91SAM9261)	+= at91sam9261.o at91sam926x_time.o at91sam9261_devices.o sam9_smc.o at91sam9_alt_reset.o
-obj-$(CONFIG_ARCH_AT91SAM9G10)	+= at91sam9261.o at91sam926x_time.o at91sam9261_devices.o sam9_smc.o at91sam9_alt_reset.o
-obj-$(CONFIG_ARCH_AT91SAM9263)	+= at91sam9263.o at91sam926x_time.o at91sam9263_devices.o sam9_smc.o at91sam9_alt_reset.o
-obj-$(CONFIG_ARCH_AT91SAM9RL)	+= at91sam9rl.o at91sam926x_time.o at91sam9rl_devices.o sam9_smc.o at91sam9_alt_reset.o
-obj-$(CONFIG_ARCH_AT91SAM9G20)	+= at91sam9260.o at91sam926x_time.o at91sam9260_devices.o sam9_smc.o at91sam9_alt_reset.o
+obj-$(CONFIG_ARCH_AT91SAM9260)	+= at91sam9260.o at91sam926x_time.o at91sam9260_devices.o sam9_smc.o
+obj-$(CONFIG_ARCH_AT91SAM9261)	+= at91sam9261.o at91sam926x_time.o at91sam9261_devices.o sam9_smc.o
+obj-$(CONFIG_ARCH_AT91SAM9G10)	+= at91sam9261.o at91sam926x_time.o at91sam9261_devices.o sam9_smc.o
+obj-$(CONFIG_ARCH_AT91SAM9263)	+= at91sam9263.o at91sam926x_time.o at91sam9263_devices.o sam9_smc.o
+obj-$(CONFIG_ARCH_AT91SAM9RL)	+= at91sam9rl.o at91sam926x_time.o at91sam9rl_devices.o sam9_smc.o
+obj-$(CONFIG_ARCH_AT91SAM9G20)	+= at91sam9260.o at91sam926x_time.o at91sam9260_devices.o sam9_smc.o
 obj-$(CONFIG_ARCH_AT91SAM9G45)	+= at91sam9g45.o at91sam926x_time.o at91sam9g45_devices.o sam9_smc.o
 obj-$(CONFIG_ARCH_AT91CAP9)	+= at91cap9.o at91sam926x_time.o at91cap9_devices.o sam9_smc.o
 obj-$(CONFIG_ARCH_AT91X40)	+= at91x40.o at91x40_time.o
-- 
1.7.7
