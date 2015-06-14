From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sun, 14 Jun 2015 16:16:36 +0300
Subject: [PATCH v5 00/17] new LoCoMo driver set
In-Reply-To: <1433797008-6246-1-git-send-email-dbaryshkov@gmail.com>
References: <1433797008-6246-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <CALT56yMn5dCFNTco6Uk20zy0u5OtVJAHXhwRqEQAagdYCAErpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

2015-06-08 23:56 GMT+03:00 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>:
> Hello,
>
> Russell, I understand that you are quite busy. Could you please find
> a small amount of time to review and comment/ack the sa1100/collie-related
> parts of the patchset. It looks like this serie misses only your blessing.

Russell? Can we please have any feedback?

>
> Lee have agreed to merge this through the MFD tree, and the respective
> subsystem maintainers are also fine with this.
>
> Changes since V4:
>  * Added all Acked-by lines.
>  * Dropped the SPI patch - no reaction from Mark Brown onto the latest
>    version of the patch. It can go separately, as it adds new functionality.
>
> The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:
>
>   Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)
>
> are available in the git repository at:
>
>   git://git.infradead.org/users/dbaryshkov/zaurus.git locomo-v5
>
> for you to fetch changes up to 736e2f3b9c71c8baa0a260fcabe9a979e9bd8d5c:
>
>   ARM: drop old LoCoMo driver (2015-06-08 23:36:10 +0300)
>
> ----------------------------------------------------------------
> Dmitry Eremin-Solenikov (17):
>       mfd: add new driver for Sharp LoCoMo
>       leds: port locomo leds driver to new locomo core
>       input: convert LoCoMo keyboard driver to use new locomo core
>       input: locomokbd: differentiate between two Enter keys
>       input: make LoCoMo keyboard driver support both poodle and collie
>       video: backlight: add new locomo backlight driver
>       video: lcd: add LoCoMo LCD driver
>       gpio: port LoCoMo gpio support from old driver
>       gpio: locomo: implement per-pin irq handling
>       i2c: add locomo i2c driver
>       ARM: sa1100: make collie use new locomo drivers
>       ARM: sa1100: don't preallocate IRQ space for locomo
>       ASoC: pxa: poodle: make use of new locomo GPIO interface
>       ARM: pxa: poodle: use new LoCoMo driver
>       ARM: pxa: poodle: don't preallocate IRQ space for locomo
>       video: backlight: drop old locomo bl/lcd driver
>       ARM: drop old LoCoMo driver
>
>  arch/arm/common/Kconfig                    |   3 -
>  arch/arm/common/Makefile                   |   1 -
>  arch/arm/common/locomo.c                   | 914 -----------------------------
>  arch/arm/include/asm/hardware/locomo.h     | 221 -------
>  arch/arm/mach-pxa/Kconfig                  |   1 -
>  arch/arm/mach-pxa/include/mach/poodle.h    |   8 +-
>  arch/arm/mach-pxa/poodle.c                 |  58 +-
>  arch/arm/mach-sa1100/Kconfig               |   1 -
>  arch/arm/mach-sa1100/collie.c              | 213 +++++--
>  arch/arm/mach-sa1100/include/mach/collie.h |  16 +-
>  arch/arm/mach-sa1100/include/mach/irqs.h   |  19 +-
>  drivers/gpio/Kconfig                       |  13 +
>  drivers/gpio/Makefile                      |   1 +
>  drivers/gpio/gpio-locomo.c                 | 285 +++++++++
>  drivers/i2c/busses/Kconfig                 |  12 +
>  drivers/i2c/busses/Makefile                |   1 +
>  drivers/i2c/busses/i2c-locomo.c            | 135 +++++
>  drivers/input/keyboard/Kconfig             |   2 +-
>  drivers/input/keyboard/locomokbd.c         | 262 ++++-----
>  drivers/leds/Kconfig                       |   2 +-
>  drivers/leds/leds-locomo.c                 | 117 ++--
>  drivers/mfd/Kconfig                        |  10 +
>  drivers/mfd/Makefile                       |   1 +
>  drivers/mfd/locomo.c                       | 336 +++++++++++
>  drivers/video/backlight/Kconfig            |  16 +-
>  drivers/video/backlight/Makefile           |   3 +-
>  drivers/video/backlight/locomo_bl.c        | 153 +++++
>  drivers/video/backlight/locomo_lcd.c       | 285 +++++++++
>  drivers/video/backlight/locomolcd.c        | 255 --------
>  include/linux/mfd/locomo.h                 | 169 ++++++
>  sound/soc/pxa/poodle.c                     |  52 +-
>  31 files changed, 1862 insertions(+), 1703 deletions(-)
>  delete mode 100644 arch/arm/common/locomo.c
>  delete mode 100644 arch/arm/include/asm/hardware/locomo.h
>  create mode 100644 drivers/gpio/gpio-locomo.c
>  create mode 100644 drivers/i2c/busses/i2c-locomo.c
>  create mode 100644 drivers/mfd/locomo.c
>  create mode 100644 drivers/video/backlight/locomo_bl.c
>  create mode 100644 drivers/video/backlight/locomo_lcd.c
>  delete mode 100644 drivers/video/backlight/locomolcd.c
>  create mode 100644 include/linux/mfd/locomo.h
>



-- 
With best wishes
Dmitry
