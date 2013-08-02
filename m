From: simon.guinot@sequanux.org (Simon Guinot)
Date: Fri,  2 Aug 2013 16:46:38 +0200
Subject: [PATCH] leds: leds-ns2: depends on ARCH_KIRKWOOD
In-Reply-To: <1375369655-1310-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375369655-1310-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1375454798-6849-1-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the DT conversion, the board Kconfig symbols MACH_ are going to be
removed. In order to prepare this removal, this patch replaces alls the
machines dependencies for leds-ns2 by ARCH_KIRKWOOD.

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
---
Thomas,

Please, insert this patch in your series before the patch named:
[PATCHv2 1/9] ARM: kirkwood: convert d2net_v2 to DT

Simon

 drivers/leds/Kconfig |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index e43402d..0e41460 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -398,10 +398,7 @@ config LEDS_MC13783
 config LEDS_NS2
 	tristate "LED support for Network Space v2 GPIO LEDs"
 	depends on LEDS_CLASS
-	depends on MACH_NETSPACE_V2 || MACH_INETSPACE_V2 || \
-		   MACH_NETSPACE_MAX_V2 || MACH_D2NET_V2 || \
-		   MACH_NETSPACE_V2_DT || MACH_INETSPACE_V2_DT || \
-		   MACH_NETSPACE_MAX_V2_DT || MACH_NETSPACE_MINI_V2_DT
+	depends on ARCH_KIRKWOOD
 	default y
 	help
 	  This option enable support for the dual-GPIO LED found on the
-- 
1.7.10.4
