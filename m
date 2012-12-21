From: mgreer@animalcreek.com (Mark A. Greer)
Date: Fri, 21 Dec 2012 09:28:13 -0700
Subject: [PATCH 13/15] ARM: AM33XX: Add aes0 crypto clock data
In-Reply-To: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
References: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
Message-ID: <1356107295-11121-14-git-send-email-mgreer@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Mark A. Greer" <mgreer@animalcreek.com>

Add clock data for for the SHA0 crypto module
on the am33xx SoC.

CC: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 arch/arm/mach-omap2/cclock33xx_data.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-omap2/cclock33xx_data.c b/arch/arm/mach-omap2/cclock33xx_data.c
index 56d6755..ca8e6cb 100644
--- a/arch/arm/mach-omap2/cclock33xx_data.c
+++ b/arch/arm/mach-omap2/cclock33xx_data.c
@@ -416,6 +416,10 @@ static struct clk sha0_fck;
 DEFINE_STRUCT_CLK_HW_OMAP(sha0_fck, NULL);
 DEFINE_STRUCT_CLK(sha0_fck, dpll_core_ck_parents, clk_ops_null);
 
+static struct clk aes0_fck;
+DEFINE_STRUCT_CLK_HW_OMAP(aes0_fck, NULL);
+DEFINE_STRUCT_CLK(aes0_fck, dpll_core_ck_parents, clk_ops_null);
+
 /*
  * Modules clock nodes
  *
@@ -881,6 +885,7 @@ static struct omap_clk am33xx_clks[] = {
 	CLK(NULL,	"smartreflex0_fck",	&smartreflex0_fck,	CK_AM33XX),
 	CLK(NULL,	"smartreflex1_fck",	&smartreflex1_fck,	CK_AM33XX),
 	CLK(NULL,	"sha0_fck",		&sha0_fck,	CK_AM33XX),
+	CLK(NULL,	"aes0_fck",		&aes0_fck,	CK_AM33XX),
 	CLK(NULL,	"timer1_fck",		&timer1_fck,	CK_AM33XX),
 	CLK(NULL,	"timer2_fck",		&timer2_fck,	CK_AM33XX),
 	CLK(NULL,	"timer3_fck",		&timer3_fck,	CK_AM33XX),
-- 
1.7.12
