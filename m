From: jg1.han@samsung.com (Jingoo Han)
Date: Wed, 12 Sep 2012 10:27:15 +0900
Subject: [PATCH 15/16] ARM: samsung: move platform_data definitions
In-Reply-To: <1347368559-31329-3-git-send-email-arnd@arndb.de>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368559-31329-1-git-send-email-arnd@arndb.de>
 <1347368559-31329-3-git-send-email-arnd@arndb.de>
Message-ID: <001d01cd9085$be3d2220$3ab76660$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, September 11, 2012 10:03 PM Arnd Bergmann wrote
> 
> Platform data for device drivers should be defined in
> include/linux/platform_data/*.h, not in the architecture
> and platform specific directories.
> 
> This moves such data out of the samsung include directories
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Jeff Garzik <jgarzik@pobox.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: "Wolfram Sang (embedded platforms)" <w.sang@pengutronix.de>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Bryan Wu <bryan.wu@canonical.com>
> Cc: Richard Purdie <rpurdie@rpsys.net>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Mauro Carvalho Chehab <mchehab@infradead.org>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Sangbeom Kim <sbkim73@samsung.com>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: linux-samsung-soc at vger.kernel.org
> ---
>  arch/arm/mach-exynos/dev-audio.c                   |    2 +-
>  arch/arm/mach-exynos/dev-ohci.c                    |    2 +-
>  arch/arm/mach-exynos/mach-nuri.c                   |    6 +++---
>  arch/arm/mach-exynos/mach-origen.c                 |    6 +++---
>  arch/arm/mach-exynos/mach-smdk4x12.c               |    2 +-
>  arch/arm/mach-exynos/mach-smdkv310.c               |    6 +++---
>  arch/arm/mach-exynos/mach-universal_c210.c         |    4 ++--
>  arch/arm/mach-exynos/setup-i2c0.c                  |    2 +-
>  arch/arm/mach-exynos/setup-i2c1.c                  |    2 +-
>  arch/arm/mach-exynos/setup-i2c2.c                  |    2 +-
>  arch/arm/mach-exynos/setup-i2c3.c                  |    2 +-
>  arch/arm/mach-exynos/setup-i2c4.c                  |    2 +-
>  arch/arm/mach-exynos/setup-i2c5.c                  |    2 +-
>  arch/arm/mach-exynos/setup-i2c6.c                  |    2 +-
>  arch/arm/mach-exynos/setup-i2c7.c                  |    2 +-
>  arch/arm/mach-s3c24xx/common-smdk.c                |    4 ++--
>  arch/arm/mach-s3c24xx/mach-amlm5900.c              |    2 +-
>  arch/arm/mach-s3c24xx/mach-anubis.c                |    6 +++---
>  arch/arm/mach-s3c24xx/mach-at2440evb.c             |    6 +++---
>  arch/arm/mach-s3c24xx/mach-bast.c                  |    8 ++++----
>  arch/arm/mach-s3c24xx/mach-gta02.c                 |   10 +++++-----
>  arch/arm/mach-s3c24xx/mach-h1940.c                 |    8 ++++----
>  arch/arm/mach-s3c24xx/mach-jive.c                  |    6 +++---
>  arch/arm/mach-s3c24xx/mach-mini2440.c              |   10 +++++-----
>  arch/arm/mach-s3c24xx/mach-n30.c                   |    8 ++++----
>  arch/arm/mach-s3c24xx/mach-nexcoder.c              |    2 +-
>  arch/arm/mach-s3c24xx/mach-osiris.c                |    4 ++--
>  arch/arm/mach-s3c24xx/mach-otom.c                  |    2 +-
>  arch/arm/mach-s3c24xx/mach-qt2410.c                |    8 ++++----
>  arch/arm/mach-s3c24xx/mach-rx1950.c                |   10 +++++-----
>  arch/arm/mach-s3c24xx/mach-rx3715.c                |    2 +-
>  arch/arm/mach-s3c24xx/mach-smdk2410.c              |    2 +-
>  arch/arm/mach-s3c24xx/mach-smdk2413.c              |    4 ++--
>  arch/arm/mach-s3c24xx/mach-smdk2416.c              |    8 ++++----
>  arch/arm/mach-s3c24xx/mach-smdk2440.c              |    2 +-
>  arch/arm/mach-s3c24xx/mach-smdk2443.c              |    2 +-
>  arch/arm/mach-s3c24xx/mach-tct_hammer.c            |    2 +-
>  arch/arm/mach-s3c24xx/mach-vr1000.c                |    6 +++---
>  arch/arm/mach-s3c24xx/mach-vstms.c                 |    4 ++--
>  arch/arm/mach-s3c24xx/setup-i2c.c                  |    2 +-
>  arch/arm/mach-s3c24xx/simtec-audio.c               |    2 +-
>  arch/arm/mach-s3c24xx/simtec-usb.c                 |    2 +-
>  arch/arm/mach-s3c64xx/dev-audio.c                  |    2 +-
>  arch/arm/mach-s3c64xx/mach-anw6410.c               |    2 +-
>  arch/arm/mach-s3c64xx/mach-crag6410-module.c       |    2 +-
>  arch/arm/mach-s3c64xx/mach-crag6410.c              |    4 ++--
>  arch/arm/mach-s3c64xx/mach-hmt.c                   |    4 ++--
>  arch/arm/mach-s3c64xx/mach-mini6410.c              |    4 ++--
>  arch/arm/mach-s3c64xx/mach-ncp.c                   |    2 +-
>  arch/arm/mach-s3c64xx/mach-real6410.c              |    4 ++--
>  arch/arm/mach-s3c64xx/mach-smartq.c                |    8 ++++----
>  arch/arm/mach-s3c64xx/mach-smdk6400.c              |    2 +-
>  arch/arm/mach-s3c64xx/mach-smdk6410.c              |    6 +++---
>  arch/arm/mach-s3c64xx/setup-i2c0.c                 |    2 +-
>  arch/arm/mach-s3c64xx/setup-i2c1.c                 |    2 +-
>  arch/arm/mach-s3c64xx/setup-ide.c                  |    2 +-
>  arch/arm/mach-s5p64x0/dev-audio.c                  |    2 +-
>  arch/arm/mach-s5p64x0/mach-smdk6440.c              |    4 ++--
>  arch/arm/mach-s5p64x0/mach-smdk6450.c              |    4 ++--
>  arch/arm/mach-s5p64x0/setup-i2c0.c                 |    2 +-
>  arch/arm/mach-s5p64x0/setup-i2c1.c                 |    2 +-
>  arch/arm/mach-s5pc100/dev-audio.c                  |    2 +-
>  arch/arm/mach-s5pc100/mach-smdkc100.c              |    8 ++++----
>  arch/arm/mach-s5pc100/setup-i2c0.c                 |    2 +-
>  arch/arm/mach-s5pc100/setup-i2c1.c                 |    2 +-
>  arch/arm/mach-s5pv210/dev-audio.c                  |    2 +-
>  arch/arm/mach-s5pv210/mach-goni.c                  |    2 +-
>  arch/arm/mach-s5pv210/mach-smdkc110.c              |    4 ++--
>  arch/arm/mach-s5pv210/mach-smdkv210.c              |    6 +++---
>  arch/arm/mach-s5pv210/mach-torbreck.c              |    2 +-
>  arch/arm/mach-s5pv210/setup-i2c0.c                 |    2 +-
>  arch/arm/mach-s5pv210/setup-i2c1.c                 |    2 +-
>  arch/arm/mach-s5pv210/setup-i2c2.c                 |    2 +-
>  arch/arm/plat-samsung/devs.c                       |   20 ++++++++++----------
>  drivers/ata/pata_samsung_cf.c                      |    2 +-
>  drivers/hwmon/s3c-hwmon.c                          |    2 +-
>  drivers/i2c/busses/i2c-s3c2410.c                   |    2 +-
>  drivers/input/touchscreen/s3c2410_ts.c             |    2 +-
>  drivers/leds/leds-s3c24xx.c                        |    2 +-
>  drivers/media/video/s5p-fimc/mipi-csis.c           |    2 +-
>  drivers/mmc/host/s3cmci.c                          |    2 +-
>  drivers/mtd/nand/s3c2410.c                         |    2 +-
>  drivers/spi/spi-s3c64xx.c                          |    2 +-
>  drivers/usb/gadget/s3c2410_udc.c                   |    2 +-
>  drivers/usb/host/ehci-s5p.c                        |    2 +-
>  drivers/usb/host/ohci-exynos.c                     |    2 +-
>  drivers/usb/host/ohci-s3c2410.c                    |    2 +-
>  .../linux/platform_data/asoc-s3c.h                 |    0
>  .../linux/platform_data/asoc-s3c24xx_simtec.h      |    0
>  .../linux/platform_data/ata-samsung_cf.h           |    0
>  .../linux/platform_data/hwmon-s3c.h                |    0
>  .../linux/platform_data/i2c-s3c2410.h              |    0
>  .../linux/platform_data/leds-s3c24xx.h             |    0
>  .../linux/platform_data/mipi-csis.h                |    0
>  .../linux/platform_data/mmc-s3cmci.h               |    0
>  .../linux/platform_data/mtd-nand-s3c2410.h         |    0
>  .../linux/platform_data/spi-s3c64xx.h              |    0
>  .../linux/platform_data/touchscreen-s3c2410.h      |    0
>  .../linux/platform_data/usb-ehci-s5p.h             |    0
>  .../linux/platform_data/usb-exynos.h               |    0
>  .../linux/platform_data/usb-ohci-s3c2410.h         |    0
>  .../linux/platform_data/usb-s3c2410_udc.h          |    0
>  sound/soc/samsung/ac97.c                           |    2 +-
>  sound/soc/samsung/i2s.c                            |    2 +-
>  sound/soc/samsung/pcm.c                            |    2 +-
>  sound/soc/samsung/s3c24xx_simtec.c                 |    2 +-
>  sound/soc/samsung/spdif.c                          |    2 +-
>  107 files changed, 164 insertions(+), 164 deletions(-)
>  rename arch/arm/plat-samsung/include/plat/audio.h => include/linux/platform_data/asoc-s3c.h (100%)
>  rename arch/arm/plat-samsung/include/plat/audio-simtec.h => include/linux/platform_data/asoc-
> s3c24xx_simtec.h (100%)
>  rename arch/arm/plat-samsung/include/plat/ata.h => include/linux/platform_data/ata-samsung_cf.h (100%)
>  rename arch/arm/plat-samsung/include/plat/hwmon.h => include/linux/platform_data/hwmon-s3c.h (100%)
>  rename arch/arm/plat-samsung/include/plat/iic.h => include/linux/platform_data/i2c-s3c2410.h (100%)
>  rename arch/arm/mach-s3c24xx/include/mach/leds-gpio.h => include/linux/platform_data/leds-s3c24xx.h
> (100%)
>  rename arch/arm/plat-samsung/include/plat/mipi_csis.h => include/linux/platform_data/mipi-csis.h (100%)
>  rename arch/arm/plat-samsung/include/plat/mci.h => include/linux/platform_data/mmc-s3cmci.h (100%)
>  rename arch/arm/plat-samsung/include/plat/nand.h => include/linux/platform_data/mtd-nand-s3c2410.h
> (100%)
>  rename arch/arm/plat-samsung/include/plat/s3c64xx-spi.h => include/linux/platform_data/spi-s3c64xx.h
> (100%)
>  rename arch/arm/plat-samsung/include/plat/ts.h => include/linux/platform_data/touchscreen-s3c2410.h
> (100%)
>  rename arch/arm/plat-samsung/include/plat/ehci.h => include/linux/platform_data/usb-ehci-s5p.h (100%)
>  rename arch/arm/mach-exynos/include/mach/ohci.h => include/linux/platform_data/usb-exynos.h (100%)

Hi Arnd Bergmann,

Could you change the name from 'ohci.h' to 'usb-ohci-exynos.h',
instead of 'usb-exynos.h'? This is because 'ohci.h' has the platdata
for only exynos ohci.


Best regards,
Jingoo Han


>  rename arch/arm/plat-samsung/include/plat/usb-control.h => include/linux/platform_data/usb-ohci-
> s3c2410.h (100%)
>  rename arch/arm/plat-samsung/include/plat/udc.h => include/linux/platform_data/usb-s3c2410_udc.h (100%)
> 
