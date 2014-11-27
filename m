From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 27 Nov 2014 17:06:31 +0100
Subject: [PATCH 03/11] ARM: at91: switch configuration option to SOC_AT91RM9200
In-Reply-To: <cover.1417103399.git.nicolas.ferre@atmel.com>
References: <cover.1417103399.git.nicolas.ferre@atmel.com>
Message-ID: <388c466bdae899f52d55baa02c83b352f4c95c41.1417103399.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the ARCH_AT91RM9200 is removed because being !DT, we use
the SOC_AT91RM9200 variant. This option can certainly be removed
once the ST driver is reworked a bit.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index db8e756a15a8..826e50b63d7e 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -224,7 +224,7 @@ config AT91_TIMER_HZ
        int "Kernel HZ (jiffies per second)"
        range 32 1024
        depends on ARCH_AT91
-       default "128" if ARCH_AT91RM9200
+       default "128" if SOC_AT91RM9200
        default "100"
        help
 	  On AT91rm9200 chips where you're using a system clock derived
-- 
2.1.3
