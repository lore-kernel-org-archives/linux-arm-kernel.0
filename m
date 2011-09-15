From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Sep 2011 12:41:32 +0200
Subject: [PATCH 3/5] of/irq: introduce of_irq_init
In-Reply-To: <1316017900-19918-4-git-send-email-robherring2@gmail.com>
References: <1316017900-19918-1-git-send-email-robherring2@gmail.com>
	<1316017900-19918-4-git-send-email-robherring2@gmail.com>
Message-ID: <201109151241.32951.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 September 2011, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> of_irq_init will scan the devicetree for matching interrupt controller
> nodes. Then it calls an initialization function for each found controller
> in the proper order with parent nodes initialized before child nodes.
> 
> Based on initial pseudo code from Grant Likely.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>

Looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>

> +
> +struct intc_desc {
> +       struct list_head        list;
> +       struct device_node      *dev;
> +       struct device_node      *parent;
> +};

One tiny comment: how about naming the parent 'interrupt_parent'? While
reading through the code, I was confused for a short time until I figured
out what this is about.

	Arnd
