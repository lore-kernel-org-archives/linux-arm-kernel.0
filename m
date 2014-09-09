From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 9 Sep 2014 11:15:34 +0100
Subject: [PATCH] KVM: arm64: add gic-400 compatible
In-Reply-To: <20140908222144.4967.80301.stgit@joelaarch64.amd.com>
References: <20140908222144.4967.80301.stgit@joelaarch64.amd.com>
Message-ID: <20140909101534.GA27786@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 08, 2014 at 11:21:44PM +0100, Joel Schopp wrote:
> Add a one liner to identify the gic-400.  It's gicv2 with optional MSI extensions.
> 
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Joel Schopp <joel.schopp@amd.com>
> ---
>  virt/kvm/arm/vgic.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index 73eba79..e81444e 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -1550,6 +1550,7 @@ static struct notifier_block vgic_cpu_nb = {
>  
>  static const struct of_device_id vgic_ids[] = {
>  	{ .compatible = "arm,cortex-a15-gic", .data = vgic_v2_probe, },
> +	{ .compatible = "arm,gic-400", .data = vgic_v2_probe, },

Given this is documented and is supported by the GIC driver:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.
