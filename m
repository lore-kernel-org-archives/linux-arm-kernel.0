From: yong.wu@mediatek.com (Yong Wu)
Date: Fri, 4 Mar 2016 08:00:49 +0800
Subject: [PATCH] arm64/dma-mapping: Add DMA_ATTR_ALLOC_SINGLE_PAGES support
In-Reply-To: <CAD=FV=VOJT_Nd67O21J2-rabXRQ2=iTJxP8yCAty2xFhcVupGw@mail.gmail.com>
References: <1456944866-15990-1-git-send-email-yong.wu@mediatek.com>
 <CAD=FV=VOJT_Nd67O21J2-rabXRQ2=iTJxP8yCAty2xFhcVupGw@mail.gmail.com>
Message-ID: <1457049649.26149.11.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-03-03 at 09:44 -0800, Doug Anderson wrote:
> Hi,
> 
> On Wed, Mar 2, 2016 at 10:54 AM, Yong Wu <yong.wu@mediatek.com> wrote:
> > Sometimes it is not worth for the iommu allocating big chunks.
> > Here we enable DMA_ATTR_ALLOC_SINGLE_PAGES which could help avoid to
> > allocate big chunks while iommu allocating buffer.
> >
> > More information about this attribute, please check Doug's commit[1].
> >
> > [1]: https://lkml.org/lkml/2016/1/11/720
> >
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Suggested-by: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >
> > Our video drivers may soon use this.
> >
> >  arch/arm64/mm/dma-mapping.c |  4 ++--
> >  drivers/iommu/dma-iommu.c   | 14 ++++++++++----
> >  include/linux/dma-iommu.h   |  4 ++--
> >  3 files changed, 14 insertions(+), 8 deletions(-)
> 
> It should also be mentioned that this depends on commit df05c6f6e0bb
> ("ARM: 8506/1: common: DMA-mapping: add DMA_ATTR_ALLOC_SINGLE_PAGES
> attribute") which is not in mainline quite yet.

Thanks. I will add it in the commit message.

> 
> Also please CC Marek Szyprowski on any future patches in this area
> since I saw a patch series from him that was touching this same area.

Will do.

> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks.
