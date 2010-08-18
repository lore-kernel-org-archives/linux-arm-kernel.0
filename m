From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 18 Aug 2010 23:01:18 +0900
Subject: [PATCH 08/14] ARM: S5PV310: Adds enable and ctrlbit for clk_vpllsrc
In-Reply-To: <1282140084-10265-1-git-send-email-kgene.kim@samsung.com>
References: <1282140084-10265-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1282140084-10265-9-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jongpill Lee <boyko.lee@samsung.com>

This patch adds enable and ctrlbit for struct clksrc_clk clk_vpllsrc

Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv310/clock.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv310/clock.c b/arch/arm/mach-s5pv310/clock.c
index cc583c1..c3ee742 100644
--- a/arch/arm/mach-s5pv310/clock.c
+++ b/arch/arm/mach-s5pv310/clock.c
@@ -46,6 +46,11 @@ static struct clk clk_sclk_usbphy1 = {
 	.id		= -1,
 };
 
+static int s5pv310_clksrc_mask_top_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P_CLKSRC_MASK_TOP, clk, enable);
+}
+
 /* Core list of CMU_CPU side */
 
 static struct clksrc_clk clk_mout_apll = {
@@ -216,6 +221,8 @@ static struct clksrc_clk clk_vpllsrc = {
 	.clk	= {
 		.name		= "vpll_src",
 		.id		= -1,
+		.enable		= s5pv310_clksrc_mask_top_ctrl,
+		.ctrlbit	= (1 << 0),
 	},
 	.sources	= &clkset_vpllsrc,
 	.reg_src	= { .reg = S5P_CLKSRC_TOP1, .shift = 0, .size = 1 },
-- 
1.6.2.5
