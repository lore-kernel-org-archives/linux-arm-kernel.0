From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Fri, 18 Feb 2011 19:28:05 +0100
Subject: platform/i2c busses: pm runtime and system sleep
In-Reply-To: <AANLkTinsPqFcodH0w7LQeFEY+amodNH4CneRCRhhbKaz@mail.gmail.com>
References: <AANLkTinyDE3OxKup_aqsN8HJH_r5LcwkP17OtuMRpACx@mail.gmail.com>
	<AANLkTikRUZRh0YnP8nYTKFnFeUiJbK5xKvHHjn_S+gZE@mail.gmail.com>
	<AANLkTinsPqFcodH0w7LQeFEY+amodNH4CneRCRhhbKaz@mail.gmail.com>
Message-ID: <201102181928.05911.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, February 18, 2011, Rabin Vincent wrote:
> On Thu, Feb 17, 2011 at 20:55, Rabin Vincent <rabin@rab.in> wrote:
> > This will solve the platform vs AMBA bus, but shouldn't we really be
> > aiming for consistent behaviour between these and the other busses such
> > as I2C and SPI, which are also usually commonly used on the same
> > platforms and are using GENERIC_PM_OPS?
> >
> > Should we be auditing all platform drivers and then switch platform to
> > the GENERIC_PM_OPS?
> >
> > Or should the two points (1) and (2) be not handled in the bus at all
> > and be left to individual drivers (in which case we should audit i2c and
> > spi and change GENERIC_PM_OPS)?
> 
> How about something like the below?  If we have something like this, we
> can just switch platform to GENERIC_PM_OPS and add the
> pm_runtime_want_interaction() (or something better named) call to the
> i2c and spi drivers using runtime PM.

Why don't we make platform_bus_type behave along the lines of generic ops
instead?

Rafael
