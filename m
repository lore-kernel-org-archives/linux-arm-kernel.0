From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 9 May 2014 08:11:47 +0100
Subject: [linux-sunxi] Re: [PATCH v2 3/7] mfd: add support for sun6i PRCM
 (Power/Reset/Clock Management) unit
In-Reply-To: <1399611909.13870.0.camel@chi>
References: <1399483554-8824-1-git-send-email-boris.brezillon@free-electrons.com>
 <1399483554-8824-4-git-send-email-boris.brezillon@free-electrons.com>
 <20140508110205.GB5767@lee--X1>
 <536BE366.8080907@free-electrons.com>
 <1399611909.13870.0.camel@chi>
Message-ID: <20140509071147.GD5767@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > >> The PRCM (Power/Reset/Clock Management) block exposes several subdevices
> > >> in different subsystems (clk, reset ...)
> > >>
> > >> Add basic support for the PRCM unit with clk (AR100, AHB0, and APB0 clks)
> > >> and reset controller subdevices.
> > >>
> > >> Other subdevices might be added later (if needed).
> > >>
> > >> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> > >> ---
> > >>  drivers/mfd/Kconfig      |   8 +++
> > >>  drivers/mfd/Makefile     |   1 +
> > >>  drivers/mfd/sun6i-prcm.c | 151 +++++++++++++++++++++++++++++++++++++++++++++++
> > >>  3 files changed, 160 insertions(+)
> > >>  create mode 100644 drivers/mfd/sun6i-prcm.c
> > > [...]
> > >
> > >> +#include <linux/module.h>
> > >> +#include <linux/kernel.h>
> > >> +#include <linux/errno.h>
> > >> +#include <linux/err.h>
> > >> +#include <linux/spinlock.h>
> > >> +#include <linux/io.h>
> > >> +#include <linux/slab.h>
> > >> +#include <linux/mutex.h>
> > >> +#include <linux/completion.h>
> > >> +#include <linux/irq.h>
> > >> +#include <linux/jiffies.h>
> > >> +#include <linux/bitops.h>
> > >> +#include <linux/fs.h>
> > >> +#include <linux/of.h>
> > >> +#include <linux/of_irq.h>
> > >> +#include <linux/platform_device.h>
> > >> +#include <linux/uaccess.h>
> > >> +#include <linux/mfd/core.h>
> > > I'm pretty sure you don't need half of these.  Please only add the
> > > ones you make use of.
> > 
> > Sure (this is what happens when you copy/paste from another driver :-))
> 
> Also, alphabetic order would be nice.

No, please don't do that, it's a waste of time.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
