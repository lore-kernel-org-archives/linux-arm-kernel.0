From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Tue, 2 Apr 2013 06:17:06 +0000
Subject: [PATCH v7 03/14] spi/spi-atmel: add physical base address
References: <1363678866-3567-1-git-send-email-wenyou.yang@atmel.com>
 <1363679016-3761-1-git-send-email-wenyou.yang@atmel.com>
 <20130401134147.GV18636@opensource.wolfsonmicro.com>
Message-ID: <B256D81BAE5131468A838E5D7A24364150E8B3B7@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Mark,

> -----Original Message-----
> From: Yang, Wenyou
> Sent: 2013?4?2? 13:50
> To: 'Mark Brown'
> Cc: linux-arm-kernel at lists.infradead.org; grant.likely at secretlab.ca;
> richard.genoud at gmail.com; plagnioj at jcrosoft.com; Ferre, Nicolas; Lin, JM;
> spi-devel-general at lists.sourceforge.net; linux-kernel at vger.kernel.org
> Subject: RE: [PATCH v7 03/14] spi/spi-atmel: add physical base address
> 
> Hi, Mark,
> 
> > -----Original Message-----
> > From: Mark Brown [mailto:broonie at opensource.wolfsonmicro.com]
> > Sent: 2013?4?1? 21:42
> > To: Yang, Wenyou
> > Cc: linux-arm-kernel at lists.infradead.org; grant.likely at secretlab.ca;
> > richard.genoud at gmail.com; plagnioj at jcrosoft.com; Ferre, Nicolas; Lin, JM;
> > spi-devel-general at lists.sourceforge.net; linux-kernel at vger.kernel.org
> > Subject: Re: [PATCH v7 03/14] spi/spi-atmel: add physical base address
> >
> > On Tue, Mar 19, 2013 at 03:43:36PM +0800, Wenyou Yang wrote:
> >
> > > +++ b/drivers/spi/spi-atmel.c
> > > @@ -196,6 +196,7 @@ struct atmel_spi_caps {  struct atmel_spi {
> > >  	spinlock_t		lock;
> > >
> > > +	resource_size_t		phybase;
> > >  	void __iomem		*regs;
> > >  	int			irq;
> > >  	struct clk		*clk;
> >
> > This looks like the wrong type?
> 
I got it, you are right, you mean It should be used " phys_addr_t " type.

	phys_addr_t	phybase;

Thanks.

Best Regards,
Wenyou Yang.

> I double checked.
> 
> The type ' resource_size_t ' is defined in include/linux/ types.h as below,
> 
> typedef phys_addr_t resource_size_t;
> 
> I think it is OK.
> 
> Best Regards,
> Wenyou Yang
