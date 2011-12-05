From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 5 Dec 2011 10:33:16 +0000
Subject: [PATCH] backlight: add regulator support for platform_lcd driver
In-Reply-To: <CAH9JG2XJ4TCEaN1rMRjMZNRn5Wx6jcTRC_DmyN4Qyf2zztWSsg@mail.gmail.com>
References: <1323074921-29291-1-git-send-email-thomas.abraham@linaro.org>
 <CAH9JG2XJ4TCEaN1rMRjMZNRn5Wx6jcTRC_DmyN4Qyf2zztWSsg@mail.gmail.com>
Message-ID: <20111205103315.GB11150@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2011 at 07:10:03PM +0900, Kyungmin Park wrote:

> > +		if (plcd->pdata->min_uV || plcd->pdata->max_uV)
> > +			if (regulator_set_voltage(lcd_regulator,
> > +				plcd->pdata->min_uV, plcd->pdata->max_uV))
> > +				dev_info(plcd->us,
> > +					"regulator voltage set failed\n");

> Are there case to change the voltage? Doesn't it easy to set the
> voltage at board file? I mean don't need to setup at drivers?

Yes, unless the driver changes the voltage it should just assume the
voltage is already set up sensibly and leave it up to the board to
do any configuration which is required on boot.

There is one existing driver which implements things this way in the
video subsystem but that should be fixed.
