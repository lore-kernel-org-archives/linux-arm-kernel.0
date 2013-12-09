From: zonque@gmail.com (Daniel Mack)
Date: Mon, 09 Dec 2013 09:56:57 +0100
Subject: [PATCH 4/9] ARM: pxa: remove unused variable
In-Reply-To: <1386543229-1542-5-git-send-email-ynvich@gmail.com>
References: <1386348542-9584-1-git-send-email-ynvich@gmail.com>
 <1386543229-1542-1-git-send-email-ynvich@gmail.com>
 <1386543229-1542-5-git-send-email-ynvich@gmail.com>
Message-ID: <52A585D9.4000605@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/08/2013 11:53 PM, Sergei Ianovich wrote:
> Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
> CC: Daniel Mack <zonque@gmail.com>
> ---
>  arch/arm/mach-pxa/irq.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
> index b6cc181..432842c 100644
> --- a/arch/arm/mach-pxa/irq.c
> +++ b/arch/arm/mach-pxa/irq.c
> @@ -236,7 +236,6 @@ void __init pxa_dt_irq_init(int (*fn)(struct irq_data *, unsigned int))
>  {
>  	struct device_node *node;
>  	const struct of_device_id *of_id;
> -	struct pxa_intc_conf *conf;
>  	struct resource res;
>  	int n, ret;
>  
> @@ -246,7 +245,6 @@ void __init pxa_dt_irq_init(int (*fn)(struct irq_data *, unsigned int))
>  		return;
>  	}
>  	of_id = of_match_node(intc_ids, node);
> -	conf = of_id->data;

A similar patch was already merged by Haojian recently. You should
probably rebase your patch stack on top of his maintainer tree.


Daniel
