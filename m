From: stefanc@marvell.com (Stefan Chulski)
Date: Mon, 1 Jan 2018 10:35:25 +0000
Subject: [EXT] Re: [PATCH net-next 5/6] arm64: dts: marvell: mcbin: enable
 the fourth network interface
In-Reply-To: <CAPv3WKfn0=51CVtC8V5nWeiM+UV0BhqwFNewwRWUV3wy-9MtUg@mail.gmail.com>
References: <20171227221446.18459-6-antoine.tenart@free-electrons.com>
 <20171227222401.GT10595@n2100.armlinux.org.uk>
 <20171228074623.GA28444@lunn.ch> <20171228100519.GE2626@kwain>
 <462da70b-ba7d-6299-3e21-b619d3c4c7e6@gmail.com>
 <20171228182739.GH2626@kwain> <20171228184642.GV10595@n2100.armlinux.org.uk>
 <CAPv3WKdNCOB=1BqGXw7gXZNX+bBhOXVfheYPjC4CFZjfiOXyHQ@mail.gmail.com>
 <20171229113850.GX10595@n2100.armlinux.org.uk>
 <CAPv3WKcFT5YgvwEk9QNB5=O0j23ds1jCxaBYnMVhxDHeBZzbDA@mail.gmail.com>
 <20171230173157.GC10595@n2100.armlinux.org.uk>
 <CAPv3WKfn0=51CVtC8V5nWeiM+UV0BhqwFNewwRWUV3wy-9MtUg@mail.gmail.com>
Message-ID: <616c2f3b0fe64184bc26d2de43442540@IL-EXCH01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Marcin Wojtas [mailto:mw at semihalf.com]
> Sent: Monday, January 01, 2018 12:18 PM
> To: Russell King - ARM Linux <linux@armlinux.org.uk>
> Cc: Stefan Chulski <stefanc@marvell.com>; Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com>; Andrew Lunn <andrew@lunn.ch>;
> Florian Fainelli <f.fainelli@gmail.com>; Yan Markman
> <ymarkman@marvell.com>; Jason Cooper <jason@lakedaemon.net>; netdev
> <netdev@vger.kernel.org>; Antoine Tenart <antoine.tenart@free-
> electrons.com>; linux-kernel at vger.kernel.org; kishon at ti.com; Nadav Haklai
> <nadavh@marvell.com>; Miqu?l Raynal <miquel.raynal@free-electrons.com>;
> Gregory Cl?ment <gregory.clement@free-electrons.com>; David S. Miller
> <davem@davemloft.net>; linux-arm-kernel at lists.infradead.org; Sebastian
> Hesselbarth <sebastian.hesselbarth@gmail.com>
> Subject: [EXT] Re: [PATCH net-next 5/6] arm64: dts: marvell: mcbin: enable the
> fourth network interface
> 
> External Email
> 
> ----------------------------------------------------------------------
> Hi Russell,
> 
> 2017-12-30 18:31 GMT+01:00 Russell King - ARM Linux
> <linux@armlinux.org.uk>:
> > Hi Marcin,
> >
> > On Sat, Dec 30, 2017 at 05:34:23PM +0100, Marcin Wojtas wrote:
> >> Yes, I already split the series and will send first one right away. I
> >> will be followed by MDIO bus / PHY handling proposal, including the
> >> bits related to phylink. I'm looking forward to your opinion on that
> >> once sent.
> >
> > I'm looking forward to the patches. :)
> >
> >> This my understanding of how the PP2 HW works in terms of signalling
> >> the link interrupt:
> >>
> >> The full in-band management, similar to mvneta is supported only in
> >> the SGMII mode (1G, not sure how it looks like in 2.5G mode). Such
> >> handling is not yet implemented in the mvpp2.c
> >>
> >> 10G:
> >> The XGMII MAC (XLG) is capable of generating link status change
> >> interrupt upon information provided from the reconciliation layer
> >> (RS) of the interface.
> >>
> >> 2.5G/1G SGMII:
> >> Apart from the in-band management, the MAC is also capable of
> >> generating IRQ during link-status change.
> >>
> >> 1G RGMII:
> >> I was a bit surprised, but checked on my own - the link change IRQ
> >> can be generated here as well.
> >>
> >> In addition to above the clause 22 PHYs can be automatically polled
> >> via SMI bus and provide complete information about link status,
> >> speed, etc., reflecting it directly in GMAC status registers.
> >> However, this feature had to be disabled, in order not to conflict
> >> with SW PHY management of the phylib.
> >>
> >> Stefan, is above correct?
> >
> > This sounds very much like mvneta's 'managed = "in-band"' mode.
> 
> Indeed. RGMII MAC behaves same way, although it shouldn't be named as 'in-
> band' to be on par with the specifications. Anyway - this one is rather a stub for
> being able to work with ACPI, so once the MDIO bus works there, this will be
> out of any concerns.

Hi Marcin,

This is correct.
"in-band" supported only for SGMII mode.
IRQ link interrupt depend on "in-band"' auto negation only if "in-band"' enabled.
But IRQ link interrupt could be triggered with "in-band", "out-band" or with specific fixed speed/duplex/flow_contol.

Best Regards.
