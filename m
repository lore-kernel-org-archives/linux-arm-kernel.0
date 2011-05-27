From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 26 May 2011 21:22:43 -0600
Subject: [PATCH 0/4] Samsung: Move Samsung SoCs GPIO drivers to
	drivers/gpio
In-Reply-To: <20110521112102.GA11887@sirena.org.uk>
References: <20110520054441.GA9952@july>
	<20110520063128.GA21285@ponder.secretlab.ca>
	<20110521112102.GA11887@sirena.org.uk>
Message-ID: <20110527032243.GJ5032@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 21, 2011 at 12:21:02PM +0100, Mark Brown wrote:
> On Fri, May 20, 2011 at 12:31:28AM -0600, Grant Likely wrote:
> > On Fri, May 20, 2011 at 02:44:41PM +0900, Kyungmin Park wrote:
> > >  .../gpiolib.c => drivers/gpio/s5pc100-gpio.c       |    0
> > >  .../gpiolib.c => drivers/gpio/s5pv210-gpio.c       |    0
> > >  .../gpiolib.c => drivers/gpio/samsung-gpiolib.c    |    3 +-
> 
> > drivers/gpio/gpio-*.c please.  I'm starting to enforce some level of
> > naming convention.
> 
> Hrm, looking at the current mainline drivers the existing tendency seems
> to be mostly towards gpio/*-gpio.c...

However, drivers/i2c/busses is nicely organized with i2c-*.c, and a
lot of the spi drivers are drivers/spi/spi* (although it is a mixed
bag here).  I also personally prefer the drivers to have the type as
a prefix instead of a suffix, and I hope to reorganize both
drivers/spi and drivers/gpio to follow the i2c lead in the next
cycle.

True, this does come down to personal taste, but unless someone has a
really strong objection to it then I'll keep asking for new drivers to
use gpio- as a prefix.

g.
