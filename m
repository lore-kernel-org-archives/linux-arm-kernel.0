From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 13 Apr 2012 17:11:34 +0200 (CEST)
Subject: [PATCH] ARM: i.mx35 increase dma consistent region size
In-Reply-To: <20120413144029.GP3852@pengutronix.de>
References: <1334167274-29524-1-git-send-email-alexg@meprolight.com>
 <20120413144029.GP3852@pengutronix.de>
Message-ID: <Pine.LNX.4.64.1204131710260.21260@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Apr 2012, Sascha Hauer wrote:

> On Wed, Apr 11, 2012 at 09:01:14PM +0300, Alex Gershgorin wrote:
> > The default size of the consistent DMA region is 2MB
> > without this patch, attempt to allocate more than 2MB
> > is causing allocation failure
> > 
> > Signed-off-by: Alex Gershgorin <alexg@meprolight.com>
> > ---
> >  arch/arm/mach-imx/mm-imx3.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
> > index 7412738..a2c0c7d 100644
> > --- a/arch/arm/mach-imx/mm-imx3.c
> > +++ b/arch/arm/mach-imx/mm-imx3.c
> > @@ -201,6 +201,7 @@ static struct map_desc mx35_io_desc[] __initdata = {
> >  void __init mx35_map_io(void)
> >  {
> >  	iotable_init(mx35_io_desc, ARRAY_SIZE(mx35_io_desc));
> > +	init_consistent_dma_size(SZ_8M);
> 
> I don't know what to think about this. You probably have a board with
> camera support and thus need bigger buffers, right? Nevertheless this
> patch affects all i.MX35 users, even the ones without camera support.
> 
> Another possibility would be to make this board specific.

Isn't this what other (including i.MX3*) boards use arm_memblock_steal() 
for?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
