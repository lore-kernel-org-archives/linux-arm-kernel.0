From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Jan 2017 14:55:41 +0100
Subject: [RFC, PATCHv2 29/29] mm, x86: introduce RLIMIT_VADDR
In-Reply-To: <CALCETrXmdAnbgjsxw=qTbP2PhVCzE8v3y5XMt8DVa4P9DowsGA@mail.gmail.com>
References: <20161227015413.187403-1-kirill.shutemov@linux.intel.com>
 <21511994.eBlbEPoKOz@wuerfel>
 <CALCETrXmdAnbgjsxw=qTbP2PhVCzE8v3y5XMt8DVa4P9DowsGA@mail.gmail.com>
Message-ID: <5530270.v1BLsanhbo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, January 3, 2017 2:09:16 PM CET Andy Lutomirski wrote:
> >
> >> When
> >> ADDR_LIMIT_EXPLICIT is in effect, prctl can set a 64-bit numeric
> >> limit.  If ADDR_LIMIT_EXPLICIT is cleared, the prctl value stops being
> >> settable and reading it via prctl returns whatever is implied by the
> >> other personality bits.
> >
> > I don't see anything wrong with it, but I'm a bit confused now
> > what this would be good for, compared to using just prctl.
> >
> > Is this about setuid clearing the personality but not the prctl,
> > or something else?
> 
> It's to avid ambiguity as to what happens if you set ADDR_LIMIT_32BIT
> and use the prctl.  ISTM it would be nice for the semantics to be
> fully defined in all cases.
> 

Ok, got it.

	Arnd
