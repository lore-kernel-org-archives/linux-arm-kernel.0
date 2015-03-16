From: tony@atomide.com (Tony Lindgren)
Date: Mon, 16 Mar 2015 08:29:39 -0700
Subject: [PATCH v6 6/6] wlcore: remove wl12xx_platform_data
In-Reply-To: <2070859.WcMooC33YH@wuerfel>
References: <1426162154-8716-1-git-send-email-eliad@wizery.com>
 <20150313151301.GJ5264@atomide.com>
 <CAB3XZEdFMQexA69JEuw=VnqsNOEkWAM0+oWWmt6DaN9+hZ+vdw@mail.gmail.com>
 <2070859.WcMooC33YH@wuerfel>
Message-ID: <20150316152939.GP5264@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [150315 05:10]:
> On Sunday 15 March 2015 10:50:42 Eliad Peller wrote:
> > yeah, i missed it :/
> > 
> > looks like there's no platform that defines platform data for it.
> > i'll replace the dev_get_platdata() with a function that only parses
> > the clock-frequency properties (the irq is taken in this case from the
> > spi_device).
> > (or maybe i should just drop it, as no one actually uses it?)
> 
> I don't think we should drop the driver, but dropping the platform_data
> support sounds reasonable. New users of this driver should all be using
> DT, and if there is a good reason to use platform_data, it's easily
> put back.

Well we have n8x0 and n900 using the spi driver. For those, n8x0 boot
all in dts mode, but n900 still also boots in legacy mode. It seems the
board-rx51-peripherals.c only passes the power_gpio though, so that
should be easy to keep around.

We should keep things still working for n900 in legacy mode until the
pending regressions with device tree based booting have been cleared
for at least one merge cycle. I believe the last pending issues is the
support for ATAG_REVISION in device tree mode as posted by Pali.

Regards,

Tony
