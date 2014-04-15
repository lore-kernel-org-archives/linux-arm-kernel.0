From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 15 Apr 2014 13:16:17 +0100
Subject: [PATCH v9 12/12] ARM/ARM64: KVM: Advertise KVM_CAP_ARM_PSCI_0_2
 to user space
In-Reply-To: <1397542455-354-13-git-send-email-anup.patel@linaro.org> (Anup
 Patel's message of "Tue, 15 Apr 2014 07:14:15 +0100")
References: <1397542455-354-1-git-send-email-anup.patel@linaro.org>
 <1397542455-354-13-git-send-email-anup.patel@linaro.org>
Message-ID: <874n1uzt2m.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15 2014 at  7:14:15 am BST, Anup Patel <anup.patel@linaro.org> wrote:
> We have PSCI v0.2 emulation available in KVM ARM/ARM64
> hence advertise this to user space (i.e. QEMU or KVMTOOL)
> via KVM_CHECK_EXTENSION ioctl.
>
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

> ---
>  arch/arm/kvm/arm.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index f0e50a0..3c82b37 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -197,6 +197,7 @@ int kvm_dev_ioctl_check_extension(long ext)
>  	case KVM_CAP_DESTROY_MEMORY_REGION_WORKS:
>  	case KVM_CAP_ONE_REG:
>  	case KVM_CAP_ARM_PSCI:
> +	case KVM_CAP_ARM_PSCI_0_2:
>  		r = 1;
>  		break;
>  	case KVM_CAP_COALESCED_MMIO:

-- 
Jazz is not dead. It just smells funny.
