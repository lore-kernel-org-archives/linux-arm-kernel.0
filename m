From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 22 Sep 2016 11:00:07 +0100
Subject: [PATCH v4 06/10] KVM: arm: vgic: Support 64-bit data manipulation
 on 32-bit host systems
In-Reply-To: <1473691764-29424-7-git-send-email-vladimir.murzin@arm.com>
References: <1473691764-29424-1-git-send-email-vladimir.murzin@arm.com>
 <1473691764-29424-7-git-send-email-vladimir.murzin@arm.com>
Message-ID: <57E3ABA7.2060003@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/16 15:49, Vladimir Murzin wrote:
> We have couple of 64-bit registers defined in GICv3 architecture, so
> unsigned long accesses to these registers will only access a single
> 32-bit part of that regitser. On the other hand these registers can't
> be accessed as 64-bit with a single instruction like ldrd/strd or
> ldmia/stmia if we run a 32-bit host because KVM does not support
> access to MMIO space done by these instructions.
> 
> It means that a 32-bit guest accesses these registers in 32-bit
> chunks, so the only thing we need to do is to ensure that
> extract_bytes() always takes 64-bit data.
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  virt/kvm/arm/vgic/vgic-mmio-v3.c |    2 +-
>  virt/kvm/arm/vgic/vgic-mmio.h    |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
