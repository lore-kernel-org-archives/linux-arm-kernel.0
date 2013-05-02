From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 2 May 2013 19:55:08 +0200
Subject: [PATCH, RFC 15/22] USB: EHCI: remove bogus #error
In-Reply-To: <Pine.LNX.4.44L0.1305021333020.1436-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1305021333020.1436-100000@iolanthe.rowland.org>
Message-ID: <201305021955.08470.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 May 2013, Alan Stern wrote:
> On Thu, 2 May 2013, Arnd Bergmann wrote:
> 
> > The EHCI host controller driver can be built standalone now,
> > without enabling any of the available bus glue drivers, so
> > there is not really a reason to error out here:
> 
> On the other hand, there's no reason to build the driver without any 
> bus glue.  It wouldn't do anything.

Yes, as I mention below, we could also use Kconfig logic to prevent
that case, as the OHCI and UHCI patches from this series do, but I felt
that would be a lot of unnecessary churn, and having just ehci-hci.ko
enabled without a bus glue is not an error, it's just as pointless
as most of the other drivers we get with "make randconfig".

> > drivers/usb/host/ehci-hcd.c:1303:2: error:
> >  #error "missing bus glue for ehci-hcd"  #error "missing bus glue for ehci-hcd"
> > 
> > The alternative would be to change the Kconfig code to build
> > the ehci-hcd module only if any of the symbols below are
> > in fact enabled.

	Arnd
