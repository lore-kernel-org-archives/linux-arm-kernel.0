From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 31 Jul 2012 20:35:59 -0700
Subject: [06/10,V2] spi: Add SPI driver for mx233/mx28
In-Reply-To: <20120801035333.GB1672@S2100-06.ap.freescale.net>
References: <1341555449-17507-6-git-send-email-marex@denx.de>
 <20120731205300.GA25721@roeck-us.net>
 <201208010431.04399.marex@denx.de>
 <20120801035333.GB1672@S2100-06.ap.freescale.net>
Message-ID: <20120801033559.GB2323@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 01, 2012 at 11:53:36AM +0800, Shawn Guo wrote:
> On Wed, Aug 01, 2012 at 04:31:04AM +0200, Marek Vasut wrote:
> > > Couple of reasons for asking: No other SPI master driver calls it in the
> > > remove function (unless I missed it), most drivers don't call it in the
> > > probe function error path, and if I call it in the remove function in a
> > > SPI master driver I am working on, and load/unload the module several
> > > times in a row, I get a nasty kernel crash.
> > 
> > It seems the spi_master class takes care of that kfree() in 
> > spi.c:spi_master_release() . Good catch, thanks!
> > 
> I do not hardware setup to confirm that right away.  When
> spi_master_release will be called exactly?  The time that
> spi_master_put gets called?  I'm trying to understand if the kfree
> is not needed only in remove function, or both probe and remove.
> 
I think the call to spi_master_put() triggers the call to spi_master_release().
If so, kfree() would not be needed at all, and the documentation is wrong.

Thanks,
Guenter
