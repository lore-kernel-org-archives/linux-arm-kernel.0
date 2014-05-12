From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Mon, 12 May 2014 18:23:37 +0200
Subject: [PATCH v2 4/4] ARM: at91: move sam9x5 SoCs to the CCF
In-Reply-To: <1399911817-4980-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1399911817-4980-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1399911817-4980-5-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes the selection of AT91_USE_OLD_CLK when selecting
sam9x5 SoCs support. This will automatically enable COMMON_CLK_AT91 option
and add support for at91 common clk implementation.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index a1ac430..45b55e0 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -167,7 +167,6 @@ config SOC_AT91SAM9X5
 	select HAVE_AT91_DBGU0
 	select HAVE_FB_ATMEL
 	select SOC_AT91SAM9
-	select AT91_USE_OLD_CLK
 	select HAVE_AT91_UTMI
 	select HAVE_AT91_SMD
 	select HAVE_AT91_USB_CLK
-- 
1.8.3.2
