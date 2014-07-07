From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon,  7 Jul 2014 22:23:22 +0200
Subject: [PATCHv2 05/32] ARM: at91: move at91rm9200 SoC to the CCF
In-Reply-To: <1404764629-29136-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1404764629-29136-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1404764629-29136-6-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes the selection of AT91_USE_OLD_CLK when selecting at91rm9200
SoC support. This will automatically enable COMMON_CLK_AT91 option and add
support for at91 common clk implementation.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 arch/arm/mach-at91/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 45b55e0f0db6..c818136a74b8 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -113,7 +113,6 @@ config SOC_AT91RM9200
 	select HAVE_AT91_DBGU0
 	select MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
-	select AT91_USE_OLD_CLK
 	select HAVE_AT91_USB_CLK
 
 config SOC_AT91SAM9260
-- 
1.9.1
