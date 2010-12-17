From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 17 Dec 2010 14:00:15 +0900
Subject: [PATCH 15/17] ARM: S5PV310: Add AC97 support for SMDK
In-Reply-To: <1292561925-19586-1-git-send-email-jassisinghbrar@gmail.com>
References: <1292561925-19586-1-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <1292562015-20068-1-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Enable AC97 audio device on SMDKV310 and SMDKC210.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5pv310/mach-smdkc210.c |    2 ++
 arch/arm/mach-s5pv310/mach-smdkv310.c |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv310/mach-smdkc210.c b/arch/arm/mach-s5pv310/mach-smdkc210.c
index 2b8d4fc..c90d136 100644
--- a/arch/arm/mach-s5pv310/mach-smdkc210.c
+++ b/arch/arm/mach-s5pv310/mach-smdkc210.c
@@ -147,6 +147,8 @@ static struct platform_device *smdkc210_devices[] __initdata = {
 	&s3c_device_rtc,
 	&s3c_device_wdt,
 	&smdkc210_smsc911x,
+	&samsung_asoc_dma,
+	&s5pv310_device_ac97,
 };
 
 static void __init smdkc210_smsc911x_init(void)
diff --git a/arch/arm/mach-s5pv310/mach-smdkv310.c b/arch/arm/mach-s5pv310/mach-smdkv310.c
index 35826d6..da79f7f 100644
--- a/arch/arm/mach-s5pv310/mach-smdkv310.c
+++ b/arch/arm/mach-s5pv310/mach-smdkv310.c
@@ -147,6 +147,8 @@ static struct platform_device *smdkv310_devices[] __initdata = {
 	&s3c_device_rtc,
 	&s3c_device_wdt,
 	&smdkv310_smsc911x,
+	&samsung_asoc_dma,
+	&s5pv310_device_ac97,
 };
 
 static void __init smdkv310_smsc911x_init(void)
-- 
1.6.2.5
