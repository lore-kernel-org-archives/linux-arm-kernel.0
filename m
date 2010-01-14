From: leif.lindholm@arm.com (Leif Lindholm)
Date: Thu, 14 Jan 2010 13:08:08 -0000
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors (v3)
In-Reply-To: <20100106193641.GD1728@n2100.arm.linux.org.uk>
References: <20100105182447.5374.79579.stgit@e101986-lin>
	<20100105194328.GG14376@shareable.org>
	<000001ca8f05$2fbb4150$8f31c3f0$@lindholm@arm.com>
	<20100106193641.GD1728@n2100.arm.linux.org.uk>
Message-ID: <000001ca951a$9e1009e0$da301da0$@lindholm@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: 06 January 2010 19:37
>
> > It's to ensure it would work (without console warnings) even if
> > someone decides to disable ALIGNMENT_TRAP. An alternative would be to
> > strip the creation of /proc/cpu out from mm/alignment.c and put it
> > somewhere else (or move the stats file somewhere else - but it seemed
> > logical to group with /proc/alignment).
> 
> As I said when you previously posted this patch, that's definitely on
> the cards.  In fact, I'm about to commit the following patch for doing
> exactly this.

Excellent, thanks. I'm just about to submit the next version, which relies
on that patch, and no longer checks ALIGNMENT_TRAP for anything.

Other changes:
- Code restructured a bit, from Jamie's comments. It did end up quite a bit
  cleaner because of this.
- Comments added for memory barriers, as pointed out by Jamie.
- Added description in Documentation/arm/swp_emulation.

/
	Leif
