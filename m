From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 28 Nov 2018 13:58:46 -0800
Subject: [PATCH 3/6] clk: mvebu: add CPU clock driver for Armada 7K/8K
In-Reply-To: <87wooymqo3.fsf@bootlin.com>
References: <20180922181709.13007-1-gregory.clement@bootlin.com>
 <20180922181709.13007-4-gregory.clement@bootlin.com>
 <153980089252.5275.819540708953283855@swboyd.mtv.corp.google.com>
 <87y39tufwe.fsf@bootlin.com> <87wooymqo3.fsf@bootlin.com>
Message-ID: <154344232606.88331.9141020759033189289@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Gregory CLEMENT (2018-11-27 08:27:40)
> Hi Stephen,
>  
>  On ven., nov. 16 2018, Gregory CLEMENT <gregory.clement@bootlin.com> wrote:
> 
> >>> +static int ap_cpu_clock_probe(struct platform_device *pdev)
> >>> +{
> >>> +       int ret, nclusters = 0, cluster_index = 0;
> >>> +       struct device *dev = &pdev->dev;
> >>> +       struct device_node *dn, *np = dev->of_node;
> >>> +       struct ap_cpu_clk *ap_cpu_clk;
> >>> +       struct regmap *regmap;
> >>> +
> >>> +       regmap = syscon_node_to_regmap(np->parent);
> >>
> >> Can we just call dev_get_remap() on pdev->dev.parent?
> >
> > we could do regmap = dev_get_regmap(pdev->dev.parent, NULL); instead of
> > this line. But is it really better?
> 
> Actually we can't, because we really depend on a syscon and at this
> moment there is no regmap. It is the syscon_node_to_regmap function which
> creates this regmap when needed.
> 

Ah ok. Nevermind then.
