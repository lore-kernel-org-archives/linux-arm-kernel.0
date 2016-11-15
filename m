From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 15 Nov 2016 11:54:21 -0800
Subject: [PATCH v2 3/3] ARM: davinci: PM: support da8xx DT platforms
In-Reply-To: <20161115195421.19983-1-khilman@baylibre.com>
References: <20161115195421.19983-1-khilman@baylibre.com>
Message-ID: <20161115195421.19983-4-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm/mach-davinci/da8xx-dt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index c9f7e9274aa8..aed44dcdfd30 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -46,6 +46,7 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 static void __init da850_init_machine(void)
 {
 	of_platform_default_populate(NULL, da850_auxdata_lookup, NULL);
+	davinci_pm_init();
 }
 
 static const char *const da850_boards_compat[] __initconst = {
-- 
2.9.3
