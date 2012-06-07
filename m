From: B29397@freescale.com (Chen Peter-B29397)
Date: Thu, 7 Jun 2012 03:14:04 +0000
Subject: [PATCH v4] usb: ehci-hcd: notify phy when connect change
In-Reply-To: <20120607024328.GB5566@b20223-02.ap.freescale.net>
References: <1338946190-19105-1-git-send-email-richard.zhao@freescale.com>
 <Pine.LNX.4.44L0.1206061017210.1788-100000@iolanthe.rowland.org>
 <F281D0F91ED19E4D8E63A7504E8A649803BDB929@039-SN2MPN1-023.039d.mgd.msft.net>
 <20120607024328.GB5566@b20223-02.ap.freescale.net>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803BDB9EE@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > >
> > > > +			/* FIXME:
> > > > +			 * - it does not work for multi-phy ehci
> > > > +			 * - the best place is after debounce, but I
> can't get
> > > > +			 *   phy there
> > > > +			 */
> > > > +			if (unlikely(ehci->transceiver &&
> > > > +					(pstatus & PORT_CSC))) {
> > >
> > > A new thought...  If you move the transceiver pointer from struct
> > > ehci_hcd to struct usb_hcd, then you _will_ be able to get at it from
> > > within the debouncing routine.
> > >
> > Good suggestion, after that the driver can add PHY operation(quirk or
> not)
> > during the whole usb host life periods.
> Since it makes it more generic, I'm considering:
>  - change variable name from transceiver to phy
>  - Do we need considering phy on hub? I prefer HCD phy only.
>  - Do we need supporting multi-phy for one hcd? I don't know multi-phy
>    case, so I prefer one phy one hcd.
> 
I suggest that you can do it at next patchset.
This patchset is just add phy notify to ehci hcd interrupt handler.
At next patchset, you can refine and improve PHY operation at the whole hcd.

I am not sure Alan's suggestion.

 
