From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 15 Oct 2016 21:57:27 +0200
Subject: [PATCH v2 1/4] cpufreq: pxa: use generic platdev driver for
 device-tree
In-Reply-To: <1476561450-28407-1-git-send-email-robert.jarzmik@free.fr>
References: <1476561450-28407-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1476561450-28407-2-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For device-tree based pxa25x and pxa27x platforms, cpufreq-dt driver is
doing the job as well as pxa2xx-cpufreq, so add these platforms to the
compatibility list.

This won't work for legacy non device-tree platforms where
pxa2xx-cpufreq is still required.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 0bb44d5b5df4..356825b5c9b8 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -32,6 +32,8 @@ static const struct of_device_id machines[] __initconst = {
 	{ .compatible = "fsl,imx7d", },
 
 	{ .compatible = "marvell,berlin", },
+	{ .compatible = "marvell,pxa250", },
+	{ .compatible = "marvell,pxa270", },
 
 	{ .compatible = "samsung,exynos3250", },
 	{ .compatible = "samsung,exynos4210", },
-- 
2.1.4
