From: ping.bai@nxp.com (Jacky Bai)
Date: Sat, 24 Feb 2018 06:19:59 +0000
Subject: [PATCH v3 4/4] driver: clk: imx: add clock driver for imx6sll
In-Reply-To: <20180224034552.GY3217@dragon>
References: <1517968819-12869-1-git-send-email-ping.bai@nxp.com>
 <1517968819-12869-4-git-send-email-ping.bai@nxp.com>
 <20180224034552.GY3217@dragon>
Message-ID: <HE1PR04MB311302D386C13F246A820BE187C30@HE1PR04MB3113.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > a/drivers/clk/imx/clk-imx6sll.c b/drivers/clk/imx/clk-imx6sll.c new
> > file mode 100644 index 0000000..e902b27
> > --- /dev/null
> > +++ b/drivers/clk/imx/clk-imx6sll.c
> > @@ -0,0 +1,351 @@
> > +/*
> > + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> > + * Copyright 2017-2018 NXP.
> > + *
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> 
> SPDX tag instead?

Thanks, will fix it.

> 
> > + */
> > +
> > +#include <dt-bindings/clock/imx6sll-clock.h>
> > +#include <linux/clk.h>
> > +#include <linux/clkdev.h>
> > +#include <linux/err.h>
> > +#include <linux/init.h>
> > +#include <linux/io.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/types.h>
> > +
> > +#include "clk.h"
> > +
> > +#define CCM_ANALOG_PLL_BYPASS		(0x1 << 16)
> > +#define BM_CCM_CCDR_MMDC_CH0_MASK	(0x2 << 16)
> > +#define CCDR	0x4
> 
> There is no much point to use define for this particular offset.  Or if you think
> it's really useful, please make the indent unified with other defines.
> 

OK, will remove the define in V4.


> > +	clks[IMX6SLL_CLK_PLL2_PFD0] = imx_clk_pfd("pll2_pfd0_352m",
> "pll2_bus",	   base + 0x100, 0);
> > +	clks[IMX6SLL_CLK_PLL2_PFD1] = imx_clk_pfd("pll2_pfd1_594m",
> "pll2_bus",	   base + 0x100, 1);
> > +	clks[IMX6SLL_CLK_PLL2_PFD2] = imx_clk_pfd("pll2_pfd2_396m",
> "pll2_bus",	   base + 0x100, 2);
> > +	clks[IMX6SLL_CLK_PLL2_PFD3] = imx_clk_pfd("pll2_pfd3_594m",
> "pll2_bus",	   base + 0x100, 3);
> > +	clks[IMX6SLL_CLK_PLL3_PFD0] = imx_clk_pfd("pll3_pfd0_720m",
> "pll3_usb_otg", base + 0xf0,  0);
> > +	clks[IMX6SLL_CLK_PLL3_PFD1] = imx_clk_pfd("pll3_pfd1_540m",
> "pll3_usb_otg", base + 0xf0,  1);
> > +	clks[IMX6SLL_CLK_PLL3_PFD2] = imx_clk_pfd("pll3_pfd2_508m",
> "pll3_usb_otg", base + 0xf0,	 2);
> > +	clks[IMX6SLL_CLK_PLL3_PFD3] = imx_clk_pfd("pll3_pfd3_454m",
> "pll3_usb_otg", base + 0xf0,	 3);
> 
> The indent of the last number of last two line are unnecessarily broken.
> 

Thanks, I will go through this file to make the indent better.

BR
Jacky Bai
