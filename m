From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Dec 2011 20:29:12 +0000
Subject: [GIT PULL] Linux support for ARM LPAE
In-Reply-To: <20111207122544.GD23720@arm.com>
References: <20111202182054.GA3250@arm.com>
 <20111206124109.GT14542@n2100.arm.linux.org.uk>
 <20111206140729.GA31720@arm.com>
 <20111206233058.GZ14542@n2100.arm.linux.org.uk>
 <20111207112320.GB23720@arm.com> <20111207122544.GD23720@arm.com>
Message-ID: <20111207202912.GE14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2011 at 12:25:44PM +0000, Catalin Marinas wrote:
> ARM: pgtable: Fix compiler warning in ioremap.c introduced by nopud
> 
> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> With the arch/arm code conversion to pgtable-nopud.h, the section and
> supersection (un|re)map code triggers compiler warnings on UP systems.
> This is caused by pmd_offset() being given a pgd_t argument rather than
> a pud_t one. This patch makes the necessary conversion via pud_alloc()
> and pmd_alloc().
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

So, do I now take this email as you saying that _your_ LPAE tree is
not ready for merging because you want to rework this patch, or what?

Because you've decided to go down the path of reworking this patch,
I consider it dangerous for me to just pull from your tree again - I've
no idea what I'd get, and I've no idea whether what's there is what you
want me to merge.

So, this is causing extra delay, and there's nothing _I_ can do about
it at my end.

This is getting completely out of hand.

What I want from you - by 5pm tomorrow so I can get this stuff merged -
is a pull request for the LPAE stuff as it was in your v2 pull request,
either based on top of _either_ my devel-stable (if you can get it - as
the machine is having severe problems running git atm) or with Will's
idmap changes merged into it _before_ the LPAE changes.

I suspect you'll have to do the latter though, because I don't think I
can sort out git on the server at the moment.
