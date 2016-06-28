From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Tue, 28 Jun 2016 07:24:38 +0000
Subject: [PATCH 2/4] dmaengine: vdma: Add support for mulit-channel dma
 mode
In-Reply-To: <C246CAC1457055469EF09E3A7AC4E11A4A5B9B9E@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1465549954-30220-1-git-send-email-appanad@xilinx.com>
 <1465549954-30220-3-git-send-email-appanad@xilinx.com>
 <20160621155502.GB16910@localhost>
 <C246CAC1457055469EF09E3A7AC4E11A4A5B8248@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160621163340.GE16910@localhost>
 <C246CAC1457055469EF09E3A7AC4E11A4A5B84A9@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160628043459.GR22564@localhost>
 <C246CAC1457055469EF09E3A7AC4E11A4A5B9B9E@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A5B9BD5@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

	
 
> > > > > > >  /**
> > > > > > > + * struct xilinx_mcdma_config - DMA Multi channel
> > > > > > > +configuration structure
> > > > > > > + * @tdest: Channel to operate on
> > > > > > > + * @tid:   Channel configuration
> > > > > > > + * @tuser: Tuser configuration
> > > > > > > + * @ax_user: ax_user value
> > > > > > > + * @ax_cache: ax_cache value  */ struct xilinx_mcdma_config
> > > > > > > +{
> > > > > > > +	u8 tdest;
> > > > > > > +	u8 tid;
> > > > > > > +	u8 tuser;
> > > > > > > +	u8 ax_user;
> > > > > > > +	u8 ax_cache;
> > > > > >
> > > > > > can you describe these in details, what do these do, what are
> > > > > > the values to be programmed?
> > > > >
> > > > > As said above In Multi-Channel Mode each Stream interface can be
> > > > > Configured up to 16 channels each channel is differentiated
> > > > > based on the tdest
> > > > and tid values.
> > > >
> > > > Then why are you not registering 16 channels for this? That should
> > > > give you channel to operate on!
> > >
> > > The number of channels are configurable.
> > > We are registering number of Channels that h/w configured for.
> > >
> > > Will fix in the next version. Will remove this config.
> > > And based on the channel type will configure the h/w.
> >
> > Looking at this you should redesign!
> >
> > The vchan was designed to operate on 'virtual' channels. The hardware
> > channels can be independent of that.
> >
> > Your IP seems to be a good fit for that approach. Do not link the two
> > and separate them. User can have a virtual channel. In your driver,
> > you can manage hardware channels...
> 
> Fixed it in the v2 and posted the v2 series.
> Please go thought it...

Sorry forgot to write explanation.
Without the need of virtual channels fixed it in the driver itself.
During probe based on the number of channels configuring the h/w
Accordingly user no need to aware of this configuration. User can request DMA
Channel in normal way the using dma_request_slave_channel or dma_request_channel
 Posted v2 series please go through it.

Regards,
Kedar.
