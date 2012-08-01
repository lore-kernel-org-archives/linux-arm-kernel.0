From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 31 Jul 2012 22:29:47 -0700
Subject: [06/10,V2] spi: Add SPI driver for mx233/mx28
In-Reply-To: <201208010700.54829.marex@denx.de>
References: <1341555449-17507-6-git-send-email-marex@denx.de>
 <20120801033559.GB2323@roeck-us.net>
 <20120801045010.GC1672@S2100-06.ap.freescale.net>
 <201208010700.54829.marex@denx.de>
Message-ID: <20120801052947.GA2400@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 01, 2012 at 07:00:54AM +0200, Marek Vasut wrote:
> Dear Shawn Guo,
> 
> > On Tue, Jul 31, 2012 at 08:35:59PM -0700, Guenter Roeck wrote:
> > > I think the call to spi_master_put() triggers the call to
> > > spi_master_release(). If so, kfree() would not be needed at all, and the
> > > documentation is wrong.
> > 
> > Also those drivers calling kfree in probe.
> 
> Looks like that to me ...
> 
Doesn't seem to be far spread, fortunately. Only spi-davinci.c, spi-imx.c, and
spi-omap2-mcspi.c as far as I can see, plus the misleading comment in spi.c.

Anyone up for writing some patches ? If not, I'll do it.

Thanks,
Guenter
