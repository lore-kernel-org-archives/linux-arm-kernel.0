From: will.deacon@arm.com (Will Deacon)
Date: Mon, 19 May 2014 17:50:10 +0100
Subject: [PATCHv3 1/3] ARM: mm: allow sub-architectures to override PCI
 I/O memory type
In-Reply-To: <4669695.sl9JY8Fb9h@wuerfel>
References: <1400145519-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <66413148.lBD9c9XUns@wuerfel> <20140519142355.GD15130@arm.com>
 <4669695.sl9JY8Fb9h@wuerfel>
Message-ID: <20140519165010.GQ15130@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 05:40:51PM +0100, Arnd Bergmann wrote:
> On Monday 19 May 2014 15:23:55 Will Deacon wrote:
> > Fair enough -- I just don't think we should dress up an erratum workaround as
> > a bug fix, especially when it's adding a new user of strongly-ordered memory
> > to the kernel which we can't honour for arm64.
> 
> Makes sense. How about a patch then that just changes the memory type for
> the I/O space and adds a comment explaining all we found out? From what
> I can tell, strict ordering is required for Armada 3xx, may or may not
> be required elsewhere but should never hurt noticeably. We may want to restrict
> it to ARMv6/v7 so we don't have to pick the right domain.

Ok, and we don't bother with the extra dsb in outb? I'm alright with that if
the comment goes into enough detail.

Will
