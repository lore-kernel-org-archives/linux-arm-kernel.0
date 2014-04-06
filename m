From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Sun,  6 Apr 2014 16:58:12 +0200
Subject: [PATCH 0/5] GPIO OMAP driver changes for v3.16
Message-ID: <1396796297-13002-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Now that you have sent your changes for v3.15 to Torvalds, here are some
changes for the OMAP GPIO driver targeted to v3.16. Mostly improvements
so nothing here is -rc material.

The biggest change is Patch 4 that converts the driver to use the newly
introduced generic irqchip helpers in the gpiolib core which allows to
remove some driver specific logic that should really be generic.

Aaro and Paul,

I've just build tested using omap1_defconfig since I don't have any OMAP1
board to test. It would be nice if you could test using any of your boards
to see if this patch-set does not introduce a regression. Specially on those
using MPUIO interrupt generation since I'm not familiar with it and I could
get something wrong while studying the code.

I prefer this set to not be merged until we have some testing on OMAP1 SoCs.

Santosh and Kevin,

If you agree I would like to be added to the list of maintainers for this
driver since that is what I've been doing lately anyways and that way tools
like get_maintainer.pl will hint people posting patches that I'm interested
in being cc'ed for this driver.

The patch-set is composed of the following patches: 

Javier Martinez Canillas (5):
  gpio: omap: convert to use irq_domain_add_simple()
  gpio: omap: check gpiochip_add() return value
  gpio: omap: add a GPIO_OMAP option instead of using ARCH_OMAP
  gpio: omap: convert driver to use gpiolib irqchip
  MAINTAINERS: update GPIO OMAP driver entry

 MAINTAINERS              |   1 +
 drivers/gpio/Kconfig     |   8 +++
 drivers/gpio/Makefile    |   2 +-
 drivers/gpio/gpio-omap.c | 128 +++++++++++++++++++++++------------------------
 4 files changed, 73 insertions(+), 66 deletions(-)

Thanks a lot and best regards,
Javier

-- 
1.9.0
