From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 17 Jun 2013 10:01:23 -0400 (EDT)
Subject: [PATCh V10 04/12] usb: ehci: ehci-mv: use PHY driver for ehci
In-Reply-To: <CADApbehH9wrNZEmAN=3ZWGMXA7Jetgd+VpWfMRBSX0AqUeG0pg@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1306171000080.1437-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Jun 2013, Chao Xie wrote:

> > To avoid PHY init/shutdown, the platform driver should simply leave the
> > generic PHY pointer (which has not yet been added to struct hcd) set to
> > NULL.
> >
> So does it mean that i need add adtional usb_phy to struct hcd?

Ah, I was wrong.  There already is a PHY pointer in struct usb_hcd.  
You don't need to add another one.

> I think we can still make use of struct hcd->phy without add addtional members.
> For OMAP transceiver-less mode, you can still use your own phy init/shutdown and
> leave the hcd->phy to be NULL, and for the PHY mode, hcd->phy can be
> set. It will
> do ->init at usb_add_hcd and ->shutdown at usb_remove_hcd.

That's right.

Alan Stern
