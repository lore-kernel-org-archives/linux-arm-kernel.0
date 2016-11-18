From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Nov 2016 10:22:46 +0100
Subject: [PATCH V5 2/3] ARM64 LPC: Add missing range exception for special
 ISA
In-Reply-To: <20161114111111.1b753dc3@lxorguk.ukuu.org.uk>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <5900275.i4NZvtxTcC@wuerfel> <20161114111111.1b753dc3@lxorguk.ukuu.org.uk>
Message-ID: <11716372.n451O5j8Vs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, November 14, 2016 11:11:11 AM CET One Thousand Gnomes wrote:
> > > It's not a safe assumption for x86 at least. There are a few systems with
> > > multiple ISA busses particularly older laptops with a docking station.  
> > 
> > But do they have multiple ISA domains? There is no real harm in supporting
> > it, the (small) downsides I can think of are:
> 
> I don't believe they x86 class ones have multiple ISA domains. But as
> I've said I don't know how the electronics in the older ThinkPad worked
> when it used two PIIX4s with some LPC or ISA stuff on each.
> 
> It works in DOS and unmodified Linux so I'm pretty sure there are no
> additional domains. Likewise the various x86 schemes that route some bits
> of ISA bus off into strange places work in DOS and don't have any
> overlaps.
> 
> yenta_socket handles PCI/PCMCIA bridging and routes a range of that flat
> ISA space appropriately to the card.

Right, that's what I had expected, so we still don't even
need to handle multiple ISA I/O address spaces for the
only known case of multiple ISA buses, though we may decide
to generalize the code like that anyway.

	Arnd
