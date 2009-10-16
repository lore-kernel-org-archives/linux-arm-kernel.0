From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:08 -0700
Subject: [PATCH 04/46] davinci: Move DA8xx/OMAP-L13x emac register routine
In-Reply-To: <1255720190-7452-5-git-send-email-khilman@deeprootsystems.com>
References: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-2-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-4-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-5-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-6-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark A. Greer <mgreer@mvista.com>

Some mcasp code was inserted between the emac resource setup
and the related register routine that registers the emac.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/devices-da8xx.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 58ad5b6..94ce7a1 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -282,6 +282,11 @@ static struct platform_device da8xx_emac_device = {
 	.resource	= da8xx_emac_resources,
 };
 
+int __init da8xx_register_emac(void)
+{
+	return platform_device_register(&da8xx_emac_device);
+}
+
 static struct resource da830_mcasp1_resources[] = {
 	{
 		.name	= "mcasp1",
@@ -338,11 +343,6 @@ static struct platform_device da850_mcasp_device = {
 	.resource	= da850_mcasp_resources,
 };
 
-int __init da8xx_register_emac(void)
-{
-	return platform_device_register(&da8xx_emac_device);
-}
-
 void __init da8xx_init_mcasp(int id, struct snd_platform_data *pdata)
 {
 	/* DA830/OMAP-L137 has 3 instances of McASP */
-- 
1.6.4.3
