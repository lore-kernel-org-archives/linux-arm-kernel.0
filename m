From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 24 Jul 2013 11:58:29 -0400 (EDT)
Subject: [PATCH 2/6] USB: OHCI: make ohci-omap a separate driver
In-Reply-To: <CAJFYCKGEKNLmy4o6KRMmxjuSYMXaXdbNxodcyXtOSReONa0hLg@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1307241157230.1313-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Jul 2013, Manjunath Goudar wrote:

> > I suspect there's a mistake here, and the omap_ohci_clock_power() call
> > perhaps should be moved after the "err3:" label.  But that mistake (if
> > it is a mistake) was present in the original code, and this patch
> > shouldn't change it.
> >
> 
>  Before omap_ohci_clock_power(0) was calling dependence on host_enabled
>  value was set or not. We rid the of host_enabled.

I know.  I was the person who told you to do that.

> Now my approach is as below, to avoid the omap_ohci_clock_power(0) issue:
> 
>     retval = usb_add_hcd(hcd, irq, 0);
>  +       if (retval == 0)
>     +            return retval;
> 
> /* I thought  here clock disable is required before any of
> errX statement execute
>     please comment on this*/
>    + omap_ohci_clock_power(0);
> err3:
>        iounmap(hcd->regs);
> 
> What about your suggestion?

I don't know.  You should ask the person who wrote this driver 
originally.

Alan Stern
