From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 01 Jul 2010 15:32:17 +0200
Subject: [PATCH 2/3] arm: s5pv210: Aquila: add support for MAX8998 PMIC
In-Reply-To: <20100701122451.GA17698@sirena.org.uk>
References: <1277964466-23891-1-git-send-email-m.szyprowski@samsung.com>
	<1277964466-23891-3-git-send-email-m.szyprowski@samsung.com>
	<20100701122451.GA17698@sirena.org.uk>
Message-ID: <000001cb1921$d75de060$8619a120$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thursday, July 01, 2010 2:25 PM Mark Brown wrote:

> On Thu, Jul 01, 2010 at 08:07:45AM +0200, Marek Szyprowski wrote:
> 
> > +static struct regulator_consumer_supply aquila_ldo3_consumers[] = {
> > +	{	.supply	= "VMIPI_1.1V",	},
> > +};
> 
> > +static struct regulator_consumer_supply aquila_ldo8_consumers[] = {
> > +	{	.supply	= "VADC_3.3V", },
> > +};
> 
> Almost all of these regulator supplies should be removed.  Except in
> some exceptional cases all supplies should specify a struct device (the
> only one that really exists at the minute is CPU core due to lack of
> devices for CPUfreq).  In general if you're defining a supply name that
> is the same as the rail on the board rather than a pin on a chip you're
> not using the API correctly.

Ok. I will remove them now and add later with the appropriate devices.

One more question - should I enable the regulators in the driver itself
or in the platform callback (like a "poweron()" callback)?

If I put regulator enabling into the driver how can one make it working
on a board without regulators (chip powered all the time)? Should the
driver ignore errors from regulator_get()?

What if one regulator needs enabling other to operate properly 
(parent-child hierarchy)?

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
