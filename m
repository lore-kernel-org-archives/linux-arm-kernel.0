From: mporter@ti.com (Matt Porter)
Date: Fri, 11 Jan 2013 13:21:46 -0500
Subject: [PATCH v4,03/14] ARM: edma: add AM33XX support to the private
 EDMA API
In-Reply-To: <9fda86bbbec3444393fd5a2dc5135a5e@DFLE73.ent.ti.com>
References: <1357883330-5364-4-git-send-email-mporter@ti.com>
 <9fda86bbbec3444393fd5a2dc5135a5e@DFLE73.ent.ti.com>
Message-ID: <20130111182146.GZ14660@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 06:14:27PM +0000, Lars Poeschel wrote:
> Hi Matt,
> 
> On Friday 11 January 2013 at 06:48:39, Matt Porter wrote:
> 
> > diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> > index a3d189d..1951d63 100644
> > --- a/arch/arm/common/edma.c
> > +++ b/arch/arm/common/edma.c
> > @@ -24,6 +24,13 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/io.h>
> >  #include <linux/slab.h>
> > +#include <linux/edma.h>
> > +#include <linux/err.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_dma.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/pm_runtime.h>
> 
> You add the include linux/of_dma.h here, but maybe you missed to add the file 
> itself. It is not in Linus v3.8-rc3 tree, not in the patches yours depend on 
> listed and not in your patchset.

of_dma.h comes in with the dependencies listed in the cover letter.
Particularly, Vinod's dt_dmaengine branch in slave-dma.git contains Jon
Hunter's OF DMA helpers series.

-Matt
