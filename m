From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Apr 2013 17:54:31 +0200
Subject: [PATCH] ARM: allmodconfig regressions in linux-next
Message-ID: <1366732475-479886-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

These are a couple of simple patches to fix bugs that break allyesconfig
and that are only present in linux-next at the moment. Please apply
to the appropriate trees or provide feedback!

Arnd Bergmann (5):
  mfd: ab8500: remove broken ab8500_debug_register_interrupt logic
  usb: phy: phy core cannot yet be a module
  ASoC: don't call of_dma_request_slave_channel directly
  hwrng: bcm2835: fix MODULE_LICENSE tag
  clocksource: kona: adapt to CLOCKSOURCE_OF_DECLARE change

 drivers/char/hw_random/bcm2835-rng.c  |  2 +-
 drivers/clocksource/bcm_kona_timer.c  | 15 ++++-----------
 drivers/mfd/ab8500-debugfs.c          | 10 ----------
 drivers/usb/phy/Kconfig               |  2 +-
 sound/soc/soc-generic-dmaengine-pcm.c |  9 +++++----
 5 files changed, 11 insertions(+), 27 deletions(-)

Cc: Christian Daudt <csd@broadcom.com>
Cc: Dom Cobley <popcornmix@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Jonas ABERG <jonas.aberg@stericsson.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Cc: Lubomir Rintel <lkundrak@v3.sk>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Matt Mackall <mpm@selenic.com>
Cc: Mattias WALLIN <mattias.wallin@stericsson.com>
Cc: Per FORLIN <per.forlin@stericsson.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel at alsa-project.org
Cc: linux-rpi-kernel at lists.infradead.org
Cc: linux-usb at vger.kernel.org
Cc: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
-- 
1.8.1.2
