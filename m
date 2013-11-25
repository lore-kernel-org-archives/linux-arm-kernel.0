From: anup.patel@linaro.org (Anup Patel)
Date: Mon, 25 Nov 2013 21:27:46 +0530
Subject: [PATCH 0/2] PSCI system off and reset for KVM ARM/ARM64
In-Reply-To: <1385394599-15439-1-git-send-email-anup.patel@linaro.org>
References: <1385394599-15439-1-git-send-email-anup.patel@linaro.org>
Message-ID: <CALrVBktOaQz5zbv2xRr8YbfvmRToK-kg3kJMFpNHSVeyuYutAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 November 2013 21:19, Anup Patel <anup.patel@linaro.org> wrote:
> The Power State and Coordination Interface (PSCI) specification defines
> SYSTEM_OFF and SYSTEM_RESET functions for system poweroff and reboot.
>
> This patchset adds emulation of PSCI SYSTEM_OFF and SYSTEM_RESET functions
> in KVM ARM/ARM64 by forwarding them to user space (QEMU or KVMTOOL) using
> KVM_EXIT_SHUTDOWN and KVM_EXIT_RESET exit reasons.
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
>
> Anup Patel (2):
>   KVM: Add KVM_EXIT_RESET to user space API header
>   ARM/ARM64: KVM: Forward PSCI SYSTEM_OFF and SYSTEM_RESET to user
>     space
>
>  arch/arm/include/asm/kvm_psci.h   |    2 +-
>  arch/arm/include/uapi/asm/kvm.h   |    2 ++
>  arch/arm/kvm/handle_exit.c        |    7 ++++++-
>  arch/arm/kvm/psci.c               |   38 +++++++++++++++++++++++++++++--------
>  arch/arm64/include/asm/kvm_psci.h |    2 +-
>  arch/arm64/include/uapi/asm/kvm.h |    2 ++
>  arch/arm64/kvm/handle_exit.c      |   10 ++++++----
>  include/uapi/linux/kvm.h          |    1 +
>  8 files changed, 49 insertions(+), 15 deletions(-)
>
> --
> 1.7.9.5
>

Hi All,

If anyone wants to try this patches using KVMTOOL then they
can find guest kernel side PSCI patches and KVMTOOL patch
attached here.

Regards,
Anup
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0006-ARM-psci-Add-support-for-system-reboot-and-poweroff.patch
Type: text/x-diff
Size: 2340 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131125/a3142151/attachment-0003.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0007-ARM64-psci-Add-support-for-system-reboot-and-powerof.patch
Type: text/x-diff
Size: 2381 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131125/a3142151/attachment-0004.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: kvmtool_psci_emulation.patch
Type: text/x-diff
Size: 4544 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131125/a3142151/attachment-0005.bin>
