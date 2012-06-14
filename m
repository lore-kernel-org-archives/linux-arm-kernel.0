From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 14 Jun 2012 10:11:00 -0400 (EDT)
Subject: [Patch v5 03/13] USB: notify phy when root hub port connect change
In-Reply-To: <20120614003653.GA29684@b20223-02.ap.freescale.net>
Message-ID: <Pine.LNX.4.44L0.1206141003100.1701-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 14 Jun 2012, Richard Zhao wrote:

> > > +	if (unlikely(hcd->phy && !hdev->level)) {
> > 
> > This is okay, but it's more common to test for root hubs with 
> > "!hdev->parent".
> So it will be like:
> if (unlikely(hcd->phy && !hdev->parent)) {

Yes.

> And,
> I didn't check (portchange & USB_PORT_STAT_C_CONNECTION), because if
> the device is connected on boot, there'll be no USB_PORT_STAT_C_CONNECTION.
> Is it acceptable?

Yes.  In fact the hub_port_debounce() routine turns off
USB_PORT_STAT_C_CONNECTION anyway.

Alan Stern
