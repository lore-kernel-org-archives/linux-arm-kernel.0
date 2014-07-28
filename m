From: andriy.shevchenko@intel.com (Shevchenko, Andriy)
Date: Mon, 28 Jul 2014 11:56:25 +0000
Subject: [PATCH] spi/pxa2xx-pci: Enable DMA binding through device name
In-Reply-To: <1406545580.8530.28.camel@smile.fi.intel.com>
References: <1406196111-22861-1-git-send-email-hock.leong.kweh@intel.com>
 <5426556.OzZIXLrofJ@wuerfel> <1406285147.8530.13.camel@smile.fi.intel.com>
 <5237362.DJsH7MtqlU@wuerfel> <1406545580.8530.28.camel@smile.fi.intel.com>
Message-ID: <1406548584.8530.35.camel@smile.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-07-28 at 14:06 +0300, Andy Shevchenko wrote:
> On Fri, 2014-07-25 at 17:55 +0200, Arnd Bergmann wrote:
> > On Friday 25 July 2014 13:45:47 Andy Shevchenko wrote:

[]

> > > > What I think you got wrong here (by following my bad advice) is the master
> > > > number. Looking at the code for dw_dma, I think src_master needs to be '1'
> > > > for your driver.
> > > 
> > > On some SoCs we have up to 4 masters. It's blurry for me how the SPI
> > > should choose those masters. Currently it works fine, but I suspect
> > > there are [might be] performance issues.
> > 
> > I think it works because the dw-dma defaults to the values used by
> > the specific implementation in your hardware.

[Missed in previous email]

Actually the defaults came from original driver for AVR32 case.

Regarding to DW DMA databook the AHB masters could be used each by any
channel, though it depends on what AHB layer is bound to (and
corresponding peripheral device).

Thus, like I said we might have the [minor] performance issues if we
use, for example, two out of four masters.

-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy
---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
