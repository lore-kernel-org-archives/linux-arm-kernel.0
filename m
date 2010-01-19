From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Tue, 19 Jan 2010 12:12:30 +0100
Subject: [PATCH] regulator: mc13783: consider Power Gates as digital
	regulators.
In-Reply-To: <1263896816.3089.40.camel@odin>
References: <1263830523.3632.22.camel@realization>
	<20100118190445.GA16989@pengutronix.de>
	<1263848512.3632.74.camel@realization> <1263896816.3089.40.camel@odin>
Message-ID: <1263899550.6669.21.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On mar, 2010-01-19 at 10:26 +0000, Liam Girdwood wrote:
> > +static struct regulator_ops mc13783_gpo_regulator_ops = {
> > +     .enable = mc13783_gpo_regulator_enable,
> > +     .disable = mc13783_gpo_regulator_disable,
> > +     .is_enabled = mc13783_gpo_regulator_is_enabled,
> 
> How is the voltage output on the GPO regulator governed. Is it
> controlled by a parent regulator or fixed ?
> 
> We probably want a way to query the voltage here or specify the parent
> relationship. 

Good question.
>From datasheet GPO's are marked as LV (Low Voltage)-> 3.1V
Power Gates Driver are marked as EMV (Extended Medium Voltage) -> 5.5V

and no way to modify that -> they are fixed regulators.

I will add voltage query capability.
