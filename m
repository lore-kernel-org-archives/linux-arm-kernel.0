From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 Jan 2016 07:39:34 +0000
Subject: [PATCH v6 4/9] mfd: axp20x: Split the driver into core and i2c
 bits
In-Reply-To: <CAGb2v65hCaCJAhBvuLugfD=5mzFQdMfktOTwbCO_CM04UtYemw@mail.gmail.com>
References: <1450283538-25067-1-git-send-email-wens@csie.org>
 <1450283538-25067-5-git-send-email-wens@csie.org>
 <20160111092530.GL14104@x1>
 <CAGb2v65hCaCJAhBvuLugfD=5mzFQdMfktOTwbCO_CM04UtYemw@mail.gmail.com>
Message-ID: <20160112073934.GJ19803@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Jan 2016, Chen-Yu Tsai wrote:

> Hi,
> 
> On Mon, Jan 11, 2016 at 5:25 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Thu, 17 Dec 2015, Chen-Yu Tsai wrote:
> >
> >> The axp20x driver assumes the device is i2c based. This is not the
> >> case with later chips, which use a proprietary 2 wire serial bus
> >> by Allwinner called "Reduced Serial Bus".
> >>
> >> This patch follows the example of mfd/wm831x and splits it into
> >> an interface independent core, and an i2c specific glue layer.
> >> MFD_AXP20X and the new MFD_AXP20X_I2C are changed to tristate
> >> symbols, allowing the driver to be built as modules.
> >>
> >> Whitespace and other style errors in the moved i2c specific code
> >> have been fixed. Included but unused header files are removed as
> >> well.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> ---
> >>  drivers/mfd/Kconfig        |  14 ++++---
> >>  drivers/mfd/Makefile       |   1 +
> >>  drivers/mfd/axp20x-i2c.c   | 102 +++++++++++++++++++++++++++++++++++++++++++++
> >>  drivers/mfd/axp20x.c       |  88 +++++++-------------------------------
> >>  include/linux/mfd/axp20x.h |  33 ++++++++++++++-
> >>  5 files changed, 158 insertions(+), 80 deletions(-)
> >>  create mode 100644 drivers/mfd/axp20x-i2c.c
> >
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> >
> 
> [..]
> 
> >> diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
> >> new file mode 100644
> >> index 000000000000..b54205677bb2
> >> --- /dev/null
> >> +++ b/drivers/mfd/axp20x-i2c.c
> >> @@ -0,0 +1,102 @@
> >> +/*
> >> + * axp20x-i2c.c - I2C driver for the X-Powers' Power Management ICs
> 
> Do you want me to remove the filenames from these 2 files (axp20x.c and
> axp20x-i2c.c) as well?

Yes, that would be good.

> >> + * AXP20x typically comprises an adaptive USB-Compatible PWM charger, BUCK DC-DC
> >> + * converters, LDOs, multiple 12-bit ADCs of voltage, current and temperature
> >> + * as well as configurable GPIOs.
> >> + *
> >> + * This driver supports the I2C variants.
> >> + *
> >> + * Author: Carlo Caione <carlo@caione.org>
> 
> Not sure about the copyright, since it's not mine.

Perhaps shoot Carlo an email to see what he thinks.

> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License version 2 as
> >> + * published by the Free Software Foundation.
> >> + */
> >> +
> 
> [..]
> 
> Regards
> ChenYu

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
