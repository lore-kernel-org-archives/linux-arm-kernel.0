From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 31 May 2013 17:30:01 +0200 (CEST)
Subject: [PATCH 1/2] ARM: shmobile: sdhi: pass DMA filter from platform
 code
In-Reply-To: <2862988.jnTv0iSQcj@wuerfel>
References: <1370008605-3745603-1-git-send-email-arnd@arndb.de>
 <alpine.DEB.2.00.1305311611460.7395@axis700.grange>
 <2862988.jnTv0iSQcj@wuerfel>
Message-ID: <alpine.DEB.2.00.1305311721160.7395@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 31 May 2013, Arnd Bergmann wrote:

> On Friday 31 May 2013 16:52:13 Guennadi Liakhovetski wrote:
> > 
> > Thanks for the patches. How about this fix:
> > 
> > http://thread.gmane.org/gmane.linux.kernel.mmc/20619
> > 
> > I think it's a better fix. SHDMA users cannot use other DMA drivers, so, I 
> > don't think we need to pass the filter via the platform data.
> 
> I think it's more a matter of using the API correctly. The dmaengine
> API is an abstraction to separate the slave driver from the master
> through well-defined calls. If you make additional assumptions
> in the slave driver about the master, that is a layering violation.

I think it is a common practice, see e.g.

drivers/mmc/host/omap_hsmmc.c
drivers/mmc/host/davinci_mmc.c

And what do you do for DT-based platforms?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
