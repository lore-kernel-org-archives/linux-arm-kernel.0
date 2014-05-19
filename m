From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 May 2014 19:04:24 +0200
Subject: [PATCHv3 1/3] ARM: mm: allow sub-architectures to override PCI
 I/O memory type
In-Reply-To: <20140519165010.GQ15130@arm.com>
References: <1400145519-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <4669695.sl9JY8Fb9h@wuerfel> <20140519165010.GQ15130@arm.com>
Message-ID: <6041406.aOYqt5yzTp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 May 2014 17:50:10 Will Deacon wrote:
> On Mon, May 19, 2014 at 05:40:51PM +0100, Arnd Bergmann wrote:
> > On Monday 19 May 2014 15:23:55 Will Deacon wrote:
> > > Fair enough -- I just don't think we should dress up an erratum workaround as
> > > a bug fix, especially when it's adding a new user of strongly-ordered memory
> > > to the kernel which we can't honour for arm64.
> > 
> > Makes sense. How about a patch then that just changes the memory type for
> > the I/O space and adds a comment explaining all we found out? From what
> > I can tell, strict ordering is required for Armada 3xx, may or may not
> > be required elsewhere but should never hurt noticeably. We may want to restrict
> > it to ARMv6/v7 so we don't have to pick the right domain.
> 
> Ok, and we don't bother with the extra dsb in outb? I'm alright with that if
> the comment goes into enough detail.

That was my idea. I'm fine with it either way, with the dsb or without it.
Let's see what Russell thinks about this, he probably has a preference.

	Arnd
