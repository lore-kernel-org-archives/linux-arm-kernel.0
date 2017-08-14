From: Eugeniy.Paltsev@synopsys.com (Eugeniy Paltsev)
Date: Mon, 14 Aug 2017 13:45:47 +0000
Subject: [PATCH v2 1/5] reset: add reset-simple to unify socfpga, stm32,
 sunxi, and zx2967
In-Reply-To: <1502469440.2310.27.camel@pengutronix.de>
References: <20170811130618.3676-1-p.zabel@pengutronix.de>
 <20170811130618.3676-2-p.zabel@pengutronix.de>
 <fc0d0480-947b-a731-627c-32c99bbc2586@adaptrum.com>
 <1502469440.2310.27.camel@pengutronix.de>
Message-ID: <1502718347.2586.16.camel@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Fri, 2017-08-11 at 18:37 +0200, Philipp Zabel wrote:
> > > +struct reset_simple_devdata {
> > > > > +	bool inverted;
> > > 
> > > +};
> > > +
> > > +static const struct reset_simple_devdata reset_simple_inverted =
> > > {
> > > +	.inverted = true,
> > 
> > Hmm. I think it would be useful for new devices if there were have
> > a way?
> > to specify this in devicetree.
> 
> This is a separate issue, and it should be discussed including the
> device tree list.
> 
> It could be as simple as a boolean "active-low;" property. But then
> absence of that property would not mean active-high for existing
> active-low drivers, which is confusing.
> 
> It could also reuse the flags already defined in
> dt-bindings/reset/ti-syscon.h and have some kind of
> ????reset-flags = <ASSERT_SET | DEASSERT_CLEAR | STATUS_SET>;
> property.
> 
> Suggestions welcome.
> 

Imho,

reset-type = <ACTIVE_LOW | ACTIVE_HIGH>;

looks good.
-- 
?Eugeniy Paltsev
