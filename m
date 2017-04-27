From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 27 Apr 2017 09:12:37 +0200
Subject: [linux-sunxi] Re: [PATCH v5 02/11] clk: sunxi-ng: add support
 for DE2 CCU
In-Reply-To: <9def8a6b635880095e6b75e3a53af1f4@aosc.io>
References: <20170423103754.50012-1-icenowy@aosc.io>
 <20170423103754.50012-3-icenowy@aosc.io>
 <20170424085109.p44bmzbyjkuf7ckv@lukather>
 <9def8a6b635880095e6b75e3a53af1f4@aosc.io>
Message-ID: <20170427071237.eqv2pyp6t2i4auv2@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 24, 2017 at 06:26:51PM +0800, icenowy at aosc.io wrote:
> ? 2017-04-24 16:51?Maxime Ripard ???
> > Hi,
> > 
> > On Sun, Apr 23, 2017 at 06:37:45PM +0800, Icenowy Zheng wrote:
> > > +static const struct of_device_id sunxi_de2_clk_ids[] = {
> > > +	{
> > > +		.compatible = "allwinner,sun8i-a83t-de2-clk",
> > > +		.data = &sun8i_a83t_de2_clk_desc,
> > > +	},
> > > +	{
> > > +		.compatible = "allwinner,sun50i-h5-de2-clk",
> > > +		.data = &sun50i_a64_de2_clk_desc,
> > > +	},
> > > +	/*
> > > +	 * The Allwinner A64 SoC needs some bit to be poke in syscon to make
> > > +	 * DE2 really working.
> > > +	 * So there's currently no A64 compatible here.
> > > +	 * H5 shares the same reset line with A64, so here H5 is using the
> > > +	 * clock description of A64.
> > > +	 */
> > > +	{ }
> > > +};
> > 
> > So that A64 driver would require more than just what you defined in
> > the binding in order to operate?
> 
> Yes. When trying to do A64 driver, I will send out first a patch to
> add the needed binding bit.

Then remove the A64 compatible from the binding document.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170427/07055f3a/attachment.sig>
