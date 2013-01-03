From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 2 Jan 2013 23:35:40 -0800
Subject: [PATCH 1/2] timer: vt8500: Move system timer to clocksource
In-Reply-To: <1357183510-8476-2-git-send-email-linux@prisktech.co.nz>
References: <1357183510-8476-1-git-send-email-linux@prisktech.co.nz>
 <1357183510-8476-2-git-send-email-linux@prisktech.co.nz>
Message-ID: <20130103073540.GB11309@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 03, 2013 at 04:25:09PM +1300, Tony Prisk wrote:
> +static void __init vt8500_timer_init(void)
> +{
> +	struct device_node *np;
> +	int timer_irq;
> +
> +	np = of_find_matching_node(NULL, vt8500_timer_ids);
> +	if (!np) {
> +		pr_err("%s: Timer description missing from Device Tree\n",
> +								__func__);
> +		return;
> +	}
> +	regbase = of_iomap(np, 0);
> +	if (!regbase) {
> +		pr_err("%s: Missing iobase description in Device Tree\n",
> +								__func__);
> +		of_node_put(np);
> +		return;
> +	}
> +	timer_irq = irq_of_parse_and_map(np, 0);
> +	if (!timer_irq) {
> +		pr_err("%s: Missing irq description in Device Tree\n",
> +								__func__);
> +		of_node_put(np);
> +		return;

You are forgetting to unmap the regbase here.

Thanks.

-- 
Dmitry
