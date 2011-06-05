From: nsekhar@ti.com (Sekhar Nori)
Date: Sun, 5 Jun 2011 17:38:42 +0530
Subject: [PATCH] davinci: make PCM platform devices static
Message-ID: <b6a445acd3407e085b564a1efea6d903dda80f3f.1307274978.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the PCM device structures used in devices.c
and devices-da8xx.c static as they are used only
in the respective files.

This was found when trying to build a single image
for DaVinci and DA8x devices using runtime P2V support.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/devices-da8xx.c |    2 +-
 arch/arm/mach-davinci/devices.c       |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 87aa19e..8c3cdc1 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -496,7 +496,7 @@ static struct platform_device da850_mcasp_device = {
 	.resource	= da850_mcasp_resources,
 };
 
-struct platform_device davinci_pcm_device = {
+static struct platform_device davinci_pcm_device = {
 	.name	= "davinci-pcm-audio",
 	.id	= -1,
 };
diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
index 8f4f736..806a2f0 100644
--- a/arch/arm/mach-davinci/devices.c
+++ b/arch/arm/mach-davinci/devices.c
@@ -298,7 +298,7 @@ static void davinci_init_wdt(void)
 
 /*-------------------------------------------------------------------------*/
 
-struct platform_device davinci_pcm_device = {
+static struct platform_device davinci_pcm_device = {
 	.name		= "davinci-pcm-audio",
 	.id		= -1,
 };
-- 
1.7.3.2
