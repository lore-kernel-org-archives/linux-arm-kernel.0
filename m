From: marex@denx.de (Marek Vasut)
Date: Wed, 1 Aug 2012 06:48:05 +0200
Subject: [06/10,V2] spi: Add SPI driver for mx233/mx28
In-Reply-To: <20120801035333.GB1672@S2100-06.ap.freescale.net>
References: <1341555449-17507-6-git-send-email-marex@denx.de>
 <201208010431.04399.marex@denx.de>
 <20120801035333.GB1672@S2100-06.ap.freescale.net>
Message-ID: <201208010648.05325.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Wed, Aug 01, 2012 at 04:31:04AM +0200, Marek Vasut wrote:
> > > Couple of reasons for asking: No other SPI master driver calls it in
> > > the remove function (unless I missed it), most drivers don't call it
> > > in the probe function error path, and if I call it in the remove
> > > function in a SPI master driver I am working on, and load/unload the
> > > module several times in a row, I get a nasty kernel crash.
> > 
> > It seems the spi_master class takes care of that kfree() in
> > spi.c:spi_master_release() . Good catch, thanks!
> 
> I do not hardware setup to confirm that right away.  When
> spi_master_release will be called exactly?  The time that
> spi_master_put gets called?  I'm trying to understand if the kfree
> is not needed only in remove function, or both probe and remove.

I checked, it's called in both cases ... (if .probe() crashes, release() is 
called, so kfree() is unneeded)

> Regards,
> Shawn

Best regards,
Marek Vasut
