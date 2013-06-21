From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 21 Jun 2013 12:33:02 -0400 (EDT)
Subject: [PATCH V2 5/6] USB: OHCI: make ohci-at91 a separate driver
In-Reply-To: <CAJFYCKGLZaS_naUedZ3qVqPQMQnh-cqoyE=5EmxXegCbCT9SNQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1306211229540.1020-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Jun 2013, Manjunath Goudar wrote:

> On 20 June 2013 22:23, Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > On Thu, 20 Jun 2013, Manjunath Goudar wrote:
> >
> > > > > @@ -686,7 +631,7 @@ ohci_hcd_at91_drv_suspend(struct platform_device
> > > > *pdev, pm_message_t mesg)
> > > > >        * REVISIT: some boards will be able to turn VBUS off...
> > > > >        */
> > > > >       if (at91_suspend_entering_slow_clock()) {
> > > > > -             ohci_usb_reset (ohci);
> > > > > +             ohci_restart(ohci);
> > > >
> > > > Why did you change this?  Did we discuss it earlier?
> > > >
> > >
> > > We are not discussed  regarding this,I think we need to call
> > > use ohci_resume() instead of ohci_restart().
> >
> > Why?  Don't you think the current code has a good reason for calling
> > ohci_usb_reset()?
> >
> >
> Here ohci_usb_reset() is static function,that is what I am planing to call
> ohci_setup() or ohci_restart() because it is calling  ohci_usb_reset(),
> If not calling, we can make ohci_usb_reset() function as non-static
> function
> or use directly  ohci_usb_reset() function code here.
> 
> Let me know which one is good approach.

As a general rule, you should never change code that you don't 
understand.  Do you _know_ that it will be safe to call ohci_setup() or 
ohci_restart() at this point?

It might be a good idea to get in touch with the person who wrote that
routine originally and ask why they used ohci_usb_reset().

Alan Stern
