From: marex@denx.de (Marek Vasut)
Date: Tue, 5 Jun 2012 19:23:08 +0200
Subject: [PATCH v3 03/12] usb: ehci-hcd: notify phy when connect change
In-Reply-To: <Pine.LNX.4.44L0.1206051250400.1542-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1206051250400.1542-100000@iolanthe.rowland.org>
Message-ID: <201206051923.09063.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Alan Stern,

> On Tue, 5 Jun 2012, Marek Vasut wrote:
> > > > > +			/* FIXME:
> > > > > +			 * - it does not work for multi-phy ehci
> > > > > +			 * - the best place is after debounce, but I 
can't get
> > > > > +			 *   phy there
> > > > > +			 */
> > > > > +			if ((pstatus & PORT_CSC) && ehci->transceiver) {
> > > 
> > > Do the tests in the opposite order and add "unlikely":
> > > 			if (unlikely(ehci->transceiver &&
> > > 			
> > > 					(pstatus & PORT_CSC)) {
> > > 
> > > That way it will fail more quickly on systems where it doesn't apply or
> > > for unaffected ports.
> > 
> > Does this unlikely() have any effect on ARM/MIPS/PPC, where this chipidea
> > IP is used ? Or is there some x86 device sporting this IP too?
> 
> I don't know what unlikely() does on architectures other than x86.

It should be optimized out to nothing on anything else but x86. On x86 it is a 
hint for the branch predictor. Or that's what I believe it is.

> And
> I haven't heard of any x86 systems that would need to use this code.
>
> On the other hand, port-status changes don't occur very frequently.  A
> little time penalty one way or the other won't make much difference.

I'm not opposed, just curious :)

> Alan Stern

Best regards,
Marek Vasut
