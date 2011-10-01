From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Oct 2011 22:03:41 +0200
Subject: [PATCH 09/26] ARM: pxa: export symbols from pxa3xx-ulpi
In-Reply-To: <1317499438-14058-1-git-send-email-arnd@arndb.de>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
Message-ID: <1317499438-14058-10-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pxa3xx_u2d_start_hc/pxa3xx_u2d_stop_hc symbols are used by the
ohci-pxa27x driver, which can be a module.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/pxa3xx-ulpi.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa3xx-ulpi.c b/arch/arm/mach-pxa/pxa3xx-ulpi.c
index ce7168b..e28dfb8 100644
--- a/arch/arm/mach-pxa/pxa3xx-ulpi.c
+++ b/arch/arm/mach-pxa/pxa3xx-ulpi.c
@@ -265,6 +265,7 @@ int pxa3xx_u2d_start_hc(struct usb_bus *host)
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(pxa3xx_u2d_start_hc);
 
 void pxa3xx_u2d_stop_hc(struct usb_bus *host)
 {
@@ -277,6 +278,7 @@ void pxa3xx_u2d_stop_hc(struct usb_bus *host)
 
 	clk_disable(u2d->clk);
 }
+EXPORT_SYMBOL_GPL(pxa3xx_u2d_stop_hc);
 
 static int pxa3xx_u2d_probe(struct platform_device *pdev)
 {
-- 
1.7.5.4
