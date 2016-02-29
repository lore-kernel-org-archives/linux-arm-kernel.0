From: david@lechnology.com (David Lechner)
Date: Mon, 29 Feb 2016 16:33:24 -0600
Subject: [PATCH 1/3] arm: davinci: simplify call to of populate
In-Reply-To: <1456785206-2280-1-git-send-email-david@lechnology.com>
References: <1456785206-2280-1-git-send-email-david@lechnology.com>
Message-ID: <1456785206-2280-2-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Take advantage of of_platoform_default_populate convience function.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/da8xx-dt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index c4b5808..358ab34 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -54,9 +54,7 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 
 static void __init da850_init_machine(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table,
-			     da850_auxdata_lookup, NULL);
-
+	of_platform_default_populate(NULL, da850_auxdata_lookup, NULL);
 }
 
 static const char *const da850_boards_compat[] __initconst = {
-- 
1.9.1
