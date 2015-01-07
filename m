From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Jan 2015 18:57:05 +0000
Subject: [PATCH v6 6/8] dma-mapping: detect and configure IOMMU in
 of_dma_configure
In-Reply-To: <7693528.krAZff0s6I@wuerfel>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
 <2983977.dWWQcFZRoJ@wuerfel> <20141221100451.GA23242@arm.com>
 <7693528.krAZff0s6I@wuerfel>
Message-ID: <20150107185704.GV7485@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Sorry for the delay on this, I had to do a bit of digging.

On Mon, Dec 22, 2014 at 01:36:01PM +0000, Arnd Bergmann wrote:
> Do you think it's possible that we might have to deal with a single PCI host
> that is connected two different SMMU instances for the purposes of extending
> the StreamID space from 15 to 16 bits? I think we would have trouble
> expressing this with the current syntax.

Unfortunately, this sounds like something we may well have to support.
Whilst the SMMUv2 architecture did grow a late extension to support 16-bit
StreamIDs, that may have been too late for all silicon vendors and, as such,
I'm not confident that such systems will present a single software interface
for their SMMU.

Will
