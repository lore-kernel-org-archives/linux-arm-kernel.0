From: B29397@freescale.com (Chen Peter-B29397)
Date: Thu, 7 Jun 2012 02:04:00 +0000
Subject: [PATCH v4] usb: ehci-hcd: notify phy when connect change
In-Reply-To: <Pine.LNX.4.44L0.1206061017210.1788-100000@iolanthe.rowland.org>
References: <1338946190-19105-1-git-send-email-richard.zhao@freescale.com>
 <Pine.LNX.4.44L0.1206061017210.1788-100000@iolanthe.rowland.org>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803BDB929@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> 
> > It still has below limitations:
> > - it does not work for multi-phy ehci
> > - the best place is after debounce, but I can't get
> >   phy there
> 
> > +			/* FIXME:
> > +			 * - it does not work for multi-phy ehci
> > +			 * - the best place is after debounce, but I can't get
> > +			 *   phy there
> > +			 */
> > +			if (unlikely(ehci->transceiver &&
> > +					(pstatus & PORT_CSC))) {
> 
> A new thought...  If you move the transceiver pointer from struct
> ehci_hcd to struct usb_hcd, then you _will_ be able to get at it from
> within the debouncing routine.
> 
Good suggestion, after that the driver can add PHY operation(quirk or not)
during the whole usb host life periods.

> Or if you prefer, leave the pointer where it is and add a method to
> struct hc_driver for retrieving the pointer.
> 
> Alan Stern
> 
