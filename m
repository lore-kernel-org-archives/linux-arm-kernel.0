From: HenryC.Chen@mediatek.com (Henry Chen)
Date: Tue, 21 Jul 2015 17:52:19 +0800
Subject: [PATCH 2/2] regulator: MT6311: Add support for MT6311 regulator
In-Reply-To: <20150720173153.GH11162@sirena.org.uk>
References: <1437377793-31558-1-git-send-email-henryc.chen@mediatek.com>
 <1437377793-31558-3-git-send-email-henryc.chen@mediatek.com>
 <20150720173153.GH11162@sirena.org.uk>
Message-ID: <1437472339.30329.57.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-07-20 at 18:31 +0100, Mark Brown wrote:
> On Mon, Jul 20, 2015 at 03:36:33PM +0800, Henry Chen wrote:
> 
> > @@ -460,6 +460,15 @@ config REGULATOR_MT6397
> >  	  This driver supports the control of different power rails of device
> >  	  through regulator interface.
> >  
> > +config REGULATOR_MT6311
> > +	tristate "MediaTek MT6311 PMIC"
> 
> Please keep these files sorted, MT6311 should be before MT6397.
> 
> > +static struct mt6311_pdata *mt6311_parse_regulators_dt(
> > +		struct device *dev)
> > +{
> > +	struct mt6311_pdata *pdata;
> > +	struct device_node *node;
> > +	int i, num, n;
> > +
> > +	node = of_get_child_by_name(dev->of_node, "regulators");
> > +	if (!node) {
> > +		dev_err(dev, "regulators node not found\n");
> > +		return ERR_PTR(-ENODEV);
> > +	}
> > +
> > +	num = of_regulator_match(dev, node, mt6311_matches,
> > +				 ARRAY_SIZE(mt6311_matches));
> 
> Please convert this to use the modern method of specifying the regulator
> DT bindings by providing of_match and regulators_node in the
> regulator_desc so the core does the mapping for yand regulators_node in
> the regulator_desc so the core does the mapping for yand regulators_node
> in the regulator_desc so the core does the mapping for yand
> regulators_node in the regulator_desc so the core does the mapping for
> you and you can delete the DT handling code.
> 
> Otherwise this driver looks good.

Ok, I will correct these on next version.

Thanks,
Henry
