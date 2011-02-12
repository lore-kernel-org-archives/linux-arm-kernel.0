From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 12 Feb 2011 20:39:57 +0530
Subject: [PATCH v3 2/5] ARM: pm: add generic CPU suspend/resume support
In-Reply-To: <20110212145010.GK15616@n2100.arm.linux.org.uk>
References: <E1PmA28-0000AC-2t@rmk-PC.arm.linux.org.uk>
	<20110207120103.GC31929@n2100.arm.linux.org.uk>
	<20110207121052.GD31929@n2100.arm.linux.org.uk>
	<AANLkTintBD2Gfb3pkPZPe2mreU5EatUnNwUqR-id7q+M@mail.gmail.com>
	<20110207133457.GE31929@n2100.arm.linux.org.uk>
	<AANLkTi=B45PuOErxR49Gfhfq6-=y_NugbWBLBo0MEoCt@mail.gmail.com>
	<20110207141734.GG31929@n2100.arm.linux.org.uk>
	<AANLkTimCtaSZ=CHT5snWZ496_bi4sH=0LU7vJ-Jfh=dP@mail.gmail.com>
	<20110211115853.GC23404@n2100.arm.linux.org.uk>
	<998315b4ab88b66cc0e32e73d10a0015@mail.gmail.com>
	<20110212145010.GK15616@n2100.arm.linux.org.uk>
Message-ID: <3f574626437da8db9f7844d5bb031046@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Saturday, February 12, 2011 8:20 PM
> To: Santosh Shilimkar
> Cc: Colin Cross; Kukjin Kim; saeed bishara; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v3 2/5] ARM: pm: add generic CPU suspend/resume
> support
>
> On Fri, Feb 11, 2011 at 05:37:04PM +0530, Santosh Shilimkar wrote:
> > There is a Monitor secure API, needs to be called from non-secure
> > software to set this diagnostic registers in resume path.
>
> It would be an idea to get the OMAP sleep code up to date so that I
> can
> look at OMAPs requirements for this to be useful.
>
> As the current code stands, I don't see any reason why the sleep34xx
> code
> can't use this infrastructure, but I'm loathed to start modifying
> that if there's outstanding code changes in that area.

Yep. There are few issues out there with sleep34xx code.
	- Secure APIs
	- Current code needs to be cleaned up to remove
	unwanted registers save restore
	- Some part of the code on OMAP3 must be run from
	SRAM. It can't run from DDR
	- AUXCTLR, Diagnostic registers aren't accessible
	in secure mode.
	- L2 cache needs to be handled with secure APIs.
	- Code sequence needs to handle errata's handling
	which accesses OMAP PM registers.

Few of the above are getting addressed for this merge window.

So my plan was to take a look at generic suspend after the
merge window. By that time your generic stuff and omap
cleanup would have got merged hopefully.

Regards,
Santosh
