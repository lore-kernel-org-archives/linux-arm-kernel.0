From: richard.genoud@gmail.com (Richard Genoud)
Date: Fri, 17 Aug 2012 17:39:32 +0200
Subject: [PATCH 06/14] arm: at91: dt: at91sam9 add pinctrl support
In-Reply-To: <CACRpkdY2HjwOBy7P8mZ81f8bYU4V2=taXzqv03q9NWqbfMVQ4A@mail.gmail.com>
References: <20120810124820.GA20557@game.jcrosoft.org>
 <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
 <1344603731-32667-6-git-send-email-plagnioj@jcrosoft.com>
 <CACRpkdY2HjwOBy7P8mZ81f8bYU4V2=taXzqv03q9NWqbfMVQ4A@mail.gmail.com>
Message-ID: <CACQ1gAjy7kT9emFGYQY5m1=kS3S5SPS4F5yMCV2ZzMxbhPcFGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean-Christophe, it seems that you forgot those clocks:

Regards,
Richard.


    sam9x5: add clocks for pinctrl

    Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 arch/arm/mach-at91/at91sam9x5.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
index 477cf9d..55b52ef 100644
--- a/arch/arm/mach-at91/at91sam9x5.c
+++ b/arch/arm/mach-at91/at91sam9x5.c
@@ -231,6 +231,11 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t0_clk", "f800c000.timer", &tcb0_clk),
 	CLKDEV_CON_DEV_ID("dma_clk", "ffffec00.dma-controller", &dma0_clk),
 	CLKDEV_CON_DEV_ID("dma_clk", "ffffee00.dma-controller", &dma1_clk),
+	CLKDEV_CON_DEV_ID(NULL, "fffff400.gpio", &pioAB_clk),
+	CLKDEV_CON_DEV_ID(NULL, "fffff600.gpio", &pioAB_clk),
+	CLKDEV_CON_DEV_ID(NULL, "fffff800.gpio", &pioCD_clk),
+	CLKDEV_CON_DEV_ID(NULL, "fffffa00.gpio", &pioCD_clk),
+
 	CLKDEV_CON_ID("pioA", &pioAB_clk),
 	CLKDEV_CON_ID("pioB", &pioAB_clk),
 	CLKDEV_CON_ID("pioC", &pioCD_clk),
-- 
1.7.2.5
