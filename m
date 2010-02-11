From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 11 Feb 2010 08:37:39 +0200
Subject: [PATCH] imxfb: add support for i.MX25
In-Reply-To: <20100210162942.GA15883@pengutronix.de>
References: <20100210162942.GA15883@pengutronix.de>
Message-ID: <855e977f1f610de9d409602da41ed3e191e7e613.1265869827.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/Kconfig |    1 +
 drivers/video/Kconfig     |    5 ++++-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index 8b0a1ee..2a049df 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -24,6 +24,7 @@ config ARCH_MX25
 	bool "MX25-based"
 	select CPU_ARM926T
 	select COMMON_CLKDEV
+	select HAVE_FB_IMX
 	help
 	  This enables support for systems based on the Freescale i.MX25 family
 
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 5a5c303..83d40ed 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -400,9 +400,12 @@ config FB_SA1100
 	  If you plan to use the LCD display with your SA-1100 system, say
 	  Y here.
 
+config HAVE_FB_IMX
+	bool
+
 config FB_IMX
 	tristate "Motorola i.MX LCD support"
-	depends on FB && (ARCH_MX1 || ARCH_MX2)
+	depends on FB && (HAVE_FB_IMX || ARCH_MX1 || ARCH_MX2)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
1.6.6.1
