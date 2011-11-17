From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 17 Nov 2011 18:08:59 +0000
Subject: [GIT PULL] ARM irqchip consolidation
In-Reply-To: <20111117172319.GX9581@n2100.arm.linux.org.uk>
References: <4EC39D44.8000706@arm.com>
 <20111117172319.GX9581@n2100.arm.linux.org.uk>
Message-ID: <4EC54DBB.9090309@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/11/11 17:23, Russell King - ARM Linux wrote:
> On Wed, Nov 16, 2011 at 11:23:48AM +0000, Marc Zyngier wrote:
>> I've collected patches converting GIC and VIC based platforms to use the
>> MULTI_IRQ_HANDLER configuration option in a single branch (as they depend
>> on a common patch).
>>
>> It also include the patch adding non-banked support to the GIC, which is
>> required to convert EXYNOS to MULTI_IRQ_HANDLER in a sane way (not to
>> mention fixing obvious bugs).
>>
>> If you're happy with this, feel free to pull this branch.
> 
> We need to sort out the conflicts between this and the arch_reset stuff
> I'm carrying, because I'm not going to fight git from this early in the
> cycle, dealing with stuff like this:
> 
> CONFLICT (delete/modify): arch/arm/mach-omap2/include/mach/omap4-common.h deleted in HEAD and modified in devel-stable. Version devel-stable of arch/arm/mach-omap2/include/mach/omap4-common.h left in tree.
> 
> which is immune to git rerere, and I'm sure as hell not going to keep on
> merging this with my for-next branch.

If you have a stable branch on which I can rebase, I'm happy to do it
(I've just resolved these conflicts on -next). If it's more convenient
to do it later in the cycle, I can wait. Just let me know what is the
most convenient route for you.

> Even though I've split out the conflicting cleanup commits from the
> arch_reset() stuff, many of them still don't have acked-bys from the
> maintainers of the affected code, so I don't feel like I can commit
> them to being stable.

While I perfectly understand how important it is to wait for maintainers
to ack the patches, these patches have been posted multiple times over
the past weeks/months, directly Cc-ing the relevant maintainers. Most of
them have contributed Acked-by/Tested-by. In a few cases, the patches
have fallen on deaf ears.

Are these platforms now unmaintained? At that point, I'd be quite
tempted to simply apply the patches and wait until someone screams back
at me.

> What we need are more responsive platform maintainers!

Amen.

	M.
-- 
Jazz is not dead. It just smells funny...
