From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 14 Dec 2010 19:05:05 +0100
Subject: [PATCH] ARM: pxa: PXA_ESERIES depends on FB_W100.
Message-ID: <20101214180505.GL15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As arch/arm/mach-pxa/eseries.c references w100fb_gpio_{read,write}()
directly.

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index dd235ec..c93e73d 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -540,6 +540,7 @@ config MACH_ICONTROL
 config ARCH_PXA_ESERIES
 	bool "PXA based Toshiba e-series PDAs"
 	select PXA25x
+	select FB_W100
 
 config MACH_E330
 	bool "Toshiba e330"
