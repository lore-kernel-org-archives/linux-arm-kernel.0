From: marc@cpdesign.com.au (Marc Reilly)
Date: Fri, 17 Dec 2010 17:44:34 +1100
Subject: [PATCHv2] mc13xxx: Add i2c support for mc13xxx-core
In-Reply-To: <20101216092032.GA4209@pengutronix.de>
References: <1292449675-20308-1-git-send-email-marc@cpdesign.com.au>
	<20101216090210.GE1940@pengutronix.de>
	<20101216092032.GA4209@pengutronix.de>
Message-ID: <201012171744.34075.marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> >      (BTW, did you fix the dependencies?  Currently you need to depend
> >      on I2C && SPI.  (Not sure these are the correct names, you may want
> >      to double check that.))
> 
> Be careful, this is a subtle issue. You will get unresolved symbols if your
> chip is connected via SPI, and <driver>=y, SPI=y, together with I2C=m. Been
> there.
> 
How quickly a "simple" patch gets complicated. :)

Am I right in thinking that in the above scenario (assuming it was coerced 
into compiling) the mc13xxx i2c driver would never get registered even after 
the i2c module is insmod'ed?

Sounds like the only way to handle this is by splitting the spi and i2c... 

> >      This is more flexible but IMHO not worth the effort.
> 
> I had to do it back then :( I wondered if there couldn't be a generic way
> to deal with SPI+I2C-drivers, never got to investigate it, though.
> 

Looking at some of the other mfd drivers, it seems that's the way they've gone 
too.

> Also, be sure to CC i2c- and spi-lists when you do the next version.

Will do.

Cheers,
Marc
