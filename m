From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 1 Aug 2012 08:45:19 +0200
Subject: [06/10,V2] spi: Add SPI driver for mx233/mx28
In-Reply-To: <20120801063936.GC2764@roeck-us.net>
References: <1341555449-17507-6-git-send-email-marex@denx.de>
 <201208010810.37652.marex@denx.de> <20120801063936.GC2764@roeck-us.net>
Message-ID: <201208010845.19361.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Guenter Roeck,

> On Wed, Aug 01, 2012 at 08:10:37AM +0200, Marek Vasut wrote:
> > Dear Shawn Guo,
> > 
> > > On Tue, Jul 31, 2012 at 10:42:28PM -0700, Guenter Roeck wrote:
> > > > On Wed, Aug 01, 2012 at 01:58:56PM +0800, Shawn Guo wrote:
> > > > > On Tue, Jul 31, 2012 at 10:29:47PM -0700, Guenter Roeck wrote:
> > > > > > Anyone up for writing some patches ? If not, I'll do it.
> > > > > 
> > > > > Go ahead.
> > > > 
> > > > Ok, will do. It isn't that simple, actually, since at least some of
> > > > the drivers also call spi_master_get(), and thus need two calls to
> > > > spi_master_put() (or a call to spi_master_put and a call to kfree).
> > > 
> > > Hmm, are you saying that there must be a spi_master_put call matching
> > > spi_alloc_master?  I think we only need to have spi_master_get and
> > > spi_master_put matched.
> > 
> > Naw, spi_master_get() does refcounting, spi_alloc_master() doesnt. You
> > don't need to match spi_alloc_master() with spi_master_put()
> 
> I must be missing something.  Why do almost all spi drivers call it in the
> error path, even if there is no call to spi_master_get ?

To push the refcounting to 0, to deallocate the device, I'd say ...

Best regards,
Marek Vasut
