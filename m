From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue,  9 Sep 2014 11:14:59 +0200
Subject: [PATCH] ARM: at91: enable new AIC driver even if the old one is
 selected
Message-ID: <1410254099-24680-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new AIC driver is currently only selected when only DT board support
is enabled (and not when both DT and non-DT boards are supported), thus,
when booting a "DT + non-DT" kernel with a dtb, the irqchip is never
initialized/registered which then triggers a panic.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 arch/arm/mach-at91/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 7df2c9b..cd7c0cb 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -51,7 +51,7 @@ config HAVE_AT91_SMD
 config SOC_AT91SAM9
 	bool
 	select AT91_SAM9_TIME
-	select ATMEL_AIC_IRQ if !OLD_IRQ_AT91
+	select ATMEL_AIC_IRQ
 	select CPU_ARM926T
 	select GENERIC_CLOCKEVENTS
 
@@ -111,7 +111,7 @@ endif
 if SOC_SAM_V4_V5
 config SOC_AT91RM9200
 	bool "AT91RM9200"
-	select ATMEL_AIC_IRQ if !OLD_IRQ_AT91
+	select ATMEL_AIC_IRQ
 	select CPU_ARM920T
 	select GENERIC_CLOCKEVENTS
 	select HAVE_AT91_DBGU0
-- 
1.9.1
