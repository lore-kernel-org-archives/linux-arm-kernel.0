From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 23 May 2017 18:18:21 +0100
Subject: [PATCH v2 4/9] KVM: arm/arm64: Move timer IRQ default init to
 arch_timer.c
In-Reply-To: <20170516184556.26785-5-cdall@linaro.org>
References: <20170516184556.26785-1-cdall@linaro.org>
 <20170516184556.26785-5-cdall@linaro.org>
Message-ID: <96a536ca-5ae3-03b9-edb9-f55606401372@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/05/17 19:45, Christoffer Dall wrote:
> We currently initialize the arch timer IRQ numbers from the reset code,
> presumably because we once intended to model multiple CPU or SoC types
> from within the kernel and have hard-coded reset values in the reset
> code.
> 
> As we are moving towards userspace being in charge of more fine-grained
> CPU emulation and stitching together the pieces needed to emulate a
> particular type of CPU, we should no longer have a tight coupling
> between resetting a VCPU and setting IRQ numbers.
> 
> Therefore, move the logic to define and use the default IRQ numbers to
> the timer code and set the IRQ number immediately when creating the
> VCPU.
> 
> Signed-off-by: Christoffer Dall <cdall@linaro.org>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
