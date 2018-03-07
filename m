From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 7 Mar 2018 13:02:07 +0000
Subject: [PATCH] KVM: arm/arm64: Reset mapped IRQs on VM reset
In-Reply-To: <20180305103638.1633-1-cdall@kernel.org>
References: <20180305103638.1633-1-cdall@kernel.org>
Message-ID: <a5dbae97-7ab8-4f60-723f-d3599297f396@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/18 10:36, Christoffer Dall wrote:
> We currently don't allow resetting mapped IRQs from userspace, because
> their state is controlled by the hardware.  But we do need to reset the
> state when the VM is reset, so we provide a function for the 'owner' of
> the mapped interrupt to reset the interrupt state.
> 
> Currently only the timer uses mapped interrupts, so we call this
> function from the timer reset logic.
> 
> Signed-off-by: Christoffer Dall <cdall@kernel.org>
> ---
> This depends on "KVM: arm/arm64: Avoid vcpu_load for other vcpu ioctls
> than KVM_RUN" from the VHE optimization series so that the reset doesn't
> get called while vtimer->loaded is true.

Queued for 4.16-rc5.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
