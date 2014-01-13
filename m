From: tony@atomide.com (Tony Lindgren)
Date: Mon, 13 Jan 2014 13:02:42 -0800
Subject: [PATCH RFC 00/26] Migrate more OMAP DMA code to DMA engine
In-Reply-To: <20140113203404.GF27282@n2100.arm.linux.org.uk>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk>
 <20140108012110.GL5074@atomide.com>
 <20140109152437.GB27282@n2100.arm.linux.org.uk>
 <20140113141811.GD27282@n2100.arm.linux.org.uk>
 <20140113173744.GA7746@atomide.com>
 <20140113185503.GE27282@n2100.arm.linux.org.uk>
 <20140113192630.GB7746@atomide.com>
 <20140113203404.GF27282@n2100.arm.linux.org.uk>
Message-ID: <20140113210242.GA7993@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [140113 12:36]:
> On Mon, Jan 13, 2014 at 11:26:31AM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [140113 10:57]:
> > > On Mon, Jan 13, 2014 at 09:37:45AM -0800, Tony Lindgren wrote:
> > > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [140113 08:48]:
> > > > > Any news on this?
> > > > 
> > > > Sorry for the delay, now getting this:
> > > > 
> > > > arch/arm/mach-omap1/dma.c: In function ?omap1_system_dma_init?:
> > > > arch/arm/mach-omap1/dma.c:368: error: ?struct omap_dma_dev_attr? has no member named ?chan?
> > > 
> > > Gah.  Next incremental patch:
> > 
> > Thanks, now getting this on omap1:
> > 
> > # dmesg | grep -i dma
> > DMA: preallocated 256 KiB pool for atomic coherent allocations
> > OMAP DMA hardware version 1
> > DMA capabilities: 0000000c:00000000:01ff:003f:007f
> > omap-dma-engine omap-dma-engine: invalid resource
> > omap-dma-engine: probe of omap-dma-engine failed with error -22
> > mmci-omap mmci-omap.1: unable to obtain TX DMA engine channel 54
> > mmci-omap mmci-omap.1: unable to obtain RX DMA engine channel 55
> 
> Sigh... let's give it the iomem resource then:

OK, looks like adding that makes MMC card detection to fail with:

DMA timeout with device 55

Regards,

Tony
