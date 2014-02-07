From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  7 Feb 2014 22:29:25 +0100
Subject: [PATCH v2 2/3] ARM: sunxi: Add the new watchog compatibles to the
 reboot code
In-Reply-To: <1391808566-31008-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1391808566-31008-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1391808566-31008-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the watchdog driver has new compatibles, we need to support them in
the machine reboot code.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-sunxi/sunxi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index aeea6ce..460b5a4 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -94,8 +94,8 @@ static void sun6i_restart(enum reboot_mode mode, const char *cmd)
 }
 
 static struct of_device_id sunxi_restart_ids[] = {
-	{ .compatible = "allwinner,sun4i-wdt" },
-	{ .compatible = "allwinner,sun6i-wdt" },
+	{ .compatible = "allwinner,sun4i-a10-wdt" },
+	{ .compatible = "allwinner,sun6i-a31-wdt" },
 	{ /*sentinel*/ }
 };
 
-- 
1.8.4.2
