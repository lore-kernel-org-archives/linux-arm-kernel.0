From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 27 Jan 2011 14:00:32 +0100
Subject: [PATCH 12/13] ARM i.MX51 cpuimx51: remove unnecessary
	CONFIG_SERIAL_8250 ifdefs
In-Reply-To: <1296133233-1062-1-git-send-email-s.hauer@pengutronix.de>
References: <1296133233-1062-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1296133233-1062-13-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx5/board-cpuimx51.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
index f8652ef..f576a97 100644
--- a/arch/arm/mach-mx5/board-cpuimx51.c
+++ b/arch/arm/mach-mx5/board-cpuimx51.c
@@ -60,7 +60,6 @@
 #define	MX51_USB_PLL_DIV_19_2_MHZ	0x01
 #define	MX51_USB_PLL_DIV_24_MHZ		0x02
 
-#if defined(CONFIG_SERIAL_8250) || defined(CONFIG_SERIAL_8250_MODULE)
 static struct plat_serial8250_port serial_platform_data[] = {
 	{
 		.mapbase = (unsigned long)(MX51_CS1_BASE_ADDR + 0x400000),
@@ -105,12 +104,9 @@ static struct platform_device serial_device = {
 		.platform_data = serial_platform_data,
 	},
 };
-#endif
 
 static struct platform_device *devices[] __initdata = {
-#if defined(CONFIG_SERIAL_8250) || defined(CONFIG_SERIAL_8250_MODULE)
 	&serial_device,
-#endif
 };
 
 static iomux_v3_cfg_t eukrea_cpuimx51_pads[] = {
-- 
1.7.2.3
