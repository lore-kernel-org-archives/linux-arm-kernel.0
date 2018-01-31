From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 31 Jan 2018 09:00:04 +0000
Subject: [PATCH 2/3] KVM: arm/arm64: Fix userspace_irqchip_in_use counting
In-Reply-To: <20180130124206.12262-3-christoffer.dall@linaro.org>
References: <20180130124206.12262-1-christoffer.dall@linaro.org>
 <20180130124206.12262-3-christoffer.dall@linaro.org>
Message-ID: <87739826-dea6-1946-4bb4-afd21f238fbf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/01/18 12:42, Christoffer Dall wrote:
> We were not decrementing the static key count in the right location.
> kvm_arch_vcpu_destroy() is only called to clean up after a failed
> VCPU create attempt, whereas kvm_arch_vcpu_free() is called on teardown
> of the VM as well.  Move the static key decrement call to
> kvm_arch_vcpu_free().
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	N,
-- 
Jazz is not dead. It just smells funny...
