From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 16 Mar 2015 06:33:38 +0100
Subject: [PATCH 3/5] clk: mediatek: Add basic clocks for Mediatek MT8135.
In-Reply-To: <1426232670.1716.21.camel@mtksdaap41>
References: <1424605765-19751-1-git-send-email-s.hauer@pengutronix.de>
 <1424605765-19751-4-git-send-email-s.hauer@pengutronix.de>
 <1426232670.1716.21.camel@mtksdaap41>
Message-ID: <20150316053338.GD24798@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 03:44:30PM +0800, Henry Chen wrote:
> On Sun, 2015-02-22 at 12:49 +0100, Sascha Hauer wrote:
> > +#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits, _pd_reg, _pd_shift, _tuner_reg, _pcw_reg, _pcw_shift) { \
> > +		.id = _id,						\
> > +		.name = _name,						\
> > +		.reg = _reg,						\
> > +		.pwr_reg = _pwr_reg,					\
> > +		.en_mask = _en_mask,					\
> > +		.flags = _flags,					\
> > +		.rst_bar_mask = CON0_MT8135_RST_BAR,			\
> > +		.fmax = MT8135_PLL_FMAX,				\
> > +		.pcwbits = _pcwbits,					\
> > +		.pd_reg = _pd_reg,					\
> > +		.pd_shift = _pd_shift,					\
> > +		.tuner_reg = _tuner_reg,				\
> > +		.pcw_reg = _pcw_reg,					\
> > +		.pcw_shift = _pcw_shift,				\
> > +	}
> > +
> > +static struct mtk_pll_data plls[] = {
> > +	PLL(APMIXED_ARMPLL1, "armpll1", 0x200, 0x218, 0x80000001, 0, 21, 0x204, 24, 0x0, 0x204, 0),
> > +	PLL(APMIXED_ARMPLL2, "armpll2", 0x2cc, 0x2e4, 0x80000001, 0, 21, 0x2d0, 24, 0x0, 0x2d0, 0),
> > +	PLL(APMIXED_MAINPLL, "mainpll", 0x21c, 0x234, 0xf0000001, HAVE_RST_BAR, 21, 0x21c, 6, 0x0, 0x220, 0),
> > +	PLL(APMIXED_UNIVPLL, "univpll", 0x238, 0x250, 0xf3000001, HAVE_RST_BAR, 7, 0x238, 6, 0x0, 0x238, 9),
> > +	PLL(APMIXED_MMPLL, "mmpll", 0x254, 0x26c, 0xf0000001, HAVE_RST_BAR, 21, 0x254, 6, 0x0, 0x258, 0),
> > +	PLL(APMIXED_MSDCPLL, "msdcpll", 0x278, 0x290, 0x80000001, 0, 21, 0x278, 6, 0x0, 0x27c, 0),
> > +	PLL(APMIXED_TVDPLL, "tvdpll", 0x294, 0x2ac, 0x80000001, 0, 31, 0x296, 6, 0x0, 0x298, 0),
> 
> Hi Sasha,
> 
> The pd_reg of tvdpll should be 0x294.

Fixed, thanks

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
