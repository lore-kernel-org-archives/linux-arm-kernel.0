From: horms@verge.net.au (Simon Horman)
Date: Fri,  9 Nov 2012 16:29:24 +0900
Subject: [PATCH 09/10] ARM: shmobile: add fsi external clock on r8a7740
In-Reply-To: <1352446165-19298-1-git-send-email-horms@verge.net.au>
References: <1352446165-19298-1-git-send-email-horms@verge.net.au>
Message-ID: <1352446165-19298-10-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

xcka/xckb were required from FSI driver

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7740.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index eb5dfee..eac49d5 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -625,6 +625,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("ickb", "sh_fsi2",	&div6_reparent_clks[DIV6_FSIB]),
 	CLKDEV_ICK_ID("diva", "sh_fsi2",	&fsidivs[FSIDIV_A]),
 	CLKDEV_ICK_ID("divb", "sh_fsi2",	&fsidivs[FSIDIV_B]),
+	CLKDEV_ICK_ID("xcka", "sh_fsi2",	&fsiack_clk),
+	CLKDEV_ICK_ID("xckb", "sh_fsi2",	&fsibck_clk),
 };
 
 void __init r8a7740_clock_init(u8 md_ck)
-- 
1.7.10.4
