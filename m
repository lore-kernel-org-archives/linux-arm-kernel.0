From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Tue, 4 Jun 2013 09:53:04 +0000
Subject: [PATCH 05/11] spi: omap2-mcspi: enhance pinctrl support
In-Reply-To: <20130601192726.GS16790@sirena.org.uk>
References: <1369995191-20855-1-git-send-email-gururaja.hebbar@ti.com>
 <1369995191-20855-6-git-send-email-gururaja.hebbar@ti.com>
 <20130601192726.GS16790@sirena.org.uk>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EC22370@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 02, 2013 at 00:57:26, Mark Brown wrote:
> On Fri, May 31, 2013 at 03:43:05PM +0530, Hebbar Gururaja wrote:
> > Amend the spi omap controller to optionally take a pin control
> > handle and set the state of the pins to:
> > 
> > - "default" on boot, resume and before performing an spi transfer
> > - "idle" after initial default, after resume default, and after each
> > spi xfer
> > - "sleep" on suspend()
> 
> Looking at this code I can't really see what's OMAP-specific about it -
> exactly the same flow should apply to pretty much any SPI controller,
> especially given that the code will happily ignore missing states.
> We're just setting the idle state when not actively transferring data
> which seems sensible and generic.
> 
> This suggests to me that we should be adding this code into the core,
> probably joined up with the transfer_one_message stuff, so that any
> hardware which has an idle state will be able to get the benefit.  Can
> anyone think of a reason why we shouldn't do that?

Let me pull out some info about these and come back

> 


Regards, 
Gururaja
