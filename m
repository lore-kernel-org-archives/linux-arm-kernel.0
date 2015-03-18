From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 18 Mar 2015 15:53:00 +0000
Subject: [PATCH 01/13] ARM: at91: Add big endian configuration for ATSAMA5D
 devices
In-Reply-To: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1426693992-31163-2-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ATSAMA5D devices are based on Cortex-A5 which should work in big
endian configuration. Add ARCH_SUPPORTS_BIG_ENDIAN if these SoCs are
configured so we can run the system big endian.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
CC: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
CC: Andrew Victor <linux@maxim.org.za>
CC: Nicolas Ferre <nicolas.ferre@atmel.com>
CC: Jean-Christophe Plagniol-Villard
CC: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mach-at91/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index c74a443..05212fb 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -18,6 +18,7 @@ config HAVE_AT91_H32MX
 
 config SOC_SAMA5
 	bool
+	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ATMEL_AIC5_IRQ
 	select COMMON_CLK_AT91
 	select CPU_V7
-- 
2.1.4
