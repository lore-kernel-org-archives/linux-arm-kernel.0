From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 03 Sep 2014 00:50:26 +0300
Subject: [RFC PATCH 0/7] Introduce automatic DMA configuration for IOMMU
 masters
In-Reply-To: <3133975.8bg0CLVMMz@wuerfel>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
 <5405B6F2.1060105@samsung.com> <3133975.8bg0CLVMMz@wuerfel>
Message-ID: <1804700.tdyjJcKU9T@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 September 2014 14:43:18 Arnd Bergmann wrote:
> On Tuesday 02 September 2014 14:24:18 Marek Szyprowski wrote:
> > >>> For isolation purposes, it can only help to have more domains, but
> > >>> I would guess that there is some space overhead in maintaining lots
> > >>> of page tables.
> > >> 
> > >> I'm okay with both approaches (separate domain for each device vs.
> > >> single common domain for all devices). Maybe this can be some kind of
> > >> Kconfig option added to DMA debugging? Separation might be really
> > >> helpful when debugging strange device behavior.
> > > 
> > > One potential problem with a single domain is when you have multiple
> > > instances of a given IOMMU, each with different hardware restrictions.
> > > Then you can end up with multiple sets of page tables for the domain
> > > which, although not impossible to work with, is a bit of a mess.
> > 
> > Maybe the default dma-mapping domain should be one per a given IOMMU
> > instance? This will simplify a lot of things in such case.
> 
> Yes, that sounds like a good idea.

That would work as a default configuration for the Renesas IPMMU IOMMU, which 
supports four TLBs to be shared between more than four bus masters. Ideally 
I'd like to make the bus master to TLB association somehow configurable, but 
associating all bus masters with a single TLB as a first step is fine.

-- 
Regards,

Laurent Pinchart
