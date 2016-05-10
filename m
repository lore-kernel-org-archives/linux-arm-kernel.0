From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 10 May 2016 09:57:03 +0100
Subject: [PATCH v3 09/55] KVM: arm/arm64: Fix MMIO emulation data handling
In-Reply-To: <1462531568-9799-10-git-send-email-andre.przywara@arm.com>
References: <1462531568-9799-1-git-send-email-andre.przywara@arm.com>
 <1462531568-9799-10-git-send-email-andre.przywara@arm.com>
Message-ID: <5731A25F.4020203@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/16 11:45, Andre Przywara wrote:
> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> When the kernel was handling a guest MMIO read access internally, we
> need to copy the emulation result into the run->mmio structure in order
> for the kvm_handle_mmio_return() function to pick it up and inject the
> 	result back into the guest.
> 
> Currently the only user of kvm_io_bus for ARM is the VGIC, which did
> this copying itself, so this was not causing issues so far.
> 
> But with the upcoming new vgic implementation we need this done
> properly.
> 
> Update the kvm_handle_mmio_return description and cleanup the code to
> only perform a single copying when needed.
> 
> Code and commit message inspired by Andre Przywara.
> 
> Reported-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
