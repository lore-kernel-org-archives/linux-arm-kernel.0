From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 May 2014 11:32:23 +0200
Subject: [PATCH] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <20140521090244.GB19268@ulmo>
References: <1400242998-437-1-git-send-email-thierry.reding@gmail.com>
 <4506822.XX7GrvtHhk@wuerfel> <20140521090244.GB19268@ulmo>
Message-ID: <11242680.PQytQQqlPJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 May 2014 11:02:45 Thierry Reding wrote:
> On Wed, May 21, 2014 at 10:54:42AM +0200, Arnd Bergmann wrote:
>
> > Right. As long as we always unmap the buffers from the IOMMU after they
> > have stopped being in use, it's very unlikely that even a broken device
> > driver causes a DMA into some bus address that happens to be mapped for
> > another device.
> 
> I think that if buffers remain mapped in the IOMMU when they have been
> deallocated that should be considered a bug.

You could see it as a performance optimization in some cases, e.g. when you
cannot flush individual IOTLBs or doing so is expensive, and you just keep
assigning new addresses until every one has been used, then you do a global
IOTLB flush once. Obviously you have to maintain the IO page tables correctly.

	Arnd
