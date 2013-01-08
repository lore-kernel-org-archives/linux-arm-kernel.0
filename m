From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Tue, 8 Jan 2013 01:02:38 +0000
Subject: [v3 PATCH 06/12] spi/atmel_spi: add dmaengine support
In-Reply-To: <1357524615.4940.19.camel@joe-AO722>
References: <1357523413-27209-1-git-send-email-wenyou.yang@atmel.com>
 <1357523413-27209-7-git-send-email-wenyou.yang@atmel.com>
 <1357524615.4940.19.camel@joe-AO722>
Message-ID: <B256D81BAE5131468A838E5D7A2436413A057056@penmbx02>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Joe Perches [mailto:joe at perches.com]
> Sent: 2013?1?7? 10:10
> To: Yang, Wenyou
> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Ferre,
> Nicolas; plagnioj at jcrosoft.com; richard.genoud at gmail.com; Lin, JM;
> grant.likely at secretlab.ca; spi-devel-general at lists.sourceforge.net
> Subject: Re: [v3 PATCH 06/12] spi/atmel_spi: add dmaengine support
> 
> On Mon, 2013-01-07 at 09:50 +0800, Wenyou Yang wrote:
> > From: Nicolas Ferre <nicolas.ferre@atmel.com>
> []
> > diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> []
> > +static inline bool atmel_spi_use_dma(struct atmel_spi *as,
> > +				struct spi_transfer *xfer)
> > +{
> > +	if ((as->use_dma) && (xfer->len >= DMA_MIN_BYTES))
> > +		return true;
> > +	else
> > +		return false;
> > +}
> 
> Same unnecessary form.
> 
> 	return as->use_dma && xfer->len >= DMA_MIN_BYTES;
> 
> > +static inline bool atmel_spi_use_pdc(struct atmel_spi *as)
> > +{
> > +	if (as->use_pdc)
> > +		return true;
> > +	else
> > +		return false;
> > +}
> 
> Does this function really need to exist at all?
> 
Thanks a lot for your advice.
