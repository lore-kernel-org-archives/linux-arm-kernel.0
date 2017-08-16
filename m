From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 16 Aug 2017 10:19:12 +0200
Subject: [PATCH 1/3 v2] cpufreq: enable the DT cpufreq driver on the Ux500
Message-ID: <20170816081914.30471-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the generic DT and OPP-based cpufreq driver on the
ST-Ericsson Ux500 series.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1-v2:
- Added Viresh's ACK.

Please apply this to the cpufreq tree.
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 1c262923fe58..d80300251bc4 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -88,6 +88,11 @@ static const struct of_device_id machines[] __initconst = {
 	{ .compatible = "socionext,uniphier-ld11", },
 	{ .compatible = "socionext,uniphier-ld20", },
 
+	{ .compatible = "st-ericsson,u8500", },
+	{ .compatible = "st-ericsson,u8540", },
+	{ .compatible = "st-ericsson,u9500", },
+	{ .compatible = "st-ericsson,u9540", },
+
 	{ .compatible = "ti,omap2", },
 	{ .compatible = "ti,omap3", },
 	{ .compatible = "ti,omap4", },
-- 
2.13.5
