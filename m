From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 6 Jun 2012 09:27:44 +0800
Subject: [PATCH v3 03/12] usb: ehci-hcd: notify phy when connect change
In-Reply-To: <Pine.LNX.4.44L0.1206051328430.1542-100000@iolanthe.rowland.org>
References: <201206051923.09063.marex@denx.de>
 <Pine.LNX.4.44L0.1206051328430.1542-100000@iolanthe.rowland.org>
Message-ID: <20120606012743.GA16929@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2012 at 01:30:08PM -0400, Alan Stern wrote:
> On Tue, 5 Jun 2012, Marek Vasut wrote:
> 
> > > > > Do the tests in the opposite order and add "unlikely":
> > > > > 			if (unlikely(ehci->transceiver &&
> > > > > 			
> > > > > 					(pstatus & PORT_CSC)) {
> > > > > 
> > > > > That way it will fail more quickly on systems where it doesn't apply or
> > > > > for unaffected ports.
> > > > 
> > > > Does this unlikely() have any effect on ARM/MIPS/PPC, where this chipidea
> > > > IP is used ? Or is there some x86 device sporting this IP too?
> > > 
> > > I don't know what unlikely() does on architectures other than x86.
> > 
> > It should be optimized out to nothing on anything else but x86. On x86 it is a 
> > hint for the branch predictor. Or that's what I believe it is.
> 
> That's right.  Then it should have no effect on ARM/MIPS/PPC.
I prefer add the unlikely, we don't need to care about the arch
implementation. Maybe it'll be implemented some day if it don't. and
at least the code tell the reader the condition is unlikely.

I'll post a update to this series.

Thanks
Richard
> 
> > > And
> > > I haven't heard of any x86 systems that would need to use this code.
> > >
> > > On the other hand, port-status changes don't occur very frequently.  A
> > > little time penalty one way or the other won't make much difference.
> > 
> > I'm not opposed, just curious :)
> 
> No big deal either way.  But the order of the tests should be switched, 
> because on most systems, ehci->transceiver will be NULL.
> 
> Alan Stern
> 
> 
