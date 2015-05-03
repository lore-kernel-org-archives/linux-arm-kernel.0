From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun,  3 May 2015 21:15:09 +0300
Subject: [PATCH 2/3] ARM: s3c24xx: Add DMA resources for SDI and I2S
In-Reply-To: <1430676910-30657-1-git-send-email-anarsoul@gmail.com>
References: <1430676910-30657-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1430676910-30657-2-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/plat-samsung/devs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 83c7d15..62edcab 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -564,6 +564,8 @@ void __init s3c_i2c7_set_platdata(struct s3c2410_platform_i2c *pd)
 #ifdef CONFIG_PLAT_S3C24XX
 static struct resource s3c_iis_resource[] = {
 	[0] = DEFINE_RES_MEM(S3C24XX_PA_IIS, S3C24XX_SZ_IIS),
+	[1] = DEFINE_RES_DMA(DMACH_I2S_OUT),
+	[2] = DEFINE_RES_DMA(DMACH_I2S_IN),
 };
 
 struct platform_device s3c_device_iis = {
@@ -863,6 +865,7 @@ struct platform_device s3c_device_rtc = {
 static struct resource s3c_sdi_resource[] = {
 	[0] = DEFINE_RES_MEM(S3C24XX_PA_SDI, S3C24XX_SZ_SDI),
 	[1] = DEFINE_RES_IRQ(IRQ_SDI),
+	[2] = DEFINE_RES_DMA(DMACH_SDI),
 };
 
 struct platform_device s3c_device_sdi = {
-- 
2.3.5
