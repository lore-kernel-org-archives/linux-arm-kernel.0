From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Thu, 25 Apr 2013 14:48:38 +0100
Subject: [PATCH v4 1/7] xen/arm: actually pass a non-NULL percpu pointer
 to request_percpu_irq
In-Reply-To: <1366831695-13214-1-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1304242012590.4180@kaball.uk.xensource.com>
 <1366831695-13214-1-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <1366897718.20256.546.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-04-24 at 20:28 +0100, Stefano Stabellini wrote:
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Reviewed-by: Ian Campbell <ian.camjpbell@citrix.com>

> CC: stable at vger.kernel.org
> ---
>  arch/arm/xen/enlighten.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index 8dc0605..99ce189 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -239,7 +239,7 @@ static int __init xen_init_events(void)
>  	xen_init_IRQ();
>  
>  	if (request_percpu_irq(xen_events_irq, xen_arm_callback,
> -			"events", xen_vcpu)) {
> +			"events", &xen_vcpu)) {
>  		pr_err("Error requesting IRQ %d\n", xen_events_irq);
>  		return -EINVAL;
>  	}
