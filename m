From: wfp5p@virginia.edu (Bill Pemberton)
Date: Fri,  7 Dec 2012 09:26:14 -0500
Subject: [PATCH 02/25] ASoC: pxa/hx4700: remove __dev* attributes
In-Reply-To: <1354890397-28568-1-git-send-email-wfp5p@virginia.edu>
References: <1354890397-28568-1-git-send-email-wfp5p@virginia.edu>
Message-ID: <1354890397-28568-3-git-send-email-wfp5p@virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HOTPLUG is going away as an option.  As result the __dev*
markings will be going away.

Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
and __devexit.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Philipp Zabel <philipp.zabel@gmail.com>
Cc: Paul Parsons <lost.distance@yahoo.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 sound/soc/pxa/hx4700.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/pxa/hx4700.c b/sound/soc/pxa/hx4700.c
index 2a342c9..dcc9b04 100644
--- a/sound/soc/pxa/hx4700.c
+++ b/sound/soc/pxa/hx4700.c
@@ -183,7 +183,7 @@ static struct gpio hx4700_audio_gpios[] = {
 	{ GPIO92_HX4700_HP_DRIVER, GPIOF_OUT_INIT_LOW, "EP_POWER" },
 };
 
-static int __devinit hx4700_audio_probe(struct platform_device *pdev)
+static int hx4700_audio_probe(struct platform_device *pdev)
 {
 	int ret;
 
@@ -204,7 +204,7 @@ static int __devinit hx4700_audio_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit hx4700_audio_remove(struct platform_device *pdev)
+static int hx4700_audio_remove(struct platform_device *pdev)
 {
 	snd_soc_jack_free_gpios(&hs_jack, 1, &hs_jack_gpio);
 	snd_soc_unregister_card(&snd_soc_card_hx4700);
@@ -223,7 +223,7 @@ static struct platform_driver hx4700_audio_driver = {
 		.pm = &snd_soc_pm_ops,
 	},
 	.probe	= hx4700_audio_probe,
-	.remove	= __devexit_p(hx4700_audio_remove),
+	.remove	= hx4700_audio_remove,
 };
 
 module_platform_driver(hx4700_audio_driver);
-- 
1.8.0.1
