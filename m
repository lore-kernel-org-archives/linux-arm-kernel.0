From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Mon, 14 Nov 2016 11:11:11 +0000
Subject: [PATCH V5 2/3] ARM64 LPC: Add missing range exception for
 special ISA
In-Reply-To: <5900275.i4NZvtxTcC@wuerfel>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <2368890.jTbyGqYR0M@wuerfel>
 <20161109135453.2e5402bd@lxorguk.ukuu.org.uk>
 <5900275.i4NZvtxTcC@wuerfel>
Message-ID: <20161114111111.1b753dc3@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > It's not a safe assumption for x86 at least. There are a few systems with
> > multiple ISA busses particularly older laptops with a docking station.  
> 
> But do they have multiple ISA domains? There is no real harm in supporting
> it, the (small) downsides I can think of are:

I don't believe they x86 class ones have multiple ISA domains. But as
I've said I don't know how the electronics in the older ThinkPad worked
when it used two PIIX4s with some LPC or ISA stuff on each.

It works in DOS and unmodified Linux so I'm pretty sure there are no
additional domains. Likewise the various x86 schemes that route some bits
of ISA bus off into strange places work in DOS and don't have any
overlaps.

yenta_socket handles PCI/PCMCIA bridging and routes a range of that flat
ISA space appropriately to the card.

Alan
