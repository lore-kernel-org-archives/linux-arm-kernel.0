From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 7 Mar 2018 13:09:16 +0000
Subject: [PATCH] KVM: arm/arm64: VGIC MMIO: add missing irq_lock
In-Reply-To: <20180306092106.13044-1-andre.przywara@arm.com>
References: <20180306092106.13044-1-andre.przywara@arm.com>
Message-ID: <20a9983c-6e66-1fc6-6901-1748fcc3226e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/18 09:21, Andre Przywara wrote:
> Our irq_is_pending() helper function accesses multiple members of the
> vgic_irq struct, so we need to hold the lock when calling it.
> Add that requirement as a comment to the definition and take the lock
> around the call in vgic_mmio_read_pending(), where we were missing it
> before.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Queued for 4.16-rc5.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
