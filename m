From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 25 Oct 2017 14:45:28 +0100
Subject: [PATCH v4 05/20] KVM: arm/arm64: Support calling
 vgic_update_irq_pending from irq context
In-Reply-To: <20171020114939.12554-6-christoffer.dall@linaro.org> (Christoffer
 Dall's message of "Fri, 20 Oct 2017 13:49:24 +0200")
References: <20171020114939.12554-1-christoffer.dall@linaro.org>
 <20171020114939.12554-6-christoffer.dall@linaro.org>
Message-ID: <86k1zjcpdz.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 20 2017 at  1:49:24 pm BST, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> From: Christoffer Dall <cdall@linaro.org>
>
> We are about to optimize our timer handling logic which involves
> injecting irqs to the vgic directly from the irq handler.
>
> Unfortunately, the injection path can take any AP list lock and irq lock
> and we must therefore make sure to use spin_lock_irqsave where ever
> interrupts are enabled and we are taking any of those locks, to avoid
> deadlocking between process context and the ISR.
>
> This changes a lot of the VGIC code, but The good news are that the
> changes are mostly mechanical.
>
> Signed-off-by: Christoffer Dall <cdall@linaro.org>

Acked-by: Marc Zyngier <marc,zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
