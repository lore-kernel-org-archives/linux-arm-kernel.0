From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 10 Aug 2011 14:14:28 +0100
Subject: [RFC PATCH 1/3] dt: irq: add interrupt controller descriptor
	struct
In-Reply-To: <1312921020-6820-2-git-send-email-robherring2@gmail.com>
References: <1312921020-6820-1-git-send-email-robherring2@gmail.com>
	<1312921020-6820-2-git-send-email-robherring2@gmail.com>
Message-ID: <20110810131428.GF2680@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2011 at 03:16:58PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> In preparation to scan and initialize interrupt controllers from a
> device-tree, create struct to pass to interrupt controller initialization
> functions.
> 
> irq_base should go away with dynamic linux irq assignment.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
>  include/linux/of_irq.h |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
> index cd2e61c..de91ff9 100644
> --- a/include/linux/of_irq.h
> +++ b/include/linux/of_irq.h
> @@ -33,6 +33,12 @@ struct of_irq {
>  	u32 specifier[OF_MAX_IRQ_SPEC]; /* Specifier copy */
>  };
>  
> +struct of_intc_desc {
> +	struct device_node *controller;
> +	struct device_node *parent;

Do we need parent here?  I think that of_irq_find_parent() will do the 
job.

Other than that nit the series looks nice to me.

Jamie
