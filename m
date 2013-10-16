From: anup@brainfault.org (Anup Patel)
Date: Wed, 16 Oct 2013 22:38:43 +0530
Subject: [RFC PATCH 0/5] PSCI system off and reset for KVM ARM/ARM64
In-Reply-To: <1381942954-22388-1-git-send-email-anup.patel@linaro.org>
References: <1381942954-22388-1-git-send-email-anup.patel@linaro.org>
Message-ID: <CAAhSdy2wDgkhuSQooVj8g0Az2qnx-PtuC1nEF5hH2VR2vdhEiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 16, 2013 at 10:32 PM, Anup Patel <anup.patel@linaro.org> wrote:
> The Power State and Coordination Interface (PSCI) specification defines
> SYSTEM_OFF and SYSTEM_RESET functions for system poweroff and reboot.
>
> This patchset adds:
> 1. Emulation of PSCI SYSTEM_OFF and SYSTEM_RESET functions in
>    KVM ARM/ARM64 by forwarding them to user space (QEMU or KVMTOOL)
> 2. System poweroff and reboot using PSCI for ARM/ARM64 kernel
>
> Anup Patel (5):
>   ARM/ARM64: KVM: Update user space API header for PSCI emulation
>   ARM/ARM64: KVM: Forward PSCI SYSTEM_OFF and SYSTEM_RESET to user
>     space
>   KVM: Add documentation for KVM_EXIT_PSCI exit reason
>   ARM: psci: Add support for system reboot and poweroff
>   ARM64: psci: Add support for system reboot and poweroff
>
>  Documentation/virtual/kvm/api.txt |   13 +++++++++
>  arch/arm/include/asm/kvm_psci.h   |   25 +++++++++++++++-
>  arch/arm/include/uapi/asm/kvm.h   |    2 ++
>  arch/arm/kernel/psci.c            |   36 +++++++++++++++++++++++
>  arch/arm/kvm/arm.c                |   12 ++++++--
>  arch/arm/kvm/handle_exit.c        |   12 ++++++--
>  arch/arm/kvm/psci.c               |   57 ++++++++++++++++++++++++++++++++++---
>  arch/arm64/include/asm/kvm_psci.h |   25 +++++++++++++++-
>  arch/arm64/include/uapi/asm/kvm.h |    2 ++
>  arch/arm64/kernel/psci.c          |   36 +++++++++++++++++++++++
>  arch/arm64/kvm/handle_exit.c      |   24 ++++++++++++----
>  include/uapi/linux/kvm.h          |    7 +++++
>  12 files changed, 233 insertions(+), 18 deletions(-)
>
> --
> 1.7.9.5
>
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm

Hi All,

If any of you want to try this patchset then you can temporarily
use the KVMTOOL patch attached here.

We will soon have QEMU side changes for emulating PSCI
SYSTEM_OFF and SYSTEM_RESET.

Regards,
Anup
-------------- next part --------------
A non-text attachment was scrubbed...
Name: kvmtool_psci_emulation.patch
Type: application/octet-stream
Size: 1593 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131016/0284206b/attachment.obj>
