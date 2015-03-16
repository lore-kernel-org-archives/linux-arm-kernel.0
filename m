From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 16 Mar 2015 06:34:19 +0100
Subject: [PATCH 1/5] clk: mediatek: Add initial common clock support for
 Mediatek SoCs.
In-Reply-To: <55031468.2040109@gmail.com>
References: <1424605765-19751-1-git-send-email-s.hauer@pengutronix.de>
 <1424605765-19751-2-git-send-email-s.hauer@pengutronix.de>
 <55031468.2040109@gmail.com>
Message-ID: <20150316053419.GE24798@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 05:46:32PM +0100, Matthias Brugger wrote:
> 
> 
> On 22/02/15 12:49, Sascha Hauer wrote:
> > From: James Liao <jamesjj.liao@mediatek.com>
> 
> > diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
> > new file mode 100644
> > index 0000000..c7c0d35
> > --- /dev/null
> > +++ b/drivers/clk/mediatek/clk-mtk.h
> 
> [...]
> 
> > +void __init mtk_clk_register_plls(struct device_node *node,
> > +		const struct mtk_pll_data *plls, int num_plls);
> > +
> > +#ifdef CONFIG_RESET_CONTROLLER
> > +void mtk_register_reset_controller(struct device_node *np,
> > +			unsigned int num_regs, int regofs);
> > +#else
> > +static inline void mtk_register_reset_controller(struct device_node *np,
> > +			unsigned int num_regs, int regofs)
> > +{
> > +}
> > +#endif
> 
> This lines should only be added once in [2/5], compiling ends with:
> 
> In file included from drivers/clk/mediatek/clk-mtk.c:24:0:
> drivers/clk/mediatek/clk-mtk.h:168:20: error: redefinition of ?mtk_register_reset_controller?
> drivers/clk/mediatek/clk-mtk.h:158:20: note: previous definition of ?mtk_register_reset_controller? was here

Hm, seems to be a rebase accident. Fixed, thanks

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
