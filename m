From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 30 Mar 2015 20:31:38 +0200
Subject: [PATCH 2/6] clk: mediatek: Add initial common clock support for
 Mediatek SoCs.
In-Reply-To: <1427738146.14276.20.camel@perches.com>
References: <1427737245-4064-1-git-send-email-s.hauer@pengutronix.de>
 <1427737245-4064-3-git-send-email-s.hauer@pengutronix.de>
 <1427738146.14276.20.camel@perches.com>
Message-ID: <20150330183138.GG9742@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 10:55:46AM -0700, Joe Perches wrote:
> On Mon, 2015-03-30 at 19:40 +0200, Sascha Hauer wrote:
> > This patch adds common clock support for Mediatek SoCs, including plls,
> > muxes and clock gates.
> 
> trivia:
> 
> > diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
> 
> > +static int mtk_cg_bit_is_cleared(struct clk_hw *hw)
> > +{
> []
> > +	return val == 0;
> > +}
> > +
> > +static int mtk_cg_bit_is_set(struct clk_hw *hw)
> > +{
> []
> > +	return val != 0;
> > +}
> 
> These functions may be better returning a bool

The return type of these functions is forced by function prototype in
struct clk_ops.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
