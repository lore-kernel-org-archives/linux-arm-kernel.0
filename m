From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 27 Sep 2010 15:50:38 +0200
Subject: [PATCH 02/40] ARM: imx: ehci: use void __iomem * to hold i/o addresses
In-Reply-To: <20100927135009.GC6271@pengutronix.de>
References: <20100927135009.GC6271@pengutronix.de>
Message-ID: <1285595476-10025-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes:

	arch/arm/plat-mxc/ehci.c: In function 'mxc_initialize_usb_hw':
	arch/arm/plat-mxc/ehci.c:260: warning: assignment makes integer from pointer without a cast
	arch/arm/plat-mxc/ehci.c:263: warning: assignment makes integer from pointer without a cast
	arch/arm/plat-mxc/ehci.c:270: warning: assignment makes integer from pointer without a cast

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/ehci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/ehci.c b/arch/arm/plat-mxc/ehci.c
index 35a064f..9915607 100644
--- a/arch/arm/plat-mxc/ehci.c
+++ b/arch/arm/plat-mxc/ehci.c
@@ -249,8 +249,8 @@ int mxc_initialize_usb_hw(int port, unsigned int flags)
 #ifdef CONFIG_ARCH_MX51
 	if (cpu_is_mx51()) {
 		void __iomem *usb_base;
-		u32 usbotg_base;
-		u32 usbother_base;
+		void __iomem *usbotg_base;
+		void __iomem *usbother_base;
 		int ret = 0;
 
 		usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
-- 
1.7.2.3
