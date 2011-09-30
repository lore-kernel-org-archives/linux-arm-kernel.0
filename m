From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 29 Sep 2011 19:24:08 -0600
Subject: [PATCH 2/9] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <20110927121003.GB4289@opensource.wolfsonmicro.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
	<1317118372-17052-3-git-send-email-rnayak@ti.com>
	<20110927121003.GB4289@opensource.wolfsonmicro.com>
Message-ID: <20110930012408.GE12606@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2011 at 01:10:04PM +0100, Mark Brown wrote:
> On Tue, Sep 27, 2011 at 03:42:45PM +0530, Rajendra Nayak wrote:
> 
> > +	init_data = devm_kzalloc(dev, sizeof(struct regulator_init_data),
> > +						 GFP_KERNEL);
> > +	if (!init_data)
> > +		return NULL; /* Out of memory? */
> 
> This means that the init data will be kept around for the entire
> lifetime of the device rather than being discarded.
> 
> > +	init_data->supply_regulator = (char *)of_get_property(dev->of_node,
> > +						"regulator-supplies", NULL);
> 
> I'd expect that in the device tree world the supply regulator would
> reference the node for that regulator.

Yes, I would expect the same.
