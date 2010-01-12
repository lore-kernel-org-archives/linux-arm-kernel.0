From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Jan 2010 17:35:16 +0000
Subject: [PATCH] Consolidate clks_register() and similar
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190902089AA3@mi8nycmail19.Mi8.com>
References: <20100112121723.GC27771@n2100.arm.linux.org.uk>
	<BD79186B4FD85F4B8E60E381CAEE190902089AA3@mi8nycmail19.Mi8.com>
Message-ID: <20100112173516.GE5633@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2010 at 12:29:00PM -0500, H Hartley Sweeten wrote:
> On Tuesday, January 12, 2010 5:17 AM, Russell King wrote,
> > I don't think it's -rc material (not a bug fix) so 2.6.34.
> 
> It's not a bug fix but due to how often people patch the various
> clock sources it might be better to get this is soon so that merge
> conflicts don't show up.

Things in the tables tends to change, rather than the code which sets
them up.  I don't think there'll be much in the way of conflicts.

> >> This should take care of davinci.  Tested on v2.6.33-rc3 + $SUBJECT patch.
> >
> > Shall I queue this for merging after my patch, or are there likely to
> > be conflicts in this area?
> 
> BTW, arch/arm/mach-ep93xx/clock.c might need to be rebased due to you
> applying 5875/1 and 5879/1 to your git-curr (ep93xx branch).

It merged fine - more the problem was 5875/1 vs 5879/1 which could only
be applied with GNU patch with fuzz.
