From: eric.auger@redhat.com (Auger Eric)
Date: Mon, 8 May 2017 18:03:21 +0200
Subject: [PATCH 2/8] KVM: arm/arm64: vgic: Rename kvm_vgic_vcpu_init to
 kvm_vgic_vcpu_enable
In-Reply-To: <20170508115454.5075-3-cdall@linaro.org>
References: <20170508115454.5075-1-cdall@linaro.org>
 <20170508115454.5075-3-cdall@linaro.org>
Message-ID: <318ef8e6-846a-a94c-7fcc-fbe0e96ca497@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/05/2017 13:54, Christoffer Dall wrote:
> This function really doesn't init anything, it enables the CPU
> interface, so name it as such, which gives us the name to use for actual
> init work later on.
> 
> Signed-off-by: Christoffer Dall <cdall@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  virt/kvm/arm/vgic/vgic-init.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
> index 87de048..0ea64a1 100644
> --- a/virt/kvm/arm/vgic/vgic-init.c
> +++ b/virt/kvm/arm/vgic/vgic-init.c
> @@ -226,11 +226,7 @@ static int kvm_vgic_dist_init(struct kvm *kvm, unsigned int nr_spis)
>  	return 0;
>  }
>  
> -/**
> - * kvm_vgic_vcpu_init() - Enable the VCPU interface
> - * @vcpu: the VCPU which's VGIC should be enabled
> - */
> -static void kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
> +static void kvm_vgic_vcpu_enable(struct kvm_vcpu *vcpu)
>  {
>  	if (kvm_vgic_global_state.type == VGIC_V2)
>  		vgic_v2_enable(vcpu);
> @@ -269,7 +265,7 @@ int vgic_init(struct kvm *kvm)
>  		dist->msis_require_devid = true;
>  
>  	kvm_for_each_vcpu(i, vcpu, kvm)
> -		kvm_vgic_vcpu_init(vcpu);
> +		kvm_vgic_vcpu_enable(vcpu);
>  
>  	ret = kvm_vgic_setup_default_irq_routing(kvm);
>  	if (ret)
> 
