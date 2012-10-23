From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 23 Oct 2012 15:33:43 -0400 (EDT)
Subject: [PATCH v2 2/2] USB: doc: Binding document for ehci-platform driver
In-Reply-To: <5086E62D.8040407@wwwdotorg.org>
Message-ID: <Pine.LNX.4.44L0.1210231522230.1635-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Oct 2012, Stephen Warren wrote:

> > Nothing intrinsically distinguishes this class of hardware.  The only
> > thing these devices have in common is that they can be managed by
> > Linux's ehci-platform driver.
> 
> I don't agree. They're all EHCI USB controllers (or all EHCI USB
> controllers that don't require custom drivers due to quirks), which is a
> much more general statement than anything related to which driver Linux
> uses for them.

That's true, but it doesn't distinguish these devices.  There are other
EHCI controllers with no quirks that nevertheless can't be handled by
ehci-platform because they have requirements (_not_ quirks) that
ehci-platform is unable to deal with currently -- clocks or power
supplies or special register settings or PHYs or etc.

> > In essense, we're trying to say that the HW is compatible with a 
> > particular driver rather than with some other type of HW.
> 
> Using a compatible value in order to pick a specific driver in Linux is
> explicitly against the device tree design principles; DT is supposed to
> represent just the hardware.
> 
> > Maybe DT
> > wasn't intended to provide this kind of information, but it seems like 
> > a logical thing to do.  Unless DT already offers some other way to 
> > accomplish the same thing?
> 
> The typical way is for the Linux driver to declare that is supports a
> variety of different HW models.
> 
> Admittedly this is annoying when there are many HW models that otherwise
> wouldn't need any driver changes, hence the desire to (additionally)
> include some generic value in the compatible field, but again, what that
> generic value is should be driven by the HW itself, not the SW that's
> using it.

Okay, fine.  But then what should the binding documentation specify for
the compatible value?  A list of all the HW models that the driver
currently supports?

Alan Stern
