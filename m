From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 23 May 2011 18:22:34 +0100
Subject: [PATCH v5 00/19] ARM: Add support for the Large Physical
	Address Extensions
In-Reply-To: <20110523165412.GF15138@n2100.arm.linux.org.uk>
References: <1304859098-10760-1-git-send-email-catalin.marinas@arm.com>
	<20110523165412.GF15138@n2100.arm.linux.org.uk>
Message-ID: <1306171354.7196.30.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-05-23 at 17:54 +0100, Russell King - ARM Linux wrote:
> On Sun, May 08, 2011 at 01:51:19PM +0100, Catalin Marinas wrote:
> > This set of patches adds support for the Large Physical Extensions on
> > the ARM architecture (available with the Cortex-A15 processor). LPAE
> > comes with a 3-level page table format (compared to 2-level for the
> > classic one), allowing up to 40-bit physical address space.
> >
> > The ARM LPAE documentation is available from (free registration needed):
> >
> > http://infocenter.arm.com/help/topic/com.arm.doc.ddi0406b_virtualization_extns/index.html
> >
> > The full set of patches on top of linux-next (LPAE, support for an
> > emulated Versatile Express with Cortex-A15 tile and generic timers) is
> > available on this branch:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/linux-2.6-cm.git arm-lpae-next
> 
> FYI, I'm going to drop the pgt patch because the warnings are still there
> and I _still_ don't feel happy about pushing that into mainline and then
> being endlessly bugged about it.

I haven't seen the warnings but probably because I applied the LPAE
patches on top. I'll have a look as well.

> So I'll drop it from my tree again and re-merge that branch after this
> window has closed.

OK. In the meantime I'll cherry-pick it into my LPAE branch based on
mainline. As we discussed, after -rc1 I plan to push the LPAE patches to
-next. Your patch would come from two different sources but I'm not sure
whether git can cope with it (given that I rename files like pgtable.h).
The alternative would be to base my patches on your branch as long as
you don't rebase it.

-- 
Catalin
