From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Mar 2013 10:43:51 +0000
Subject: [PATCH v6 3/5] mmc: davinci_mmc: add DT support
In-Reply-To: <A73F36158E33644199EB82C5EC81C7BC3EA4A96A@DBDE01.ent.ti.com>
References: <1363779852-24083-1-git-send-email-prakash.pm@ti.com>
 <201303201326.09265.arnd@arndb.de>
 <A73F36158E33644199EB82C5EC81C7BC3EA4A96A@DBDE01.ent.ti.com>
Message-ID: <201303271043.51265.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 March 2013, Manjunathappa, Prakash wrote:
> On Wed, Mar 20, 2013 at 18:56:09, Arnd Bergmann wrote:
> > On Wednesday 20 March 2013, Manjunathappa, Prakash wrote:
> > > Adds device tree support for davinci_mmc. Also add binding documentation.
> > > As of now in non-dma PIO mode and without GPIO card_detect/write_protect
> > > option because of dependencies on EDMA and GPIO module DT support.
> > 
> > Shouldn't the binding at least specify the names for the DMA channels?
> > It's fine if the driver works without those, but I think there is no
> > strict dependency here: If dma_request_slave_channel does not find
> > a channel, the driver can just continue in PIO mode, and as soon
> > as the EDMA driver is merged, it will work with DMA.
> 
> In that case, don't I have to add support for it in driver also using
> dma_request_slave_channel_compat? As we do not have edma support yet on
> da850, I will not be able to test it.

The code is independent of the binding in this case. If you already know
that the hardware supports DMA channels and you will add support in the
code later, I would recommend writing up the binding the way it should
be used.

	Arnd
