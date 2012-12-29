From: olof@lixom.net (Olof Johansson)
Date: Fri, 28 Dec 2012 22:53:56 -0800
Subject: [PATCH] arm: dma mapping: export arm iommu functions
In-Reply-To: <CAH=HWYP5r18qjQSc_2121vikbTMpYv6DKOfW=hpOpGB7rUyNRA@mail.gmail.com>
References: <1356592458-11077-1-git-send-email-prathyush.k@samsung.com>
 <50DC580C.7080507@samsung.com>
 <CAH=HWYP5r18qjQSc_2121vikbTMpYv6DKOfW=hpOpGB7rUyNRA@mail.gmail.com>
Message-ID: <20121229065356.GA13760@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 28, 2012 at 09:53:47AM +0530, Prathyush K wrote:
> On Thu, Dec 27, 2012 at 7:45 PM, Marek Szyprowski
> <m.szyprowski@samsung.com>wrote:
> 
> > Hello,
> >
> >
> > On 12/27/2012 8:14 AM, Prathyush K wrote:
> >
> >> This patch adds EXPORT_SYMBOL calls to the three arm iommu
> >> functions - arm_iommu_create_mapping, arm_iommu_free_mapping
> >> and arm_iommu_attach_device. These functions can now be called
> >> from dynamic modules.
> >>
> >
> > Could You describe a bit more why those functions might be needed by
> > dynamic modules?
> >
> > Hi Marek,
> 
> We are adding iommu support to exynos gsc and s5p-mfc.
> And these two drivers need to be built as modules to improve boot time.
> 
> We're calling these three functions from inside these drivers:
> e.g.
> mapping = arm_iommu_create_mapping(&platform_bus_type, 0x20000000, SZ_256M,
> 4);
> arm_iommu_attach_device(mdev, mapping);

The driver shouldn't have to call these low-level functions directly,
something's wrong if you need that.

How is the DMA address management different here from other system/io mmus? is
that 256M window a hardware restriction?

-Olof
