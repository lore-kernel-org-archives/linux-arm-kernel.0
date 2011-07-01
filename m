From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  1 Jul 2011 11:46:34 +0200
Subject: [RFC PATCH 3/3] ARM: imx/mx31moboard: remove obsolete baseboard
	handling
In-Reply-To: <1309513594-31016-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110701094403.GT11559@pengutronix.de>
	<1309513594-31016-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1309513594-31016-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/mach-mx31moboard.c |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index 802595b..6681de4 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -517,16 +517,6 @@ static const struct baseboard_entry
 	},
 };
 
-static const char *baseboardnames[] = {
-	"",
-	"devboard",
-	"marxbot",
-	"smartbot",
-	"eyebot",
-};
-static int mx31moboard_baseboard;
-core_param(mx31moboard_baseboard, mx31moboard_baseboard, int, 0444);
-
 /*
  * Board specific initialization.
  */
@@ -559,12 +549,6 @@ static void __init mx31moboard_init(void)
 
 	moboard_usbh2_init();
 
-	if (mx31moboard_baseboard > 0 &&
-			mx31moboard_baseboard < ARRAY_SIZE(baseboardnames)) {
-		pr_warn("mx31moboard_baseboard=<id> is deprecated, use baseboard=<fullname>\n");
-		baseboard_select(baseboardnames[mx31moboard_baseboard]);
-	}
-
 	baseboard_setup(mx31moboard_baseboard_map,
 			ARRAY_SIZE(mx31moboard_baseboard_map));
 }
-- 
1.7.5.3
