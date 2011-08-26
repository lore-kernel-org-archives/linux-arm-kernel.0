From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Fri, 26 Aug 2011 16:21:58 -0300
Subject: [PATCH 2/5] ARM: mx53: Register gpc_dvfs clock
In-Reply-To: <1314386521-29351-1-git-send-email-fabio.estevam@freescale.com>
References: <1314386521-29351-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1314386521-29351-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpc_dvfs_clk is needed for entering low power mode.

Add support for it on MX53.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/clock-mx51-mx53.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 2b9bd1f..058fb42 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1513,6 +1513,7 @@ static struct clk_lookup mx53_lookups[] = {
 	_REGISTER_CLOCK("imx-ssi.2", NULL, ssi3_clk)
 	_REGISTER_CLOCK("imx-keypad", NULL, dummy_clk)
 	_REGISTER_CLOCK("pata_imx", NULL, pata_clk)
+	_REGISTER_CLOCK(NULL, "gpc_dvfs", gpc_dvfs_clk)
 };
 
 static void clk_tree_init(void)
-- 
1.6.0.4
