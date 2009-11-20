From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Nov 2009 13:07:28 +0000
Subject: [PATCH 04/10] ARM: PNX4008: convert watchdog clocks to match by
	device only
In-Reply-To: <20091120144422.GA18223@n2100.arm.linux.org.uk>
References: <20091120144422.GA18223@n2100.arm.linux.org.uk>
Message-ID: <E1NBUjk-0004Pd-SS@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-pnx4008/clock.c  |    2 +-
 drivers/watchdog/pnx4008_wdt.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pnx4008/clock.c b/arch/arm/mach-pnx4008/clock.c
index 2714f9f..d12e0b1 100644
--- a/arch/arm/mach-pnx4008/clock.c
+++ b/arch/arm/mach-pnx4008/clock.c
@@ -806,7 +806,7 @@ static struct clk_lookup onchip_clkreg[] = {
 	{ .clk = &uart4_ck,	.con_id = "uart4_ck"	},
 	{ .clk = &uart5_ck,	.con_id = "uart5_ck"	},
 	{ .clk = &uart6_ck,	.con_id = "uart6_ck"	},
-	{ .clk = &wdt_ck,	.con_id = "wdt_ck"	},
+	{ .clk = &wdt_ck,	.dev_id = "pnx4008-watchdog" },
 };
 
 static void local_clk_disable(struct clk *clk)
diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index 4d227b1..9add3a8 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -273,7 +273,7 @@ static int __devinit pnx4008_wdt_probe(struct platform_device *pdev)
 	}
 	wdt_base = (void __iomem *)IO_ADDRESS(res->start);
 
-	wdt_clk = clk_get(&pdev->dev, "wdt_ck");
+	wdt_clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(wdt_clk)) {
 		ret = PTR_ERR(wdt_clk);
 		release_resource(wdt_mem);
-- 
1.6.2.5
