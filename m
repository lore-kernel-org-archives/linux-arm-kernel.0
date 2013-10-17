From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu, 17 Oct 2013 14:01:37 +0400
Subject: [PATCH 3/3] ALSA: ASoC: pxa: add asoc pm callbacks to pxa audio
 drivers
In-Reply-To: <1382004097-6350-1-git-send-email-dbaryshkov@gmail.com>
References: <1382004097-6350-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1382004097-6350-3-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After convertion to snd_soc_register_card, platform driver should
reference snd_soc_pm_ops callbacks to properly suspend/resume sound
hardware. This was missed during conversion of PXA sound devices.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 sound/soc/pxa/brownstone.c     | 1 +
 sound/soc/pxa/corgi.c          | 1 +
 sound/soc/pxa/e740_wm9705.c    | 1 +
 sound/soc/pxa/e750_wm9705.c    | 1 +
 sound/soc/pxa/e800_wm9712.c    | 1 +
 sound/soc/pxa/imote2.c         | 1 +
 sound/soc/pxa/mioa701_wm9713.c | 1 +
 sound/soc/pxa/palm27x.c        | 1 +
 sound/soc/pxa/poodle.c         | 1 +
 sound/soc/pxa/tosa.c           | 1 +
 sound/soc/pxa/ttc-dkb.c        | 1 +
 11 files changed, 11 insertions(+)

diff --git a/sound/soc/pxa/brownstone.c b/sound/soc/pxa/brownstone.c
index 5b7d969..08acdc2 100644
--- a/sound/soc/pxa/brownstone.c
+++ b/sound/soc/pxa/brownstone.c
@@ -163,6 +163,7 @@ static struct platform_driver mmp_driver = {
 	.driver		= {
 		.name	= "brownstone-audio",
 		.owner	= THIS_MODULE,
+		.pm     = &snd_soc_pm_ops,
 	},
 	.probe		= brownstone_probe,
 	.remove		= brownstone_remove,
diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index f4cce1e..1853d41 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -329,6 +329,7 @@ static struct platform_driver corgi_driver = {
 	.driver		= {
 		.name	= "corgi-audio",
 		.owner	= THIS_MODULE,
+		.pm     = &snd_soc_pm_ops,
 	},
 	.probe		= corgi_probe,
 	.remove		= corgi_remove,
diff --git a/sound/soc/pxa/e740_wm9705.c b/sound/soc/pxa/e740_wm9705.c
index 70d799b..44b5c09 100644
--- a/sound/soc/pxa/e740_wm9705.c
+++ b/sound/soc/pxa/e740_wm9705.c
@@ -178,6 +178,7 @@ static struct platform_driver e740_driver = {
 	.driver		= {
 		.name	= "e740-audio",
 		.owner	= THIS_MODULE,
+		.pm     = &snd_soc_pm_ops,
 	},
 	.probe		= e740_probe,
 	.remove		= e740_remove,
diff --git a/sound/soc/pxa/e750_wm9705.c b/sound/soc/pxa/e750_wm9705.c
index f94d2ab..c34e447 100644
--- a/sound/soc/pxa/e750_wm9705.c
+++ b/sound/soc/pxa/e750_wm9705.c
@@ -160,6 +160,7 @@ static struct platform_driver e750_driver = {
 	.driver		= {
 		.name	= "e750-audio",
 		.owner	= THIS_MODULE,
+		.pm     = &snd_soc_pm_ops,
 	},
 	.probe		= e750_probe,
 	.remove		= e750_remove,
diff --git a/sound/soc/pxa/e800_wm9712.c b/sound/soc/pxa/e800_wm9712.c
index 8768a64..3137f80 100644
--- a/sound/soc/pxa/e800_wm9712.c
+++ b/sound/soc/pxa/e800_wm9712.c
@@ -150,6 +150,7 @@ static struct platform_driver e800_driver = {
 	.driver		= {
 		.name	= "e800-audio",
 		.owner	= THIS_MODULE,
+		.pm     = &snd_soc_pm_ops,
 	},
 	.probe		= e800_probe,
 	.remove		= e800_remove,
diff --git a/sound/soc/pxa/imote2.c b/sound/soc/pxa/imote2.c
index eef1f7b..fd2f4ed 100644
--- a/sound/soc/pxa/imote2.c
+++ b/sound/soc/pxa/imote2.c
@@ -91,6 +91,7 @@ static struct platform_driver imote2_driver = {
 	.driver		= {
 		.name	= "imote2-audio",
 		.owner	= THIS_MODULE,
+		.pm     = &snd_soc_pm_ops,
 	},
 	.probe		= imote2_probe,
 	.remove		= imote2_remove,
diff --git a/sound/soc/pxa/mioa701_wm9713.c b/sound/soc/pxa/mioa701_wm9713.c
index bbea778..160c524 100644
--- a/sound/soc/pxa/mioa701_wm9713.c
+++ b/sound/soc/pxa/mioa701_wm9713.c
@@ -215,6 +215,7 @@ static struct platform_driver mioa701_wm9713_driver = {
 	.driver		= {
 		.name		= "mioa701-wm9713",
 		.owner		= THIS_MODULE,
+		.pm     = &snd_soc_pm_ops,
 	},
 };
 
diff --git a/sound/soc/pxa/palm27x.c b/sound/soc/pxa/palm27x.c
index e1ffcdd..3284c4b 100644
--- a/sound/soc/pxa/palm27x.c
+++ b/sound/soc/pxa/palm27x.c
@@ -181,6 +181,7 @@ static struct platform_driver palm27x_wm9712_driver = {
 	.driver		= {
 		.name		= "palm27x-asoc",
 		.owner		= THIS_MODULE,
+		.pm     = &snd_soc_pm_ops,
 	},
 };
 
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index fafe463..c93e138 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -303,6 +303,7 @@ static struct platform_driver poodle_driver = {
 	.driver		= {
 		.name	= "poodle-audio",
 		.owner	= THIS_MODULE,
+		.pm     = &snd_soc_pm_ops,
 	},
 	.probe		= poodle_probe,
 	.remove		= poodle_remove,
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index a3fe191..1d9c2ed 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -275,6 +275,7 @@ static struct platform_driver tosa_driver = {
 	.driver		= {
 		.name	= "tosa-audio",
 		.owner	= THIS_MODULE,
+		.pm     = &snd_soc_pm_ops,
 	},
 	.probe		= tosa_probe,
 	.remove		= tosa_remove,
diff --git a/sound/soc/pxa/ttc-dkb.c b/sound/soc/pxa/ttc-dkb.c
index 13c9ee0..0b535b5 100644
--- a/sound/soc/pxa/ttc-dkb.c
+++ b/sound/soc/pxa/ttc-dkb.c
@@ -160,6 +160,7 @@ static struct platform_driver ttc_dkb_driver = {
 	.driver		= {
 		.name	= "ttc-dkb-audio",
 		.owner	= THIS_MODULE,
+		.pm     = &snd_soc_pm_ops,
 	},
 	.probe		= ttc_dkb_probe,
 	.remove		= ttc_dkb_remove,
-- 
1.8.4.rc3
