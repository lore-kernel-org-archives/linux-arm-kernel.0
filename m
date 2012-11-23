From: andrea.adami@gmail.com (Andrea Adami)
Date: Fri, 23 Nov 2012 01:03:39 +0100
Subject: [PATCH] ARM: pxa: pxa25x.c: add dummy SA1100 rtc clock
Message-ID: <1353629019-32203-1-git-send-email-andrea.adami@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* fix failure seen on Zaurus corgi:
* sa1100-rtc sa1100-rtc: failed to find rtc clock source
* sa1100-rtc: probe of sa1100-rtc failed with error -2

Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
---
 arch/arm/mach-pxa/pxa25x.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 3352b37..0f05671 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -209,6 +209,7 @@ static struct clk_lookup pxa25x_clkregs[] = {
 	INIT_CLKREG(&clk_pxa25x_gpio12, NULL, "GPIO12_CLK"),
 	INIT_CLKREG(&clk_pxa25x_mem, "pxa2xx-pcmcia", NULL),
 	INIT_CLKREG(&clk_dummy, "pxa-gpio", NULL),
+	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
 };
 
 static struct clk_lookup pxa25x_hwuart_clkreg =
-- 
1.7.8.6
