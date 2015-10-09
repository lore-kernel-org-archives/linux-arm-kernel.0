From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 9 Oct 2015 11:16:13 -0700
Subject: [PATCH 3/3] fpga manager: Adding FPGA Manager support for Xilinx
 Zynq 7000
In-Reply-To: <alpine.DEB.2.10.1510091903240.2257@atull-730U3E-740U3E>
References: <1444344307-22509-1-git-send-email-moritz.fischer@ettus.com>
 <1444344307-22509-4-git-send-email-moritz.fischer@ettus.com>
 <alpine.DEB.2.10.1510091903240.2257@atull-730U3E-740U3E>
Message-ID: <20151009181613.GA12738@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 07:09:15PM +0100, atull wrote:
> On Thu, 8 Oct 2015, Moritz Fischer wrote:
> 
> > --- /dev/null
> > +++ b/drivers/fpga/zynq-fpga.c
> > @@ -0,0 +1,478 @@
> > +/*
> > + * Copyright (c) 2011-2015 Xilinx Inc.
> > + * Copyright (c) 2015, National Instruments Corp.
> > + *
> > + * FPGA Manager Driver for Xilinx Zynq, heavily based on xdevcfg driver
> > + * in their vendor tree.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; version 2 of the License.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/completion.h>
> > +#include <linux/delay.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/fpga/fpga-mgr.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/module.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/pm.h>
> > +#include <linux/regmap.h>
> > +#include <linux/string.h>
> 
> Hi Moritz,
> 
> That was fast!  I just have a couple of very minor comments...
> 
> Please alphabetize the #includes.

Bah, who cares about that, it's not a requirement at all.

greg k-h
