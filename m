From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 27 Nov 2014 17:06:33 +0100
Subject: [PATCH 05/11] ARM: at91: always USE_OF from now on
In-Reply-To: <cover.1417103399.git.nicolas.ferre@atmel.com>
References: <cover.1417103399.git.nicolas.ferre@atmel.com>
Message-ID: <37d9512335b5e41fbac498536faa9b2790703e19.1417103399.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we always use Device Tree now, we can add the configuration here.
Also remove the condition for PINCTRL_AT91.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 89c4b5ccc68d..28f320589aa7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -376,7 +376,8 @@ config ARCH_AT91
 	select IRQ_DOMAIN
 	select NEED_MACH_IO_H if PCCARD
 	select PINCTRL
-	select PINCTRL_AT91 if USE_OF
+	select PINCTRL_AT91
+	select USE_OF
 	help
 	  This enables support for systems based on Atmel
 	  AT91RM9200 and AT91SAM9* processors.
-- 
2.1.3
