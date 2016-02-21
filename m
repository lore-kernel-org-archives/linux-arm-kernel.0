From: yong.wu@mediatek.com (Yong Wu)
Date: Mon, 22 Feb 2016 02:43:09 +0800
Subject: [v9,4/5] iommu/mediatek: Add mt8173 IOMMU driver
In-Reply-To: <20160220070209.GA16577@roeck-us.net>
References: <1455669974-1527-5-git-send-email-yong.wu@mediatek.com>
 <20160220070209.GA16577@roeck-us.net>
Message-ID: <1456080189.25237.4.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-02-19 at 23:02 -0800, Guenter Roeck wrote:
> On Wed, Feb 17, 2016 at 08:46:13AM +0800, Yong Wu wrote:
> > This patch adds support for mediatek m4u (MultiMedia Memory Management
> > Unit).
[...]
> > +#include <linux/clk.h>
> > +#include <linux/component.h>
> > +#include <linux/dma-iommu.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/iommu.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/list.h>
> > +#include <linux/module.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_iommu.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <soc/mediatek/smi.h>
> > +#include <dt-bindings/memory/mt8173-larb-port.h>
> > +
> 
> Some missing includes:
> 
> linux/bug.h
> 	for WARN_ON()
> linux/device.h
> 	for dev_xxx() error messages, dev_get_drvdata(), etc.
> linux/err.h
> 	for error functions (IS_ERR, error definitions)
> linux/slab.h
> 	for kzalloc() etc.
> linux/spinlock.h
> 	for spinlock functions
> asm/barrier.h
> 	for wmb()
> 
> Guenter

Hi Guenter,
    Thanks for this suggestion. I'm sorry that I didn't get any build
warning or error here. Anyway I will add them and send a quick v10.
