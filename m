From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 29 Jul 2012 13:11:07 +0000
Subject: [PATCH 2/8 v2] ARM: EXYNOS5: Add machine data for USB 2.0
In-Reply-To: <CAFp+6iH0c=LogUXnpg0pD05X+mMGP9XiWDDxiTyNQAxJq_srJg@mail.gmail.com>
References: <1342866729-30460-1-git-send-email-gautam.vivek@samsung.com>
 <201207261124.50141.arnd@arndb.de>
 <CAFp+6iH0c=LogUXnpg0pD05X+mMGP9XiWDDxiTyNQAxJq_srJg@mail.gmail.com>
Message-ID: <201207291311.08012.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 28 July 2012, Vivek Gautam wrote:
> > Can you pleae explain why this is done in the changelog?
> >
> > We try hard to do such mappings from the device driver instead,
> > so I'm surprised that this is necessary fo rthe USB phy.
> >
> 
> We are doing the mapping for device address in the driver, but this memory
> mapping for USB PHY registers that need to be programmed by the software
> is done here. This is similar to what we see for exynos4 also. Is it
> something
> that i can still change? Please suggest.


Yes, I think the USB PHY handling for all exynos chips should be changed
from an ad-hoc method to a more formal device driver. As I commented
in another patch of this series, I think the main problem is that
treat the USB PHY as a property of the "platform", which it really isn't.

We have a bunch of other USB PHY drivers for other platforms that are
inside of the drivers/usb hierarchy. For all I know, there is no formal
USB PHY driver API yet, and it seems that it would be a good idea to
introduce one now, but for now, just move the code to
drivers/usb/phy/ and make it one file per different kind of PHY.

	Arnd
