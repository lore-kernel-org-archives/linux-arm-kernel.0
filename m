From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 22 Nov 2011 18:21:14 -0700
Subject: [PATCH 06/17] ASoC: Tegra PCM: Use module_platform_driver
In-Reply-To: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
Message-ID: <1322011285-4002-7-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This saves some boiler-plate code.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/tegra_pcm.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/sound/soc/tegra/tegra_pcm.c b/sound/soc/tegra/tegra_pcm.c
index 436def1..90345ee 100644
--- a/sound/soc/tegra/tegra_pcm.c
+++ b/sound/soc/tegra/tegra_pcm.c
@@ -392,18 +392,7 @@ static struct platform_driver tegra_pcm_driver = {
 	.probe = tegra_pcm_platform_probe,
 	.remove = __devexit_p(tegra_pcm_platform_remove),
 };
-
-static int __init snd_tegra_pcm_init(void)
-{
-	return platform_driver_register(&tegra_pcm_driver);
-}
-module_init(snd_tegra_pcm_init);
-
-static void __exit snd_tegra_pcm_exit(void)
-{
-	platform_driver_unregister(&tegra_pcm_driver);
-}
-module_exit(snd_tegra_pcm_exit);
+module_platform_driver(tegra_pcm_driver);
 
 MODULE_AUTHOR("Stephen Warren <swarren@nvidia.com>");
 MODULE_DESCRIPTION("Tegra PCM ASoC driver");
-- 
1.7.0.4
