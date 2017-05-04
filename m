From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 4 May 2017 09:11:09 +0100
Subject: [PATCH 3/5] KVM: arm/arm64: Move irq_is_ppi() to header file
In-Reply-To: <20170503183300.4618-4-cdall@linaro.org>
References: <20170503183300.4618-1-cdall@linaro.org>
 <20170503183300.4618-4-cdall@linaro.org>
Message-ID: <7f12b380-d8e6-af23-6f44-8b5778a3d89a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/05/17 19:32, Christoffer Dall wrote:
> We are about to need this define in the arch timer code as well so move
> it to a common location.
> 
> Signed-off-by: Christoffer Dall <cdall@linaro.org>
> ---
>  include/kvm/arm_vgic.h | 2 ++
>  virt/kvm/arm/pmu.c     | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> index 26ed4fb..1541f5d 100644
> --- a/include/kvm/arm_vgic.h
> +++ b/include/kvm/arm_vgic.h
> @@ -38,6 +38,8 @@
>  #define VGIC_MIN_LPI		8192
>  #define KVM_IRQCHIP_NUM_PINS	(1020 - 32)
>  
> +#define irq_is_ppi(irq) ((irq) >= VGIC_NR_SGIS && (irq) < VGIC_NR_PRIVATE_IRQS)
> +
>  enum vgic_type {
>  	VGIC_V2,		/* Good ol' GICv2 */
>  	VGIC_V3,		/* New fancy GICv3 */
> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
> index f046b08..9b3e3ea 100644
> --- a/virt/kvm/arm/pmu.c
> +++ b/virt/kvm/arm/pmu.c
> @@ -481,8 +481,6 @@ static int kvm_arm_pmu_v3_init(struct kvm_vcpu *vcpu)
>  	return 0;
>  }
>  
> -#define irq_is_ppi(irq) ((irq) >= VGIC_NR_SGIS && (irq) < VGIC_NR_PRIVATE_IRQS)
> -
>  /*
>   * For one VM the interrupt type must be same for each vcpu.
>   * As a PPI, the interrupt number is the same for all vcpus,
> 

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
