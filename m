From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 1 Aug 2012 08:41:34 +0200
Subject: [06/10,V2] spi: Add SPI driver for mx233/mx28
In-Reply-To: <20120801063639.GB2764@roeck-us.net>
References: <1341555449-17507-6-git-send-email-marex@denx.de>
 <CAM=Q2csm1m8DCd8__NAUCmk6AN=Czg_=nm4c3ervAgOhOtoMTw@mail.gmail.com>
 <20120801063639.GB2764@roeck-us.net>
Message-ID: <201208010841.34805.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Guenter Roeck,

> On Wed, Aug 01, 2012 at 11:16:15AM +0530, Shubhrajyoti Datta wrote:
> > On Wed, Aug 1, 2012 at 10:59 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> > > On Wed, Aug 01, 2012 at 07:00:54AM +0200, Marek Vasut wrote:
> > >> Dear Shawn Guo,
> > >> 
> > >> > On Tue, Jul 31, 2012 at 08:35:59PM -0700, Guenter Roeck wrote:
> > >> > > I think the call to spi_master_put() triggers the call to
> > >> > > spi_master_release(). If so, kfree() would not be needed at all,
> > >> > > and the documentation is wrong.
> > >> > 
> > >> > Also those drivers calling kfree in probe.
> > >> 
> > >> Looks like that to me ...
> > > 
> > > Doesn't seem to be far spread, fortunately. Only spi-davinci.c,
> > > spi-imx.c, and spi-omap2-mcspi.c
> > 
> > I have a  omapsdp I could patch spi-omap2-mcspi.c  file thanks for the
> > catch.
> 
> For that it would be good to determine if there is a memory leak when
> removing the driver (I don't see where the memory allocated with
> spi_alloc_master is removed).

When the refcounting for the device reaches 0, it's deallocated. (Aka _put long 
enough and it'll disappear)

> Thanks,
> Guenter

Best regards,
Marek Vasut
