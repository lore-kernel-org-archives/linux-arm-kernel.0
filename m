From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  7 Jul 2014 09:54:40 +0200
Subject: [PATCH v2 15/30] ARM: shmobile: r8a7740: correct SCI clock support
 for DT
In-Reply-To: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
References: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1404719695-1634-16-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When initialising SCI devices their names will be .serial
not .sci.

This will be used when initialising SCI devices using DT
until common clock framework support is added.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* First post
---
 arch/arm/mach-shmobile/clock-r8a7740.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index 789091c..a60c324 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -556,27 +556,27 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_mobile_ceu.1",	&mstp_clks[MSTP128]),
 
 	CLKDEV_DEV_ID("sh-sci.4",		&mstp_clks[MSTP200]),
-	CLKDEV_DEV_ID("e6c80000.sci",		&mstp_clks[MSTP200]),
+	CLKDEV_DEV_ID("e6c80000.serial",	&mstp_clks[MSTP200]),
 	CLKDEV_DEV_ID("sh-sci.3",		&mstp_clks[MSTP201]),
-	CLKDEV_DEV_ID("e6c70000.sci",		&mstp_clks[MSTP201]),
+	CLKDEV_DEV_ID("e6c70000.serial",	&mstp_clks[MSTP201]),
 	CLKDEV_DEV_ID("sh-sci.2",		&mstp_clks[MSTP202]),
-	CLKDEV_DEV_ID("e6c60000.sci",		&mstp_clks[MSTP202]),
+	CLKDEV_DEV_ID("e6c60000.serial",	&mstp_clks[MSTP202]),
 	CLKDEV_DEV_ID("sh-sci.1",		&mstp_clks[MSTP203]),
-	CLKDEV_DEV_ID("e6c50000.sci",		&mstp_clks[MSTP203]),
+	CLKDEV_DEV_ID("e6c50000.serial",	&mstp_clks[MSTP203]),
 	CLKDEV_DEV_ID("sh-sci.0",		&mstp_clks[MSTP204]),
-	CLKDEV_DEV_ID("e6c40000.sci",		&mstp_clks[MSTP204]),
+	CLKDEV_DEV_ID("e6c40000.serial",	&mstp_clks[MSTP204]),
 	CLKDEV_DEV_ID("sh-sci.8",		&mstp_clks[MSTP206]),
-	CLKDEV_DEV_ID("e6c30000.sci",		&mstp_clks[MSTP206]),
+	CLKDEV_DEV_ID("e6c30000.serial",	&mstp_clks[MSTP206]),
 	CLKDEV_DEV_ID("sh-sci.5",		&mstp_clks[MSTP207]),
-	CLKDEV_DEV_ID("e6cb0000.sci",		&mstp_clks[MSTP207]),
+	CLKDEV_DEV_ID("e6cb0000.serial",	&mstp_clks[MSTP207]),
 	CLKDEV_DEV_ID("sh-dma-engine.3",	&mstp_clks[MSTP214]),
 	CLKDEV_DEV_ID("sh-dma-engine.2",	&mstp_clks[MSTP216]),
 	CLKDEV_DEV_ID("sh-dma-engine.1",	&mstp_clks[MSTP217]),
 	CLKDEV_DEV_ID("sh-dma-engine.0",	&mstp_clks[MSTP218]),
 	CLKDEV_DEV_ID("sh-sci.7",		&mstp_clks[MSTP222]),
-	CLKDEV_DEV_ID("e6cd0000.sci",		&mstp_clks[MSTP222]),
+	CLKDEV_DEV_ID("e6cd0000.serial",	&mstp_clks[MSTP222]),
 	CLKDEV_DEV_ID("sh-sci.6",		&mstp_clks[MSTP230]),
-	CLKDEV_DEV_ID("e6cc0000.sci",		&mstp_clks[MSTP230]),
+	CLKDEV_DEV_ID("e6cc0000.serial",	&mstp_clks[MSTP230]),
 
 	CLKDEV_DEV_ID("sh_fsi2",		&mstp_clks[MSTP328]),
 	CLKDEV_DEV_ID("fe1f0000.sound",		&mstp_clks[MSTP328]),
-- 
2.0.0.rc2
