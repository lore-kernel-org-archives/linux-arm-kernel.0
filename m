From: d-gerlach@ti.com (Dave Gerlach)
Date: Wed, 14 Sep 2016 15:41:37 -0500
Subject: [PATCH] cpufreq: ti: Use generic platdev driver
Message-ID: <20160914204137.20346-1-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the cpufreq-dt-platdev is used to create the cpufreq-dt platform
device for all OMAP platforms and the platform code that did it
before has been removed, add ti,am33xx and ti,dra7xx to the machine list
in cpufreq-dt-platdev which had relied on the removed platform code to do
this previously.

Fixes: 7694ca6e1d6f ("cpufreq: omap: Use generic platdev driver")
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 0bb44d5b5df4..d5e8ba50f8a3 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -68,6 +68,8 @@ static const struct of_device_id machines[] __initconst = {
 
 	{ .compatible = "sigma,tango4" },
 
+	{ .compatible = "ti,am33xx", },
+	{ .compatible = "ti,dra7", },
 	{ .compatible = "ti,omap2", },
 	{ .compatible = "ti,omap3", },
 	{ .compatible = "ti,omap4", },
-- 
2.9.3
