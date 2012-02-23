From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 24 Feb 2012 00:00:49 +0800
Subject: [PATCH v3 5/7] ARM: pxa: add rtc dummy clock
In-Reply-To: <1330012851-13693-1-git-send-email-haojian.zhuang@marvell.com>
References: <1330012851-13693-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1330012851-13693-6-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sa1100-rtc driver could be shared among sa1100/pxa/mmp series silicon.
Since clk is used in mmp series silicon, add dummy clock support in
pxa also.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-pxa/pxa25x.c |    1 +
 arch/arm/mach-pxa/pxa27x.c |    1 +
 arch/arm/mach-pxa/pxa3xx.c |    1 +
 arch/arm/mach-pxa/pxa95x.c |    1 +
 4 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 91e4f6c..d43c1a7 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -209,6 +209,7 @@ static struct clk_lookup pxa25x_clkregs[] = {
 	INIT_CLKREG(&clk_pxa25x_gpio11, NULL, "GPIO11_CLK"),
 	INIT_CLKREG(&clk_pxa25x_gpio12, NULL, "GPIO12_CLK"),
 	INIT_CLKREG(&clk_pxa25x_mem, "pxa2xx-pcmcia", NULL),
+	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
 };
 
 static struct clk_lookup pxa25x_hwuart_clkreg =
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index aed6cbc..cf2f9d1 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -230,6 +230,7 @@ static struct clk_lookup pxa27x_clkregs[] = {
 	INIT_CLKREG(&clk_pxa27x_im, NULL, "IMCLK"),
 	INIT_CLKREG(&clk_pxa27x_memc, NULL, "MEMCLK"),
 	INIT_CLKREG(&clk_pxa27x_mem, "pxa2xx-pcmcia", NULL),
+	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
 };
 
 #ifdef CONFIG_PM
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 4f402af..8819348 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -89,6 +89,7 @@ static struct clk_lookup pxa3xx_clkregs[] = {
 	INIT_CLKREG(&clk_pxa3xx_mmc2, "pxa2xx-mci.1", NULL),
 	INIT_CLKREG(&clk_pxa3xx_smemc, "pxa2xx-pcmcia", NULL),
 	INIT_CLKREG(&clk_pxa3xx_gpio, "pxa-gpio", NULL),
+	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
 };
 
 #ifdef CONFIG_PM
diff --git a/arch/arm/mach-pxa/pxa95x.c b/arch/arm/mach-pxa/pxa95x.c
index d082a58..35023d7 100644
--- a/arch/arm/mach-pxa/pxa95x.c
+++ b/arch/arm/mach-pxa/pxa95x.c
@@ -231,6 +231,7 @@ static struct clk_lookup pxa95x_clkregs[] = {
 	INIT_CLKREG(&clk_pxa95x_pwm0, "pxa27x-pwm.0", NULL),
 	INIT_CLKREG(&clk_pxa95x_pwm1, "pxa27x-pwm.1", NULL),
 	INIT_CLKREG(&clk_pxa95x_gpio, "pxa-gpio", NULL),
+	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
 };
 
 void __init pxa95x_init_irq(void)
-- 
1.7.0.4
