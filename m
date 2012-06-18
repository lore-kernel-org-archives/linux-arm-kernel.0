From: stigge@antcom.de (Roland Stigge)
Date: Mon, 18 Jun 2012 18:42:21 +0200
Subject: [PATCH 1/2] sound: tegra_wm8903: Adjust to of_get_named_gpio() change
Message-ID: <1340037743-12924-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_get_named_gpio() was changed to return -EPROBE_DEFER in case of
gpios not probed yet. This patch adjusts tegra_wm8903 to this.

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
Applies to git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git,
branch for-next

 sound/soc/tegra/tegra_wm8903.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/tegra/tegra_wm8903.c b/sound/soc/tegra/tegra_wm8903.c
index 0c5bb33..d4f14e4 100644
--- a/sound/soc/tegra/tegra_wm8903.c
+++ b/sound/soc/tegra/tegra_wm8903.c
@@ -284,27 +284,27 @@ static __devinit int tegra_wm8903_driver_probe(struct platform_device *pdev)
 	} else if (np) {
 		pdata->gpio_spkr_en = of_get_named_gpio(np,
 						"nvidia,spkr-en-gpios", 0);
-		if (pdata->gpio_spkr_en == -ENODEV)
+		if (pdata->gpio_spkr_en == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
 
 		pdata->gpio_hp_mute = of_get_named_gpio(np,
 						"nvidia,hp-mute-gpios", 0);
-		if (pdata->gpio_hp_mute == -ENODEV)
+		if (pdata->gpio_hp_mute == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
 
 		pdata->gpio_hp_det = of_get_named_gpio(np,
 						"nvidia,hp-det-gpios", 0);
-		if (pdata->gpio_hp_det == -ENODEV)
+		if (pdata->gpio_hp_det == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
 
 		pdata->gpio_int_mic_en = of_get_named_gpio(np,
 						"nvidia,int-mic-en-gpios", 0);
-		if (pdata->gpio_int_mic_en == -ENODEV)
+		if (pdata->gpio_int_mic_en == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
 
 		pdata->gpio_ext_mic_en = of_get_named_gpio(np,
 						"nvidia,ext-mic-en-gpios", 0);
-		if (pdata->gpio_ext_mic_en == -ENODEV)
+		if (pdata->gpio_ext_mic_en == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
 	}
 
-- 
1.7.10
