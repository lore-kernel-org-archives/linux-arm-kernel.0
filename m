From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Fri, 15 Jun 2012 17:29:14 +0800
Subject: [PATCH 05/16] ARM: imx: move irq_domain_add_legacy call into
 tzic driver
In-Reply-To: <1339653587-4832-6-git-send-email-shawn.guo@linaro.org>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
 <1339653587-4832-6-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120615092914.GC8383@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 01:59:36PM +0800, Shawn Guo wrote:
> Move irq_domain_add_legacy call from imx5*-dt.c into tzic init function
> and have the tzic driver adopt irqdomain support for both DT and non-DT
> boot.
> 
> Now tzic init function calls irq_alloc_descs to get irq_base and adds
> a lenacy irqdomain with the irq_base, so that the mapping between tzic
> irq and Linux irq number can be handled by irqdomain.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
...
> @@ -77,15 +80,14 @@ static int tzic_set_irq_fiq(unsigned int irq, unsigned int type)
>  static void tzic_irq_suspend(struct irq_data *d)
>  {
>  	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> -	int idx = gc->irq_base >> 5;
> +	int idx = d->hwirq >> 5;
Good idea to address the virt irq_base issue.

Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

Regards
Dong Aisheng
