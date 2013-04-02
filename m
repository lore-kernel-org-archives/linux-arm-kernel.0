From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Tue, 2 Apr 2013 05:49:50 +0000
Subject: [PATCH v7 03/14] spi/spi-atmel: add physical base address
In-Reply-To: <20130401134147.GV18636@opensource.wolfsonmicro.com>
References: <1363678866-3567-1-git-send-email-wenyou.yang@atmel.com>
 <1363679016-3761-1-git-send-email-wenyou.yang@atmel.com>
 <20130401134147.GV18636@opensource.wolfsonmicro.com>
Message-ID: <B256D81BAE5131468A838E5D7A24364150E8B33C@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Mark,

> -----Original Message-----
> From: Mark Brown [mailto:broonie at opensource.wolfsonmicro.com]
> Sent: 2013?4?1? 21:42
> To: Yang, Wenyou
> Cc: linux-arm-kernel at lists.infradead.org; grant.likely at secretlab.ca;
> richard.genoud at gmail.com; plagnioj at jcrosoft.com; Ferre, Nicolas; Lin, JM;
> spi-devel-general at lists.sourceforge.net; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v7 03/14] spi/spi-atmel: add physical base address
> 
> On Tue, Mar 19, 2013 at 03:43:36PM +0800, Wenyou Yang wrote:
> 
> > +++ b/drivers/spi/spi-atmel.c
> > @@ -196,6 +196,7 @@ struct atmel_spi_caps {  struct atmel_spi {
> >  	spinlock_t		lock;
> >
> > +	resource_size_t		phybase;
> >  	void __iomem		*regs;
> >  	int			irq;
> >  	struct clk		*clk;
> 
> This looks like the wrong type?

I double checked.

The type ' resource_size_t ' is defined in include/linux/ types.h as below,

typedef phys_addr_t resource_size_t;

I think it is OK.

Best Regards,
Wenyou Yang
