From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 13 Dec 2013 11:19:31 -0800
Subject: [PATCH v2 0/2] PSCI system off and reset for KVM ARM/ARM64
In-Reply-To: <1386864747-29006-4-git-send-email-anup.patel@linaro.org>
References: <1386864747-29006-1-git-send-email-anup.patel@linaro.org>
 <1386864747-29006-4-git-send-email-anup.patel@linaro.org>
Message-ID: <20131213191931.GZ2871@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 09:42:25PM +0530, Anup Patel wrote:
> The Power State and Coordination Interface (PSCI) specification defines
> SYSTEM_OFF and SYSTEM_RESET functions for system poweroff and reboot.
> 
> This patchset adds emulation of PSCI SYSTEM_OFF and SYSTEM_RESET functions
> in KVM ARM/ARM64 by forwarding them to user space (QEMU or KVMTOOL) using
> KVM_EXIT_SYSTEM_EVENT exit reason.
> 
> To try this patch from guest kernel, we will need PSCI-based restart and
> poweroff support in the guest kenel for both ARM and ARM64.
> 
> Rob Herring has already submitted patches for PSCI-based restart and
> poweroff in ARM kernel but these are not merged yet due unstable device
> tree bindings of kernel PSCI support. We will be having similar patches
> for PSCI-based restart and poweroff in ARM64 kernel.
> (Refer http://www.spinics.net/lists/arm-kernel/msg262217.html)
> (Refer http://www.spinics.net/lists/devicetree/msg05348.html)

There's something really funky about the threading and reply-to settings
of all of these patches, please check your e-mail sending tool config.

> 
> Change Log:
> 
> V2:
>  - Replace KVM_EXIT_RESET with KVM_EXIT_SYSTEM_EVENT
>  - Make kvm_psci_call() return convention to match 
>    KVM ARM return convention
> 
> V1:
>  - Initial revised patch after RFC PATCH.
> 
> Anup Patel (2):
>   KVM: Add KVM_EXIT_SYSTEM_EVENT to user space API header
>   ARM/ARM64: KVM: Forward PSCI SYSTEM_OFF and SYSTEM_RESET to user
>     space
> 
>  Documentation/virtual/kvm/api.txt |   15 ++++++++++++
>  arch/arm/include/asm/kvm_psci.h   |    2 +-
>  arch/arm/include/uapi/asm/kvm.h   |    2 ++
>  arch/arm/kvm/handle_exit.c        |   13 +++++++---
>  arch/arm/kvm/psci.c               |   48 ++++++++++++++++++++++++++++++-------
>  arch/arm64/include/asm/kvm_psci.h |    2 +-
>  arch/arm64/include/uapi/asm/kvm.h |    2 ++
>  arch/arm64/kvm/handle_exit.c      |   12 +++++++---
>  include/uapi/linux/kvm.h          |    8 +++++++
>  9 files changed, 88 insertions(+), 16 deletions(-)
> 
> -- 
> 1.7.9.5
> 

-- 
Christoffer
