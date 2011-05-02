From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 May 2011 00:09:40 +0100
Subject: [PATCH 3/3] at91: make PLAT_PHYS_OFFSET depending on
	!ARM_PATCH_PHYS_VIRT or XIP_KERNEL
In-Reply-To: <20110502225046.GI13724@game.jcrosoft.org>
References: <1304374403-28513-1-git-send-email-plagnioj@jcrosoft.com>
	<1304374403-28513-3-git-send-email-plagnioj@jcrosoft.com>
	<20110502225242.GC28001@n2100.arm.linux.org.uk>
	<20110502225046.GI13724@game.jcrosoft.org>
Message-ID: <20110502230940.GF28001@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 03, 2011 at 12:50:46AM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 23:52 Mon 02 May     , Russell King - ARM Linux wrote:
> > Ideally, I'd like to see platforms not provide PLAT_PHYS_OFFSET.
> > However, there are two cases where it's needed by generic ARM code as
> > you've identified above.
> > 
> > Does AT91 support XIP_KERNEL?  It doesn't support XIP from flash (MTD_XIP)
> > so I suspect this isn't a particularly useful configuration.
>
> I never see a board using it

I think Nicolas questioned whether it was worth keeping XIP support in
the kernel - I suspect there are very few users of that.

We know that MTD_XIP is only used on OMAP1, PXA and SA1100 platforms.
Anyone else using XIP_KERNEL either has the kernel in some kind of ROM
or off-line updatable flash (while the kernel runs from it, this flash
would have to be read-only without MTD_XIP support.)

> > As far as ARM_PATCH_PHYS_VIRT, maybe AT91 should force this to always
> > be selected.  That then means it can eliminate the PLAT_PHYS_OFFSET
> > definition entirely.
>
> I get this in mind too but as it's sleep mark EXPERIMANTAL I was not sure
> to enable it by default

It's marked experimental because it's a new feature which needs testing
to fully prove itself across all platforms.  If you're happy that it
works for your class of platforms, then there shouldn't be much of a
problem.

SMP is also marked experimental, but has been around for a while now,
and the norm for some systems already.  However, SMP has been around for
a while and can have that tag dropped now.
