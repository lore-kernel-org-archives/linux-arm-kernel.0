From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 10 May 2016 10:39:28 +0100
Subject: [PATCH v3 15/55] KVM: arm/arm64: vgic-new: Implement virtual IRQ
 injection
In-Reply-To: <1462531568-9799-16-git-send-email-andre.przywara@arm.com>
References: <1462531568-9799-1-git-send-email-andre.przywara@arm.com>
 <1462531568-9799-16-git-send-email-andre.przywara@arm.com>
Message-ID: <5731AC50.5020809@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/16 11:45, Andre Przywara wrote:
> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> Provide a vgic_queue_irq() function which decides whether a given
> IRQ needs to be queued to a VCPU's ap_list.
> This should be called whenever an IRQ becomes pending or enabled,
> either as a result of userspace injection, from in-kernel emulated
> devices like the architected timer or from MMIO accesses to the
> distributor emulation.
> Also provides the necessary functions to allow userland to inject an
> IRQ to a guest.
> Since this is the first code that starts using our locking mechanism, we
> add some (hopefully) clear documentation of our locking strategy and
> requirements along with this patch.
> 
> [Andre: refactor out vgic_queue_irq_unlock()]
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
