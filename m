From: simon.guinot@sequanux.org (Simon Guinot)
Date: Fri,  2 Aug 2013 23:34:34 +0200
Subject: [PATCH] leds: leds-netxbig: depends on ARCH_KIRKWOOD
In-Reply-To: <1375369655-1310-8-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375369655-1310-8-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1375479274-9942-1-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the DT conversion, the board Kconfig symbols MACH_ are going to be
removed. In order to prepare this removal, this patch replaces alls the
machines dependencies for leds-netxbig by ARCH_KIRKWOOD.

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
---
Thomas,

Please, insert this patch in your series before the patch named:
[PATCHv2 7/9] ARM: kirkwood: convert LaCie Net{2, 5}Big v2 platforms to DT

Simon

 drivers/leds/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 0e41460..7226696 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -407,8 +407,8 @@ config LEDS_NS2
 
 config LEDS_NETXBIG
 	tristate "LED support for Big Network series LEDs"
-	depends on MACH_NET2BIG_V2 || MACH_NET5BIG_V2
 	depends on LEDS_CLASS
+	depends on ARCH_KIRKWOOD
 	default y
 	help
 	  This option enable support for LEDs found on the LaCie 2Big
-- 
1.7.10.4
