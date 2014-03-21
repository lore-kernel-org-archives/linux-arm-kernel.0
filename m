From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 21 Mar 2014 16:30:24 -0700
Subject: [PATCH v5 11/11] ARM/ARM64: KVM: Advertise KVM_CAP_ARM_PSCI_0_2
 to user space
In-Reply-To: <1395406414-11707-12-git-send-email-anup.patel@linaro.org>
References: <1395406414-11707-1-git-send-email-anup.patel@linaro.org>
 <1395406414-11707-12-git-send-email-anup.patel@linaro.org>
Message-ID: <20140321233024.GD25519@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 21, 2014 at 06:23:34PM +0530, Anup Patel wrote:
> We have PSCI v0.2 emulation available in KVM ARM/ARM64
> hence advertise this to user space (i.e. QEMU or KVMTOOL)
> via KVM_CHECK_EXTENSION ioctl.
> 
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> ---
>  arch/arm/kvm/arm.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index bd18bb8..2076605 100644
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
> -- 
> 1.7.9.5
> 

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
