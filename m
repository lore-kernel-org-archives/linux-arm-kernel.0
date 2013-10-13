From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 13 Oct 2013 18:17:46 +0200
Subject: [PATCH 0/4] remove devm_pinctrl_get_select_default from drivers
Message-ID: <1381681071-6021-1-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The core does this automatically, no need to do this explicitly in drivers.
Those patchces should go via the respective subtrees. Thanks!


Wolfram Sang (4):
  drivers/gpu/drm/tilcdc: don't use devm_pinctrl_get_select_default() in
    probe
  drivers/mmc/host: don't use devm_pinctrl_get_select_default() in probe
  drivers/pwm: don't use devm_pinctrl_get_select_default() in probe
  sound/soc/atmel: don't use devm_pinctrl_get_select_default() in probe

 drivers/gpu/drm/tilcdc/tilcdc_panel.c  | 6 ------
 drivers/gpu/drm/tilcdc/tilcdc_slave.c  | 6 ------
 drivers/gpu/drm/tilcdc/tilcdc_tfp410.c | 6 ------
 drivers/mmc/host/mvsdio.c              | 7 +------
 drivers/mmc/host/omap_hsmmc.c          | 7 -------
 drivers/mmc/host/sdhci-esdhc-imx.c     | 8 --------
 drivers/pwm/pwm-tiecap.c               | 6 ------
 drivers/pwm/pwm-tiehrpwm.c             | 6 ------
 sound/soc/atmel/atmel_wm8904.c         | 8 --------
 9 files changed, 1 insertion(+), 59 deletions(-)

-- 
1.8.4.rc3
