From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2016 15:16:12 +0100
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <87y47ykzmz.fsf@intel.com>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <13248156.8VXoeOzRlg@wuerfel> <8737q6stpl.fsf@ti.com>
 <5129992.Q57qoSDEqC@wuerfel> <87y47ykzmz.fsf@intel.com>
Message-ID: <20160428141611.GK19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2016 at 09:37:08AM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> Arnd Bergmann <arnd@arndb.de> writes:
> >    pointer and pass that in platform_data. This is really easy, it's
> 
> Sorry but passing a struct device pointer in platform_data is
> ridiculous. Not to mention that, as I said before, we can't assume which
> device to pass to xhci_plat in the first place. It might be dwc->dev and
> it might be dwc->dev->parent.

+1.  Passing an unref-counted struct device through platform data is
totally mad, Arnd you're off your rocker if you think that's a good
idea.  What's more is that there's no way to properly refcount the
thing.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
