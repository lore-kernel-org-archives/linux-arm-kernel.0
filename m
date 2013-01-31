From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 31 Jan 2013 12:32:09 +0000
Subject: [PATCH v2 0/4] Preparatory GIC patches for arm64 support
In-Reply-To: <20130131114703.GX23505@n2100.arm.linux.org.uk>
References: <1359476319-23720-1-git-send-email-catalin.marinas@arm.com>
 <20130131103044.GB12877@arm.com>
 <20130131114703.GX23505@n2100.arm.linux.org.uk>
Message-ID: <20130131123208.GE12877@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 11:47:04AM +0000, Russell King - ARM Linux wrote:
> On Thu, Jan 31, 2013 at 10:30:44AM +0000, Catalin Marinas wrote:
> > On Tue, Jan 29, 2013 at 04:18:35PM +0000, Catalin Marinas wrote:
> > > That's the second version of the GIC clean-up patches to support arm64.
> > > The only change from v1 is that the second patch (chained_irq.h) also
> > > covers drivers/gpio and drivers/pinctrl (#include change).
> > 
> > Are you ok to merge this series via the arm-soc tree for 3.9-rc1? There
> > are no complaints so far (only acks ;). This would allow me to push GIC
> > support for arm64.
> 
> So I don't exist anymore to you?

You do ;) and you've been cc'ed on these patches. Just wasn't sure you
care about patches that have 'arm64' in the cover email ;).

Since Rob's series went through the arm-soc, I consider that further
changes should go the same route as there is a dependency and I'd like
to get them merged sooner. These patches touch primarily SoC code, apart
from some trivial code moving and the CPU notifier in irq-gic.c (you are
the original author of this driver) and I'm ok if you want to merge it.

I really don't mind if you or Olof merge the whole series as long as it
gets upstream at some point. As you expressed an opinion on these
patches and you want to merge them, they'll have to wait until after
3.9-rc1 for Rob's patches to get in.

> Catalin, it's already been suggested to you that this series is more
> core ARM stuff than SoC stuff, and it's also been suggested that you
> merge this through my tree.

No, it hasn't. Just Nico saying that he'd prefer *his* series was merged
by RMK (and I agree). A way to sort the dependency issue for Nico is to
at least push some of this series in 3.9-rc1. Otherwise we just postpone
the dependency issue.

> No, I guess this figures after all your excessively negative replies
> on all of my comments during the review of ARM64.

It's all relative - negative reply to negative reply would make it
positive ;).

-- 
Catalin
