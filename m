From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 12 Apr 2012 10:44:18 +0800
Subject: [PATCH 25/40] ARM: imx: add common clock support for clk busy
In-Reply-To: <20120412015013.GA27730@b20223-02.ap.freescale.net>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
 <1334065553-7565-26-git-send-email-s.hauer@pengutronix.de>
 <20120412015013.GA27730@b20223-02.ap.freescale.net>
Message-ID: <20120412024415.GE2445@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2012 at 09:50:14AM +0800, Richard Zhao wrote:
...
> > +struct clk_busy_divider {
> > +	struct clk_hw hw;
> > +	void __iomem *reg;
> > +	u8 shift;
> > +	struct clk_divider div;
> > +	const struct clk_ops *div_ops;
> > +};
> It's not like a good way to inherit from struct clk_divider.

Any good way to suggest?

> Since we
> already have struct clk_hw in struct clk_divider, why do you still 
> duplicate hw here?
>  
I can use the clk_hw in clk_divider, but it will make the translation
from clk_hw to clk_busy_divider a bit more complicated.  And in any
case, clk_busy_divider is a particular type of clk, so it should not
be surprising to have a its own clk_hw like any other clks.

-- 
Regards,
Shawn
