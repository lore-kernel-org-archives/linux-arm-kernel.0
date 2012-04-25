From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 25 Apr 2012 09:42:14 +0530
Subject: [PATCH 04/33] ARM: EXYNOS: mach-armlex4210: Use common macro to
 define resources
In-Reply-To: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
References: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1335327163-11794-5-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/mach-exynos/mach-armlex4210.c |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-armlex4210.c b/arch/arm/mach-exynos/mach-armlex4210.c
index 6ab171c..372e331 100644
--- a/arch/arm/mach-exynos/mach-armlex4210.c
+++ b/arch/arm/mach-exynos/mach-armlex4210.c
@@ -118,16 +118,9 @@ static void __init armlex4210_wlan_init(void)
 }
 
 static struct resource armlex4210_smsc911x_resources[] = {
-	[0] = {
-		.start	= EXYNOS4_PA_SROM_BANK(3),
-		.end	= EXYNOS4_PA_SROM_BANK(3) + SZ_64K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_EINT(27),
-		.end	= IRQ_EINT(27),
-		.flags	= IORESOURCE_IRQ | IRQF_TRIGGER_HIGH,
-	},
+	[0] = DEFINE_RES_MEM(EXYNOS4_PA_SROM_BANK(3), SZ_64K),
+	[1] = DEFINE_RES_NAMED(IRQ_EINT(27), 1, NULL, IORESOURCE_IRQ \
+					| IRQF_TRIGGER_HIGH),
 };
 
 static struct smsc911x_platform_config smsc9215_config = {
-- 
1.7.4.1
