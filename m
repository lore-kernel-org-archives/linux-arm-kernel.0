From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 12 Feb 2015 10:32:48 +0800
Subject: [PATCH 2/3] ARM: at91: move "select SRAM" under SOC_AT91SAM9 and
 SOC_SAMA5
In-Reply-To: <1423708269-7750-1-git-send-email-wenyou.yang@atmel.com>
References: <1423708269-7750-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1423708368-7847-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To simply the PM config the CONFIG_AT91_SLOW_CLOCK config will be removed,
so move "select SRAM" from under AT91_SLOW_CLOCK,
add "select SRAM if PM" under SOC_AT91SAM9 and SOC_SAMA5

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/Kconfig |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index c6740e3..6b9e685 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -25,6 +25,7 @@ config SOC_SAMA5
 	select MEMORY
 	select ATMEL_SDRAMC
 	select PHYLIB if NETDEVICES
+	select SRAM if PM
 
 menu "Atmel AT91 System-on-Chip"
 
@@ -82,6 +83,7 @@ config SOC_AT91RM9200
 	select CPU_ARM920T
 	select GENERIC_CLOCKEVENTS
 	select HAVE_AT91_USB_CLK
+	select SRAM if PM
 
 config SOC_AT91SAM9
 	bool "AT91SAM9"
@@ -95,6 +97,7 @@ config SOC_AT91SAM9
 	select HAVE_AT91_UTMI
 	select HAVE_FB_ATMEL
 	select MEMORY
+	select SRAM if PM
 	help
 	  Select this if you are using one of those Atmel SoC:
 	    AT91SAM9260
@@ -119,7 +122,6 @@ comment "AT91 Feature Selections"
 
 config AT91_SLOW_CLOCK
 	bool "Suspend-to-RAM disables main oscillator"
-	select SRAM
 	depends on SUSPEND
 	help
 	  Select this if you want Suspend-to-RAM to save the most power
-- 
1.7.9.5
