From: joelagnel@ti.com (Fernandes, Joel A)
Date: Mon, 24 Jun 2013 21:09:58 +0000
Subject: [PATCH v12 05/11] edma: config: Enable config options for EDMA
In-Reply-To: <201306242307.35840.arnd@arndb.de>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
 <201306242228.23297.arnd@arndb.de>
 <CAD=GYpYwswOYGHRzZ6SeKD+sEfi-7s3HuqKr7G0OXQWFCA_EtQ@mail.gmail.com>
 <201306242307.35840.arnd@arndb.de>
Message-ID: <083BC63EECB6FD41B8E81CF7FD87CC0F2E4EE5A1@DLEE08.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Monday, June 24, 2013 4:08 PM
> To: Joel A Fernandes
> Cc: Nori, Sekhar; Fernandes, Joel A; Tony Lindgren; Matt Porter; Grant Likely;
> Rob Herring; Vinod Koul; Mark Brown; Cousson, Benoit; Russell King; Rob
> Landley; Andrew Morton; Jason Kridner; Koen Kooi; Devicetree Discuss; Linux
> OMAP List; Linux ARM Kernel List; Linux DaVinci Kernel List; Linux Kernel
> Mailing List; Linux Documentation List; Linux MMC List; Linux SPI Devel List
> Subject: Re: [PATCH v12 05/11] edma: config: Enable config options for EDMA
> 
> On Monday 24 June 2013, Joel A Fernandes wrote:
> > >> Yes sure, right now they are defined  as follows in include/linux/edma.h:
> > >>
> > >> #if defined(CONFIG_TI_EDMA) || defined(CONFIG_TI_EDMA_MODULE)
> bool
> > >> edma_filter_fn(struct dma_chan *, void *); #else static inline bool
> > >> edma_filter_fn(struct dma_chan *chan, void *param) { return false;
> > >> } #endif
> > >
> > > It's best to just define the filter function in the platform code
> > > and pass a pointer to it through platform data. The way you do it
> > > above makes the slave drivers inherently nonportable.
> >
> > But with DT-only platforms, can you really do that?
> 
> The nice thing about this is that with a DT-only platform, the filter function will
> automatically go away: you have no platform_data, which means that if you
> are using dma_request_slave_channel_compat, you just pass NULL as the filter
> and the filter-data, same as just calling dma_request_slave_channel.
> 
 
[Joel] Ah yes! Thanks for that. Right, edma_filter_fn is not passed explicitly for DT case.

Thanks,
Joel
