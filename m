From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Jan 2015 20:29:15 +0100
Subject: [PATCH v6 6/8] dma-mapping: detect and configure IOMMU in
 of_dma_configure
In-Reply-To: <20150107185704.GV7485@arm.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
 <7693528.krAZff0s6I@wuerfel> <20150107185704.GV7485@arm.com>
Message-ID: <2577020.XPDvrs2bDx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 January 2015 18:57:05 Will Deacon wrote:
> 
> Sorry for the delay on this, I had to do a bit of digging.
> 
> On Mon, Dec 22, 2014 at 01:36:01PM +0000, Arnd Bergmann wrote:
> > Do you think it's possible that we might have to deal with a single PCI host
> > that is connected two different SMMU instances for the purposes of extending
> > the StreamID space from 15 to 16 bits? I think we would have trouble
> > expressing this with the current syntax.
> 
> Unfortunately, this sounds like something we may well have to support.
> Whilst the SMMUv2 architecture did grow a late extension to support 16-bit
> StreamIDs, that may have been too late for all silicon vendors and, as such,
> I'm not confident that such systems will present a single software interface
> for their SMMU.

So it's technically possible to connect two SMMU instances to a single
PCIe root complex? I knew that there is at least one vendor (AMD) that
can only do 128 bus numbers on PCIe, which seems a much simpler workaround.

	Arnd
