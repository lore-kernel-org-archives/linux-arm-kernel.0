From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 19 Jan 2012 05:54:39 -0700
Subject: [PATCH 2/3] mfd: mc13xxx-core: Move spi specific code into
 separate module.
In-Reply-To: <20120119080843.GC4066@pengutronix.de>
References: <1326934894-29516-1-git-send-email-marc@cpdesign.com.au>
 <1326934894-29516-3-git-send-email-marc@cpdesign.com.au>
 <20120119080843.GC4066@pengutronix.de>
Message-ID: <20120119125439.GR4223@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2012 at 09:08:43AM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Thu, Jan 19, 2012 at 12:01:33PM +1100, Marc Reilly wrote:
> > All spi specific code is moved into a new module. The mc13xxx
> > struct moves to the include file by necessity.
> > 
> > A new config choice selects the bus type with SPI as the first item
> > (default selection) to remain compatible with existing configs.
> > 
> > Signed-off-by: Marc Reilly <marc@cpdesign.com.au>
> > ---
> > +choice
> > +	tristate "MC13XXX Bus interface type"
> > +	depends on MFD_MC13XXX
> > +	default MFD_MC13XXX_SPI
> > +	help
> > +	  The MC13XXX family can be connected over an SPI or I2C bus.
> > +	  Select the appropriate option for your hardware configuration.
> > +
> > +config MFD_MC13XXX_SPI
> > +	tristate "SPI interface"
> > +	depends on SPI_MASTER
> > +	help
> > +	  Select this if your MC13xxx is connected via an SPI bus.
> > +
> > +endchoice
> > +
> Hmm, you cannot have both, spi and i2c support?

+1 on Uwe's comment.  We're going multiplatform.  I2C and SPI support
should not be mutually exclusive.

g.
