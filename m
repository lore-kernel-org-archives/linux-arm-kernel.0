From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 25 Apr 2012 09:42:43 +0530
Subject: [PATCH 33/33] ARM: S5PV210: mach-smdkv210: Use common macro to define
 resources
In-Reply-To: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
References: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1335327163-11794-34-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/mach-s5pv210/mach-smdkv210.c |   19 ++++---------------
 1 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index 91d4ad8..fa1b612 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -119,21 +119,10 @@ static struct samsung_keypad_platdata smdkv210_keypad_data __initdata = {
 };
 
 static struct resource smdkv210_dm9000_resources[] = {
-	[0] = {
-		.start	= S5PV210_PA_SROM_BANK5,
-		.end	= S5PV210_PA_SROM_BANK5,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= S5PV210_PA_SROM_BANK5 + 2,
-		.end	= S5PV210_PA_SROM_BANK5 + 2,
-		.flags	= IORESOURCE_MEM,
-	},
-	[2] = {
-		.start	= IRQ_EINT(9),
-		.end	= IRQ_EINT(9),
-		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
-	},
+	[0] = DEFINE_RES_MEM(S5PV210_PA_SROM_BANK5, 1),
+	[1] = DEFINE_RES_MEM(S5PV210_PA_SROM_BANK5 + 2, 1),
+	[2] = DEFINE_RES_NAMED(IRQ_EINT(9), 1, NULL, IORESOURCE_IRQ \
+				| IORESOURCE_IRQ_HIGHLEVEL),
 };
 
 static struct dm9000_plat_data smdkv210_dm9000_platdata = {
-- 
1.7.4.1
