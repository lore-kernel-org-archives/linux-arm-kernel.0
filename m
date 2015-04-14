From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 14 Apr 2015 12:44:46 +0200
Subject: [PATCH] KVM: arm: irqfd: fix value returned by kvm_irq_map_gsi
In-Reply-To: <1428930119-21692-1-git-send-email-eric.auger@linaro.org>
References: <1428930119-21692-1-git-send-email-eric.auger@linaro.org>
Message-ID: <20150414104446.GA6186@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 13, 2015 at 03:01:59PM +0200, Eric Auger wrote:
> irqfd/arm curently does not support routing. kvm_irq_map_gsi is
> supposed to return all the routing entries associated with the
> provided gsi and return the number of those entries. We should
> return 0 at this point.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> ---
>  virt/kvm/arm/vgic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index 9ad074e..9b4f7d4 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -1947,7 +1947,7 @@ int kvm_irq_map_gsi(struct kvm *kvm,
>  		    struct kvm_kernel_irq_routing_entry *entries,
>  		    int gsi)
>  {
> -	return gsi;
> +	return 0;
>  }
>  
>  int kvm_irq_map_chip_pin(struct kvm *kvm, unsigned irqchip, unsigned pin)
> -- 

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
