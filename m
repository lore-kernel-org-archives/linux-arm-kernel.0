From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Jun 2017 00:31:17 -0700
Subject: [PATCH 6/7] ARM: debug: Update port descriptions for omap variants
In-Reply-To: <20170614073118.28246-1-tony@atomide.com>
References: <20170614073118.28246-1-tony@atomide.com>
Message-ID: <20170614073118.28246-7-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks like we're still missing omap4-sdk naming that Russell
already pointed out long time ago. And we're also missing
am437x that works with the am335x port. And omap5-uevm naming
is wrong.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/Kconfig.debug | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -671,7 +671,7 @@ choice
 		  and 3517evm.
 
 	config DEBUG_OMAP4UART3
-		bool "Kernel low-level debugging messages via OMAP4/5 UART3 (omap4 blaze, panda, omap5 sevm)"
+		bool "Kernel low-level debugging messages via OMAP4/5 UART3 (omap4-evm, blaze, panda, omap5-uevm)"
 		depends on ARCH_OMAP2PLUS
 		select DEBUG_UART_8250
 
@@ -725,7 +725,7 @@ choice
 		select DEBUG_UART_8250
 
 	config DEBUG_AM33XXUART1
-		bool "Kernel low-level debugging messages via AM33XX UART1"
+		bool "Kernel low-level debugging messages via AM33XX/AM437X UART1"
 		depends on ARCH_OMAP2PLUS
 		select DEBUG_UART_8250
 
-- 
2.13.0
