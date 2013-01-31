From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 31 Jan 2013 11:49:36 +0000
Subject: [PATCH v2 4/4] irqchip: gic: Perform the gic_secondary_init()
 call via CPU notifier
In-Reply-To: <20130131112538.GW23505@n2100.arm.linux.org.uk>
References: <1359476319-23720-1-git-send-email-catalin.marinas@arm.com>
 <1359476319-23720-5-git-send-email-catalin.marinas@arm.com>
 <alpine.LFD.2.02.1301291734140.6300@xanadu.home>
 <20130129231205.GA25176@MacBook-Pro.local>
 <alpine.LFD.2.02.1301291907340.6300@xanadu.home>
 <20130131112538.GW23505@n2100.arm.linux.org.uk>
Message-ID: <20130131114935.GD12877@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 11:25:38AM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 29, 2013 at 07:11:56PM -0500, Nicolas Pitre wrote:
> > On Tue, 29 Jan 2013, Catalin Marinas wrote:
> > > I would like to get them in as soon as possible (ideally 3.9) as AArch64
> > > needs GIC support. I can base them on Rob's branch (already in -next)
> > > and send them the same route (the arm-soc tree if Olof/Arnd are ok to
> > > take them).
> > 
> > Well...  I'd prefer if my series was merged by RMK since this is mostly 
> > core ARM code.  That is posing dependency issues.
> > 
> > I think I'll just ignore your change for now and we'll fix things up 
> > during the v3.9-rc period.
> 
> Given that the ARM kernel seems to be rather broken at the moment, that's
> not going to happen until the 32-bit kernel gets some loving attention to
> make it work again.
> 
> Our primary responsibility is not to stuff the kernel with new features
> as quickly as we possibly can.  It's to make sure that the kernel works,
> and at the moment, it doesn't.  I'm not talking about ancient architectures.
> I'm talking about platforms using ARMv6 and above - platforms with the GIC
> which I'd be able to test this change on.

FWIW, I tested this on vexpress with CA9x4 tile with both 3.8-rc3 (Rob's
branch) and latest linux-next.

If you want to test this change for longer, I'm ok to leave it for 3.10
and stick it in -next at some point (after 3.9-rc1 since there are many
conflicts). I'd like however to push the other trivial code-moving
patches in this series.

-- 
Catalin
