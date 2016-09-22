From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 22 Sep 2016 10:59:04 +0100
Subject: [PATCH v4 08/10] ARM: Move system register accessors to asm/cp15.h
In-Reply-To: <1473691764-29424-9-git-send-email-vladimir.murzin@arm.com>
References: <1473691764-29424-1-git-send-email-vladimir.murzin@arm.com>
 <1473691764-29424-9-git-send-email-vladimir.murzin@arm.com>
Message-ID: <57E3AB68.80208@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/16 15:49, Vladimir Murzin wrote:
> Headers linux/irqchip/arm-gic.v3.h and arch/arm/include/asm/kvm_hyp.h
> are included in virt/kvm/arm/hyp/vgic-v3-sr.c and both define macros
> called __ACCESS_CP15 and __ACCESS_CP15_64 which obviously creates a
> conflict. These macros were introduced independently for GIC and KVM
> and, in fact, do the same thing.
> 
> As an option we could add prefixes to KVM and GIC version of macros so
> they won't clash, but it'd introduce code duplication.  Alternatively,
> we could keep macro in, say, GIC header and include it in KVM one (or
> vice versa), but such dependency would not look nicer.
> 
> So we follow arm64 way (it handles this via sysreg.h) and move only
> single set of macros to asm/cp15.h
> 
> Cc: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  arch/arm/include/asm/arch_gicv3.h |   27 +++++++++++----------------
>  arch/arm/include/asm/cp15.h       |   15 +++++++++++++++
>  arch/arm/include/asm/kvm_hyp.h    |   15 +--------------
>  3 files changed, 27 insertions(+), 30 deletions(-)

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
