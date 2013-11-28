From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 28 Nov 2013 17:54:45 +0900
Subject: [PATCH 15/16] ARM: shmobile: r7s72100: tidyup clock table order
In-Reply-To: <cover.1385628709.git.horms+renesas@verge.net.au>
References: <cover.1385628709.git.horms+renesas@verge.net.au>
Message-ID: <204aa273a7b7f2861ecc592c1fd722e7b51b6134.1385628709.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

SuperH lookups clock is using CLKDEV_CON/DEV/ICK_ID() macro
for a long term.
But in these days, the ICK clock is defined in random place.
This patch arranges it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r7s72100.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r7s72100.c b/arch/arm/mach-shmobile/clock-r7s72100.c
index 4aba20c..0814a50 100644
--- a/arch/arm/mach-shmobile/clock-r7s72100.c
+++ b/arch/arm/mach-shmobile/clock-r7s72100.c
@@ -170,6 +170,9 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("cpu_clk", &div4_clks[DIV4_I]),
 
 	/* MSTP clocks */
+	CLKDEV_CON_ID("mtu2_fck", &mstp_clks[MSTP33]),
+
+	/* ICK */
 	CLKDEV_ICK_ID("sci_fck", "sh-sci.0", &mstp_clks[MSTP47]),
 	CLKDEV_ICK_ID("sci_fck", "sh-sci.1", &mstp_clks[MSTP46]),
 	CLKDEV_ICK_ID("sci_fck", "sh-sci.2", &mstp_clks[MSTP45]),
-- 
1.8.4
