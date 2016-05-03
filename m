From: thomas.hanson@linaro.org (Tom Hanson)
Date: Tue, 3 May 2016 16:22:37 -0600
Subject: [PATCH v2 07/54] KVM: arm/arm64: vgic: Remove irq_phys_map from
 interface
In-Reply-To: <1461861973-26464-8-git-send-email-andre.przywara@arm.com>
References: <1461861973-26464-1-git-send-email-andre.przywara@arm.com>
 <1461861973-26464-8-git-send-email-andre.przywara@arm.com>
Message-ID: <572924AD.9050902@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2016 10:45 AM, Andre Przywara wrote:
...
> diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
> index 3a74b17..9475000 100644
> --- a/virt/kvm/arm/arch_timer.c
> +++ b/virt/kvm/arm/arch_timer.c
> @@ -333,10 +333,10 @@ int kvm_timer_vcpu_reset(struct kvm_vcpu *vcpu,
...
> +	ret = kvm_vgic_map_phys_irq(vcpu, irq->irq, phys_irq);
> +	if (ret)
> +		return ret;
>
>   	return 0;
>   }

This isn't wrong, but it is overly complicated.  I'd recommend either:
     ret = kvm_vgic_map_phys_irq(vcpu, irq->irq, phys_irq);
     return ret;
OR
     return kvm_vgic_map_phys_irq(vcpu, irq->irq, phys_irq);
