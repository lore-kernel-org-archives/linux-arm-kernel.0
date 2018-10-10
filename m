From: abel.vesa@nxp.com (Abel Vesa)
Date: Wed, 10 Oct 2018 07:50:41 +0000
Subject: [PATCH v10 4/5] clk: imx: add imx composite clock
In-Reply-To: <20181010053744.5pxrlcdxmmyisu62@pengutronix.de>
References: <1539074230-27277-1-git-send-email-abel.vesa@nxp.com>
 <1539074230-27277-5-git-send-email-abel.vesa@nxp.com>
 <5c0cc4de8403fca17431a9382f7e34e8003f497b.camel@nxp.com>
 <20181010053744.5pxrlcdxmmyisu62@pengutronix.de>
Message-ID: <20181010075040.lcpdsw433vfet3ok@fsr-ub1664-175>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2018 at 07:37:44AM +0200, Sascha Hauer wrote:
> On Tue, Oct 09, 2018 at 10:56:14PM +0000, Leonard Crestez wrote:
> > On Tue, 2018-10-09 at 08:37 +0000, Abel Vesa wrote:
> > > +struct clk *imx_clk_composite_8m_flags(const char *name,
> > > +					const char **parent_names,
> > > +					int num_parents, void __iomem *reg,
> > > +					unsigned long flags);
> > > +
> > > +#define __imx_clk_composite_8m(name, parent_names, reg, flags) \
> > > +	imx_clk_composite_8m_flags(name, parent_names, \
> > > +		ARRAY_SIZE(parent_names), reg, \
> > > +		flags | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
> > > +
> > > +#define imx_clk_composite_8m(name, parent_names, reg) \
> > > +	__imx_clk_composite_8m(name, parent_names, reg, 0)
> > > +
> > > +#define imx_clk_composite_8m_critical(name, parent_names, reg) \
> > > +	__imx_clk_composite_8m(name, parent_names, reg, CLK_IS_CRITICAL)
> > 
> > Does anyone else think that the "8m" would be prettier next to imx
> > rather than as a suffix? Using imx8m_clk_composite* and
> > imx7ulp_clk_composite* makes more sense to me.
> 
> +1
> 
> Sascha

Just sent another version.

Abel

> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.pengutronix.de%2F&amp;data=02%7C01%7Cabel.vesa%40nxp.com%7C4eaf85c4f4504cc112d908d62e72870e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636747466762782779&amp;sdata=muaryKQFzFYCKzVw4XNxzp0m1Y1wZmAsfwNBodJfTKY%3D&amp;reserved=0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

-- 
