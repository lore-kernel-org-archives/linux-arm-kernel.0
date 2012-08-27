From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Mon, 27 Aug 2012 18:56:40 +0530
Subject: [PATCH V2 2/6] ARM: Davinci: Remove references to davinci pcm
In-Reply-To: <1346074004-22172-1-git-send-email-gururaja.hebbar@ti.com>
References: <1346074004-22172-1-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <1346074004-22172-3-git-send-email-gururaja.hebbar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since davinci-pcm is no more a platform_driver but helper to register
"platform" pcm driver, remove  davinci-pcm device registration

Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
---
Changes from V1:
	- New Commit. 

:100644 100644 783eab6... 4735d64... M	arch/arm/mach-davinci/devices-da8xx.c
:100644 100644 d2f96662.. 70056fb... M	arch/arm/mach-davinci/devices.c
 arch/arm/mach-davinci/devices-da8xx.c |    7 -------
 arch/arm/mach-davinci/devices.c       |   11 -----------
 2 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 783eab6..4735d64 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -505,15 +505,8 @@ static struct platform_device da850_mcasp_device = {
 	.resource	= da850_mcasp_resources,
 };
 
-static struct platform_device davinci_pcm_device = {
-	.name	= "davinci-pcm-audio",
-	.id	= -1,
-};
-
 void __init da8xx_register_mcasp(int id, struct snd_platform_data *pdata)
 {
-	platform_device_register(&davinci_pcm_device);
-
 	/* DA830/OMAP-L137 has 3 instances of McASP */
 	if (cpu_is_davinci_da830() && id == 1) {
 		da830_mcasp1_device.dev.platform_data = pdata;
diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
index d2f9666..70056fb 100644
--- a/arch/arm/mach-davinci/devices.c
+++ b/arch/arm/mach-davinci/devices.c
@@ -313,16 +313,6 @@ static void davinci_init_wdt(void)
 
 /*-------------------------------------------------------------------------*/
 
-static struct platform_device davinci_pcm_device = {
-	.name		= "davinci-pcm-audio",
-	.id		= -1,
-};
-
-static void davinci_init_pcm(void)
-{
-	platform_device_register(&davinci_pcm_device);
-}
-
 /*-------------------------------------------------------------------------*/
 
 struct davinci_timer_instance davinci_timer_instance[2] = {
@@ -345,7 +335,6 @@ static int __init davinci_init_devices(void)
 	/* please keep these calls, and their implementations above,
 	 * in alphabetical order so they're easier to sort through.
 	 */
-	davinci_init_pcm();
 	davinci_init_wdt();
 
 	return 0;
-- 
1.7.1
