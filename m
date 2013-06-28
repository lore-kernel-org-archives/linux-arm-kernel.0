From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 28 Jun 2013 15:02:50 +0200
Subject: [PATCHv3 1/8] ARM: mxs: Simplify detection of CrystalFontz boards
In-Reply-To: <1372424577-8279-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1372424577-8279-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1372424577-8279-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As all CrystalFontz boards are compatible with "crystalfontz,cfa10036", make it
easier to add future boards.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-mxs/mach-mxs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 6298adb..1b8c274 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -478,10 +478,7 @@ static void __init mxs_machine_init(void)
 		imx28_evk_init();
 	else if (of_machine_is_compatible("bluegiga,apx4devkit"))
 		apx4devkit_init();
-	else if (of_machine_is_compatible("crystalfontz,cfa10037") ||
-		 of_machine_is_compatible("crystalfontz,cfa10049") ||
-		 of_machine_is_compatible("crystalfontz,cfa10055") ||
-		 of_machine_is_compatible("crystalfontz,cfa10057"))
+	else if (of_machine_is_compatible("crystalfontz,cfa10036"))
 		crystalfontz_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table,
-- 
1.8.1.2
