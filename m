From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 12 Aug 2013 01:03:19 +0200
Subject: [PATCH 17/18] spi: s3c64xx: Always select S3C64XX_PL080 when
 ARCH_S3C64XX is enabled
In-Reply-To: <20130811191140.GI6427@sirena.org.uk>
References: <1376243970-6489-1-git-send-email-tomasz.figa@gmail.com>
 <1376243970-6489-18-git-send-email-tomasz.figa@gmail.com>
 <20130811191140.GI6427@sirena.org.uk>
Message-ID: <2033369.1oHkX7kdGa@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Sunday 11 of August 2013 20:11:40 Mark Brown wrote:
> On Sun, Aug 11, 2013 at 07:59:29PM +0200, Tomasz Figa wrote:
> > @@ -366,7 +366,7 @@ config SPI_S3C24XX_FIQ
> > 
> >  config SPI_S3C64XX
> >  
> >  	tristate "Samsung S3C64XX series type SPI"
> >  	depends on (ARCH_S3C24XX || ARCH_S3C64XX || ARCH_S5P64X0 ||
> >  	ARCH_EXYNOS)> 
> > -	select S3C64XX_DMA if ARCH_S3C64XX && !S3C64XX_PL080
> > +	select S3C64XX_PL080 if ARCH_S3C64XX
> > 
> >  	help
> >  	
> >  	  SPI driver for Samsung S3C64XX and newer SoCs.
> 
> Do we need the select here (or should we have other selects for the
> Exynos SoCs)?

The driver would build fine without this symbol selected, but since it 
relies on availability of DMA, it doesn't make too much sense to build it 
this way. This kind of selects makes kernel configuration more user 
friendly IMHO.

Possibly adding appropriate selects (PL330) for s5p* and exynos could make 
sense.

Best regards,
Tomasz
