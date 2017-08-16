From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 16 Aug 2017 17:11:33 +0200
Subject: [PATCH v3 1/5] reset: add reset-simple to unify socfpga, stm32,
 sunxi, and zx2967
In-Reply-To: <d6b20df2-12f7-68b1-f7de-0c7f205eba13@suse.de>
References: <20170816094701.30678-1-p.zabel@pengutronix.de>
 <20170816094701.30678-2-p.zabel@pengutronix.de>
 <51db563d-d6e1-18f1-01c1-3fdcf8269773@arm.com>
 <d6b20df2-12f7-68b1-f7de-0c7f205eba13@suse.de>
Message-ID: <1502896293.7596.7.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-08-16 at 14:12 +0200, Andreas F?rber wrote:
> Hi Andre,
> 
> Am 16.08.2017 um 13:30 schrieb Andre Przywara:
> > On 16/08/17 10:46, Philipp Zabel wrote:
> > > +/**
> > > + * struct reset_simple_devdata - simple reset controller properties
> > > + * @active_low: if true, bits are cleared to assert the reset. Otherwise, bits
> > > + *??????????????are set to assert the reset.
> > > + */
> > > +struct reset_simple_devdata {
> > > > > > +	bool active_low;
> > > +};
> > > +
> > > +static const struct reset_simple_devdata reset_simple_active_low = {
> > > > > > +	.active_low = true,
> > > +};
> > > +
> > > +static const struct of_device_id reset_simple_dt_ids[] = {
> > > > > > +	{ .compatible = "allwinner,sun6i-a31-clock-reset",
> > > +		.data = &reset_simple_active_low },
> > 
> > Can we have a additional generic compatible string here? New users of
> > this driver then wouldn't need to explicitly enter their name into the
> > driver, but could just use the generic name as a fallback. This would
> > enable the driver without any Linux code change just by adding a DT node.
> > 
> > 	compatible = "nexell,s5p6818-reset", "simple-reset";
> > 
> > Whenever we need a quirk (now or in the future), we can add the specific
> > name into this structure along with the required workarounds.
> 
> Same question about binding here. However the way it is done today, we
> would also need some optional active-low property then or two different
> compatible strings, as this is currently controlled via the DT matches.

I'd like to decouple this from the issue at hand, which is de-
duplicating simple reset code without device tree changes.

I'll make a separate suggestion for a simple binding on top of this
series.

regards
Philipp
