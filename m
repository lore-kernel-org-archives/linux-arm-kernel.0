From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Thu, 29 Nov 2012 08:45:15 +0200
Subject: [PATCH 1/1] ARM: tegra: bus_notifier registers IOMMU
 devices(was: How to specify IOMMU'able devices in DT)
In-Reply-To: <50B652F2.5050407@wwwdotorg.org>
References: <20120924124452.41070ed2ee9944d930cffffc@nvidia.com>
 <054901cd9a45$db1a7ea0$914f7be0$%szyprowski@samsung.com>
 <20120924.145014.1452596970914043018.hdoyu@nvidia.com>
 <20121128.154832.539666140149950229.hdoyu@nvidia.com>
 <50B652F2.5050407@wwwdotorg.org>
Message-ID: <20121129084515.8a818bf4793e0d4bb3305c36@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Nov 2012 19:07:46 +0100
Stephen Warren <swarren@wwwdotorg.org> wrote:
......
> >>> Please read more about bus notifiers. IMHO a good example is provided in 
> >>> the following thread:
> >>> http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg12238.html
> >>
> >> This bus notifier seems enough flexible to afford the variation of
> >> IOMMU map info, like Tegra ASID, which could be platform-specific, and
> >> the other could be common too. There's already iommu_bus_notifier
> >> too. I'll try to implement something base on this.
> > 
> > Experimentally implemented as below. With the followig patch, each
> > device could specify its own map in DT, and automatically the device
> > would be attached to the map.
> > 
> > There is a case that some devices share a map. This patch doesn't
> > suppor such case yet.
> > 
> > From 8cb75bb6f3a8535a077e0e85265f87c1f1289bfd Mon Sep 17 00:00:00 2001
> > From: Hiroshi Doyu <hdoyu@nvidia.com>
> > Date: Wed, 28 Nov 2012 14:47:04 +0200
> > Subject: [PATCH 1/1] ARM: tegra: bus_notifier registers IOMMU devices
> > 
> > platform_bus notifier registers IOMMU devices if dma-window is
> > specified.
> > 
> > Its format is:
> >   dma-window = <"start" "size">;
> > ex)
> >   dma-window = <0x12345000 0x8000>;
> > 
> > Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> > ---
> >  arch/arm/mach-tegra/board-dt-tegra30.c |   40 ++++++++++++++++++++++++++++++++
> 
> Shouldn't this patch be to the IOMMU driver itself, not the core Tegra code?

That could be possible and cleaner. I'll check if it works.
