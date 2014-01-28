From: anup@brainfault.org (Anup Patel)
Date: Tue, 28 Jan 2014 09:50:11 +0530
Subject: [RFC PATCH 0/3] In-kernel PSCI v0.2 emulation for KVM ARM/ARM64
In-Reply-To: <1390309301-28424-1-git-send-email-anup.patel@linaro.org>
References: <1390309301-28424-1-git-send-email-anup.patel@linaro.org>
Message-ID: <CAAhSdy1XmquKRUmLXLSSEjZpj9cqPeBxj6ji+gpoL9WRbBwo6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 6:31 PM, Anup Patel <anup.patel@linaro.org> wrote:
> Currently, KVM ARM/ARM64 only provides in-kernel emulation of Power State
> and Coordination Interface (PSCI) v0.1.
>
> This patchset aims at providing newer PSCI v0.2 for KVM ARM/ARM64 VCPUs
> such that it does not break current KVM ARM/ARM64 ABI. Also, the patchset
> provides emulation of only few PSCI v0.2 functions such as PSCI_VERSION,
> CPU_ON, and CPU_OFF. Emulation of other PSCI v0.2 functions will be added
> later.
>
> The user space tools (i.e. QEMU or KVMTOOL) will have to explicitly enable
> KVM_ARM_VCPU_PSCI_0_2 feature using KVM_ARM_VCPU_INIT ioctl for providing
> PSCI v0.2 to VCPUs.
>
> Anup Patel (3):
>   KVM: Add capability to advertise PSCI v0.2 support
>   ARM/ARM64: KVM: Add support for PSCI v0.2 emulation
>   KVM: Documentation: Add info regarding KVM_ARM_VCPU_PSCI_0_2 feature
>
>  Documentation/virtual/kvm/api.txt |    2 +
>  arch/arm/include/asm/kvm_host.h   |    2 +-
>  arch/arm/include/uapi/asm/kvm.h   |   39 ++++++++++++++++--
>  arch/arm/kvm/arm.c                |    6 ++-
>  arch/arm/kvm/psci.c               |   79 ++++++++++++++++++++++++++++++-------
>  arch/arm64/include/asm/kvm_host.h |    2 +-
>  arch/arm64/include/uapi/asm/kvm.h |   39 ++++++++++++++++--
>  include/uapi/linux/kvm.h          |    1 +
>  8 files changed, 146 insertions(+), 24 deletions(-)
>
> --
> 1.7.9.5
>
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm

Hi All,

Please provide feedback and comments on this patchset.

Regards,
Anup
