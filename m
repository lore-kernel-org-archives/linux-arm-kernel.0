From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 30 May 2013 10:23:27 -0400 (EDT)
Subject: [PATCh V10 04/12] usb: ehci: ehci-mv: use PHY driver for ehci
In-Reply-To: <51A73BD8.8000007@ti.com>
Message-ID: <Pine.LNX.4.44L0.1305301020230.1321-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 May 2013, Roger Quadros wrote:

> >> So what are your idea about making the PHY layer more generic? How
> >> ehci-hcd will make use of PHY layer?
> > 
> > 
> > on probe grab the phy and initialize it. On suspend/resume,
> > suspend/resume the PHY and so on. Whatever you were going to do on your
> > ehci glue, do it on generic ehci-hcd.
> > 
> 
> These operations sound generic enough to be done at HCD layer, no? So no need to
> replicate the same stuff in ohci, ehci, xhci, etc.

The HCD layer handles suspend and resume only for PCI host controllers.  
Not for other types.

I don't know if the acquire/start and stop/release parts can be moved 
into the USB core.  Maybe they can.

Alan Stern
