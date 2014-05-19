From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 19 May 2014 14:32:53 +0100
Subject: [PATCH v3 3/7] mfd: add support for sun6i PRCM
 (Power/Reset/Clock Management) unit
In-Reply-To: <20140519092725.GE29466@lukather>
References: <1399633911-7094-1-git-send-email-boris.brezillon@free-electrons.com>
 <1399633911-7094-4-git-send-email-boris.brezillon@free-electrons.com>
 <20140509135251.GY5767@lee--X1> <20140515151756.GX29258@lukather>
 <20140519092159.GE4978@lee--X1> <20140519092725.GE29466@lukather>
Message-ID: <20140519133253.GJ4978@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > > > > The PRCM (Power/Reset/Clock Management) block exposes several subdevices
> > > > > in different subsystems (clk, reset ...)
> > > > > 
> > > > > Add basic support for the PRCM unit with clk (AR100, AHB0, and APB0 clks)
> > > > > and reset controller subdevices.
> > > > > 
> > > > > Other subdevices might be added later (if needed).
> > > > > 
> > > > > Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> > > > > Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > > > > ---
> > > > >  drivers/mfd/Kconfig      |   8 +++
> > > > >  drivers/mfd/Makefile     |   1 +
> > > > >  drivers/mfd/sun6i-prcm.c | 134 +++++++++++++++++++++++++++++++++++++++++++++++
> > > > >  3 files changed, 143 insertions(+)
> > > > >  create mode 100644 drivers/mfd/sun6i-prcm.c
> > > > 
> > > > [...]
> > > > 
> > > > > +/*
> > > > > + * Copyright (C) 2014 Free Electrons
> > > > > + *
> > > > > + * License Terms: GNU General Public License v2
> > > > > + * Author: Boris BREZILLON <boris.brezillon@free-electrons.com>
> > > > > + *
> > > > > + * Allwinner PRCM (Power/Reset/Clock Management) driver
> > > > > + *
> > > > > + */
> > > > > +
> > > > > +#include <linux/mfd/core.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/of.h>
> > > > 
> > > > Ah, now isn't that better?
> > > > 
> > > > Acked-by: Lee Jones <lee.jones@linaro.org>
> > > 
> > > How do you want to merge this? Do you want me to take it through
> > > mach-sunxi tree, or do you want to take it in your tree?
> > 
> > If Boris can tell me what needs to go in with this patch (or if it
> > can go in on its own), I will create a(n immutable) branch from which
> > you can pull into your tree.
> 
> We don't have any runtime or compile time dependency on this, so you
> can merge it through your tree. Unless something change, I don't have
> to pull anything in my tree.

When you say 'this', do you mean this patch, or this set?  If I can
just apply this patch, that will be ideal?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
