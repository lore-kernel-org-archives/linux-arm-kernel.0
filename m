From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Tue, 27 Jan 2015 13:56:42 +0800
Subject: [PATCH v3 06/13] ARM: at91: move select SRAM to ARCH_AT91
In-Reply-To: <1422337810-3257-1-git-send-email-wenyou.yang@atmel.com>
References: <1422337810-3257-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1422338202-5906-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because the CONFIG_AT91_SLOW_CLOCK will be removed
to simply the PM config, so move select SRAM.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/Kconfig |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index c6956b8..cbaf0c8 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -24,6 +24,7 @@ config SOC_AT91SAM9
 	select GENERIC_CLOCKEVENTS
 	select MEMORY
 	select ATMEL_SDRAMC
+	select SRAM if PM
 
 config SOC_SAMA5
 	bool
@@ -34,6 +35,7 @@ config SOC_SAMA5
 	select MEMORY
 	select ATMEL_SDRAMC
 	select PHYLIB if NETDEVICES
+	select SRAM if PM
 
 menu "Atmel AT91 System-on-Chip"
 
@@ -91,6 +93,7 @@ config SOC_AT91RM9200
 	select CPU_ARM920T
 	select GENERIC_CLOCKEVENTS
 	select HAVE_AT91_USB_CLK
+	select SRAM if PM
 
 config SOC_AT91SAM9260
 	bool "AT91SAM9260, AT91SAM9XE or AT91SAM9G20"
@@ -159,7 +162,6 @@ comment "AT91 Feature Selections"
 
 config AT91_SLOW_CLOCK
 	bool "Suspend-to-RAM disables main oscillator"
-	select SRAM
 	depends on SUSPEND
 	help
 	  Select this if you want Suspend-to-RAM to save the most power
-- 
1.7.9.5
