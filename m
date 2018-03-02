From: will.deacon@arm.com (Will Deacon)
Date: Fri, 2 Mar 2018 09:36:28 +0000
Subject: [PATCH] KVM: arm/arm64: reduce verbosity of KVM init log
In-Reply-To: <20180302081630.6385-1-ard.biesheuvel@linaro.org>
References: <20180302081630.6385-1-ard.biesheuvel@linaro.org>
Message-ID: <20180302093628.GA18501@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2018 at 08:16:30AM +0000, Ard Biesheuvel wrote:
> On my GICv3 system, the following is printed to the kernel log at boot:
> 
>    kvm [1]: 8-bit VMID
>    kvm [1]: IDMAP page: d20e35000
>    kvm [1]: HYP VA range: 800000000000:ffffffffffff
>    kvm [1]: vgic-v2 at 2c020000
>    kvm [1]: GIC system register CPU interface enabled
>    kvm [1]: vgic interrupt IRQ1
>    kvm [1]: virtual timer IRQ4
>    kvm [1]: Hyp mode initialized successfully
> 
> The KVM IDMAP is a mapping of a statically allocated kernel structure,
> and so printing its physical address leaks the physical placement of
> the kernel when physical KASLR in effect. So change the kvm_info() to
> kvm_debug() to remove it from the log output.
> 
> While at it, trim the output a bit more: IRQ numbers can be found in
> /proc/interrupts, and the HYP VA and vgic-v2 lines are not highly
> informational either.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  virt/kvm/arm/arch_timer.c     | 2 +-
>  virt/kvm/arm/mmu.c            | 6 +++---
>  virt/kvm/arm/vgic/vgic-init.c | 2 +-
>  virt/kvm/arm/vgic/vgic-v2.c   | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
