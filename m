From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 07 Jan 2014 16:10:37 +0100
Subject: [PATCH 07/15] mmc: sdhi: Enable driver compilation with
 COMPILE_TEST
In-Reply-To: <2090378.13zHUAnprd@avalon>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1385515117-23664-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <2090378.13zHUAnprd@avalon>
Message-ID: <1526599.nZ6xaI3TN3@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Wednesday 11 December 2013 13:53:21 Laurent Pinchart wrote:
> Hi Chris,
> 
> Could you please pick this patch (and patch 08/15 in the same series) up for
> v3.14 ?

Ping ?

> On Wednesday 27 November 2013 02:18:29 Laurent Pinchart wrote:
> > This helps increasing build testing coverage.
> > 
> > The driver doesn't compile on (at least) x86 due (possibly among others)
> > to missing readsw/writesw I/O accessors, restrict compilation to SUPERH
> > or ARM.
> > 
> > Whether the CTL_DMA_ENABLE register is part of the standard TMIO
> > controller or is Renesas-specific is unknown and impossible to test as
> > we have no current or planned TMIO DMA users other than SUPERH and
> > ARCH_SHMOBILE. Writing to the register is thus conditionally compiled
> > for SUPERH and ARCH_SHMOBILE only. Adding ARCH_SHMOBILE_MULTI to the
> > list would extend this to multiarch kernels, but would break the driver
> > for non-shmobile platforms if the register is Renesas-specific. We can
> > thus get rid of the conditional compilation completely without
> > introducing any further issue, and let future non-Renesas users deal
> > with the situation if it turns out to be a the problem.
> > 
> > Cc: Chris Ball <cjb@laptop.org>
> > Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > Cc: Ian Molton <ian@mnementh.co.uk>
> > Cc: linux-mmc at vger.kernel.org
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > Acked-by: Simon Horman <horms@verge.net.au>
> > ---
> > 
> >  drivers/mmc/host/Kconfig | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 7fc5099..ca1315e 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -479,7 +479,8 @@ config MMC_TMIO
> > 
> >  config MMC_SDHI
> >  
> >  	tristate "SH-Mobile SDHI SD/SDIO controller support"
> > 
> > -	depends on SUPERH || ARCH_SHMOBILE
> > +	depends on SUPERH || ARM
> > +	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
> > 
> >  	select MMC_TMIO_CORE
> >  	help
> >  	
> >  	  This provides support for the SDHI SD/SDIO controller found in
-- 
Regards,

Laurent Pinchart
