From: fabf@skynet.be (Fabian Frederick)
Date: Mon, 16 Mar 2015 20:54:40 +0100
Subject: [PATCH 30/35 linux-next] devfreq: constify of_device_id array
In-Reply-To: <1426535685-25996-1-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426535685-25996-1-git-send-email-fabf@skynet.be>
Message-ID: <1426535685-25996-9-git-send-email-fabf@skynet.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_device_id is always used as const.
(See driver.of_match_table and open firmware functions)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/devfreq/event/exynos-ppmu.c | 2 +-
 drivers/devfreq/tegra-devfreq.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index ad83473..5afb851 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -354,7 +354,7 @@ static int exynos_ppmu_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id exynos_ppmu_id_match[] = {
+static const struct of_device_id exynos_ppmu_id_match[] = {
 	{ .compatible = "samsung,exynos-ppmu", },
 	{ /* sentinel */ },
 };
diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 3479096..244d8db 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -695,7 +695,7 @@ static SIMPLE_DEV_PM_OPS(tegra_devfreq_pm_ops,
 			 tegra_devfreq_suspend,
 			 tegra_devfreq_resume);
 
-static struct of_device_id tegra_devfreq_of_match[] = {
+static const struct of_device_id tegra_devfreq_of_match[] = {
 	{ .compatible = "nvidia,tegra124-actmon" },
 	{ },
 };
-- 
2.1.0
