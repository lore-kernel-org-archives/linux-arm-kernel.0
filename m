From: mtosatti@redhat.com (Marcelo Tosatti)
Date: Tue, 31 Dec 2013 17:25:17 -0200
Subject: [PULL 00/15] KVM/{arm,arm64} updates for 3.14
In-Reply-To: <1388229347-24185-1-git-send-email-marc.zyngier@arm.com>
References: <1388229347-24185-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20131231192517.GA22613@amt.cnet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 28, 2013 at 11:15:32AM +0000, Marc Zyngier wrote:
> Hi Marcelo,
> 
> Could you please pull the following tag into kvm/next?
> 
> It contains the long overdue GIC+timer save/restore interface for
> KVM/arm, and a couple of other less important changes for KVM/arm64.
> 
> Thanks,
> 
> 	M.
> 
> The following changes since commit 989c6b34f6a9480e397b170cc62237e89bf4fdb9:
> 
>   KVM: MMU: handle invalid root_hpa at __direct_map (2013-12-20 19:22:49 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/kvm-arm64/next-3.14-1
> 
> for you to fetch changes up to da91747cda0fdbaa05b80becb5cecfac35c8de36:
> 
>   Merge branch 'kvm-arm64/for-3.14' into kvm-arm64/next (2013-12-28 10:29:37 +0000)
> 
> ----------------------------------------------------------------
> 
> First drop of 3.14 merge candidates for KVM/{arm,arm64}
> 
> - GIC+timer save restore
> - Allow userspace to request a X-Gene vcpu
> - Cleanup SMC handling on arm64
> - Allow configuration of maximum number of vcpus on arm64
> 
> ----------------------------------------------------------------
> Andre Przywara (1):
>       ARM/KVM: save and restore generic timer registers
> 
> Anup Patel (3):
>       arm64: KVM: Add Kconfig option for max VCPUs per-Guest
>       arm64: KVM: Support X-Gene guest VCPU on APM X-Gene host
>       arm64: KVM: Force undefined exception for Guest SMC intructions
> 
> Christoffer Dall (11):
>       arm/arm64: KVM: arch_timer: Initialize cntvoff at kvm_init
>       ARM: KVM: Allow creating the VGIC after VCPUs
>       KVM: arm-vgic: Support KVM_CREATE_DEVICE for VGIC
>       KVM: arm-vgic: Set base addr through device API
>       irqchip: arm-gic: Define additional MMIO offsets and masks
>       KVM: arm-vgic: Make vgic mmio functions more generic
>       arm/arm64: kvm: Set vcpu->cpu to -1 on vcpu_put
>       KVM: arm-vgic: Add vgic reg access from dev attr
>       KVM: arm-vgic: Support unqueueing of LRs to the dist
>       KVM: arm-vgic: Add GICD_SPENDSGIR and GICD_CPENDSGIR handlers
>       KVM: arm-vgic: Support CPU interface reg access
> 
> Marc Zyngier (2):
>       Merge tag 'vgic-migrate-for-marc' of git://git.linaro.org/people/christoffer.dall/linux-kvm-arm into kvm-arm64/next
>       Merge branch 'kvm-arm64/for-3.14' into kvm-arm64/next
> 
>  Documentation/virtual/kvm/api.txt              |   7 +-
>  Documentation/virtual/kvm/devices/arm-vgic.txt |  73 ++++
>  arch/arm/include/asm/kvm_host.h                |   3 +
>  arch/arm/include/uapi/asm/kvm.h                |  28 ++
>  arch/arm/kvm/arm.c                             |  19 +-
>  arch/arm/kvm/guest.c                           |  92 +++-
>  arch/arm64/include/asm/kvm_host.h              |   7 +-
>  arch/arm64/include/uapi/asm/kvm.h              |  21 +-
>  arch/arm64/kvm/Kconfig                         |  11 +
>  arch/arm64/kvm/guest.c                         |  32 +-
>  arch/arm64/kvm/handle_exit.c                   |   3 -
>  arch/arm64/kvm/sys_regs_generic_v8.c           |   3 +
>  include/kvm/arm_vgic.h                         |   2 +-
>  include/linux/irqchip/arm-gic.h                |  12 +
>  include/linux/kvm_host.h                       |   1 +
>  include/uapi/linux/kvm.h                       |   1 +
>  virt/kvm/arm/arch_timer.c                      |  34 ++
>  virt/kvm/arm/vgic.c                            | 584 +++++++++++++++++++++++--
>  virt/kvm/kvm_main.c                            |   5 +
>  19 files changed, 881 insertions(+), 57 deletions(-)
>  create mode 100644 Documentation/virtual/kvm/devices/arm-vgic.txt
> 
> Andre Przywara (1):
>   ARM/KVM: save and restore generic timer registers
> 
> Anup Patel (3):
>   arm64: KVM: Add Kconfig option for max VCPUs per-Guest
>   arm64: KVM: Support X-Gene guest VCPU on APM X-Gene host
>   arm64: KVM: Force undefined exception for Guest SMC intructions
> 
> Christoffer Dall (11):
>   arm/arm64: KVM: arch_timer: Initialize cntvoff at kvm_init
>   ARM: KVM: Allow creating the VGIC after VCPUs
>   KVM: arm-vgic: Support KVM_CREATE_DEVICE for VGIC
>   KVM: arm-vgic: Set base addr through device API
>   irqchip: arm-gic: Define additional MMIO offsets and masks
>   KVM: arm-vgic: Make vgic mmio functions more generic
>   arm/arm64: kvm: Set vcpu->cpu to -1 on vcpu_put
>   KVM: arm-vgic: Add vgic reg access from dev attr
>   KVM: arm-vgic: Support unqueueing of LRs to the dist
>   KVM: arm-vgic: Add GICD_SPENDSGIR and GICD_CPENDSGIR handlers
>   KVM: arm-vgic: Support CPU interface reg access

Pulled into queue, thanks.
