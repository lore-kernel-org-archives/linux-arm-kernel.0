From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 21 May 2014 11:27:20 +0100
Subject: [PATCH 1/2] irqchip: Add generic gic-v1/gic-v2 compat strings.
In-Reply-To: <1400664501-4208-2-git-send-email-Nikolay.Borisov@arm.com>
References: <1400664501-4208-1-git-send-email-Nikolay.Borisov@arm.com>
 <1400664501-4208-2-git-send-email-Nikolay.Borisov@arm.com>
Message-ID: <20140521102720.GF17827@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding devicetree at vger.kernel.org]

On Wed, May 21, 2014 at 10:28:20AM +0100, Nikolay Borisov wrote:
> The current set of GIC compatible strings only contains specific
> implementations (e.g. arm,cortex-a9-gic) rather than revisions of the
> standard (e.g. arm,gic-v2), so each new implementation must either claim
> to be an extension of an existing implementation or have a new string
> added to the driver. This may be problematic when workarounds are
> required for bugs in particular implementations, as said workaround may
> end up targeting a wider set of implementations than intended.
> 
> To prevent these issues, this patch adds compatible strings for the
> revisions of the GIC spec which all GIC implementations should be able
> to claim conformance to in addition to any particular implementation
> specific string, e.g.
> 
> compatible = "$VENDOR,specific-gic-variant", "arm,gic-v2";

This makes sense to me, so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Cheers,
Mark.

> 
> Signed-off-by: Nikolay Borisov <Nikolay.Borisov@arm.com>
> ---
>  drivers/irqchip/irq-gic.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 57d165e..89e9b05 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -1073,6 +1073,8 @@ gic_of_init(struct device_node *node, struct device_node *parent)
>  }
>  IRQCHIP_DECLARE(cortex_a15_gic, "arm,cortex-a15-gic", gic_of_init);
>  IRQCHIP_DECLARE(cortex_a9_gic, "arm,cortex-a9-gic", gic_of_init);
> +IRQCHIP_DECLARE(gic_v1, "arm,gic-v1", gic_of_init);
> +IRQCHIP_DECLARE(gic_v2, "arm,gic-v2", gic_of_init);
>  IRQCHIP_DECLARE(msm_8660_qgic, "qcom,msm-8660-qgic", gic_of_init);
>  IRQCHIP_DECLARE(msm_qgic2, "qcom,msm-qgic2", gic_of_init);
>  
> -- 
> 1.8.1.5
> 
