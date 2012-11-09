From: horms@verge.net.au (Simon Horman)
Date: Fri,  9 Nov 2012 16:29:25 +0900
Subject: [PATCH 10/10] ARM: shmobile: add fsi external clock sh7372
In-Reply-To: <1352446165-19298-1-git-send-email-horms@verge.net.au>
References: <1352446165-19298-1-git-send-email-horms@verge.net.au>
Message-ID: <1352446165-19298-11-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

xcka/xckb were required from FSI driver

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/clock-sh7372.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index bee2d05..4d57e34 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -606,6 +606,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("spu2", "sh_fsi2", &mstp_clks[MSTP223]),
 	CLKDEV_ICK_ID("diva", "sh_fsi2", &fsidivs[FSIDIV_A]),
 	CLKDEV_ICK_ID("divb", "sh_fsi2", &fsidivs[FSIDIV_B]),
+	CLKDEV_ICK_ID("xcka", "sh_fsi2", &sh7372_fsiack_clk),
+	CLKDEV_ICK_ID("xckb", "sh_fsi2", &sh7372_fsibck_clk),
 };
 
 void __init sh7372_clock_init(void)
-- 
1.7.10.4
