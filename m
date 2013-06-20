From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 20 Jun 2013 12:53:32 -0400 (EDT)
Subject: [PATCH V2 5/6] USB: OHCI: make ohci-at91 a separate driver
In-Reply-To: <CAJFYCKGaq5cQFRkXpD0jCwbrLF5R5MtDLJiaZSG6GMuZLaX5AA@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1306201252400.2063-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Jun 2013, Manjunath Goudar wrote:

> > > @@ -686,7 +631,7 @@ ohci_hcd_at91_drv_suspend(struct platform_device
> > *pdev, pm_message_t mesg)
> > >        * REVISIT: some boards will be able to turn VBUS off...
> > >        */
> > >       if (at91_suspend_entering_slow_clock()) {
> > > -             ohci_usb_reset (ohci);
> > > +             ohci_restart(ohci);
> >
> > Why did you change this?  Did we discuss it earlier?
> >
> 
> We are not discussed  regarding this,I think we need to call
> use ohci_resume() instead of ohci_restart().

Why?  Don't you think the current code has a good reason for calling 
ohci_usb_reset()?

Alan Stern
