From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 17 Nov 2011 20:07:42 +0100
Subject: [WISH] git-rerere handling delete/modify conflicts [Was: Re: [GIT
 PULL] ARM irqchip consolidation]
In-Reply-To: <20111117172319.GX9581@n2100.arm.linux.org.uk>
References: <4EC39D44.8000706@arm.com>
 <20111117172319.GX9581@n2100.arm.linux.org.uk>
Message-ID: <20111117190742.GV30612@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2011 at 05:23:19PM +0000, Russell King - ARM Linux wrote:
> On Wed, Nov 16, 2011 at 11:23:48AM +0000, Marc Zyngier wrote:
> > I've collected patches converting GIC and VIC based platforms to use the
> > MULTI_IRQ_HANDLER configuration option in a single branch (as they depend
> > on a common patch).
> > 
> > It also include the patch adding non-banked support to the GIC, which is
> > required to convert EXYNOS to MULTI_IRQ_HANDLER in a sane way (not to
> > mention fixing obvious bugs).
> > 
> > If you're happy with this, feel free to pull this branch.
> 
> We need to sort out the conflicts between this and the arch_reset stuff
> I'm carrying, because I'm not going to fight git from this early in the
> cycle, dealing with stuff like this:
> 
> CONFLICT (delete/modify): arch/arm/mach-omap2/include/mach/omap4-common.h deleted in HEAD and modified in devel-stable. Version devel-stable of arch/arm/mach-omap2/include/mach/omap4-common.h left in tree.
> 
> which is immune to git rerere, and I'm sure as hell not going to keep on
> merging this with my for-next branch.
> 
> Even though I've split out the conflicting cleanup commits from the
> arch_reset() stuff, many of them still don't have acked-bys from the
> maintainers of the affected code, so I don't feel like I can commit
> them to being stable.
> 
> What we need are more responsive platform maintainers!
and git rerere handling delete/modify conflicts. I don't know how it
works internally, but I guess it's not trivial? Just in case it is and
the only thing that stops you implementing it is that you don't know
there is a need for it: voil?.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
