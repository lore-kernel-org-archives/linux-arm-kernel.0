From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 Aug 2014 15:27:36 +0100
Subject: [PATCH 06/11] KVM: vgic: declare probe function pointer as const
In-Reply-To: <1409062410-25891-7-git-send-email-will.deacon@arm.com>
References: <1409062410-25891-1-git-send-email-will.deacon@arm.com>
 <1409062410-25891-7-git-send-email-will.deacon@arm.com>
Message-ID: <53FC9958.9010907@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/08/14 15:13, Will Deacon wrote:
> We extract the vgic probe function from the of_device_id data pointer,
> which is const. Kill the sparse warning by ensuring that the local
> function pointer is also marked as const.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.

> ---
>  virt/kvm/arm/vgic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index d1cfe672b9d7..efe6eee2e7eb 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -1557,8 +1557,8 @@ static const struct of_device_id vgic_ids[] = {
>  int kvm_vgic_hyp_init(void)
>  {
>  	const struct of_device_id *matched_id;
> -	int (*vgic_probe)(struct device_node *,const struct vgic_ops **,
> -			  const struct vgic_params **);
> +	const int (*vgic_probe)(struct device_node *,const struct vgic_ops **,
> +				const struct vgic_params **);
>  	struct device_node *vgic_node;
>  	int ret;
>  
> 


-- 
Jazz is not dead. It just smells funny...
