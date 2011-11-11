From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 11 Nov 2011 14:37:55 +0000
Subject: [REPOST PATCH] ARM: gic: allow GIC to support non-banked setups
In-Reply-To: <1320421221-28711-1-git-send-email-marc.zyngier@arm.com>
References: <1320421221-28711-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <4EBD3343.3080307@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/11 15:40, Marc Zyngier wrote:
> The GIC support code is heavily using the fact that hardware
> implementations are exposing banked registers. Unfortunately, it
> looks like at least one GIC implementation (EXYNOS4) offers both
> the distributor and the CPU interfaces at different addresses,
> depending on the CPU.
> 
> This problem is solved by turning the distributor and CPU interface
> addresses into per-cpu variables. The EXYNOS4 code is updated not
> to mess with the GIC internals while handling interrupts, and
> struct gic_chip_data is back to being private.
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> I'm reposting this in order to generate some comments on the
> approach. An alternative has been suggested by Will Deacon,
> by adding platform specific callbacks returning the base addresses.
> Both solutions have a runtime impact on "normal" platforms.
> 
> The current state is quite ugly (the code is racy, messes with
> GIC internals, abuses the gic_arch_extn hooks and duplicates
> gic_secondary_init). As such, I'm hoping we can reach a quick
> decision on how to fix this.

I still haven't received any comment on this. Does it mean everybody
agrees with the patch? ;-)

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
