From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Apr 2011 15:25:41 +0200
Subject: [PATCH] OMAP: iommu flush page table entries from L1 and L2 cache
In-Reply-To: <20110418.144246.77604458849535045.Hiroshi.DOYU@nokia.com>
References: <20110414223036.GA7335@n2100.arm.linux.org.uk>
	<20110418110502.GI12272@atomide.com>
	<20110418.144246.77604458849535045.Hiroshi.DOYU@nokia.com>
Message-ID: <201104181525.43481.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 April 2011, Hiroshi DOYU wrote:
> From: ext Tony Lindgren <tony@atomide.com>

> > have a generic replacement for this code we should start using it.
> 
> I'm afraid that there's no general IOMMU APIs yet, or already? If
> there is, migrating to those general IOMMU API is the way, but still
> SoC dependent parts remain, anyway. I guess that more or less general
> IOMMU API is composed of common set of client APIs(like IOVMM) and the
> registration of H/W dependent functions(like omap iommu), I guess.

As I explained, we have a surplus of generic iommu APIs
already, see include/linux/dma-mapping.h and include/linux/iommu.h
 
The dma-mapping interface handles IOMMUs on all other architectures
that have them.

	Arnd
