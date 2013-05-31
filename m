From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 May 2013 18:02:31 +0200
Subject: [PATCH 1/2] ARM: shmobile: sdhi: pass DMA filter from platform
 code
In-Reply-To: <alpine.DEB.2.00.1305311721160.7395@axis700.grange>
References: <1370008605-3745603-1-git-send-email-arnd@arndb.de>
 <2862988.jnTv0iSQcj@wuerfel>
 <alpine.DEB.2.00.1305311721160.7395@axis700.grange>
Message-ID: <3675801.kLfsmmiSOq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 31 May 2013 17:30:01 Guennadi Liakhovetski wrote:
> On Fri, 31 May 2013, Arnd Bergmann wrote:
> > On Friday 31 May 2013 16:52:13 Guennadi Liakhovetski wrote:

> > I think it's more a matter of using the API correctly. The dmaengine
> > API is an abstraction to separate the slave driver from the master
> > through well-defined calls. If you make additional assumptions
> > in the slave driver about the master, that is a layering violation.
> 
> I think it is a common practice, see e.g.
> 
> drivers/mmc/host/omap_hsmmc.c
> drivers/mmc/host/davinci_mmc.c

Yes, those should be fixed as well.

> And what do you do for DT-based platforms?

Once the driver is DT-enabled, we no longer have to pass
a filter function at all because the slave id and all settings
will get pulled out of the DT using the dma engine's xlate()
callback.

	Arnd
