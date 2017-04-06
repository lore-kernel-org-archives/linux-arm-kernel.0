From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 6 Apr 2017 18:13:32 +0100
Subject: [PATCH v3 5/5] KVM: arm/arm64: Advertise support for
 KVM_CAP_ARM_USER_IRQ
In-Reply-To: <20170405092815.22503-6-cdall@linaro.org>
References: <20170405092815.22503-1-cdall@linaro.org>
 <20170405092815.22503-6-cdall@linaro.org>
Message-ID: <918dbb1b-088a-dab5-e14b-914e0e879ec0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/17 10:28, Christoffer Dall wrote:
> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> Now when we support both the virtual timer and PMU reporting interrupts

Now that... both timers...

> to userspace, we can advertise this support.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/arm/kvm/arm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index f935383..b420aa9 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -229,6 +229,13 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  		else
>  			r = kvm->arch.vgic.msis_require_devid;
>  		break;
> +	case KVM_CAP_ARM_USER_IRQ:
> +		/*
> +		 * 1: EL1_VTIMER, EL1_PTIMER, and PMU.
> +		 * (bump this number if adding more devices)
> +		 */
> +		r = 1;
> +		break;
>  	default:
>  		r = kvm_arch_dev_ioctl_check_extension(kvm, ext);
>  		break;
> 


-- 
Jazz is not dead. It just smells funny...
