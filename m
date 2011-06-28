From: christian.riesch@omicron.at (Christian Riesch)
Date: Tue, 28 Jun 2011 17:10:51 +0200
Subject: [PATCH v2] davinci: da850: add a .set_rate method to ref_clk
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D7939D4@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB593024D7939D4@dbde02.ent.ti.com>
Message-ID: <1309273851-9238-1-git-send-email-christian.riesch@omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allows setting the input clock frequency of the SoC from
the board specific code using the davinci_set_refclk_rate function.

Suggested-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: Christian Riesch <christian.riesch@omicron.at>
---

v2: fixed the commit message and indentation.
Regards, Christian

 arch/arm/mach-davinci/da850.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 133aac4..27fe3ac 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -58,6 +58,7 @@ static struct pll_data pll0_data = {
 static struct clk ref_clk = {
 	.name		= "ref_clk",
 	.rate		= DA850_REF_FREQ,
+	.set_rate	= davinci_simple_set_rate,
 };
 
 static struct clk pll0_clk = {
-- 
1.7.0.4
