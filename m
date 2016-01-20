From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Wed, 20 Jan 2016 07:12:40 +0000
Subject: [PATCH 1/2] regulator: act8945a: add regulator driver for ACT8945A
In-Reply-To: <20160115175757.GA6588@sirena.org.uk>
References: <1452218938-10621-1-git-send-email-wenyou.yang@atmel.com>
 <1452218938-10621-2-git-send-email-wenyou.yang@atmel.com>
 <20160115175757.GA6588@sirena.org.uk>
Message-ID: <B256D81BAE5131468A838E5D7A243641D63F61A7@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Thank you for your review.

> -----Original Message-----
> From: Mark Brown [mailto:broonie at kernel.org]
> Sent: 2016?1?16? 1:58
> To: Yang, Wenyou <Wenyou.Yang@atmel.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>; Rob Herring <robh+dt@kernel.org>;
> Pawel Moll <pawel.moll@arm.com>; Mark Rutland <mark.rutland@arm.com>; Ian
> Campbell <ijc+devicetree@hellion.org.uk>; Kumar Gala <galak@codeaurora.org>;
> Ferre, Nicolas <Nicolas.FERRE@atmel.com>; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org
> Subject: Re: [PATCH 1/2] regulator: act8945a: add regulator driver for ACT8945A
> 
> On Fri, Jan 08, 2016 at 10:08:57AM +0800, Wenyou Yang wrote:
> 
> > +	np = of_get_child_by_name(pdev->dev.of_node, "regulators");
> > +	if (!np) {
> > +		dev_err(&pdev->dev, "regulator node not found\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	matches = act8945a_matches;
> > +	num_matches = ARRAY_SIZE(act8945a_matches);
> > +
> > +	ret = of_regulator_match(&pdev->dev, np, matches, num_matches);
> 
> Don't open code this, use the core regulators_node and of_match implementation
> instead.

Good. In the next version, I use the code implementation, and remove the redundant code.

Thank you for your advice.

> 
> > +		dev_info(act8945a_dev->dev, "%s regulator registered\n",
> > +			desc->name);
> 
> This is just noise, please remove it - let the core handle notifying users.

It is fixed in version 2.

> 
> > +static int __init act8945a_pmic_init(void) {
> > +	return platform_driver_register(&act8945a_pmic_driver);
> > +}
> > +subsys_initcall(act8945a_pmic_init);
> 
> Please use module_platform_driver() unless there is a strong reason to do
> otherwise.

It is fixed in version 2 too.


Best Regards,
Wenyou Yang
