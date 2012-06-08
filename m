From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri,  8 Jun 2012 16:24:34 -0600
Subject: [PATCH 0/6] drivers: randconfig patches for kernel 3.5
Message-ID: <1339194280-27475-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

These patches fix miscellaneous problems when working
with make randconfig.  They were discovered on kernel
3.1-rc4 and sent out during the 3.4 cycle but were not
ack'ed.  

Sending out again for completeness.

Arnd Bergmann (6):
  drivers/video: use correct __devexit_p annotation
  mg_disk: use readb/writeb instead of inb/outb
  video/ili9320: do not mark exported functions __devexit
  video/console: automatically select a font
  drivers/savagefb: use mdelay instead of udelay
  drivers/tosa: driver needs I2C and SPI to compile

 drivers/block/mg_disk.c                |   78 ++++++++++++++++----------------
 drivers/video/backlight/Kconfig        |    2 +-
 drivers/video/backlight/ili9320.c      |    2 +-
 drivers/video/broadsheetfb.c           |    2 +-
 drivers/video/console/Kconfig          |   14 ++++++
 drivers/video/mbx/mbxfb.c              |    2 +-
 drivers/video/savage/savagefb_driver.c |   10 ++--
 7 files changed, 62 insertions(+), 48 deletions(-)

-- 
1.7.5.4
