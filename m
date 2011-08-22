From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 22 Aug 2011 16:35:26 +0800
Subject: [PATCH 2/6] ARM: add Highbank core platform support
In-Reply-To: <1313526898-19920-3-git-send-email-robherring2@gmail.com>
References: <1313526898-19920-1-git-send-email-robherring2@gmail.com>
	<1313526898-19920-3-git-send-email-robherring2@gmail.com>
Message-ID: <20110822083524.GA15742@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2011 at 03:34:54PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This adds basic support for the Calxeda Highbank platform.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
[...]
> +void highbank_init_irq(void)
> +{
> +	struct device_node *node;
> +	struct of_intc_desc desc;
> +	int n = 0;
> +
> +	memset(&desc, 0, sizeof(desc));
> +	desc.controller = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-gic");
> +	gic_of_init(&desc);
> +	node = desc.controller;
> +	for_each_child_of_node(node, desc.controller) {
> +		gic_of_ppi_init(&desc);
> +	}
> +
I failed to find the implementation of gic_of_ppi_init() in your patch
series below.

  [RFC PATCH 0/3] Yet another GIC OF binding series

Also one nit: the braces seem redundant.

-- 
Regards,
Shawn
