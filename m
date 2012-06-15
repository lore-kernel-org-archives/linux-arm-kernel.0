From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Fri, 15 Jun 2012 17:37:14 +0800
Subject: [PATCH 07/16] dma: ipu: remove the use of ipu_platform_data
In-Reply-To: <1339653587-4832-8-git-send-email-shawn.guo@linaro.org>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
 <1339653587-4832-8-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120615093713.GE8383@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 01:59:38PM +0800, Shawn Guo wrote:
.......
> @@ -354,10 +355,12 @@ static struct irq_chip ipu_irq_chip = {
>  /* Install the IRQ handler */
>  int __init ipu_irq_attach_irq(struct ipu *ipu, struct platform_device *dev)
>  {
> -	struct ipu_platform_data *pdata = dev->dev.platform_data;
> -	unsigned int irq, irq_base, i;
> +	unsigned int irq, i;
> +	int irq_base = irq_alloc_descs(-1, 0, CONFIG_MX3_IPU_IRQS,
> +				       numa_node_id());
>  
> -	irq_base = pdata->irq_base;
> +	if (irq_base < 0)
> +		return irq_base;
>  
Need not add irqdomain for this irq range?
Can we still service this irq properly without irqdomain mapping?

Regards
Dong Aisheng
