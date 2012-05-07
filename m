From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Mon, 7 May 2012 10:13:50 +0200
Subject: [PATCH] ARM: imx: rename uart and fec device tree nodes
In-Reply-To: <20120504134825.GK2194@S2101-09.ap.freescale.net>
References: <1333350084-5993-1-git-send-email-shawn.guo@linaro.org>
 <4FA39D65.3020007@de.bosch.com>
 <20120504133301.GJ2194@S2101-09.ap.freescale.net>
 <4FA3DB37.8080002@de.bosch.com>
 <20120504134825.GK2194@S2101-09.ap.freescale.net>
Message-ID: <4FA7843E.8050302@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04.05.2012 15:48, Shawn Guo wrote:
> On Fri, May 04, 2012 at 03:35:51PM +0200, Dirk Behme wrote:
>> Yes, I think so
>>
>> https://github.com/dirkbehme/linux-imx6/commit/ebfac55f157425b5e063cdb2d9668b45a0a6515f#diff-14
>>
>>> It reminds me that I should rebase my imx/dt branch on Sascha's clk
>>> series to save the conflict.
>> My test branch has Sascha's clk series, too. It's mainly based on
>>
>> https://github.com/dirkbehme/linux-imx6/commits/linux-imx6-staging
>>
> If you have Sascha's clk series merged, the changes on clock-imx6q.c
> made by this patch could probably get lost, since Sascha's clk series
> will remove clock-imx6q.c.

Ok. Using this patch on top of Sascha's clk series [1], the following 
changes [2] are needed.

Many thanks to Shawn for the help!

Best regards

Dirk

[1] 
http://git.pengutronix.de/?p=imx/linux-2.6.git;a=shortlog;h=refs/heads/work/v3.4-rc4-imx-clk

[2]

From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH] ARM: imx: Adapt uart and fec devices tree names

Using the patch "ARM: imx: rename uart and fec device tree nodes"
on top of the common clock framework needs to change clk-imx6q.c,
too.

Else no console output is given due to

Serial: IMX driver
imx-uart: probe of 21e8000.serial failed with error -2

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
CC: Shawn Guo <shawn.guo@linaro.org>
CC: Sascha Hauer <s.hauer@pengutronix.de>
---
  arch/arm/mach-imx/clk-imx6q.c |   22 +++++++++++-----------
  1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index f40a35d..b37ad4b 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -392,17 +392,17 @@ int __init mx6q_clocks_init(void)
  	clk_register_clkdev(clk[gpt_ipg_per], "per", "imx-gpt.0");
  	clk_register_clkdev(clk[twd], NULL, "smp_twd");
  	clk_register_clkdev(clk[usboh3], NULL, "usboh3");
-	clk_register_clkdev(clk[uart_serial], "per", "2020000.uart");
-	clk_register_clkdev(clk[uart_ipg], "ipg", "2020000.uart");
-	clk_register_clkdev(clk[uart_serial], "per", "21e8000.uart");
-	clk_register_clkdev(clk[uart_ipg], "ipg", "21e8000.uart");
-	clk_register_clkdev(clk[uart_serial], "per", "21ec000.uart");
-	clk_register_clkdev(clk[uart_ipg], "ipg", "21ec000.uart");
-	clk_register_clkdev(clk[uart_serial], "per", "21f0000.uart");
-	clk_register_clkdev(clk[uart_ipg], "ipg", "21f0000.uart");
-	clk_register_clkdev(clk[uart_serial], "per", "21f4000.uart");
-	clk_register_clkdev(clk[uart_ipg], "ipg", "21f4000.uart");
-	clk_register_clkdev(clk[enet], NULL, "2188000.enet");
+	clk_register_clkdev(clk[uart_serial], "per", "2020000.serial");
+	clk_register_clkdev(clk[uart_ipg], "ipg", "2020000.serial");
+	clk_register_clkdev(clk[uart_serial], "per", "21e8000.serial");
+	clk_register_clkdev(clk[uart_ipg], "ipg", "21e8000.serial");
+	clk_register_clkdev(clk[uart_serial], "per", "21ec000.serial");
+	clk_register_clkdev(clk[uart_ipg], "ipg", "21ec000.serial");
+	clk_register_clkdev(clk[uart_serial], "per", "21f0000.serial");
+	clk_register_clkdev(clk[uart_ipg], "ipg", "21f0000.serial");
+	clk_register_clkdev(clk[uart_serial], "per", "21f4000.serial");
+	clk_register_clkdev(clk[uart_ipg], "ipg", "21f4000.serial");
+	clk_register_clkdev(clk[enet], NULL, "2188000.ethernet");
  	clk_register_clkdev(clk[usdhc1], NULL, "2190000.usdhc");
  	clk_register_clkdev(clk[usdhc2], NULL, "2194000.usdhc");
  	clk_register_clkdev(clk[usdhc3], NULL, "2198000.usdhc");
-- 
1.7.0.4
