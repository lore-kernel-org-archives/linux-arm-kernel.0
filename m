From: jhnikula@gmail.com (Jarkko Nikula)
Date: Tue, 21 Dec 2010 19:25:34 +0200
Subject: [PATCH 1/2] omap: rx51: Cleanup vdds_sdi supply construction
In-Reply-To: <1292952335-21314-1-git-send-email-jhnikula@gmail.com>
References: <1292952335-21314-1-git-send-email-jhnikula@gmail.com>
Message-ID: <1292952335-21314-2-git-send-email-jhnikula@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is much more cleaner to use REGULATOR_SUPPLY macro and a device name
instead of having a reference to rx51_display_device.dev with #if defined()
guards.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   11 +----------
 1 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index fd95ccf..768f0dc 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -359,17 +359,8 @@ static struct regulator_consumer_supply rx51_vio_supplies[] = {
 	REGULATOR_SUPPLY("DVDD", "2-0019"),
 };
 
-#if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
-extern struct platform_device rx51_display_device;
-#endif
-
 static struct regulator_consumer_supply rx51_vaux1_consumers[] = {
-#if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
-	{
-		.supply	= "vdds_sdi",
-		.dev	= &rx51_display_device.dev,
-	},
-#endif
+	REGULATOR_SUPPLY("vdds_sdi", "omapdss"),
 };
 
 static struct regulator_init_data rx51_vaux1 = {
-- 
1.7.2.3
