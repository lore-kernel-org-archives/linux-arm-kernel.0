From: mporter@linaro.org (Matt Porter)
Date: Tue, 4 Feb 2014 16:29:14 -0500
Subject: [PATCH 4/6] regulator: add bcm59056 regulator driver
In-Reply-To: <20140204172836.GH22609@sirena.org.uk>
References: <1391516352-32359-1-git-send-email-mporter@linaro.org>
 <1391516352-32359-5-git-send-email-mporter@linaro.org>
 <20140204172836.GH22609@sirena.org.uk>
Message-ID: <20140204212914.GB16179@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 05:28:36PM +0000, Mark Brown wrote:
> On Tue, Feb 04, 2014 at 07:19:10AM -0500, Matt Porter wrote:
> 
> > +static unsigned int bcm59056_get_mode(struct regulator_dev *dev)
> > +{
> > +	return REGULATOR_MODE_NORMAL;
> > +}
> > +
> > +static int bcm59056_set_mode(struct regulator_dev *dev, unsigned int mode)
> > +{
> > +	if (mode == REGULATOR_MODE_NORMAL)
> > +		return 0;
> > +	else
> > +		return -EINVAL;
> > +}
> 
> These do nothing, don't implement them.

Will remove. Maybe some day.

> > +	if (bcm59056->dev->of_node)
> > +		pmu_data = bcm59056_parse_dt_reg_data(pdev,
> > +						      &bcm59056_reg_matches);
> 
> It'd seem a bit neater to put the OF check into the parse function but
> meh.

On second look, I'd agree. Easy enough to clean up.

> > +	if (!pmu_data) {
> > +		dev_err(&pdev->dev, "Platform data not found\n");
> > +		return -EINVAL;
> > +	}
> 
> Like I said when reviewing the binding this should not cause the driver
> to fail to load.

Will fix.

> > +		/*
> > +		 * Regulator API handles empty constraints but not NULL
> > +		 * constraints
> > +		 */
> > +		if (!reg_data)
> > +			continue;
> 
> It should do...  if not then make it so since that'd mean most drivers
> are buggy.

Ahh, I see there is a check for NULL in the core. Will drop.

-Matt
