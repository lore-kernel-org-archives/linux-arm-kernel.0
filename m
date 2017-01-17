From: d-gerlach@ti.com (Dave Gerlach)
Date: Tue, 17 Jan 2017 07:18:08 -0600
Subject: [PATCH v4 4/4] cpufreq: dt: Don't use generic platdev driver for
 ti-cpufreq platforms
In-Reply-To: <20170117131808.29798-1-d-gerlach@ti.com>
References: <20170117131808.29798-1-d-gerlach@ti.com>
Message-ID: <20170117131808.29798-5-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some TI platforms, specifically those in the am33xx, am43xx, dra7xx, and
am57xx families of SoCs can make use of the ti-cpufreq driver to
selectively enable OPPs based on the exact configuration in use. The
ti-cpufreq is given the responsibility of creating the cpufreq-dt
platform device when the driver is in use so drop am33xx and dra7xx
from the cpufreq-dt-platdev driver so it is not created twice.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 7fcaf26e8f81..921b4a6c3d16 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -87,8 +87,6 @@ static const struct of_device_id machines[] __initconst = {
 	{ .compatible = "socionext,uniphier-ld11", },
 	{ .compatible = "socionext,uniphier-ld20", },
 
-	{ .compatible = "ti,am33xx", },
-	{ .compatible = "ti,dra7", },
 	{ .compatible = "ti,omap2", },
 	{ .compatible = "ti,omap3", },
 	{ .compatible = "ti,omap4", },
-- 
2.11.0
