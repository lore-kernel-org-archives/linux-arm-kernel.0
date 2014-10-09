From: yingjoe.chen@mediatek.com (Joe.C)
Date: Thu, 9 Oct 2014 22:53:45 +0800
Subject: [PATCH v3 4/7] ARM: mediatek: Add sysirq interrupt polarity
 support
In-Reply-To: <2076856.iIXavsNzjc@wuerfel>
References: <1412864980-20273-1-git-send-email-yingjoe.chen@mediatek.com>
 <1412864980-20273-5-git-send-email-yingjoe.chen@mediatek.com>
 <2076856.iIXavsNzjc@wuerfel>
Message-ID: <1412866425.23455.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-10-09 at 16:37 +0200, Arnd Bergmann wrote:
> On Thursday 09 October 2014 22:29:37 Joe. C wrote:
> 
> > +static int __init mtk_sysirq_of_init(struct device_node *node,
> > +				   struct device_node *parent)
> > +{
> > +	struct device_node *parent_node;
> > +	struct irq_domain *domain, *domain_parent = NULL;
> > +	struct mt_sysirq_chip_data *chip_data;
> > +	int ret = 0;
> > +
> > +	parent_node = of_irq_find_parent(node);
> > +	if (parent_node) {
> > +		domain_parent = irq_find_host(parent_node);
> > +		of_node_put(parent_node);
> > +	}
> 
> Just a small comment: I think the 'parent' argument to the function
> already contains the device node you are looking up here, so
> no need for the second variable or _find_parent call.
> 
> This means you can also drop the  = NULL assignment for the
> domain.
> 
> 	Arnd

Thanks for point this out. I'll fix this in the next version.

Joe.C
