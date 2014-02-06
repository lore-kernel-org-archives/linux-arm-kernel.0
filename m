From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:21:09 +0900
Subject: [PATCH 12/13] ARM: shmobile: r7s72100: really add i2c clocks
In-Reply-To: <cover.1391666228.git.horms+renesas@verge.net.au>
References: <cover.1391666228.git.horms+renesas@verge.net.au>
Message-ID: <3440cb28627d7fbaf25c0d60cb9c6cf6d66d61ad.1391666228.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

Due to a merge conflict, addition of the clocks was lost. Tested with
RIIC2 on a genmai board. Others untested but hopefully trivial enough to
be added.

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
[horms+renesas at verge.net.au: Capitalised "ARM" in subject]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r7s72100.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r7s72100.c b/arch/arm/mach-shmobile/clock-r7s72100.c
index e6ab0cd..dd8ce87 100644
--- a/arch/arm/mach-shmobile/clock-r7s72100.c
+++ b/arch/arm/mach-shmobile/clock-r7s72100.c
@@ -176,6 +176,10 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("cpu_clk", &div4_clks[DIV4_I]),
 
 	/* MSTP clocks */
+	CLKDEV_DEV_ID("fcfee000.i2c", &mstp_clks[MSTP97]),
+	CLKDEV_DEV_ID("fcfee400.i2c", &mstp_clks[MSTP96]),
+	CLKDEV_DEV_ID("fcfee800.i2c", &mstp_clks[MSTP95]),
+	CLKDEV_DEV_ID("fcfeec00.i2c", &mstp_clks[MSTP94]),
 	CLKDEV_CON_ID("mtu2_fck", &mstp_clks[MSTP33]),
 
 	/* ICK */
-- 
1.8.5.2
