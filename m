From: tony@atomide.com (Tony Lindgren)
Date: Tue, 6 Mar 2012 11:47:48 -0800
Subject: [PATCH] ARM: OMAP2+: Fix omap24xx_io_desc warning if SoC subtypes
 are not selected
Message-ID: <20120306194748.GU12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise we get the following warning:

arch/arm/mach-omap2/io.c:53:24: warning:
'omap24xx_io_desc' defined but not used [-Wunused-variable]

Reported-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -49,7 +49,7 @@
  * default mapping provided here.
  */
 
-#ifdef CONFIG_ARCH_OMAP2
+#if defined(CONFIG_SOC_OMAP2420) || defined(CONFIG_SOC_OMAP2430)
 static struct map_desc omap24xx_io_desc[] __initdata = {
 	{
 		.virtual	= L3_24XX_VIRT,
