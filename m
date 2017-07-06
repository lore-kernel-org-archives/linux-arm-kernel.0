From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 6 Jul 2017 08:03:52 +0100
Subject: [PATCH 3/3] mfd: twl: move header file out of I2C realm
In-Reply-To: <20170706064453.GH16144@ulmo.fritz.box>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-4-wsa@the-dreams.de>
 <20170706064453.GH16144@ulmo.fritz.box>
Message-ID: <20170706070352.xdecvsnremwqed72@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 06 Jul 2017, Thierry Reding wrote:

> On Mon, May 22, 2017 at 12:02:10AM +0200, Wolfram Sang wrote:
> > include/linux/i2c is not for client devices. Move the header file to a
> > more appropriate location.
> > 
> > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> > ---
> >  arch/arm/mach-omap2/common.h            | 2 +-
> >  arch/arm/mach-omap2/omap_twl.c          | 2 +-
> >  drivers/gpio/gpio-twl4030.c             | 2 +-
> >  drivers/iio/adc/twl4030-madc.c          | 2 +-
> >  drivers/iio/adc/twl6030-gpadc.c         | 2 +-
> >  drivers/input/keyboard/twl4030_keypad.c | 2 +-
> >  drivers/input/misc/twl4030-pwrbutton.c  | 2 +-
> >  drivers/input/misc/twl4030-vibra.c      | 2 +-
> >  drivers/mfd/twl-core.c                  | 6 +++---
> >  drivers/mfd/twl4030-audio.c             | 2 +-
> >  drivers/mfd/twl4030-irq.c               | 2 +-
> >  drivers/mfd/twl4030-power.c             | 2 +-
> >  drivers/mfd/twl6030-irq.c               | 2 +-
> >  drivers/phy/phy-twl4030-usb.c           | 2 +-
> >  drivers/power/supply/twl4030_charger.c  | 2 +-
> >  drivers/pwm/pwm-twl-led.c               | 2 +-
> >  drivers/pwm/pwm-twl.c                   | 2 +-
> >  drivers/regulator/twl-regulator.c       | 2 +-
> >  drivers/regulator/twl6030-regulator.c   | 2 +-
> >  drivers/rtc/rtc-twl.c                   | 2 +-
> >  drivers/usb/phy/phy-twl6030-usb.c       | 2 +-
> >  drivers/video/backlight/pandora_bl.c    | 2 +-
> >  drivers/watchdog/twl4030_wdt.c          | 2 +-
> >  include/linux/{i2c => mfd}/twl.h        | 0
> >  sound/soc/codecs/twl4030.c              | 2 +-
> >  25 files changed, 26 insertions(+), 26 deletions(-)
> >  rename include/linux/{i2c => mfd}/twl.h (100%)
> 
> I didn't see this get applied yet, so just in case anyone was waiting
> for me (this is trivial, so I don't think there's a need):

You're not the last. :)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
