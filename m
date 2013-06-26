From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 26 Jun 2013 16:52:25 +0200
Subject: [PATCH 1/3] ARM: mxs: Simplify detection of CrystalFontz boards
In-Reply-To: <1372258347-18422-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1372258347-18422-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1372258347-18422-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As all CrystalFontz boards are compatible with "crystalfontz,cfa10036", make it
easier to add future boards.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-mxs/mach-mxs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 77280c6..8be23cb 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -363,10 +363,7 @@ static void __init mxs_machine_init(void)
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
