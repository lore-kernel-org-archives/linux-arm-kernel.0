From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 11 Sep 2014 09:57:26 +0900
Subject: [PATCH 4/5] ARM: shmobile: r8a7740: Clean up pm domain table
In-Reply-To: <cover.1410395620.git.horms+renesas@verge.net.au>
References: <cover.1410395620.git.horms+renesas@verge.net.au>
Message-ID: <753490991fd5036fa4f31de7bc5dd7131ed44cc2.1410395620.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

  - Sort pm domains by bit_shift value,
  - Combine closing and opening curly braces on a single line, as the
    table will grow much bigger soon.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/pm-r8a7740.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index a0d44d5..3d50714 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -34,23 +34,21 @@ static int r8a7740_pd_a3sp_suspend(void)
 
 static struct rmobile_pm_domain r8a7740_pm_domains[] = {
 	{
+		.genpd.name	= "A4LC",
+		.bit_shift	= 1,
+	}, {
 		.genpd.name	= "A4S",
 		.bit_shift	= 10,
 		.gov		= &pm_domain_always_on_gov,
 		.no_debug	= true,
 		.suspend	= r8a7740_pd_a4s_suspend,
-	},
-	{
+	}, {
 		.genpd.name	= "A3SP",
 		.bit_shift	= 11,
 		.gov		= &pm_domain_always_on_gov,
 		.no_debug	= true,
 		.suspend	= r8a7740_pd_a3sp_suspend,
 	},
-	{
-		.genpd.name	= "A4LC",
-		.bit_shift	= 1,
-	},
 };
 
 void __init r8a7740_init_pm_domains(void)
-- 
2.0.1
