From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 16 Oct 2013 10:36:45 -0400 (EDT)
Subject: [PATCH] usb: ohci: remove ep93xx bus glue platform driver
In-Reply-To: <DC148C5AA1CEBA4E87973D432B1C2D8817DADDF6@P3PWEX4MB008.ex4.secureserver.net>
Message-ID: <Pine.LNX.4.44L0.1310161034500.1264-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Oct 2013, Hartley Sweeten wrote:

> > This is definitely not a show-stopper in any way, but since this is
> > just standard clock management, could you even move these clock ops
> > into the driver? Are any other platforms already doing similar things
> > so you could remove code from their platform that way as well, per
> > chance?
> 
> It does not appear any of the other users of the ohci-platform driver do
> anything similar.
> 
> The clock ops could be moved into the driver but I will need to add a
> flag or something to the usb_ohci_pdata so that the platform can
> indicated that a clock is required and  the clock ops should be done.

Adding a new entry to usb_ohci_pdata would be acceptable.

However, I'm doubtful about how generic such a change would be.  Some
of the platform drivers don't use any clocks, and others use more than
one.  For now, it seems best to keep such dependencies in the
platform-specific code.

Alan Stern
